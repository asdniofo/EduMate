package com.edumate.boot.app.teacher.controller;

import com.edumate.boot.domain.teacher.model.service.TeacherService;
import org.springframework.web.bind.annotation.*;
import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/teacher")
@RequiredArgsConstructor
public class TeacherController {

    private final TeacherService teacherService;

}
