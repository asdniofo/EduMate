package com.edumate.boot.domain.event.model.service.impl;

import java.io.IOException;
import java.nio.file.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

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

    // base upload dir (project root or absolute path)
    private final Path uploadBase = Paths.get("uploads", "events");

    @Override
    public List<Event> getAllEvents() {
        return eventMapper.selectAllEvents();
    }

    @Override
    public Event getEventById(int eventId) {
        Event e = eventMapper.selectEventById(eventId);
        return e;
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

    private String storeFile(MultipartFile file, String subDir) throws IOException {
        if (file == null || file.isEmpty()) return null;

        Path dir = uploadBase.resolve(subDir);
        Files.createDirectories(dir);

        // unique filename: timestamp + original name
        String orig = Paths.get(file.getOriginalFilename()).getFileName().toString();
        String filename = System.currentTimeMillis() + "_" + orig;
        Path target = dir.resolve(filename);

        Files.copy(file.getInputStream(), target, StandardCopyOption.REPLACE_EXISTING);
        // return relative path to be stored in DB (you can change as needed)
        return "/uploads/events/" + subDir + "/" + filename;
    }

    @Override
    @Transactional
    public int insertEvent(Event event, MultipartFile mainImage, List<MultipartFile> detailImages) throws Exception {
        // 1) get next event id
        int nextEventId = eventMapper.getNextEventId();
        event.setEventId(nextEventId);

        // 2) store main image
        String mainPath = null;
        if (mainImage != null && !mainImage.isEmpty()) {
            mainPath = storeFile(mainImage, "main");
            event.setEventPath(mainPath);
            event.setEventSubpath(mainPath); // set thumbnail same for now
        } else {
            event.setEventPath("");
            event.setEventSubpath("");
        }

        // 3) insert event
        eventMapper.insertEvent(event);

        // 4) insert detail images
        if (detailImages != null && !detailImages.isEmpty()) {
            for (MultipartFile mf : detailImages) {
                if (mf == null || mf.isEmpty()) continue;
                int nextContentNo = eventMapper.getNextContentNo();
                EventContent content = new EventContent();
                content.setEContentNo(nextContentNo);
                content.setEventId(nextEventId);
                content.setEContentTitle(mf.getOriginalFilename());
                String contentPath = storeFile(mf, "content");
                content.setEContentPath(contentPath);
                content.setEContentYn("Y");
                eventMapper.insertEventContent(content);
            }
        }

        return nextEventId;
    }

    @Override
    @Transactional
    public int updateEvent(Event event, MultipartFile mainImage, List<MultipartFile> detailImages) throws Exception {
        // assume event.eventId is already set
        // 1) handle main image if provided
        if (mainImage != null && !mainImage.isEmpty()) {
            String mainPath = storeFile(mainImage, "main");
            event.setEventPath(mainPath);
            event.setEventSubpath(mainPath);
        }
        // update board
        int updated = eventMapper.updateEvent(event);

        // optional: add new detail images (we keep existing ones)
        if (detailImages != null && !detailImages.isEmpty()) {
            for (MultipartFile mf : detailImages) {
                if (mf == null || mf.isEmpty()) continue;
                int nextContentNo = eventMapper.getNextContentNo();
                EventContent content = new EventContent();
                content.setEContentNo(nextContentNo);
                content.setEventId(event.getEventId());
                content.setEContentTitle(mf.getOriginalFilename());
                String contentPath = storeFile(mf, "content");
                content.setEContentPath(contentPath);
                content.setEContentYn("Y");
                eventMapper.insertEventContent(content);
            }
        }

        return updated;
    }

    @Override
    public int deleteEvent(int eventId) {
        return eventMapper.deleteEvent(eventId);
    }

	@Override
	public int insertEvent(Event event) {
		return eventMapper.insertEvent(event);
	}

	@Override
	public int insertEventContent(EventContent content) {
		return eventMapper.insertEventContent(content);
	}
}
