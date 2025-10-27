package com.edumate.boot.domain.event.model.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import com.edumate.boot.domain.event.model.vo.Event;
import com.edumate.boot.domain.event.model.vo.EventContent;

@Mapper
public interface EventMapper {
    
    // 이벤트 목록 조회
    List<Event> selectAllEvents();

    // 이벤트 상세 조회
    Event selectEventById(@Param("eventId") int eventId);

    // 이벤트 콘텐츠 목록 조회
    List<EventContent> selectEventContents(@Param("eventId") int eventId);

    // 이전/다음 이벤트 ID 조회
    Integer selectPrevEventId(@Param("eventId") int eventId);
    Integer selectNextEventId(@Param("eventId") int eventId);

    // 이벤트 등록
    int insertEvent(Event event);
    
    // 이벤트 콘텐츠 등록
    int insertEventContent(EventContent content);

    // 이벤트 수정
    int updateEvent(Event event);
    
    // 이벤트 삭제
    int deleteEvent(@Param("eventId") int eventId);

    // 시퀀스 조회 (Oracle용)
    int getNextEventId();
    int getNextContentNo();
    
    int deleteEventContents(int eventId);

    int getCount();
}