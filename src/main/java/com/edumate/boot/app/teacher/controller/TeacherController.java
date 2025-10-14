package com.edumate.boot.app.teacher.controller;

import com.edumate.boot.domain.teacher.model.service.TeacherService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/teacher")
@RequiredArgsConstructor
public class TeacherController {

    private final TeacherService teacherService;

}
