package com.edumate.boot.domain.event.model.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;

import com.edumate.boot.domain.event.model.mapper.EventMapper;
import com.edumate.boot.domain.event.model.service.EventService;
import com.edumate.boot.domain.event.model.vo.Event;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class EventServiceImpl implements EventService {
	private final EventMapper eventMapper;

    @Override
    public List<Event> getAllEvents() {
        return eventMapper.selectAllEvents();
    }

    @Override
    public Event getEventById(int eventId) {
        return eventMapper.selectEventById(eventId);
    }

    @Override
    public Integer getPrevEventId(int eventId) {
        return eventMapper.selectPrevEventId(eventId);
    }

    @Override
    public Integer getNextEventId(int eventId) {
        return eventMapper.selectNextEventId(eventId);
    }

    @Override
    public int insertEvent(Event event) {
        return eventMapper.insertEvent(event);
    }

    @Override
    public int updateEvent(Event event) {
        return eventMapper.updateEvent(event);
    }

    @Override
    public int deleteEvent(int eventId) {
        return eventMapper.deleteEvent(eventId);
    }
}
