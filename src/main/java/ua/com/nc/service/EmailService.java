package ua.com.nc.service;

import ua.com.nc.domain.User;
import ua.com.nc.dto.DtoMailSender;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Set;

public interface EmailService {
    void sendSimpleMessage(DtoMailSender dtoMailSender);
    String textGenerator(Set<User> students);
    void sendAttendanceReminderEmail(String to, String studentsText);
    HashMap <User, ArrayList<User>> reverseHashMap (HashMap <User, User> studentsAndManagers);
}
