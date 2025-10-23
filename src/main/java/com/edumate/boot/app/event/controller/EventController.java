package com.edumate.boot.app.event.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.List;
import java.util.UUID;

import com.edumate.boot.domain.event.model.service.EventService;
import com.edumate.boot.domain.event.model.vo.Event;
import com.edumate.boot.domain.event.model.vo.EventContent;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@Controller
@RequestMapping("/event")
@RequiredArgsConstructor
public class EventController {

    private final EventService eventService;

    @GetMapping("/list")
    public String showList(Model model) {
        model.addAttribute("eList", eventService.getAllEvents());
        return "event/event_list";
    }

    @GetMapping("/detail")
    public String showDetail(@RequestParam("eventId") int eventId, Model model) {
    	Event event = eventService.getEventById(eventId);
        List<EventContent> contents = eventService.getEventContents(eventId);

        // 디버그용 로그
        System.out.println("Event: " + event);
        if (contents != null) {
            for (EventContent c : contents) {
                System.out.println("Content: " + c.getEContentNo() + ", " + c.getEContentTitle() + ", " + c.getEContentPath());
            }
        } else {
            System.out.println("Contents list is null!");
        }

        Integer prev = eventService.getPrevEventId(eventId);
        Integer next = eventService.getNextEventId(eventId);

        model.addAttribute("event", event);
        model.addAttribute("contents", contents);
        model.addAttribute("prevEventId", prev);
        model.addAttribute("nextEventId", next);
        return "event/event_detail";
    }

    @GetMapping("/insert")
    public String showInsertPage() {
        return "event/event_insert";
    }

 // 이벤트 등록 처리
    @PostMapping("/insert")
    public String insertEvent(@ModelAttribute Event event,
                              @RequestParam("thumbnailFile") MultipartFile thumbnailFile,
                              @RequestParam("contentFiles") List<MultipartFile> contentFiles,
                              Model model) throws IOException {

        // 경로 설정
        String basePath = "C:/EduMate/src/main/webapp/resources/images/event/";
        String thumbnailPath = basePath + "thumbnail/";
        String contentPath = basePath + "content/";

        // 디렉토리 없으면 생성
        new File(thumbnailPath).mkdirs();
        new File(contentPath).mkdirs();

        // 썸네일 업로드
        if (!thumbnailFile.isEmpty()) {
            String thumbnailName = UUID.randomUUID() + "_" + thumbnailFile.getOriginalFilename();
            File thumbnailSave = new File(thumbnailPath + thumbnailName);
            try (OutputStream os = new FileOutputStream(thumbnailSave)) {
                os.write(thumbnailFile.getBytes());
            }
            event.setEventSubpath("/resources/images/event/thumbnail/" + thumbnailName);
        }

        // 첫 번째 콘텐츠 이미지를 상세 이미지로 설정 (또는 대표 이미지)
        if (!contentFiles.isEmpty()) {
            MultipartFile first = contentFiles.get(0);
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
        eventService.insertEvent(event);

        // 등록된 EVENT_ID 가져오기
        int eventId = event.getEventId();

        // 콘텐츠 파일 업로드
        for (MultipartFile file : contentFiles) {
            if (!file.isEmpty()) {
                String fileName = UUID.randomUUID() + "_" + file.getOriginalFilename();
                File saveFile = new File(contentPath + fileName);
                try (OutputStream os = new FileOutputStream(saveFile)) {
                    os.write(file.getBytes());
                }

                EventContent content = new EventContent();
                content.setEventId(eventId);
                content.setEContentTitle(file.getOriginalFilename());
                content.setEContentPath("/resources/images/event/content/" + fileName);

                eventService.insertEventContent(content);
            }
        }

        model.addAttribute("msg", "이벤트 등록이 완료되었습니다.");
        return "redirect:/event/list";
    }


    // 수정 폼
    @GetMapping("/update")
    public String showUpdateForm(@RequestParam("eventId") int eventId, Model model) {
        Event event = eventService.getEventById(eventId);
        List<EventContent> contents = eventService.getEventContents(eventId);
        model.addAttribute("event", event);
        model.addAttribute("contents", contents);
        return "event/event_update"; // user can create this JSP similar to insert
    }

    // 수정 처리
    @PostMapping("/update")
    public String updateEvent(
            @ModelAttribute Event event,
            @RequestParam(value = "mainImage", required = false) MultipartFile mainImage,
            @RequestParam(value = "detailImages", required = false) List<MultipartFile> detailImages
    ) throws Exception {
        eventService.updateEvent(event, mainImage, detailImages);
        return "redirect:/event/detail?eventId=" + event.getEventId();
    }

    // 삭제
    @GetMapping("/delete")
    public String deleteEvent(@RequestParam("eventId") int eventId) {
        eventService.deleteEvent(eventId);
        return "redirect:/event/list";
    }
}
