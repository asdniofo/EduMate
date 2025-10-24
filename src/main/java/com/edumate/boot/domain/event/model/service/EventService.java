package com.edumate.boot.domain.event.model.service;

import java.util.List;
import org.springframework.web.multipart.MultipartFile;
import com.edumate.boot.domain.event.model.vo.Event;
import com.edumate.boot.domain.event.model.vo.EventContent;

public interface EventService {
    
    // 이벤트 목록 조회
    List<Event> getAllEvents();

    // 이벤트 상세 조회
    Event getEventById(int eventId);

    // 이벤트 콘텐츠 목록 조회
    List<EventContent> getEventContents(int eventId);

    // 이전/다음 이벤트 ID 조회
    Integer getPrevEventId(int eventId);
    Integer getNextEventId(int eventId);

    // 이벤트 등록 (파일 처리 포함)
    int insertEvent(Event event, MultipartFile mainImage, List<MultipartFile> detailImages) throws Exception;

    // 이벤트 등록 (기본)
    int insertEvent(Event event);
    
    // 이벤트 콘텐츠 등록
    int insertEventContent(EventContent content);

    // 이벤트 수정
    int updateEvent(Event event, MultipartFile mainImage, List<MultipartFile> detailImages) throws Exception;

    // 이벤트 삭제
    int deleteEvent(int eventId);
    int deleteEventContents(int eventId);
}