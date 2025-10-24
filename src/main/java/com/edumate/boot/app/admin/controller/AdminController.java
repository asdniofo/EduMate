package com.edumate.boot.app.admin.controller;

import com.edumate.boot.app.admin.dto.UserListRequest;
import com.edumate.boot.app.admin.dto.UserStatusRequest;
import com.edumate.boot.app.lecture.dto.LectureListRequest;
import com.edumate.boot.app.lecture.dto.VideoListRequest;
import com.edumate.boot.domain.admin.model.service.AdminService;
import com.edumate.boot.domain.lecture.model.service.LectureService;
import com.edumate.boot.domain.member.model.service.MemberService;
import com.edumate.boot.domain.notice.model.service.NoticeService;
import com.edumate.boot.domain.reference.model.service.ReferenceService;
import com.edumate.boot.domain.teacher.model.service.TeacherService;
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
    private final LectureService lService;
    private final NoticeService nService;
    private final ReferenceService rService;
    private final TeacherService tService;
    private final MemberService mService;
    
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
        String memberType = user.getMemberType();
        if (memberType != null) {
            switch (memberType) {
                case "관리자" -> { user.setAdminYn("Y"); user.setTeacherYn("N"); }
                case "선생님" -> { user.setAdminYn("N"); user.setTeacherYn("Y"); }
                default -> { user.setAdminYn("N"); user.setTeacherYn("N"); }
            }
        } else {
            user.setAdminYn("N"); 
            user.setTeacherYn("N");
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
    
    @GetMapping("/lecture")
    public String showLecture(@RequestParam(value = "page", defaultValue = "1") int currentPage
            ,@RequestParam(value = "sort", defaultValue = "name") String sortType
            ,@RequestParam(value = "search", defaultValue = "") String searchKeyword
            ,HttpSession session, Model model) {
        String adminYn = (String) session.getAttribute("adminYn");
        if (adminYn == null || !adminYn.equals("Y")) {
            return "redirect:/";
        }
        try {
            int lectureCountPerPage = 5;
            String sortValue = getSortValue(sortType);
            
            int totalCount = 0;
            List<LectureListRequest> lectureList = null;
            
            if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
                totalCount = lService.getSearchCountAllForAdmin(searchKeyword);
                lectureList = lService.selectSearchAllForAdmin(currentPage, lectureCountPerPage, searchKeyword, sortValue);
            } else {
                totalCount = lService.getTotalCount();
                lectureList = lService.selectList(currentPage, lectureCountPerPage, sortValue);
            }
            
            int maxPage = (int) Math.ceil((double) totalCount / lectureCountPerPage);
            int naviCountPerPage = 5;
            int startNavi = ((currentPage - 1) / naviCountPerPage) * naviCountPerPage + 1;
            int endNavi = (startNavi - 1) + naviCountPerPage;
            if (endNavi > maxPage) endNavi = maxPage;
            
            model.addAttribute("lectureList", lectureList);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("currentPage", currentPage);
            model.addAttribute("lectureCountPerPage", lectureCountPerPage);
            model.addAttribute("maxPage", maxPage);
            model.addAttribute("startNavi", startNavi);
            model.addAttribute("endNavi", endNavi);
            model.addAttribute("currentSort", sortType);
            model.addAttribute("searchKeyword", searchKeyword);
            return "admin/admin_lecture";
        } catch (Exception e) {
            model.addAttribute("errorMsg", e.getMessage());
            return "common/error";
        }
    }
    
    @GetMapping("/lecture/videos")
    @ResponseBody
    public List<VideoListRequest> getLectureVideos(@RequestParam int lectureNo) {
        return lService.selectVideoListById(lectureNo);
    }
    
    @PostMapping("/lecture/deleteVideo")
    @ResponseBody
    public void deleteVideo(@RequestParam int videoNo, @RequestParam int lectureNo) {
        lService.deleteVideoAndReorder(videoNo, lectureNo);
    }
    
    @PostMapping("/lecture/delete")
    @ResponseBody
    public void deleteLecture(@RequestParam int lectureNo) {
        lService.deleteLecture(lectureNo);
    }
    
    private String getSortValue(String sortType) {
        return switch (sortType) {
            case "name" -> "L.LECTURE_NAME ASC";
            case "date" -> "L.LECTURE_CREATED_DATE DESC";
            case "category" -> "L.LECTURE_CATEGORY ASC";
            case "instructor" -> "M.MEMBER_NAME ASC";
            default -> "L.LECTURE_NAME ASC";
        };
    }

    @GetMapping("/list")
    public String showList(Model model) {
        int rCount = rService.getTotalCount();
        int nCount = nService.getTotalCount();
        String filter = "ALL";
        int tCount = tService.getTotalCount(filter);
        int mCount = mService.getCount();
        model.addAttribute("rCount", rCount);
        model.addAttribute("nCount", nCount);
        model.addAttribute("tCount", tCount);
        model.addAttribute("mCount", mCount);
        return "admin/admin_list";
    }
}
