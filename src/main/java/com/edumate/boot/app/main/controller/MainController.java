package com.edumate.boot.app.main.controller;

import com.edumate.boot.app.lecture.dto.LectureListRequest;
import com.edumate.boot.domain.lecture.model.service.LectureService;
import com.edumate.boot.domain.main.model.service.MainService;
import com.edumate.boot.domain.notice.model.service.NoticeService;
import com.edumate.boot.domain.notice.model.vo.Notice;
import com.edumate.boot.domain.teacher.model.service.TeacherService;
import com.edumate.boot.domain.teacher.model.vo.Question;
import lombok.Getter;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import lombok.RequiredArgsConstructor;

import java.util.List;

@Controller
@RequiredArgsConstructor
public class MainController {
    private final LectureService lService;
    private final NoticeService nService;
    private final TeacherService tService;

    @GetMapping("/")
    public String showMainPage(@ModelAttribute LectureListRequest Lecture
            , Model model) {
        String sortValue = null;
        List<LectureListRequest> pList = null;
        sortValue = "COUNT_STUDENT DESC";
        pList = lService.selectList(1, 4, sortValue);
        List<LectureListRequest> rList = null;
        sortValue = "LECTURE_CREATED_DATE DESC";
        rList = lService.selectList(1, 4, sortValue);
        List<Notice> nList = nService.selectNoticeList(1, 4);
        String filter = "ALL";
        List<Question> tList = tService.selectList(1, 4, filter);
        model.addAttribute("pList", pList);
        model.addAttribute("rList", rList);
        model.addAttribute("nList", nList);
        model.addAttribute("tList", tList);
        return "index";
    }

}
