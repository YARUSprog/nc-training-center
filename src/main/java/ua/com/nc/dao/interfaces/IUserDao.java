package ua.com.nc.dao.interfaces;

import ua.com.nc.domain.User;

import java.util.List;

public interface IUserDao extends GenericDao<User, Integer> {
    User getByEmail(String email);
    List<User> getAllTrainers ();
    List<User> getAllManagers();
    List<User> getLandingPageTrainers ();
    User getManagerById(Integer id);
    List<User> getAllTrainersById(Integer id);
    List<User> getByGroupId(Integer id);
    List<User> getUngroupedByCourse(Integer id);
    void updateTrainerLandingPage (int id, boolean isOnLandingPage);
    List<User> getAllForCourse(int courseId);
    void updateUserByAdmin(User user);
    void updateActive(User user);
}
