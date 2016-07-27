package com.hongzhi.zswh.app_1_4.entity;

import java.sql.Timestamp;

/**
 * Created by taylor on 7/27/16.
 * twitter: @taylorwang789
 */
public class Event {

    private Integer event_id ;
    private String event_name ;
    private Integer club_id ;
    private Timestamp start_time ;
    private Timestamp end_time ;
    private Timestamp register_start_time ;
    private Timestamp register_end_time ;
    private Integer organizer_id ;
    private String event_address ;
    private Integer min_people ;
    private Integer max_people ;
    private Double fee ;
    private String image ;
    private Integer event_status ;
    private String event_status_code ;

    public Integer getEvent_id() {
        return event_id;
    }

    public void setEvent_id(Integer event_id) {
        this.event_id = event_id;
    }

    public String getEvent_name() {
        return event_name;
    }

    public void setEvent_name(String event_name) {
        this.event_name = event_name;
    }

    public Integer getClub_id() {
        return club_id;
    }

    public void setClub_id(Integer club_id) {
        this.club_id = club_id;
    }

    public Timestamp getStart_time() {
        return start_time;
    }

    public void setStart_time(Timestamp start_time) {
        this.start_time = start_time;
    }

    public Timestamp getEnd_time() {
        return end_time;
    }

    public void setEnd_time(Timestamp end_time) {
        this.end_time = end_time;
    }

    public Timestamp getRegister_start_time() {
        return register_start_time;
    }

    public void setRegister_start_time(Timestamp register_start_time) {
        this.register_start_time = register_start_time;
    }

    public Timestamp getRegister_end_time() {
        return register_end_time;
    }

    public void setRegister_end_time(Timestamp register_end_time) {
        this.register_end_time = register_end_time;
    }

    public Integer getOrganizer_id() {
        return organizer_id;
    }

    public void setOrganizer_id(Integer organizer_id) {
        this.organizer_id = organizer_id;
    }

    public String getEvent_address() {
        return event_address;
    }

    public void setEvent_address(String event_address) {
        this.event_address = event_address;
    }

    public Integer getMin_people() {
        return min_people;
    }

    public void setMin_people(Integer min_people) {
        this.min_people = min_people;
    }

    public Integer getMax_people() {
        return max_people;
    }

    public void setMax_people(Integer max_people) {
        this.max_people = max_people;
    }

    public Double getFee() {
        return fee;
    }

    public void setFee(Double fee) {
        this.fee = fee;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public Integer getEvent_status() {
        return event_status;
    }

    public void setEvent_status(Integer event_status) {
        this.event_status = event_status;
        this.event_status_code = EventStatus.getEventStatus(event_status).name();
    }

    public String getEvent_status_code() {
        return event_status_code;
    }

    public void setEvent_status_code(String event_status_code) {
        this.event_status_code = event_status_code;
    }
}
