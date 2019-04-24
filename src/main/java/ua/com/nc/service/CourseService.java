package ua.com.nc.service;

import ua.com.nc.domain.Course;
import ua.com.nc.domain.CourseStatus;

import java.util.Date;

public interface CourseService {
    void add(Course course);

    void update(Course course);

    Course stringToObjCourse(String name, String user, String level, String courseStatus,
                             String imageUrl, String isOnLandingPage, String desc, String startDay, String endDay);
}
