package com.edumate.boot.domain.event.model.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import com.edumate.boot.domain.event.model.vo.Event;
import com.edumate.boot.domain.event.model.vo.EventContent;

@Mapper
public interface EventMapper {
    List<Event> selectAllEvents();

    Event selectEventById(@Param("eventId") int eventId);

    List<EventContent> selectEventContents(@Param("eventId") int eventId);

    Integer selectPrevEventId(@Param("eventId") int eventId);
    Integer selectNextEventId(@Param("eventId") int eventId);

    int insertEvent(Event event);
    int insertEventContent(EventContent content);

    int updateEvent(Event event);
    int deleteEvent(@Param("eventId") int eventId);

    // sequence helpers (Oracle)
    int getNextEventId();
    int getNextContentNo();
    
    
}
