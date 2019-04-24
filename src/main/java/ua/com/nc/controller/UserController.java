package ua.com.nc.controller;

import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import ua.com.nc.domain.User;
import ua.com.nc.dto.DtoUserProfiles;
import ua.com.nc.service.UserService;

import java.util.List;

@Log4j
@RestController
@CrossOrigin(origins = "http://localhost:8000")
@RequestMapping("/users")
public class UserController {
    @Autowired
    private UserService userService;

    @PostMapping()
    public ResponseEntity<?> save(@RequestBody User user) {
//        log.debug(user);
        if(     user != null &&
                user.getEmail() != null &&
                user.getFirstName() != null &&
                user.getLastName() != null &&
                user.getPassword() != null){
            userService.add(user);
            return ResponseEntity.ok().body("User saved");
        }else{
            return ResponseEntity.badRequest().body("Incorrectly entered fields");
        }

    }

    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    public ResponseEntity<?> getById(@PathVariable Integer id) {
        return new ResponseEntity<>(userService.getById(id), HttpStatus.OK);
    }
}
