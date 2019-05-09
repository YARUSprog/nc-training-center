package ua.com.nc.service.impl;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import ua.com.nc.dao.interfaces.CourseStatus;
import ua.com.nc.dao.interfaces.*;
import ua.com.nc.domain.*;
import ua.com.nc.dto.schedule.GroupSchedule;
import ua.com.nc.dto.schedule.ParsedSchedule;
import ua.com.nc.dto.schedule.ScheduleForUser;
import ua.com.nc.service.CourseService;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service
public class CourseServiceImpl implements CourseService {
    private static final Logger log = Logger.getLogger(AttachmentServiceImpl.class);
    @Autowired
    private CourseDao courseDao;
    @Autowired
    private LevelDao levelDao;
    @Autowired
    private DesiredScheduleDao desiredScheduleDao;
    @Autowired
    private SuitabilityDao suitabilityDao;
    @Autowired
    private UserDao userDao;
    @Autowired
    private GroupDao groupDao;
    @Autowired
    private UserGroupDao userGroupDao;


    private int startOfDay = 8;
    private int endOfDay = 21;


    //TODO Create all implementations for this bean, then uncomment 1st line of add(...) mthd
    private CourseStatus statusDao;

    @Override
    public void add(Course course) {
        courseDao.insert(course);
        courseDao.commit();
    }

    @Override
    public void update(Course course) {
        courseDao.update(course);
        courseDao.commit();
    }

    @Override
    public Course stringToObjCourse(String name, String user, String level,
                                    String courseStatus, String imageUrl, String isOnLandingPage,
                                    String desc, String startDay, String endDay) {
        //int statusId = statusDao.getIdByName(courseStatus.getName());
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        int userId = 1;
//        CourseStatus status = CourseStatus.valueOf(courseStatus);
        ua.com.nc.domain.CourseStatus status = ua.com.nc.domain.CourseStatus.ENDED;
        boolean isLanding = Boolean.parseBoolean(isOnLandingPage);
        Date startingDay = new Date();
        Date endingDay = startingDay;
        try {
            startingDay = format.parse(startDay);
            endingDay = format.parse(endDay);
        } catch (ParseException e) {
            log.trace(e);
        }
        int statusId = 1;
        int lvl = levelDao.getIdByName(level.trim());

        return new Course(name, lvl, statusId, userId, imageUrl,
                new java.sql.Date(startingDay.getTime()), new java.sql.Date(endingDay.getTime()),
                isLanding, desc);
    }

    @Override
    public void add(String name, int userId, String lvl, ua.com.nc.domain.CourseStatus courseStatus, String imageUrl, boolean isLanding,
                    String desc, Date startingDay, Date endingDay) {

    }

    @Override
    public List<ScheduleForUser> getDesiredScheduleForUngroupedStudentsOfCourse(int courseId) throws Exception {
        List<DesiredSchedule> desiredScheduleList = desiredScheduleDao.getAllForCourse(courseId);
        List<ScheduleForUser> scheduleForUsers = new ArrayList<>();
        for (User user : userDao.getUngroupedByCourse(courseId)) {
            scheduleForUsers.add(new ScheduleForUser(user,
                    parseSchedules(desiredScheduleList, suitabilityDao.getAll()),
                    startOfDay, endOfDay));
        }
        return scheduleForUsers;
    }

    @Override
    public List<GroupSchedule> getDesiredScheduleForFormedGroupsForCourse(int courseId) throws Exception {
        List<GroupSchedule> scheduleForGroupsForCourse = new ArrayList<>();
        List<ParsedSchedule> desiredScheduleList = parseSchedules(
                desiredScheduleDao.getAllForCourse(courseId),
                suitabilityDao.getAll());
        List<Group> allGroupsForCourse = groupDao.getAllGroupsOfCourse(courseId);
        for (Group group : allGroupsForCourse) {
            List<ScheduleForUser> scheduleForUsersInGroup = new ArrayList<>();
            for (User user : userDao.getByGroupId(group.getId())) {
                scheduleForUsersInGroup.add(new ScheduleForUser(user,
                        desiredScheduleList, startOfDay, endOfDay));
            }
            scheduleForGroupsForCourse.add(new GroupSchedule(group.getId(), group.getTitle(),
                    scheduleForUsersInGroup, courseId));
        }
        return scheduleForGroupsForCourse;
    }


    private List<ParsedSchedule> parseSchedules(List<DesiredSchedule> desiredSchedules, List<Suitability> suitabilities)
            throws Exception {
        List<ParsedSchedule> result = new ArrayList<>();
        for (DesiredSchedule desiredSchedule : desiredSchedules) {
            result.add(new ParsedSchedule(desiredSchedule, suitabilities));
        }
        return result;
    }

    @Override
    public List<String> getDayIntervals() {
        List<String> dayIntervals = new ArrayList<>();
        for (int i = startOfDay; i < endOfDay; i++) {
            int halfDay = 12;
            int hours = (i % halfDay == 0) ? 12 : i % halfDay;
            String appendix = (i < 12) ? "am" : "pm";
            dayIntervals.add(hours + appendix);
        }
        return dayIntervals;
    }


    /**
     * @return local image link;
     */
    @Override
    public String uploadImage(MultipartFile image) {
        StringBuilder name;
        if (!image.isEmpty() && image.getOriginalFilename() != null) {
            try {
                byte[] bytes = image.getBytes();

                name = new StringBuilder(image.getOriginalFilename());
                int dot = name.lastIndexOf(".");
                String imgFormat = name.substring(dot - 1);
                name = new StringBuilder(name.subSequence(0, dot));

                String rootPath = "src/main/resources/img";
                Path path = Paths.get(rootPath + File.separator + name + imgFormat);
                int i = 1;
                while (Files.exists(path)) {
                    name.append(i);
                    path = Paths.get(rootPath + File.separator + name + imgFormat);
                    i++;
                }
                File uploadedFile = Files.createFile(path).toFile();
                try (BufferedOutputStream stream = new BufferedOutputStream(new FileOutputStream(uploadedFile))) {
                    stream.write(bytes);
                    stream.flush();
                }
                return name.toString();
            } catch (Exception e) {
                log.trace(e);
            }
        }
        return "";
    }

    @Override
    public List<ScheduleForUser> getDesiredScheduleForGroup(int groupId) throws Exception {
        List<DesiredSchedule> desiredScheduleList = desiredScheduleDao.getAllForGroup(groupId);
        List<ScheduleForUser> scheduleForUsers = new ArrayList<>();
        for (User user : userDao.getByGroupId(groupId)) {
            scheduleForUsers.add(new ScheduleForUser(user,
                    parseSchedules(desiredScheduleList,
                            suitabilityDao.getAll()),
                    startOfDay, endOfDay));
        }
        return scheduleForUsers;
    }
}
