package ua.com.nc.controller;

import com.google.gson.Gson;
import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import ua.com.nc.service.AttendanceStatusService;

@Log4j2
@Controller
@RequestMapping("/api/attendance-status")
public class AttendanceStatusController {

    @Autowired
    private AttendanceStatusService attendanceStatusService;

    @RequestMapping(method = RequestMethod.GET)
    public ResponseEntity<?> getAll() {
        return ResponseEntity.ok().body(new Gson().toJson(attendanceStatusService.getAll()));
    }
}
