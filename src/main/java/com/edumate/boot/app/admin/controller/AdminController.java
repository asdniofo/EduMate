package com.edumate.boot.app.admin.controller;

import com.edumate.boot.app.admin.dto.UserListRequest;
import com.edumate.boot.app.admin.dto.UserStatusRequest;
import com.edumate.boot.app.admin.dto.WithDrawRequest;
import com.edumate.boot.app.lecture.dto.LectureListRequest;
import com.edumate.boot.app.lecture.dto.VideoListRequest;
import com.edumate.boot.domain.admin.model.service.AdminService;
import com.edumate.boot.domain.event.model.service.EventService;
import com.edumate.boot.domain.lecture.model.service.LectureService;
import com.edumate.boot.domain.member.model.service.MemberService;
import com.edumate.boot.domain.notice.model.service.NoticeService;
import com.edumate.boot.domain.reference.model.service.ReferenceService;
import com.edumate.boot.domain.teacher.model.service.TeacherService;
import jakarta.servlet.http.HttpSession;
import org.springframework.security.crypto.password.PasswordEncoder;
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
    private final EventService eService;
    private final PasswordEncoder passwordEncoder;
    
    @GetMapping("/main")
    public String showAdmin(HttpSession session, Model model) {
        String adminYn = (String) session.getAttribute("adminYn");
        if (adminYn == null || !adminYn.equals("Y")) {
            return "redirect:/";
        }
        
        // 기본 페이지에서 출금 요청 데이터를 미리 로드
        try {
            int currentPage = 1;
            int withDrawCountPerPage = 10;
            String sortType = "요청";
            
            int totalCount = aService.getTotalWithDrawByStatus(sortType);
            List<WithDrawRequest> wList = aService.getWithDrawListPaging(currentPage, withDrawCountPerPage, sortType);
            int maxPage = (int) Math.ceil((double) totalCount / withDrawCountPerPage);
            int naviCountPerPage = 5;
            int startNavi = ((currentPage - 1) / naviCountPerPage) * naviCountPerPage + 1;
            int endNavi = (startNavi - 1) + naviCountPerPage;
            if (endNavi > maxPage) endNavi = maxPage;

            model.addAttribute("wList", wList);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("currentPage", currentPage);
            model.addAttribute("withDrawCountPerPage", withDrawCountPerPage);
            model.addAttribute("maxPage", maxPage);
            model.addAttribute("startNavi", startNavi);
            model.addAttribute("endNavi", endNavi);
            model.addAttribute("currentSort", sortType);
        } catch (Exception e) {
            model.addAttribute("errorMsg", e.getMessage());
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
        // 비밀번호 BCrypt 암호화
        if (user.getMemberPw() != null && !user.getMemberPw().trim().isEmpty()) {
            user.setMemberPw(passwordEncoder.encode(user.getMemberPw()));
        }
        
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
    public String showSetting(@RequestParam(value = "page", defaultValue = "1") int currentPage
            ,@RequestParam(value = "status", defaultValue = "요청") String sortType
            ,HttpSession session, Model model) {
        String adminYn = (String) session.getAttribute("adminYn");
        if (adminYn == null || !adminYn.equals("Y")) {
            return "redirect:/";
        }
        try {
            int withDrawCountPerPage = 10;
            int totalCount = aService.getTotalWithDrawByStatus(sortType);
            List<WithDrawRequest> wList = aService.getWithDrawListPaging(currentPage, withDrawCountPerPage, sortType);
            int maxPage = (int) Math.ceil((double) totalCount / withDrawCountPerPage);
            int naviCountPerPage = 5;
            int startNavi = ((currentPage - 1) / naviCountPerPage) * naviCountPerPage + 1;
            int endNavi = (startNavi - 1) + naviCountPerPage;
            if (endNavi > maxPage) endNavi = maxPage;

            model.addAttribute("wList", wList);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("currentPage", currentPage);
            model.addAttribute("withDrawCountPerPage", withDrawCountPerPage);
            model.addAttribute("maxPage", maxPage);
            model.addAttribute("startNavi", startNavi);
            model.addAttribute("endNavi", endNavi);
            model.addAttribute("currentSort", sortType);
        }catch (Exception e) {
            model.addAttribute("errorMsg", e.getMessage());
            return "common/error";
        }
       return "admin/basicSetting";
    }
    
    @PostMapping("/withdraw/approve")
    @ResponseBody
    public String approveWithdraw(@RequestParam int withdrawNo, HttpSession session) {
        String adminYn = (String) session.getAttribute("adminYn");
        if (adminYn == null || !adminYn.equals("Y")) {
            return "권한이 없습니다.";
        }
        
        try {
            int result = aService.approveWithdrawRequest(withdrawNo);
            if (result > 0) {
                return "승인되었습니다.";
            } else {
                return "승인 처리에 실패했습니다.";
            }
        } catch (Exception e) {
            return "오류가 발생했습니다: " + e.getMessage();
        }
    }
    
    @PostMapping("/withdraw/reject")
    @ResponseBody
    public String rejectWithdraw(@RequestParam int withdrawNo, HttpSession session) {
        String adminYn = (String) session.getAttribute("adminYn");
        if (adminYn == null || !adminYn.equals("Y")) {
            return "권한이 없습니다.";
        }
        
        try {
            int result = aService.rejectWithdrawRequest(withdrawNo);
            if (result > 0) {
                return "거절되었습니다. 신청 금액이 복구되었습니다.";
            } else {
                return "거절 처리에 실패했습니다.";
            }
        } catch (Exception e) {
            return "오류가 발생했습니다: " + e.getMessage();
        }
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
        int eCount = eService.getCount();
        model.addAttribute("rCount", rCount);
        model.addAttribute("nCount", nCount);
        model.addAttribute("tCount", tCount);
        model.addAttribute("mCount", mCount);
        model.addAttribute("eCount", eCount);
        return "admin/admin_list";
    }
}
