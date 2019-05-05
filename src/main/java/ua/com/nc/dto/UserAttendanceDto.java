package ua.com.nc.dto;

import com.google.gson.annotations.SerializedName;
import lombok.Data;
import lombok.ToString;
import ua.com.nc.domain.Attendance;

import java.sql.Date;

@Data
@ToString
public class UserAttendanceDto extends Attendance {
    String studentFirstName;
    String studentLastName;
    Integer courseId;
    Date timeDate;
    String topic;

    public UserAttendanceDto(Integer id, Integer lessonId, Integer userId, String reason, String status,
                             String studentFirstName, String studentLastName, Integer courseId, Date timeDate,
                             String topic) {
        super(id, lessonId, userId, reason, status);
        this.studentFirstName = studentFirstName;
        this.studentLastName = studentLastName;
        this.courseId = courseId;
        this.timeDate = timeDate;
        this.topic = topic;
    }

    @Override
    public String toString() {
        return "UserAttendanceDto{" +
                super.toString()
                + ", " +
                "studentFirstName='" + studentFirstName + '\'' +
                ", studentLastName='" + studentLastName + '\'' +
                ", courseId=" + courseId +
                ", timeDate=" + timeDate +
                ", topic='" + topic + '\'' +
                '}';
    }
}
