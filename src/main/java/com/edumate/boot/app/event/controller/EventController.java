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

    /**
     * 이벤트 목록 페이지
     */
    @GetMapping("/list")
    public String showList(Model model) {
        List<Event> events = eventService.getAllEvents();
        model.addAttribute("eList", events);
        return "event/event_list";
    }

    /**
     * 이벤트 상세 페이지
     */
    @GetMapping("/detail")
    public String showDetail(@RequestParam("eventId") int eventId, Model model) {
        try {
            // 이벤트 기본 정보 조회
            Event event = eventService.getEventById(eventId);
            if (event == null) {
                model.addAttribute("errorMsg", "존재하지 않는 이벤트입니다.");
                return "redirect:/event/list";
            }

            // 이벤트 콘텐츠 목록 조회
            List<EventContent> contents = eventService.getEventContents(eventId);
            
            // 이전/다음 이벤트 ID 조회
            Integer prevEventId = eventService.getPrevEventId(eventId);
            Integer nextEventId = eventService.getNextEventId(eventId);

            // 모델에 데이터 추가
            model.addAttribute("event", event);
            model.addAttribute("contents", contents);
            model.addAttribute("prevEventId", prevEventId);
            model.addAttribute("nextEventId", nextEventId);
            
            return "event/event_detail";
            
        } catch (Exception e) {
            System.err.println("Error in showDetail: " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("errorMsg", "이벤트 조회 중 오류가 발생했습니다.");
            return "redirect:/event/list";
        }
    }

    /**
     * 이벤트 등록 페이지
     */
    @GetMapping("/insert")
    public String showInsertPage() {
        return "event/event_insert";
    }

    /**
     * 이벤트 등록 처리
     */
    @PostMapping("/insert")
    public String insertEvent(@ModelAttribute Event event,
                              @RequestParam("thumbnailFile") MultipartFile thumbnailFile,
                              @RequestParam("contentFiles") List<MultipartFile> contentFiles,
                              Model model) {
        try {
            int eventId = eventService.insertEvent(event, thumbnailFile, contentFiles);
            model.addAttribute("msg", "이벤트 등록이 완료되었습니다.");
            return "redirect:/event/detail?eventId=" + eventId;
        } catch (Exception e) {
            System.err.println("Error in insertEvent: " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("errorMsg", "이벤트 등록 중 오류가 발생했습니다.");
            return "event/event_insert";
        }
    }

    /**
     * 이벤트 수정 페이지
     */
    @GetMapping("/update")
    public String showUpdateForm(@RequestParam("eventId") int eventId, Model model) {
        try {
            Event event = eventService.getEventById(eventId);
            List<EventContent> contents = eventService.getEventContents(eventId);
            System.out.println("=== Debug: contents 리스트 확인 ===");
            if (contents == null) {
                System.out.println("contents is null");
            } else {
                System.out.println("contents.size() = " + contents.size());
                for (Object obj : contents) {
                    System.out.println("Object class: " + obj.getClass().getName());
                    System.out.println(obj.toString());
                }
                for (EventContent content : contents) {
                    System.out.println("eContentPath = " + content.getEContentPath());
                }
            }
            
            if (event == null) {
                model.addAttribute("errorMsg", "존재하지 않는 이벤트입니다.");
                return "redirect:/event/list";
            }
            
            model.addAttribute("event", event);
            model.addAttribute("contents", contents);
            return "event/event_update";
        } catch (Exception e) {
            System.err.println("Error in showUpdateForm: " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("errorMsg", "이벤트 조회 중 오류가 발생했습니다.");
            return "redirect:/event/list";
        }
    }

    /**
     * 이벤트 수정 처리
     */
    @PostMapping("/update")
    public String updateEvent(@ModelAttribute Event event,
                            @RequestParam(value = "mainImage", required = false) MultipartFile mainImage,
                            @RequestParam(value = "detailImages", required = false) List<MultipartFile> detailImages) {
        try {
            eventService.updateEvent(event, mainImage, detailImages);
            return "redirect:/event/detail?eventId=" + event.getEventId();
        } catch (Exception e) {
            System.err.println("Error in updateEvent: " + e.getMessage());
            e.printStackTrace();
            return "redirect:/event/update?eventId=" + event.getEventId() + "&error=true";
        }
    }

    /**
     * 이벤트 삭제
     */
    @GetMapping("/delete")
    public String deleteEvent(@RequestParam("eventId") int eventId) {
        try {
            eventService.deleteEvent(eventId);
            return "redirect:/event/list";
        } catch (Exception e) {
            System.err.println("Error in deleteEvent: " + e.getMessage());
            e.printStackTrace();
            return "redirect:/event/detail?eventId=" + eventId + "&error=true";
        }
    }
    
    @GetMapping("/search")
    public String searchEvents(@RequestParam(value = "searchKeyword", required = false) String searchKeyword,
                               Model model) {
        try {
            List<Event> events;
            if (searchKeyword == null || searchKeyword.trim().isEmpty()) {
                events = eventService.getAllEvents();
            } else {
                events = eventService.searchEvents(searchKeyword.trim());
            }
            model.addAttribute("eList", events);
            model.addAttribute("searchKeyword", searchKeyword); // JSP에서 검색창 유지용
            return "event/event_list";
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("errorMsg", "검색 중 오류가 발생했습니다.");
            return "event/event_list";
        }
    }
}