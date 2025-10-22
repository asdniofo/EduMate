package com.edumate.boot.domain.event.model.service;

import java.util.List;

import com.edumate.boot.domain.event.model.vo.Event;

public interface EventService {
    List<Event> getAllEvents();

    Event getEventById(int eventId);

    Integer getPrevEventId(int eventId);
    Integer getNextEventId(int eventId);

    int insertEvent(Event event);
    int updateEvent(Event event);
    int deleteEvent(int eventId);
}
