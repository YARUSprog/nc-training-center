package ua.com.nc.security;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Component;
import ua.com.nc.dao.interfaces.*;
import ua.com.nc.domain.Lesson;
import ua.com.nc.domain.Role;
import ua.com.nc.domain.User;
import ua.com.nc.dto.DateDeserializer;
import ua.com.nc.dto.DtoLesson;

import java.sql.Timestamp;
import java.util.List;

@Log4j
@Component("customSecuritySecurity")
public class CustomSecurityService {
    @Autowired
    UserDao userDao;
    @Autowired
    private RoleDao roleDao;
    @Autowired
    private CourseDao courseDao;
    @Autowired
    private LessonDao lessonDao;
    @Autowired
    private GroupDao groupDao;

    public boolean hasPermissionToSeeScheduleOf(Authentication authentication, Integer userId) {
        User user = (User) authentication.getPrincipal();
        List<Role> roles = roleDao.findAllByUserId(userId);
        User userToRetrieve = userDao.getEntityById(userId);
        return (roles.contains(Role.TRAINER) ||
                roles.contains(Role.EMPLOYEE)) &&
                ((user.getRoles().contains(Role.ADMIN) || user.getId().equals(userId)) ||
                        (user.getRoles().contains(Role.MANAGER) &&
                                userToRetrieve.getManagerId().equals(user.getId())) ||
                        user.getRoles().contains(Role.TRAINER));
    }

    public boolean hasPermissionToAddLesson(Authentication authentication, String toAdd) {
        User user = (User) authentication.getPrincipal();
        return user.getRoles().contains(Role.ADMIN) || getTrainerId(toAdd).equals(user.getId());
    }

    private Integer getTrainerId(String toAdd) {
        Gson gson = new GsonBuilder().registerTypeAdapter(Timestamp.class,
                new DateDeserializer()).create();
        DtoLesson toAdd1 = gson.fromJson(toAdd, DtoLesson.class);
        return courseDao.getCourseByGroup(toAdd1.getGroupId()).getUserId();
    }

    public boolean hasPermissionToDeleteLesson(Authentication authentication, Integer lessonId) {
        User user = (User) authentication.getPrincipal();
        return user.getRoles().contains(Role.ADMIN) || userDao.getTrainerByGroupId(
                lessonDao.getEntityById(lessonId).getGroupId()).getId().equals(user.getId());
    }

    public boolean hasPermissionToCancelLesson(Authentication authentication, Integer lessonId) {
        User user = (User) authentication.getPrincipal();
        Lesson lesson = lessonDao.getEntityById(lessonId);
        return user.getRoles().contains(Role.ADMIN)
                || user.getId().equals(lesson.getTrainerId())
                || userDao.getTrainerByGroupId(lesson.getGroupId()).getId().equals(user.getId());
    }

    public boolean hasPermissionToRetrieveLessons(Authentication authentication, Integer groupId) {
        User user = (User) authentication.getPrincipal();
        return user.getRoles().contains(Role.ADMIN)
                || userDao.getTrainerByGroupId(groupId).getId().equals(user.getId());
    }

    public boolean hasPermissionToRetrieveGroups(Authentication authentication, Integer employeeId) {
        log.info(employeeId);
        return roleDao.findAllByUserId(employeeId).contains(Role.EMPLOYEE);
    }


}
