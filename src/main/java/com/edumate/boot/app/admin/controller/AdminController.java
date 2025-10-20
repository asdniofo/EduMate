package com.edumate.boot.app.admin.controller;

import com.edumate.boot.domain.admin.model.service.AdminService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/admin")
@RequiredArgsConstructor
public class AdminController {

    private final AdminService adminService;
    
    @GetMapping("/main")
    public String showAdmin() {
    	return "admin/admin_main";
    }
    
    @GetMapping("/user")
    public String showUser() {
    	return "admin/admin_user";
    }
    
    @GetMapping("/setting")
    public String showSetting() {
    	return "admin/basicSetting";
    }
}
