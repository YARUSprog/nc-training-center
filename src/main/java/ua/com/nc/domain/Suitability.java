package ua.com.nc.domain;

import lombok.Data;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(callSuper = true)
@Data
public class Suitability extends Entity {
    private String title;
    private String color;
    private int priority;


    public Suitability(String title, String color, int priority) {
        this.title = title;
        this.color = color;
        this.priority = priority;
    }


    public Suitability(Integer id, String title, String color, int priority) {
        super(id);
        this.title = title;
        this.color = color;
        this.priority = priority;
    }
}
