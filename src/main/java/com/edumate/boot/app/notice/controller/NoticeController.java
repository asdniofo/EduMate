package com.edumate.boot.app.notice.controller;

import com.edumate.boot.domain.notice.model.service.NoticeService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/notice")
@RequiredArgsConstructor
public class NoticeController {

    private final NoticeService noticeService;

    @GetMapping("/list")
    public String showNoticeList() {
    	return "notice/list";
    }
    
    @GetMapping("/detail")
    public String showNoticeDetail() {
    	return "notice/detail";
    }
    
    @GetMapping("/insert")
    public String showNoticeInsert() {
    	return "notice/insert";
    }
}
