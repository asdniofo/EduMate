package com.edumate.boot.app.notice.controller;

import com.edumate.boot.domain.notice.model.service.NoticeService;
import com.edumate.boot.domain.notice.model.vo.Notice;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/notice")
@RequiredArgsConstructor
public class NoticeController {

    private final NoticeService noticeService;

    @GetMapping("/list")
    public String showNoticeList(@RequestParam(value = "page", defaultValue = "1") int currentPage, Model model) {
    	try {			
    		int totalCount = noticeService.getTotalCount();
    		int boardCountPerPage = 5; // 한페이지에 보여줄 공지사항갯수
    		int maxPage = totalCount % boardCountPerPage != 0
    				? totalCount / boardCountPerPage + 1
    						: totalCount / boardCountPerPage;
    		maxPage = (int)Math.ceil((double)totalCount/boardCountPerPage);
    		List<Notice> nList = noticeService.selectNoticeList(currentPage, boardCountPerPage);
    		int naviCountPerPage = 10;
    		int startNavi = ((currentPage-1)/naviCountPerPage*naviCountPerPage+1);
    		int endNavi = (startNavi-1)+naviCountPerPage;
    		if(endNavi > maxPage) {
    			endNavi = maxPage;
    		}
			model.addAttribute("maxPage", maxPage);
			model.addAttribute("currentPage", currentPage);
			model.addAttribute("startNavi", startNavi);
			model.addAttribute("endNavi", endNavi);
			model.addAttribute("nList", nList);
			return "notice/list";
		} catch (Exception e) {
			model.addAttribute("errorMsg", e.getMessage());
			return "common/error";
		}
    }
    
    @GetMapping("/search")
    public String showNoticeSearchList(
    		@RequestParam("searchKeyword") String searchKeyword,
    		@RequestParam(value = "page", defaultValue = "1") int currentPage,
    		Model model	) {
    	try {
			int boardLimit = 5;
			Map<String, Object> searchMap = new HashMap<String, Object>();
			searchMap.put("searchKeyword", searchKeyword);
			searchMap.put("currentPage", currentPage);
			searchMap.put("boardLimit", boardLimit);
			List<Notice> searchList = noticeService.selectSearchList(searchMap);
			if (searchList != null && !searchList.isEmpty()) {
				int totalCount = noticeService.getTotalCount(searchMap);
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
			return "notice/search";
		} catch (Exception e) {
			model.addAttribute("errorMsg", e.getMessage());
			return "common/error";
		}
    }
    
    @GetMapping("/detail")
    public String showNoticeDetail(
    		@RequestParam("noticeId") int noticeId
    		, Model model) {
    	try {
			Notice notice = noticeService.selectByOneNo(noticeId);
			Integer prevNoticeNo = noticeService.selectPrevNotice(noticeId);
			Integer nextNoticeNo = noticeService.selectNextNotice(noticeId);
			model.addAttribute("notice", notice);
			model.addAttribute("prevNoticeNo", prevNoticeNo);
			model.addAttribute("nextNoticeNo", nextNoticeNo);
		} catch (Exception e) {
			model.addAttribute("errorMsg", e.getMessage());
			return "common/error";
		}
    	return "notice/detail";
    }
    
    @GetMapping("/insert")
    public String showNoticeInsert() {
    	return "notice/insert";
    }
}
