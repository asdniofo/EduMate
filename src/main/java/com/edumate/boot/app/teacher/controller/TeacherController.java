package com.edumate.boot.app.teacher.controller;

import com.edumate.boot.domain.teacher.model.service.TeacherService;
import com.edumate.boot.domain.teacher.model.vo.Question;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/teacher")
@RequiredArgsConstructor
public class TeacherController {

    private final TeacherService tService;
    
    @GetMapping("/question/list")
    public String showQuestionListView(@RequestParam(value = "page", defaultValue = "1" ) int currentPage 
    		, @RequestParam(value = "filter", defaultValue = "ALL") String filter
			, Model model) {
    	try {
    		int totalCount = tService.getTotalCount(filter);								// 전체 게시물 갯수
			int boardCountPerPage = 5;												// 한 페이지당 보여주는 게시물의 갯수
			int maxPage = totalCount % boardCountPerPage != 0 
								? totalCount/boardCountPerPage + 1 
										: totalCount/boardCountPerPage;				// 전체 페이지 수
			maxPage = (int)Math.ceil((double)totalCount/boardCountPerPage); 
			List<Question> tList = tService.selectList(currentPage, boardCountPerPage, filter);
			int naviCountPerPage = 5;		// 한 페이징당 보여주는 페이지의 갯수	
			int startNavi = ((currentPage-1)/naviCountPerPage)*naviCountPerPage+1;	// 네비의 시작값
			int endNavi = (startNavi-1)+naviCountPerPage;							// 네비의 끝값
			if(endNavi > maxPage) endNavi = maxPage;
			model.addAttribute("currentPage", currentPage);
			model.addAttribute("maxPage", maxPage);
			model.addAttribute("startNavi", startNavi);
			model.addAttribute("endNavi", endNavi);
			model.addAttribute("tList", tList);
			model.addAttribute("filter", filter);
			return "teacher/list";
		} catch (Exception e) {
			model.addAttribute("error", e.getMessage());
			e.printStackTrace();
			return "common/error";
		}
    }
    
    @GetMapping("/question/search")
	public String showNoticeSearchList(
			@RequestParam("searchKeyword") String searchKeyword
			, @RequestParam(value = "page", defaultValue = "1") int currentPage
			, @RequestParam(value = "filter", defaultValue = "ALL") String filter
			, Model model) {
		try {
			int boardLimit = 5;
			String upperKeyword = searchKeyword.toUpperCase();
			Map<String, Object> searchMap = new HashMap<String, Object>();
			searchMap.put("filter", filter);
			searchMap.put("searchKeyword", upperKeyword);
			searchMap.put("currentPage", currentPage);
			searchMap.put("boardLimit", boardLimit);
			List<Question> searchList = tService.selectSearchList(searchMap);
			if(searchList != null && !searchList.isEmpty()) {
				// 페이징처리 코드 작성
				int totalCount = tService.getTotalCount(searchMap);
				int maxPage = (int)Math.ceil((double)totalCount/boardLimit);
				int naviLimit = 5;
				int startNavi = ((currentPage-1)/naviLimit)*naviLimit+1;
				int endNavi = (startNavi-1)+naviLimit;
				if(endNavi > maxPage) endNavi = maxPage;
				model.addAttribute("maxPage", maxPage);
				model.addAttribute("startNavi", startNavi);
				model.addAttribute("endNavi", endNavi);
				model.addAttribute("currentPage", currentPage);
			}
			model.addAttribute("searchList", searchList);
			model.addAttribute("searchKeyword", searchKeyword);
			 model.addAttribute("filter", filter);
			return "teacher/search";
		} catch (Exception e) {
			model.addAttribute("errorMsg", e.getMessage());
			return "common/error";
		}
	}
    
    @GetMapping("/question/detail")
    public String showDetailView(int questionNo, Model model) {
    	try {
			Question question = tService.selectOneByNo(questionNo);
			model.addAttribute("question", question);
			return "teacher/detail";
		} catch (Exception e) {
			return "common/error";
		}
    }

}
