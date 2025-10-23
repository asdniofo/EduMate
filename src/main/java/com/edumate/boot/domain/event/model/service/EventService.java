package com.edumate.boot.domain.event.model.service;

import java.util.List;
import org.springframework.web.multipart.MultipartFile;
import com.edumate.boot.domain.event.model.vo.Event;
import com.edumate.boot.domain.event.model.vo.EventContent;

public interface EventService {
    List<Event> getAllEvents();

    Event getEventById(int eventId);

    List<EventContent> getEventContents(int eventId);

    Integer getPrevEventId(int eventId);
    Integer getNextEventId(int eventId);

    // returns generated eventId
    int insertEvent(Event event, MultipartFile mainImage, List<MultipartFile> detailImages) throws Exception;

    int updateEvent(Event event, MultipartFile mainImage, List<MultipartFile> detailImages) throws Exception;

    int deleteEvent(int eventId);
    int insertEvent(Event event);
    int insertEventContent(EventContent content);
}
