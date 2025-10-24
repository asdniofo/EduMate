package com.edumate.boot.app.main.controller;

import com.edumate.boot.app.lecture.dto.LectureListRequest;
import com.edumate.boot.domain.event.model.service.EventService;
import com.edumate.boot.domain.event.model.vo.Event;
import com.edumate.boot.domain.lecture.model.service.LectureService;
import com.edumate.boot.domain.notice.model.service.NoticeService;
import com.edumate.boot.domain.notice.model.vo.Notice;
import com.edumate.boot.domain.teacher.model.service.TeacherService;
import com.edumate.boot.domain.teacher.model.vo.Question;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequiredArgsConstructor
public class MainController {

    private final LectureService lService;
    private final NoticeService nService;
    private final TeacherService tService;
    private final EventService eventService; // ✅ 이벤트 서비스 추가

    @GetMapping("/")
    public String showMainPage(@ModelAttribute LectureListRequest Lecture, Model model) {

        // 인기 강의
        String sortValue = "COUNT_STUDENT DESC";
        List<LectureListRequest> pList = lService.selectList(1, 4, sortValue);

        // 최근 강의
        sortValue = "LECTURE_CREATED_DATE DESC";
        List<LectureListRequest> rList = lService.selectList(1, 4, sortValue);

        // 공지사항
        List<Notice> nList = nService.selectNoticeList(1, 4);

        // 질문게시판
        String filter = "ALL";
        List<Question> tList = tService.selectList(1, 4, filter);

        // 이벤트 광고용 썸네일
        List<Event> adEvents = eventService.getAllEvents(); // ✅ 전체 이벤트 리스트
        model.addAttribute("adEvents", adEvents);

        // Model에 추가
        model.addAttribute("pList", pList);
        model.addAttribute("rList", rList);
        model.addAttribute("nList", nList);
        model.addAttribute("tList", tList);

        return "index";
    }
}
