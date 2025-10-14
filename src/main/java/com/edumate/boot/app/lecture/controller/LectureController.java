package com.edumate.boot.app.lecture.controller;

import com.edumate.boot.app.lecture.dto.LectureListRequest;
import com.edumate.boot.app.lecture.dto.ReviewListRequest;
import com.edumate.boot.domain.lecture.model.service.LectureService;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import lombok.RequiredArgsConstructor;

import java.util.List;

@Controller
@RequestMapping("/lecture")
@RequiredArgsConstructor
public class LectureController {

    private final LectureService lService;

    @GetMapping("/list")
    public String showLectureList(@ModelAttribute LectureListRequest Lecture
            ,@RequestParam(value = "page", defaultValue = "1") int currentPage
            ,@RequestParam(value = "category", defaultValue = "전체") String category
            ,@RequestParam(value = "sort", defaultValue = "인기순") String sort, Model model) {
        try {
            List<LectureListRequest> lList = null;
            int totalCount = 0;
            int lectureCountPerPage = 9;
            String sortValue = null;
            if (sort.equals("인기순")) {
                sortValue = "COUNT_STUDENT DESC";
            } else if (sort.equals("최신순")){
                sortValue = "LECTURE_CREATED_DATE DESC";
            } else if (sort.equals("낮은가격순")){
                sortValue = "LECTURE_PRICE ASC";
            } else if (sort.equals("높은가격순")){
                sortValue = "LECTURE_PRICE DESC";
            } else if (sort.equals("별점높은순")){
                sortValue = "LECTURE_RATING DESC";
            }
            if (category.equals("전체")){
                totalCount = lService.getTotalCount();
                lList = lService.selectList(currentPage, lectureCountPerPage, sortValue);
            } else {
                totalCount = lService.getCategoryCount(category);
                lList = lService.selectCategoryList(currentPage, lectureCountPerPage, category, sortValue);
            }
            int maxPage = (int) Math.ceil((double) totalCount / lectureCountPerPage);
            int naviCountPerPage = 5;
            int startNavi = ((currentPage - 1) / naviCountPerPage) * naviCountPerPage + 1;
            int endNavi = (startNavi - 1) + naviCountPerPage;
            if (endNavi > maxPage) endNavi = maxPage;
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("currentPage", currentPage);
            model.addAttribute("lectureCountPerPage", lectureCountPerPage);
            model.addAttribute("maxPage", maxPage);
            model.addAttribute("startNavi", startNavi);
            model.addAttribute("endNavi", endNavi);
            model.addAttribute("lList", lList);
            model.addAttribute("category", category);
            model.addAttribute("sort", sort);
            return "lecture/list";
        } catch (Exception e) {
            model.addAttribute("errorMsg", e.getMessage());
            return "common/error";
        }
    }

    @GetMapping("/details")
    public String showDetails(@ModelAttribute LectureListRequest lecture
            ,@ModelAttribute ReviewListRequest review
            ,@RequestParam int lectureNo, Model model) {
        try {
            List<LectureListRequest> lList = lService.selectOneById(lectureNo);
            List<ReviewListRequest> rList = lService.selectReviewById(lectureNo);
            model.addAttribute("lList", lList);
            model.addAttribute("rList", rList);
            return "lecture/details";
        } catch (Exception e) {
            model.addAttribute("errorMsg", e.getMessage());
            return "common/error";
        }
    }

    @GetMapping("/player")
    public String showPlayer() {
        return "lecture/player";
    }


}
