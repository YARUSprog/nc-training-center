package ua.com.nc.service.impl;

import lombok.extern.log4j.Log4j2;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ua.com.nc.dao.interfaces.*;
import ua.com.nc.domain.*;
import ua.com.nc.exceptions.NoSuchUserException;
import ua.com.nc.service.ReportService;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@Log4j2
@Service
public class ReportServiceImpl implements ReportService {

    @Autowired
    private LessonDao lessonDao;
    @Autowired
    private UserDao userDao;
    @Autowired
    private GroupDao groupDao;
    @Autowired
    private LevelDao levelDao;
    @Autowired
    private CourseDao courseDao;

    private String[] dashboardSheetNames = {"Level And Quantity", "Level And Trainers", "Training And Quantity"};
    private String[] levelAndQuantityColumns = {"Level", "Course Name", "Group Name"};
    private String[] levelAndTrainersColumns = {"Trainer", "Course Name and Level"};
    private String[] trainingAndQuantityColumns = {"Course Name", "Group Name", "Amount of Employees"};


    private Level findLevelById(List<Level> levels, int id) {
        for (Level level : levels) {
            if (level.getId() == id) {
                return level;
            }
        }
        throw new NoSuchUserException("Can't find Level for Id " + id);
    }

    private CellStyle headerStyle(XSSFWorkbook workbook) {
        Font headerFont = workbook.createFont();
        headerFont.setBold(true);
        return setCellStyle(workbook, headerFont);
    }

    private CellStyle presenceStyle(XSSFWorkbook workbook) {
        Font presenceFont = workbook.createFont();
        presenceFont.setItalic(true);
        return setCellStyle(workbook, presenceFont);
    }

    private CellStyle setCellStyle(XSSFWorkbook workbook, Font presenceFont) {
        CellStyle presenceStyle = workbook.createCellStyle();
        presenceStyle.setVerticalAlignment(VerticalAlignment.CENTER);
        presenceStyle.setAlignment(HorizontalAlignment.CENTER);
        presenceStyle.setWrapText(true);
        presenceStyle.setFont(presenceFont);
        return presenceStyle;
    }


    private void drawGroupSheet(XSSFWorkbook workbook, CellStyle headerStyle,
                                CellStyle presenceStyle, User trainer, List<Group> groups) {
        for (Group group : groups) {
            List<User> students = userDao.getByGroupId(group.getId());
            //foreach trainer's group create sheet with title
            Sheet groupSheet = workbook.createSheet(trainer.getLastName()
                    + "'s " + group.getTitle());

            int rowCount = 0;
            Row headerRow = groupSheet.createRow(rowCount);
            for (User student : students) {
                List<Lesson> lessons = lessonDao.getByGroupIdAndUserId(group.getId(), student.getId());

                Row studentRow = groupSheet.createRow(++rowCount);
                int cellCount = 0;
                String studentFullName = student.getFirstName() + " " + student.getLastName();
                studentRow.createCell(cellCount).setCellValue(studentFullName);
                studentRow.getCell(cellCount).setCellStyle(headerStyle);
                groupSheet.setColumnWidth(cellCount, 255 * 25);
                for (Lesson lesson : lessons) {
                    String lessonTopicAndDate = lesson.getTopic() + "\n" + lesson.getTimeDate();

                    Cell headerCell = headerRow.createCell(++cellCount);
                    headerCell.setCellStyle(headerStyle);
                    headerCell.setCellValue(lessonTopicAndDate);
                    Cell studentCell = studentRow.createCell(cellCount);
                    studentCell.setCellStyle(presenceStyle);
                    studentCell.setCellValue(lesson.getAbsenceStatus());
                    groupSheet.setColumnWidth(cellCount,
                            255 * lessonTopicAndDate.length());
                }
            }
        }
    }

    private Sheet createSheetAndHeader(XSSFWorkbook workbook, String dashboardName,
                                       String[] trainingAndQuantityColumns) {
        Sheet sheetName = workbook.createSheet(dashboardName);
        Row headerRow = sheetName.createRow(0);
        for (int i = 0; i < trainingAndQuantityColumns.length; i++) {
            headerRow.setRowStyle(headerStyle(workbook));
            headerRow.createCell(i).setCellValue(trainingAndQuantityColumns[i]);
        }
        return sheetName;
    }

    private void drawLevelAndQuantity(Sheet sheetName) {
        int levelRowCount = 1;

        for (Level level : levelDao.getAll()) {
            String levelTitle = level.getTitle();
            Row levelRowColumn = sheetName.createRow(levelRowCount++);
            Cell levelCell = levelRowColumn.createCell(0);
            sheetName.setColumnWidth(0, 255 * 12);
            levelCell.setCellStyle(headerStyle((XSSFWorkbook) sheetName.getWorkbook()));
            levelCell.setCellValue(levelTitle);
            for (Course course : courseDao.getAllByLevel(level.getId())) {
                String courseName = course.getName();
                Row courseRowColumn = sheetName.createRow(levelRowCount++);
                Cell courseCell = courseRowColumn.createCell(1);
                sheetName.setColumnWidth(1, 255 * 25);
                courseCell.setCellStyle(presenceStyle((XSSFWorkbook) sheetName.getWorkbook()));
                courseCell.setCellValue(courseName);
                for (Group group : groupDao.getAllGroupsOfCourse(course.getId())) {
                    String groupName = group.getTitle();
                    Row groupRowColumn = sheetName.createRow(levelRowCount++);
                    groupRowColumn.createCell(2).setCellValue(groupName);
                    sheetName.setColumnWidth(2, 255 * 25);
                }
            }
        }
    }


    private void drawLevelAndTrainers(Sheet levelAndTrainers) {
        int trainerRowCount = 1;
        for (User trainer : userDao.getAllTrainers()) {
            String trainerFullName = trainer.getFirstName() + " " + trainer.getLastName();
            Row trainerRowColumn = levelAndTrainers.createRow(trainerRowCount++);
            int trainerCellCount = 0;
            levelAndTrainers.setColumnWidth(trainerCellCount, 255 * 25);
            Cell trainerCell = trainerRowColumn.createCell(trainerCellCount++);
            trainerCell.setCellValue(trainerFullName);

            for (Course course : courseDao.getAllByTrainer(trainer.getId())) {
                Level level = findLevelById(levelDao.getAllByTrainer(trainer.getId()), course.getLevel());
                String courseAndLevelTitle = course.getName() + " " + level.getTitle();
                Row courseRowColumn = levelAndTrainers.createRow(trainerRowCount++);
                if (level.getTitle() != null) {
                    courseRowColumn.createCell(trainerCellCount).setCellValue(courseAndLevelTitle);
                    levelAndTrainers.setColumnWidth(trainerCellCount, 255 * 30);
                } else {
                    courseRowColumn.createCell(trainerCellCount).setCellValue(course.getName());
                    levelAndTrainers.setColumnWidth(trainerCellCount, 255 * 30);
                }
            }
        }
    }

    private void drawTrainingAndQuantity(Sheet trainingAndQuantity) {
        trainingAndQuantity.setColumnWidth(2, 255 * 25);
        int[] courseCell = {0, 2};
        int[] groupCell = {1, 2};
        int rowCounter = 1;
        for (Course course : courseDao.getAll()) {
            Row courseRow = trainingAndQuantity.createRow(rowCounter++);
            String courseName = course.getName();
            trainingAndQuantity.setColumnWidth(0, 255 * 25);
            courseRow.createCell(courseCell[0]).setCellValue(courseName);
            int numberOfEmployeesInCourse = 0;
            Cell employeesAmountCourse = courseRow.createCell(courseCell[1]);
            for (Group group : groupDao.getAllGroupsOfCourse(course.getId())) {
                int numberOfEmployeesInGroup = groupDao.getNumberOfEmployeesInGroup(group.getId());
                numberOfEmployeesInCourse += numberOfEmployeesInGroup;
                Row groupRow = trainingAndQuantity.createRow(rowCounter++);
                String groupTitle = group.getTitle();
                trainingAndQuantity.setColumnWidth(1, 255 * 25);
                groupRow.createCell(groupCell[0]).setCellValue(groupTitle);
                groupRow.createCell(groupCell[1]).setCellValue(numberOfEmployeesInGroup);
            }
            employeesAmountCourse.setCellValue(numberOfEmployeesInCourse);
        }
    }

    @Override
    public ByteArrayInputStream getDashboardExcel() throws IOException {
        try (XSSFWorkbook workbook = new XSSFWorkbook();
             ByteArrayOutputStream out = new ByteArrayOutputStream()
        ) {

            Sheet levelAndQuantity = createSheetAndHeader(workbook,
                    dashboardSheetNames[0],
                    levelAndQuantityColumns);
            drawLevelAndQuantity(levelAndQuantity);


            Sheet levelAndTrainers = createSheetAndHeader(workbook,
                    dashboardSheetNames[1],
                    levelAndTrainersColumns);
            drawLevelAndTrainers(levelAndTrainers);

            Sheet trainingAndQuantity = createSheetAndHeader(workbook,
                    dashboardSheetNames[2],
                    trainingAndQuantityColumns);
            drawTrainingAndQuantity(trainingAndQuantity);

            workbook.write(out);
            return new ByteArrayInputStream(out.toByteArray());
        }
    }

    //get full attendance report
    @Override
    public ByteArrayInputStream getAttendanceExcel() throws IOException {

        try (XSSFWorkbook workbook = new XSSFWorkbook();
             ByteArrayOutputStream out = new ByteArrayOutputStream()
        ) {
            CellStyle headerStyle = headerStyle(workbook);
            CellStyle presenceStyle = presenceStyle(workbook);

            List<User> trainers = userDao.getAllTrainers();
            for (User trainer : trainers) {
                List<Group> groups = groupDao.getGroupByTrainerId(trainer.getId());
                drawGroupSheet(workbook, headerStyle, presenceStyle, trainer, groups);
            }
            workbook.write(out);
            return new ByteArrayInputStream(out.toByteArray());
        }
    }

    //get attendance of trainers each group
    @Override
    public ByteArrayInputStream getAttendanceExcel(User trainer) throws IOException {
        try (XSSFWorkbook workbook = new XSSFWorkbook();
             ByteArrayOutputStream out = new ByteArrayOutputStream()
        ) {
            CellStyle headerStyle = headerStyle(workbook);
            CellStyle presenceStyle = presenceStyle(workbook);

            List<Group> groups = groupDao.getGroupByTrainerId(trainer.getId());
            drawGroupSheet(workbook, headerStyle, presenceStyle, trainer, groups);

            workbook.write(out);
            return new ByteArrayInputStream(out.toByteArray());
        }
    }

    //get attendance of group by id
    @Override
    public ByteArrayInputStream getAttendanceExcel(Integer groupId) throws IOException {
        try (XSSFWorkbook workbook = new XSSFWorkbook();
             ByteArrayOutputStream out = new ByteArrayOutputStream()
        ) {
            CellStyle headerStyle = headerStyle(workbook);
            CellStyle presenceStyle = presenceStyle(workbook);

            List<Group> groups = new ArrayList<>();
            groups.add(groupDao.getEntityById(groupId));
            User trainer = userDao.getTrainerByGroupId(groupId);

            drawGroupSheet(workbook, headerStyle, presenceStyle, trainer, groups);

            workbook.write(out);
            return new ByteArrayInputStream(out.toByteArray());
        }
    }
}