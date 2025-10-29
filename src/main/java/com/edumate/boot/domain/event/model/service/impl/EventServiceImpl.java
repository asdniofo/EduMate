package com.edumate.boot.domain.event.model.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.edumate.boot.common.util.CloudflareR2Service;
import com.edumate.boot.domain.event.model.mapper.EventMapper;
import com.edumate.boot.domain.event.model.service.EventService;
import com.edumate.boot.domain.event.model.vo.Event;
import com.edumate.boot.domain.event.model.vo.EventContent;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class EventServiceImpl implements EventService {

    private final EventMapper eventMapper;
    private final CloudflareR2Service cloudflareR2Service;

    @Override
    public List<Event> getAllEvents() {
        return eventMapper.selectAllEvents();
    }

    @Override
    public Event getEventById(int eventId) {
        return eventMapper.selectEventById(eventId);
    }

    @Override
    public List<EventContent> getEventContents(int eventId) {
        return eventMapper.selectEventContents(eventId);
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
    @Transactional
    public int insertEvent(Event event, MultipartFile mainImage, List<MultipartFile> detailImages) throws Exception {

        // 1️⃣ 썸네일 업로드
        if (mainImage != null && !mainImage.isEmpty()) {
            String thumbnailUrl = cloudflareR2Service.uploadFile(mainImage, "event/thumbnail");
            event.setEventPath(thumbnailUrl);
            event.setEventSubpath(thumbnailUrl);
        } else {
            throw new Exception("썸네일 이미지는 필수입니다.");
        }

        // 2️⃣ DB에 이벤트 기본 정보 INSERT
        eventMapper.insertEvent(event); // useGeneratedKeys="true"로 eventId 세팅됨
        int eventId = event.getEventId();

        // 3️⃣ 상세 이미지 업로드
        if (detailImages != null && !detailImages.isEmpty()) {
            for (MultipartFile file : detailImages) {
                if (!file.isEmpty()) {
                    String contentUrl = cloudflareR2Service.uploadFile(file, "event/content/" + eventId);

                    EventContent content = new EventContent();
                    content.setEventId(eventId);
                    content.setEContentTitle(file.getOriginalFilename());
                    content.setEContentPath(contentUrl);
                    content.setEContentYn("Y");
                    eventMapper.insertEventContent(content);
                }
            }
        }

        return eventId;
    }

    @Override
    public int insertEvent(Event event) {
        return eventMapper.insertEvent(event);
    }

    @Override
    public int insertEventContent(EventContent content) {
        return eventMapper.insertEventContent(content);
    }

    @Override
    @Transactional
    public int updateEvent(Event event, MultipartFile mainImage, List<MultipartFile> detailImages) throws Exception {
        int eventId = event.getEventId();

        // 1️⃣ 기존 이벤트 정보 조회
        Event oldEvent = eventMapper.selectEventById(eventId);
        if (oldEvent == null) {
            throw new Exception("존재하지 않는 이벤트입니다. eventId=" + eventId);
        }

        // 2️⃣ 썸네일 교체
        if (mainImage != null && !mainImage.isEmpty()) {
            // 기존 썸네일 삭제
            if (oldEvent.getEventPath() != null) {
                cloudflareR2Service.deleteFile(oldEvent.getEventPath());
            }

            // 새 썸네일 업로드
            String thumbnailUrl = cloudflareR2Service.uploadFile(mainImage, "event/thumbnail");
            event.setEventPath(thumbnailUrl);
            event.setEventSubpath(thumbnailUrl);
        } else {
            event.setEventPath(oldEvent.getEventPath());
            event.setEventSubpath(oldEvent.getEventSubpath());
        }

        // 3️⃣ 이벤트 기본 정보 업데이트
        eventMapper.updateEvent(event);

        // 4️⃣ 상세 이미지 교체
        if (detailImages != null && !detailImages.isEmpty()) {
            List<EventContent> oldContents = eventMapper.selectEventContents(eventId);

            // 기존 상세 이미지 삭제
            for (EventContent c : oldContents) {
                cloudflareR2Service.deleteFile(c.getEContentPath());
            }
            eventMapper.deleteEventContents(eventId);

            // 새 상세 이미지 업로드
            for (MultipartFile file : detailImages) {
                if (!file.isEmpty()) {
                    String contentUrl = cloudflareR2Service.uploadFile(file, "event/content/" + eventId);

                    EventContent content = new EventContent();
                    content.setEventId(eventId);
                    content.setEContentTitle(file.getOriginalFilename());
                    content.setEContentPath(contentUrl);
                    content.setEContentYn("Y");
                    eventMapper.insertEventContent(content);
                }
            }
        }

        return eventId;
    }

    @Override
    public int deleteEvent(int eventId) {
        // 상세 이미지 삭제
        List<EventContent> contents = eventMapper.selectEventContents(eventId);
        for (EventContent content : contents) {
            cloudflareR2Service.deleteFile(content.getEContentPath());
        }

        // 썸네일 삭제
        Event event = eventMapper.selectEventById(eventId);
        if (event != null && event.getEventSubpath() != null) {
            cloudflareR2Service.deleteFile(event.getEventSubpath());
        }

        // DB에서 삭제
        eventMapper.deleteEventContents(eventId);
        return eventMapper.deleteEvent(eventId);
    }

    @Override
    public int deleteEventContents(int eventId) {
        return eventMapper.deleteEventContents(eventId);
    }
    
    @Override
    public List<Event> searchEvents(String keyword) {
        return eventMapper.selectEventsByKeyword(keyword);
    }
    
    @Override
    public int getCount() {
        int result = eventMapper.getCount();
        return result;
    }
}
