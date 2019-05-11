package ua.com.nc.service;


import ua.com.nc.domain.User;
import ua.com.nc.dto.DtoGroup;
import ua.com.nc.dto.schedule.GroupSchedule;

import java.util.List;

public interface GroupsService {
    int update(GroupSchedule groupSchedule);

    boolean delete(int groupId);

    int add(GroupSchedule groupSchedule);

    List<DtoGroup> getAll();

    List<DtoGroup> getGroupsAndQuantity();

    User getTrainer(int id);
}
