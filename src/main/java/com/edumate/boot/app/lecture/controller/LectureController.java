package com.edumate.boot.app.lecture.controller;

import com.edumate.boot.domain.lecture.model.service.LectureService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/lecture")
@RequiredArgsConstructor
public class LectureController {

    private final LectureService lService;

}
