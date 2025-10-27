package com.edumate.boot.domain.event.model.service.impl;

import java.io.File;
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
    private final String BASE_PATH = "C:/Users/user1/Desktop/Five_Devs/EduMate/src/main/webapp/resources/images/event/";

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

        // 1️⃣ 썸네일 업로드 & 경로 세팅 (DB INSERT 전에)
        if (mainImage != null && !mainImage.isEmpty()) {
            String ext = mainImage.getOriginalFilename().substring(mainImage.getOriginalFilename().lastIndexOf("."));
            String uuid = UUID.randomUUID().toString();
            String saveDirPath = BASE_PATH + "thumbnail/";
            File saveDir = new File(saveDirPath);
            if (!saveDir.exists()) saveDir.mkdirs();

            // 폴더는 eventId가 없으므로 임시로 UUID 폴더 사용
            String saveFilePath = saveDirPath + uuid + ext;
            mainImage.transferTo(new File(saveFilePath));

            String dbPath = "/resources/images/event/thumbnail/" + uuid + ext;
            event.setEventPath(dbPath);
            event.setEventSubpath(dbPath);
        } else {
            throw new Exception("썸네일 이미지는 필수입니다.");
        }

        // 2️⃣ DB에 이벤트 기본 정보 INSERT
        eventMapper.insertEvent(event); // useGeneratedKeys="true"로 eventId 세팅됨
        int eventId = event.getEventId();

        // 3️⃣ 썸네일 실제 폴더로 이동 (eventId 폴더 생성)
        String oldPath = BASE_PATH + "thumbnail/" + event.getEventPath().substring(event.getEventPath().lastIndexOf("/") + 1);
        String newDirPath = BASE_PATH + "thumbnail/" + eventId + "/";
        File newDir = new File(newDirPath);
        if (!newDir.exists()) newDir.mkdirs();
        File newFile = new File(newDirPath + oldPath.substring(oldPath.lastIndexOf("/") + 1));
        if (newFile.exists()) newFile.delete();
        new File(oldPath).renameTo(newFile);

        String newDbPath = "/resources/images/event/thumbnail/" + eventId + "/" + newFile.getName();
        event.setEventPath(newDbPath);
        event.setEventSubpath(newDbPath);

        // 4️⃣ DB 경로 업데이트
        eventMapper.updateEvent(event);

        // 5️⃣ 상세 이미지 업로드
        if (detailImages != null && !detailImages.isEmpty()) {
            for (MultipartFile file : detailImages) {
                if (!file.isEmpty()) {
                    String ext = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
                    String uuid = UUID.randomUUID().toString();
                    String saveDirPath = BASE_PATH + "content/" + eventId + "/";
                    File saveDir = new File(saveDirPath);
                    if (!saveDir.exists()) saveDir.mkdirs();

                    String saveFilePath = saveDirPath + uuid + ext;
                    file.transferTo(new File(saveFilePath));

                    EventContent content = new EventContent();
                    content.setEventId(eventId);
                    content.setEContentTitle(file.getOriginalFilename());
                    content.setEContentPath("/resources/images/event/content/" + eventId + "/" + uuid + ext);
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
            if (oldEvent.getEventPath() != null) {
                File oldFile = new File(BASE_PATH + "thumbnail/" + eventId + "/" + oldEvent.getEventPath().substring(oldEvent.getEventPath().lastIndexOf("/") + 1));
                if (oldFile.exists()) oldFile.delete();
            }

            String ext = mainImage.getOriginalFilename().substring(mainImage.getOriginalFilename().lastIndexOf("."));
            String uuid = UUID.randomUUID().toString();
            String saveDirPath = BASE_PATH + "thumbnail/" + eventId + "/";
            File saveDir = new File(saveDirPath);
            if (!saveDir.exists()) saveDir.mkdirs();

            String saveFilePath = saveDirPath + uuid + ext;
            mainImage.transferTo(new File(saveFilePath));

            String dbPath = "/resources/images/event/thumbnail/" + eventId + "/" + uuid + ext;
            event.setEventPath(dbPath);
            event.setEventSubpath(dbPath);

            event.setEventPath(dbPath);
            event.setEventSubpath(dbPath);
            eventMapper.updateEvent(event);
        } else {
            event.setEventPath(oldEvent.getEventPath());
            event.setEventSubpath(oldEvent.getEventSubpath());
        }

        // 3️⃣ 이벤트 기본 정보 업데이트
        eventMapper.updateEvent(event);

        // 4️⃣ 상세 이미지 교체
        if (detailImages != null && !detailImages.isEmpty()) {
            List<EventContent> oldContents = eventMapper.selectEventContents(eventId);
            for (EventContent c : oldContents) {
                File f = new File(BASE_PATH + "content/" + eventId + "/" + c.getEContentPath().substring(c.getEContentPath().lastIndexOf("/") + 1));
                if (f.exists()) f.delete();
            }
            eventMapper.deleteEventContents(eventId);

            for (MultipartFile file : detailImages) {
                if (!file.isEmpty()) {
                    String ext = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
                    String uuid = UUID.randomUUID().toString();
                    String saveDirPath = BASE_PATH + "content/" + eventId + "/";
                    File saveDir = new File(saveDirPath);
                    if (!saveDir.exists()) saveDir.mkdirs();

                    String saveFilePath = saveDirPath + uuid + ext;
                    file.transferTo(new File(saveFilePath));

                    EventContent content = new EventContent();
                    content.setEventId(eventId);
                    content.setEContentTitle(file.getOriginalFilename());
                    content.setEContentPath("/resources/images/event/content/" + eventId + "/" + uuid + ext);
                    content.setEContentYn("Y");
                    eventMapper.insertEventContent(content);
                }
            }
        }

        return eventId;
    }

    @Override
    public int deleteEvent(int eventId) {
        List<EventContent> contents = eventMapper.selectEventContents(eventId);
        for (EventContent content : contents) {
            File f = new File(BASE_PATH + "content/" + eventId + "/" + content.getEContentPath().substring(content.getEContentPath().lastIndexOf("/") + 1));
            if (f.exists()) f.delete();
        }

        Event event = eventMapper.selectEventById(eventId);
        if (event != null) {
            File thumb = new File(BASE_PATH + "thumbnail/" + eventId + "/" + event.getEventSubpath().substring(event.getEventSubpath().lastIndexOf("/") + 1));
            if (thumb.exists()) thumb.delete();
        }

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
}
