package ua.com.nc.dao.interfaces;

import ua.com.nc.domain.UserGroup;

public interface IUserGroupDao extends GenericDao<UserGroup, Integer> {

    void deleteAllForGroup(int groupId);

    void deleteAllForUser(Integer userId);

    UserGroup getByUserAndCourse(int userId, int courseId);
}
