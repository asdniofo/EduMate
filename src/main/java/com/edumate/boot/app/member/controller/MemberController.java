package com.edumate.boot.app.member.controller;

import com.edumate.boot.app.member.dto.InsertQuestionRequest;
import com.edumate.boot.domain.member.model.service.MemberService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/member")
@RequiredArgsConstructor
public class MemberController {

    private final MemberService memberService;

    // 보여지는 화면
    @GetMapping("/insertQuestion")
    public String showInsertQuestion() {
		return "member/insertQuestion";
    }
    
    // 등록하기
    @PostMapping("/insertQuestion")
    public String insertQuestion(
    		@ModelAttribute InsertQuestionRequest question
    		, Model model) {
    	try {			
    		question.setMemberId("user01"); // 하드코딩이므로 변환필요
    		int result = memberService.insertQuestion(question);
    		return "redirect:/member/question/list";
		} catch (Exception e) {
			model.addAttribute("errorMsg", e.getMessage());
			return "common/error";
		}
    }
    
}
