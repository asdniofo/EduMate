package com.edumate.boot.app.event.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.edumate.boot.domain.event.model.service.EventService;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/event")
@RequiredArgsConstructor
public class EventController {
	
	private final EventService eventService;


	/** 이벤트 목록 */
    @GetMapping("/list")
    public String showList(Model model) {
        model.addAttribute("eList", eventService.getAllEvents());
        return "event/event_list";
    }

    /** 이벤트 상세 */
    @GetMapping("/detail")
    public String showDetail(@RequestParam("eventId") int eventId, Model model) {
        model.addAttribute("event", eventService.getEventById(eventId));
        model.addAttribute("prevEventId", eventService.getPrevEventId(eventId));
        model.addAttribute("nextEventId", eventService.getNextEventId(eventId));
        return "event/event_detail";
    }

    /** 이벤트 삭제 (관리자용) */
    @GetMapping("/delete")
    public String deleteEvent(@RequestParam("eventId") int eventId) {
        eventService.deleteEvent(eventId);
        return "redirect:/event/list";
    }
}
