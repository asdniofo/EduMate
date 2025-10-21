package com.edumate.boot.app.admin.controller;

import com.edumate.boot.app.admin.dto.UserListRequest;
import com.edumate.boot.app.admin.dto.UserStatusRequest;
import com.edumate.boot.domain.admin.model.service.AdminService;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import lombok.RequiredArgsConstructor;

import java.util.List;

@Controller
@RequestMapping("/admin")
@RequiredArgsConstructor
public class AdminController {

    private final AdminService aService;
    
    @GetMapping("/main")
    public String showAdmin(HttpSession session) {
        String adminYn = (String) session.getAttribute("adminYn");
        if (adminYn == null || !adminYn.equals("Y")) {
            return "redirect:/";
        }
       return "admin/admin_main";
    }
    
    @GetMapping("/user")
    public String showUser(@RequestParam(value = "page", defaultValue = "1") int currentPage
            ,@RequestParam(value = "sort", defaultValue = "name") String sortType
            ,@RequestParam(value = "search", defaultValue = "") String searchKeyword
            ,HttpSession session, Model model) {
        String adminYn = (String) session.getAttribute("adminYn");
        if (adminYn == null || !adminYn.equals("Y")) {
            return "redirect:/";
        }
        try {
            UserStatusRequest uStatus = aService.getUserStatus();
            int userCountPerPage = 10;

            int totalCount = 0;
            if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
                totalCount = aService.getUserSearchCount(searchKeyword);
            } else {
                totalCount = uStatus.getTotalCount();
            }
            List<UserListRequest> uList = aService.getUserListPaging(currentPage, userCountPerPage, sortType, searchKeyword);
            int maxPage = (int) Math.ceil((double) totalCount / userCountPerPage);
            int naviCountPerPage = 5;
            int startNavi = ((currentPage - 1) / naviCountPerPage) * naviCountPerPage + 1;
            int endNavi = (startNavi - 1) + naviCountPerPage;
            if (endNavi > maxPage) endNavi = maxPage;
            
            model.addAttribute("uStatus", uStatus);
            model.addAttribute("uList", uList);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("currentPage", currentPage);
            model.addAttribute("userCountPerPage", userCountPerPage);
            model.addAttribute("maxPage", maxPage);
            model.addAttribute("startNavi", startNavi);
            model.addAttribute("endNavi", endNavi);
            model.addAttribute("currentSort", sortType);
            model.addAttribute("searchKeyword", searchKeyword);
            return "admin/admin_user";
        } catch (Exception e) {
            model.addAttribute("errorMsg", e.getMessage());
            return "common/error";
        }
    }

    @PostMapping("/updateUser")
    @ResponseBody
    public void updateUser(@RequestBody UserListRequest user) {
        // 구분에 따라 teacherYN, adminYN 세팅
        switch (user.getMemberType()) {
            case "관리자" -> { user.setAdminYn("Y"); user.setTeacherYn("N"); }
            case "선생님" -> { user.setAdminYn("N"); user.setTeacherYn("Y"); }
            default -> { user.setAdminYn("N"); user.setTeacherYn("N"); }
        }
        aService.updateUser(user);
    }

    @PostMapping("/deleteUser")
    @ResponseBody
    public void deleteUser(@RequestParam String memberId) {
        aService.deleteUser(memberId);
    }
    
    @GetMapping("/setting")
    public String showSetting(HttpSession session) {
        String adminYn = (String) session.getAttribute("adminYn");
        if (adminYn == null || !adminYn.equals("Y")) {
            return "redirect:/";
        }
       return "admin/basicSetting";
    }
}
