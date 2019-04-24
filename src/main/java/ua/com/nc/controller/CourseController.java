package ua.com.nc.controller;

import com.google.gson.Gson;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import ua.com.nc.dao.implementation.CourseDao;
import ua.com.nc.dao.implementation.LevelDao;
import ua.com.nc.domain.Course;
import ua.com.nc.domain.CourseStatus;
import ua.com.nc.domain.Level;
import ua.com.nc.service.CourseService;

import javax.servlet.http.HttpServletRequest;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.stream.Stream;

@Log4j
@Controller
@CrossOrigin(origins = "http://localhost:8000")
@RequestMapping("/getcourses")
public class CourseController {
    @Autowired
    private CourseDao courseDao;
    @Autowired
    private CourseService service;

    private final Gson gson = new Gson();


    @RequestMapping(method = RequestMethod.GET)
    @ResponseBody
    public String getCourses(){
       return gson.toJson(courseDao.getAll());
    }
    @RequestMapping(method = RequestMethod.GET,value="/{id}")
    @ResponseBody
    public String getCourse(@PathVariable String id){
       return gson.toJson(courseDao.getEntityById(Integer.parseInt(id)));
    }

    @RequestMapping(method = RequestMethod.DELETE,value="/{id}")
    public void deleteCourse(@PathVariable String id){
        courseDao.delete(Integer.parseInt(id));
    }

    @RequestMapping(method = RequestMethod.POST,value = "/create")
    @ResponseBody
    public void add(@RequestParam(name = "name") String name, @RequestParam(name="level" ) String level,
                    @RequestParam(name = "courseStatus") String courseStatus, @RequestParam(name = "imageUrl") String imageUrl,
                    @RequestParam(name = "isOnLandingPage") String isOnLandingPage, @RequestParam(name = "description") String desc,
                    @RequestParam(name = "startDay") String startDay,@RequestParam(name = "endDay") String endDay) {

        service.add(service.stringToObjCourse(name, "1", level, courseStatus,
                imageUrl, isOnLandingPage, desc, startDay, endDay));
    }


    @RequestMapping(method = RequestMethod.PUT,value = "{id}/create")
    @ResponseBody
    public void update(@RequestParam(name = "name") String name, @RequestParam(name="level" ) String level,
                    @RequestParam(name = "courseStatus") String courseStatus, @RequestParam(name = "imageUrl") String imageUrl,
                    @RequestParam(name = "isOnLandingPage") String isOnLandingPage, @RequestParam(name = "description") String desc,
                    @RequestParam(name = "startDay") String startDay,@RequestParam(name = "endDay") String endDay,
                       @PathVariable int id){

        Course course = service.stringToObjCourse(name, "1", level, courseStatus,
                imageUrl, isOnLandingPage, desc, startDay, endDay);
        courseDao.update(course);
    }
    @RequestMapping(value = {"/{id}/desired"}, method = RequestMethod.GET)
    @ResponseBody
    public String getDesiredScheduleForCourse(@PathVariable("id") String id) throws Exception {
        return service.getDesiredScheduleForCourse(Integer.parseInt(id));
    }

    @RequestMapping(value = {"/desired/day-intervals"}, method = RequestMethod.GET)
    @ResponseBody
    public String getDayIntervals() {
        return service.getDayIntervals();
    }



}
