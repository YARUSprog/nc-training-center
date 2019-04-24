package ua.com.nc.service.impl;

import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ua.com.nc.dao.interfaces.IGroupDao;
import ua.com.nc.dao.interfaces.ILessonDao;
import ua.com.nc.dao.interfaces.IUserDao;
import ua.com.nc.domain.Group;
import ua.com.nc.domain.Lesson;
import ua.com.nc.domain.User;
import ua.com.nc.dto.AttendanceDto;
import ua.com.nc.service.AttendanceService;

import java.time.OffsetDateTime;
import java.util.ArrayList;
import java.util.List;

@Log4j
@Service
public class AttendanceServiceImpl implements AttendanceService {

    @Autowired
    private IUserDao userDao;

    @Autowired
    private IGroupDao groupDao;

    @Autowired
    private ILessonDao lessonDao;

    public class TrainerDto{
       public Integer id;
       public String firstName;
       public String lastName;
       public List<GroupDto> groups;

       public TrainerDto(User user, List<GroupDto> groupDtos){
           this.id = user.getId();
           this.firstName = user.getFirstName();
           this.lastName = user.getLastName();
           this.groups = groupDtos;
       }
   }

    public class GroupDto{
        public Integer id;
        public String title;
        public List<StudentDto> students;

        public GroupDto(Group group, List<StudentDto> studentDtos){
            this.id = group.getId();
            this.title = group.getTitle();
            this.students = studentDtos;
        }
   }

    public class StudentDto{
       public Integer id;
       public String email;
       public String firstName;
       public String lastName;
       public Integer managerId;
       public List<LessonDto> lessons;

       public StudentDto(User user, List<LessonDto> lessonDtos){
           this.id = user.getId();
           this.email = user.getEmail();
           this.firstName = user.getFirstName();
           this.lastName = user.getLastName();
           this.managerId = user.getManagerId();
           this.lessons = lessonDtos;
       }
   }

    public class LessonDto{
       public Integer id;
       public Integer groupId;
       public String topic;
       public Integer trainerId;
       public OffsetDateTime timeDate;
       public String absenceReason;
       public String absenceStatus;

       public LessonDto(Lesson lesson){
           this.id = lesson.getId();
           this.groupId = lesson.getGroupId();
           this.topic = lesson.getTopic();
           this.trainerId = lesson.getTrainerId();
           this.timeDate = lesson.getTimeDate();
           this.absenceReason = lesson.getAbsenceReason();
           this.absenceStatus = lesson.getAbsenceStatus();
       }
    }

    @Override
    public AttendanceDto getAttendance() {
        List<User> trainers = userDao.getAllTrainers();
        List<TrainerDto> trainerDtos = new ArrayList<>();
        for(User trainer : trainers){
            List<GroupDto> groupDtos = new ArrayList<>();
            List<Group> groups = groupDao.getGroupByTrainerId(trainer.getId());
            for(Group group : groups){
                List<StudentDto> studentDtos = new ArrayList<>();
                List<User> students = userDao.getByGroupId(group.getId());
                for(User student : students){
                    List<LessonDto> lessonsDto = new ArrayList<>();
                    List<Lesson> lessons = lessonDao.getByGroupIdAndUserId(group.getId(), student.getId());
                    for (Lesson lesson : lessons){
                        lessonsDto.add(new LessonDto(lesson));
                    }
                    studentDtos.add(new StudentDto(student, lessonsDto));
                }
                groupDtos.add(new GroupDto(group, studentDtos));
            }
            trainerDtos.add(new TrainerDto(trainer, groupDtos));
        }
        return new AttendanceDto(trainerDtos);
    }
}