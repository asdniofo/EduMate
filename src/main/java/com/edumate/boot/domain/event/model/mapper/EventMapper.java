package com.edumate.boot.domain.event.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.edumate.boot.domain.event.model.vo.Event;

@Mapper
public interface EventMapper {
	List<Event> selectAllEvents();             // 전체 목록 조회

    Event selectEventById(@Param("eventId") int eventId); // 상세 조회

    Integer selectPrevEventId(@Param("eventId") int eventId); // 이전 이벤트
    Integer selectNextEventId(@Param("eventId") int eventId); // 다음 이벤트

    int insertEvent(Event event);              // 등록
    int updateEvent(Event event);              // 수정
    int deleteEvent(@Param("eventId") int eventId); // 삭제
}
