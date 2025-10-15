package com.edumate.boot.app.lecture.controller;

import com.edumate.boot.app.lecture.dto.LectureListRequest;
import com.edumate.boot.app.lecture.dto.ReviewListRequest;
import com.edumate.boot.app.lecture.dto.VideoDetailRequest;
import com.edumate.boot.app.lecture.dto.VideoListRequest;
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
            ,@ModelAttribute VideoListRequest video
            ,@RequestParam int lectureNo, Model model) {
        try {
            List<LectureListRequest> lList = lService.selectOneById(lectureNo);
            List<ReviewListRequest> rList = lService.selectReviewById(lectureNo);
            int videoCount = lService.totalVideoById(lectureNo);
            int totalTime = lService.totalTimeById(lectureNo);
            List<VideoListRequest> vList = lService.selectVideoListById(lectureNo);

            StringBuilder totalTimeFormatted = new StringBuilder();
            int totalHour = totalTime / 3600;
            int totalMinute = (totalTime % 3600) / 60;
            int totalSecond = totalTime % 60;
            if (totalHour > 0) totalTimeFormatted.append(totalHour).append("시간 ");
            if (totalMinute > 0) totalTimeFormatted.append(totalMinute).append("분 ");
            if (totalSecond > 0) totalTimeFormatted.append(totalSecond).append("초");
            
            model.addAttribute("lList", lList);
            model.addAttribute("rList", rList);
            model.addAttribute("vList", vList);
            model.addAttribute("videoCount", videoCount);
            model.addAttribute("totalTimeFormatted", totalTimeFormatted.toString().trim());
            return "lecture/details";
        } catch (Exception e) {
            model.addAttribute("errorMsg", e.getMessage());
            return "common/error";
        }
    }

    @GetMapping("/player")
    public String showPlayer(@ModelAttribute VideoListRequest video
            ,@RequestParam int videoNo, Model model) {
        try {
            List<VideoListRequest> currentVideo = lService.selectVideoById(videoNo);
            int lectureNo =  currentVideo.get(0).getLectureNo();
            int nextVideoNo = currentVideo.get(0).getVideoOrder()+1;
            List<VideoListRequest> nextVideo = lService.selectNextVideoById(lectureNo,nextVideoNo);
            model.addAttribute("currentVideo", currentVideo);
            model.addAttribute("nextVideo", nextVideo);
        } catch (Exception e) {
            model.addAttribute("errorMsg", e.getMessage());
            return "common/error";
        }
        return "lecture/player";
    }


}
