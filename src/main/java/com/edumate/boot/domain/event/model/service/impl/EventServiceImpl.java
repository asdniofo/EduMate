package com.edumate.boot.domain.event.model.service.impl;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.List;
import java.util.UUID;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.edumate.boot.domain.event.model.mapper.EventMapper;
import com.edumate.boot.domain.event.model.service.EventService;
import com.edumate.boot.domain.event.model.vo.Event;
import com.edumate.boot.domain.event.model.vo.EventContent;

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
        // 경로 설정
        String basePath = "C:/EduMate/src/main/webapp/resources/images/event/";
        String thumbnailPath = basePath + "thumbnail/";
        String contentPath = basePath + "content/";

        // 디렉토리 생성
        new File(thumbnailPath).mkdirs();
        new File(contentPath).mkdirs();

        // 썸네일 업로드
        if (mainImage != null && !mainImage.isEmpty()) {
            String thumbnailName = UUID.randomUUID() + "_" + mainImage.getOriginalFilename();
            File thumbnailSave = new File(thumbnailPath + thumbnailName);
            try (OutputStream os = new FileOutputStream(thumbnailSave)) {
                os.write(mainImage.getBytes());
            }
            event.setEventSubpath("/resources/images/event/thumbnail/" + thumbnailName);
        }

        // 메인 이미지 설정 (첫 번째 콘텐츠 이미지 또는 썸네일)
        if (detailImages != null && !detailImages.isEmpty()) {
            MultipartFile first = detailImages.get(0);
            if (!first.isEmpty()) {
                String firstName = UUID.randomUUID() + "_" + first.getOriginalFilename();
                File contentSave = new File(contentPath + firstName);
                try (OutputStream os = new FileOutputStream(contentSave)) {
                    os.write(first.getBytes());
                }
                event.setEventPath("/resources/images/event/content/" + firstName);
            }
        }

        // 이벤트 등록
        eventMapper.insertEvent(event);

        // 등록된 EVENT_ID 가져오기
        int eventId = event.getEventId();

        // 콘텐츠 파일 업로드
        if (detailImages != null) {
            for (MultipartFile file : detailImages) {
                if (file != null && !file.isEmpty()) {
                    String fileName = UUID.randomUUID() + "_" + file.getOriginalFilename();
                    File saveFile = new File(contentPath + fileName);
                    try (OutputStream os = new FileOutputStream(saveFile)) {
                        os.write(file.getBytes());
                    }

                    EventContent content = new EventContent();
                    content.setEventId(eventId);
                    content.setEContentTitle(file.getOriginalFilename());
                    content.setEContentPath("/resources/images/event/content/" + fileName);
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
        // 경로 설정
        String basePath = "C:/EduMate/src/main/webapp/resources/images/event/";
        String thumbnailPath = basePath + "thumbnail/";
        String contentPath = basePath + "content/";

        // 디렉토리 생성
        new File(thumbnailPath).mkdirs();
        new File(contentPath).mkdirs();

        // 메인 이미지 업데이트
        if (mainImage != null && !mainImage.isEmpty()) {
            String thumbnailName = UUID.randomUUID() + "_" + mainImage.getOriginalFilename();
            File thumbnailSave = new File(thumbnailPath + thumbnailName);
            try (OutputStream os = new FileOutputStream(thumbnailSave)) {
                os.write(mainImage.getBytes());
            }
            event.setEventSubpath("/resources/images/event/thumbnail/" + thumbnailName);
            event.setEventPath("/resources/images/event/thumbnail/" + thumbnailName);
        }

        // 이벤트 수정
        int updated = eventMapper.updateEvent(event);

        // 새로운 상세 이미지 추가
        if (detailImages != null) {
            for (MultipartFile file : detailImages) {
                if (file != null && !file.isEmpty()) {
                    String fileName = UUID.randomUUID() + "_" + file.getOriginalFilename();
                    File saveFile = new File(contentPath + fileName);
                    try (OutputStream os = new FileOutputStream(saveFile)) {
                        os.write(file.getBytes());
                    }

                    EventContent content = new EventContent();
                    content.setEventId(event.getEventId());
                    content.setEContentTitle(file.getOriginalFilename());
                    content.setEContentPath("/resources/images/event/content/" + fileName);
                    content.setEContentYn("Y");

                    eventMapper.insertEventContent(content);
                }
            }
        }

        return updated;
    }

    @Override
    public int deleteEvent(int eventId) {
        return eventMapper.deleteEvent(eventId);
    }
}