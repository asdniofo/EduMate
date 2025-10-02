package com.edumate.boot.app.admin.controller;

import com.edumate.boot.domain.admin.model.service.AdminService;
import org.springframework.web.bind.annotation.*;
import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/admin")
@RequiredArgsConstructor
public class AdminController {

    private final AdminService adminService;

}
