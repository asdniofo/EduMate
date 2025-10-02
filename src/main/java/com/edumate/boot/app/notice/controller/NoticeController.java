package com.edumate.boot.app.notice.controller;

import com.edumate.boot.domain.notice.model.service.NoticeService;
import org.springframework.web.bind.annotation.*;
import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/notice")
@RequiredArgsConstructor
public class NoticeController {

    private final NoticeService noticeService;

}
