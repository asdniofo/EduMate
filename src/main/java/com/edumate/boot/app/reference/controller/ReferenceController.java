package com.edumate.boot.app.reference.controller;

import com.edumate.boot.domain.reference.model.service.ReferenceService;
import com.edumate.boot.domain.reference.model.vo.Reference;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import lombok.RequiredArgsConstructor;
import jakarta.servlet.http.HttpSession;

import java.io.File;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("/reference")
@RequiredArgsConstructor
public class ReferenceController {

	private final ReferenceService referenceService;

	@GetMapping("/list")
	public String showReferenceList(
	        @RequestParam(value = "page", defaultValue = "1") int currentPage,
	        Model model) {
	    try {
	        int totalCount = referenceService.getTotalCount();
	        int boardCountPerPage = 5;
	        int maxPage = (int) Math.ceil((double) totalCount / boardCountPerPage);
	        
	        // Map으로 파라미터 전달
	        int offset = (currentPage - 1) * boardCountPerPage;
	        java.util.Map<String, Object> paramMap = new java.util.HashMap<>();
	        paramMap.put("offset", offset);
	        paramMap.put("limit", boardCountPerPage);
	        
	        List<Reference> rList = referenceService.selectList(paramMap);
	        
	        int naviCountPerPage = 5;
	        int startNavi = ((currentPage - 1) / naviCountPerPage) * naviCountPerPage + 1;
	        int endNavi = (startNavi - 1) + naviCountPerPage;
	        
	        if (endNavi > maxPage) endNavi = maxPage;
	        
	        model.addAttribute("currentPage", currentPage);
	        model.addAttribute("maxPage", maxPage);
	        model.addAttribute("startNavi", startNavi);
	        model.addAttribute("endNavi", endNavi);
	        model.addAttribute("rList", rList);
	        
	        return "reference/list";
	    } catch (Exception e) {
	        model.addAttribute("errorMsg", e.getMessage());
	        return "common/error";
	    }
	}

	@GetMapping("/detail")
	public String showReferenceDetailView(
			@RequestParam("archiveNo") int archiveNo,
			Model model) {
		try {
			Reference reference = referenceService.selectOneByNo(archiveNo);
			model.addAttribute("reference", reference);
			return "reference/detail";
		} catch (Exception e) {
			model.addAttribute("errorMsg", e.getMessage());
			return "common/error";
		}
	}

	@GetMapping("/insert")
	public String showInsertView() {
		return "reference/insert";
	}

	@PostMapping("/insert")
	public String insertReference(
			@ModelAttribute Reference reference,
			@RequestParam(value = "uploadFile", required = false) MultipartFile uploadFile,
			HttpSession session,
			Model model) {
		try {
			String memberId = "admin"; // 실제로는 로그인한 사용자 ID 사용
			reference.setMemberId(memberId);
			
			if (uploadFile != null && !uploadFile.getOriginalFilename().isBlank()) {
				String originalName = uploadFile.getOriginalFilename();
				String renamedName = UUID.randomUUID().toString() + "_" + originalName;
				
				String folderPath = session.getServletContext().getRealPath("/resources/archiveFiles");
				uploadFile.transferTo(new File(folderPath + File.separator + renamedName));
				
				reference.setAttachmentName(originalName);
				reference.setAttachmentRename(renamedName);
				reference.setAttachmentPath("/resources/archiveFiles/" + renamedName);
			}
			
			referenceService.insertReference(reference);
			return "redirect:/reference/list";
		} catch (Exception e) {
			model.addAttribute("errorMsg", e.getMessage());
			return "common/error";
		}
	}

	@GetMapping("/modify")
	public String showModifyView(
			@RequestParam int archiveNo,
			Model model) {
		try {
			Reference reference = referenceService.selectOneByNo(archiveNo);
			model.addAttribute("reference", reference);
			return "reference/modify";
		} catch (Exception e) {
			model.addAttribute("errorMsg", e.getMessage());
			return "common/error";
		}
	}

	@PostMapping("/modify")
	public String updateReference(
			@ModelAttribute Reference reference,
			@RequestParam(value = "reloadFile", required = false) MultipartFile reloadFile,
			HttpSession session,
			Model model) {
		try {
			if (reloadFile != null && !reloadFile.getOriginalFilename().isBlank()) {
				String originalName = reloadFile.getOriginalFilename();
				String renamedName = UUID.randomUUID().toString() + "_" + originalName;
				
				String folderPath = session.getServletContext().getRealPath("/resources/archiveFiles");
				reloadFile.transferTo(new File(folderPath + File.separator + renamedName));
				
				reference.setAttachmentName(originalName);
				reference.setAttachmentRename(renamedName);
				reference.setAttachmentPath("/resources/archiveFiles/" + renamedName);
			}
			
			referenceService.updateReference(reference);
			return "redirect:/reference/detail?archiveNo=" + reference.getArchiveNo();
		} catch (Exception e) {
			model.addAttribute("errorMsg", e.getMessage());
			return "common/error";
		}
	}

	@GetMapping("/delete")
	public String deleteReference(
			@RequestParam int archiveNo,
			Model model) {
		try {
			referenceService.deleteReference(archiveNo);
			return "redirect:/reference/list";
		} catch (Exception e) {
			model.addAttribute("errorMsg", e.getMessage());
			return "common/error";
		}
	}

	@GetMapping("/search")
	public String showSearchList(
	        @RequestParam(value = "searchCondition", defaultValue = "all") String searchCondition,
	        @RequestParam(value = "searchKeyword", required = false) String searchKeyword,
	        @RequestParam(value = "page", defaultValue = "1") int currentPage,
	        Model model) {
	    try {
	        if (searchKeyword == null || searchKeyword.trim().isEmpty()) {
	            return "redirect:/reference/list";
	        }
	        
	        int boardLimit = 5;
	        int offset = (currentPage - 1) * boardLimit;
	        
	        java.util.Map<String, Object> searchMap = new java.util.HashMap<>();
	        searchMap.put("searchCondition", searchCondition);
	        searchMap.put("searchKeyword", searchKeyword.trim());
	        searchMap.put("offset", offset);
	        searchMap.put("limit", boardLimit);
	        
	        List<Reference> searchList = referenceService.selectSearchList(searchMap);
	        int totalCount = referenceService.getTotalCountBySearch(searchMap);
	        
	        if (totalCount > 0) {
	            int maxPage = (int) Math.ceil((double) totalCount / boardLimit);
	            int naviLimit = 5;
	            int startNavi = ((currentPage - 1) / naviLimit) * naviLimit + 1;
	            int endNavi = (startNavi - 1) + naviLimit;
	            
	            if (endNavi > maxPage) endNavi = maxPage;
	            
	            model.addAttribute("maxPage", maxPage);
	            model.addAttribute("startNavi", startNavi);
	            model.addAttribute("endNavi", endNavi);
	        } else {
	            model.addAttribute("maxPage", 1);
	            model.addAttribute("startNavi", 1);
	            model.addAttribute("endNavi", 1);
	        }
	        
	        model.addAttribute("currentPage", currentPage);
	        model.addAttribute("searchCondition", searchCondition);
	        model.addAttribute("searchKeyword", searchKeyword);
	        model.addAttribute("searchList", searchList);
	        
	        // list.jsp로 반환 (같은 페이지 사용)
	        return "reference/list";
	    } catch (Exception e) {
	        model.addAttribute("errorMsg", e.getMessage());
	        return "common/error";
	    }
	}

}