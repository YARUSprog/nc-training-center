package ua.com.nc.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ua.com.nc.dao.interfaces.CourseDao;
import ua.com.nc.dao.interfaces.UserDao;
import ua.com.nc.domain.Course;
import ua.com.nc.domain.User;
import ua.com.nc.service.LandingPageService;

import java.util.List;

@Service
public class LandingPageServiceImpl implements LandingPageService {

    @Autowired
    private CourseDao courseDao;

    @Autowired
    private UserDao userDao;

    @Override
    public List<Course> getLandingPageCourses() {
        return courseDao.getLandingPageCourses();
    }

    @Override
    public List<User> getLandingPageTrainers() {
        return userDao.getLandingPageTrainers();
    }

    @Override
    public void updateCourseLandingPage(int id, boolean isOnLandingPage) {
        courseDao.updateCourseLandingPage(id, isOnLandingPage);
        courseDao.commit();
    }

    @Override
    public void updateTrainerLandingPage(int id, boolean isOnLandingPage) {
        userDao.updateTrainerLandingPage(id, isOnLandingPage);
        userDao.commit();
    }
}
