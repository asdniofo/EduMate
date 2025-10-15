package com.edumate.boot.app.member.controller;

import com.edumate.boot.domain.member.model.service.MemberService;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.URL;

import javax.net.ssl.HttpsURLConnection;

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
        @RequestParam String userId,
        @RequestParam String userPwd,
        @RequestParam String userName,
        @RequestParam String birth,
        @RequestParam("g-recaptcha-response") String recaptchaResponse,
        Model model) {

    // 1️⃣ 캡챠 검증
    boolean captchaValid = verifyRecaptcha(recaptchaResponse);
    if(!captchaValid) {
        model.addAttribute("errorMessage", "[reCaptcha] 인증에 실패했습니다.");
        return "error"; // 다시 회원가입 페이지로
    }

    // 2️⃣ 회원가입 로직 처리 (DB 저장 등)
    // memberService.signup(userId, userPwd, userName, birth);

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
}
