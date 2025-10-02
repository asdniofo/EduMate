package com.edumate.boot.app.lectures.controller;

import com.edumate.boot.domain.lectures.model.service.LecturesService;
import org.springframework.web.bind.annotation.*;
import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/lectures")
@RequiredArgsConstructor
public class LecturesController {

    private final LecturesService lecturesService;

}
