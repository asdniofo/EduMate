package com.edumate.boot.app.member.controller;

import com.edumate.boot.app.member.dto.InsertQuestionRequest;
import com.edumate.boot.domain.member.model.service.MemberService;
import com.edumate.boot.domain.member.model.vo.Member;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import jakarta.servlet.http.HttpSession;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.URL;
import java.sql.Date;

import javax.net.ssl.HttpsURLConnection;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/member")
@RequiredArgsConstructor
public class MemberController {

    private final MemberService memberService;
    
    @GetMapping("/login")
    public String showLogin() {
		  return "member/login";
    }

    @PostMapping("/login")
    public String login(
            @RequestParam("memberId") String memberId,
            @RequestParam("memberPw") String memberPw,
            HttpSession session) {

        Member loginUser = memberService.login(memberId, memberPw);
        
        String loginId = loginUser.getMemberId();

        if (loginUser != null) {
            session.setAttribute("loginId", loginId);
            return "redirect:/"; // 로그인 성공 → 메인 페이지로 이동
        } else {
            return "redirect:/member/login?error=1"; // 로그인 실패 시 다시 로그인 페이지
        }
    }

    // 로그아웃
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }

    @GetMapping("/signup/terms")
    public String showTerms() {
      return "member/signup_terms";
    }

    @GetMapping("/signup/info")
    public String showInfo() {
      return "member/signup_info";
    }

    @PostMapping("/signup/info")
    public String submitSignupInfo(
    		 	@RequestParam 	String memberId,
    	        @RequestParam 	String memberPw,
    	        @RequestParam	String memberName,
    	        @RequestParam 	String memberEmail,
    	        @RequestParam 	String memberBirth,
    	        @RequestParam	("g-recaptcha-response") String recaptchaResponse,
    	        Model model) {

    // 1️⃣ 캡챠 검증
    boolean captchaValid = verifyRecaptcha(recaptchaResponse);
    if(!captchaValid) {
        model.addAttribute("errorMessage", "[reCaptcha] 인증에 실패했습니다.");
        return "error"; // 다시 회원가입 페이지로
    }

    // 2️⃣ DB 저장
    java.sql.Date birthDate = java.sql.Date.valueOf(memberBirth);
    Member member = new Member();
    member.setMemberId(memberId);
    member.setMemberPw(memberPw);
    member.setMemberName(memberName);
    member.setMemberEmail(memberEmail);
    member.setMemberBirth(memberBirth);
    member.setMemberMoney(0);
    member.setTeacherYN("N");
    member.setAdminYN("N");

    memberService.signup(member);

    // 3️⃣ 완료 후 페이지
    return "redirect:/member/signup/complete";
}

// 🔹 캡챠 검증 메서드
    private boolean verifyRecaptcha(String recaptchaResponse) {
        String secretKey = "6LdI9OorAAAAAGTZcJRgdBLA5VdUFxQN4-1s-aXL";
        String apiUrl = "https://www.google.com/recaptcha/api/siteverify";

        try {
            URL url = new URL(apiUrl);
            HttpsURLConnection conn = (HttpsURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setDoOutput(true);

            String postParams = "secret=" + secretKey + "&response=" + recaptchaResponse;
            OutputStream out = conn.getOutputStream();
            out.write(postParams.getBytes());
            out.flush();
            out.close();

            BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            StringBuilder response = new StringBuilder();
            String inputLine;
            while ((inputLine = in.readLine()) != null) {
                response.append(inputLine);
            }
            in.close();

            // Jackson으로 JSON 파싱
            ObjectMapper mapper = new ObjectMapper();
            JsonNode jsonNode = mapper.readTree(response.toString());
            return jsonNode.get("success").asBoolean();

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    @GetMapping("/signup/complete")
    public String showComplete() {
      return "member/signup_done";
    }
    
    @GetMapping("/find")
    public String showFind() {
    	return "member/find_info";
    }
    
    @PostMapping("/findId")
    public String findId(Member member, Model model) {
        String foundId = memberService.findMemberId(member);

        if (foundId != null) {
            model.addAttribute("foundId", foundId);
            return "member/find_id"; // 아이디 결과 페이지
        } else {
            model.addAttribute("msg", "일치하는 회원 정보가 없습니다.");
            return "member/find_info";
        }
    }
    
    @PostMapping("/findPw")
    public String findPw(Member member, Model model) {
        boolean exists = memberService.checkMemberForPwReset(member);

        if (exists) {
            model.addAttribute("memberId", member.getMemberId());
            return "member/find_pw"; // 비밀번호 재설정 페이지
        } else {
            model.addAttribute("msg", "입력하신 정보와 일치하는 회원이 없습니다.");
            return "member/find_info";
        }
    }
    
    @PostMapping("/updatePw")
    public String updatePw(Member member, Model model) {
        int result = memberService.updateMemberPw(member);

        if (result > 0) {
            model.addAttribute("msg", "비밀번호가 성공적으로 변경되었습니다.");
            model.addAttribute("url", "/member/login");
            return "common/success"; // 메시지 후 이동 (혹은 redirect)
        } else {
            model.addAttribute("msg", "비밀번호 변경에 실패했습니다. 다시 시도해주세요.");
            model.addAttribute("url", "/member/find_pw");
            return "common/fail"; // 실패 페이지 (선택)
        }
    }

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
