package com.edumate.boot.app.teacher.controller;

import com.edumate.boot.domain.teacher.model.service.TeacherService;
import com.edumate.boot.domain.teacher.model.vo.Question;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/teacher")
@RequiredArgsConstructor
public class TeacherController {

    private final TeacherService tService;
    
    @GetMapping("/list")
    public String showQuestionListView(@RequestParam(value = "page", defaultValue = "1" ) int currentPage 
			,Model model) {
    	try {
    		int totalCount = tService.getTotalCount();								// 전체 게시물 갯수
			int boardCountPerPage = 5;												// 한 페이지당 보여주는 게시물의 갯수
			int maxPage = totalCount % boardCountPerPage != 0 
								? totalCount/boardCountPerPage + 1 
										: totalCount/boardCountPerPage;				// 전체 페이지 수
			maxPage = (int)Math.ceil((double)totalCount/boardCountPerPage); 
			List<Question> tList = tService.selectList(currentPage, boardCountPerPage);
			int naviCountPerPage = 5;		// 한 페이징당 보여주는 페이지의 갯수	
			int startNavi = ((currentPage-1)/naviCountPerPage)*naviCountPerPage+1;	// 네비의 시작값
			int endNavi = (startNavi-1)+naviCountPerPage;							// 네비의 끝값
			if(endNavi > maxPage) endNavi = maxPage;
			model.addAttribute("currentPage", currentPage);
			model.addAttribute("maxPage", maxPage);
			model.addAttribute("startNavi", startNavi);
			model.addAttribute("endNavi", endNavi);
			model.addAttribute("tList", tList);
			return "teacher/list";
		} catch (Exception e) {
			model.addAttribute("error", e.getMessage());
			e.printStackTrace();
			return "common/error";
		}
    }

}
