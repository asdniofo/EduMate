package com.edumate.boot.app.admin.controller;

import com.edumate.boot.app.admin.dto.UserListRequest;
import com.edumate.boot.domain.admin.model.service.AdminService;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
    public String showUser(Model model) {
        List<UserListRequest> userList = adminService.getUserList();
        model.addAttribute("userList", userList);
        return "admin/admin_user";
    }

    @PostMapping("/updateUser")
    @ResponseBody
    public void updateUser(@RequestBody UserListRequest user) {
        // 구분에 따라 teacherYN, adminYN 세팅
        switch (user.getType()) {
            case "관리자" -> { user.setAdminYN("Y"); user.setTeacherYN("N"); }
            case "선생님" -> { user.setAdminYN("N"); user.setTeacherYN("Y"); }
            default -> { user.setAdminYN("N"); user.setTeacherYN("N"); }
        }
        adminService.updateUser(user);
    }

    @PostMapping("/deleteUser")
    @ResponseBody
    public void deleteUser(@RequestParam String memberId) {
        adminService.deleteUser(memberId);
    }

    @GetMapping("/setting")
    public String showSetting() {
        return "admin/basicSetting";
    }
}
