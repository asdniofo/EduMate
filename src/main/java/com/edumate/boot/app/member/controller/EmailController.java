package com.edumate.boot.app.member.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.edumate.boot.domain.member.model.service.EmailService;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/member/email")
@RequiredArgsConstructor
public class EmailController {
	
	private final EmailService emailService;

    /**
     * 이메일로 인증 코드를 발송하는 API 엔드포인트
     * POST /member/email/sendAuth
     * @param requestMap { "email": "test@example.com" }
     * @return { "success": true, "message": "인증 메일이 발송되었습니다." }
     */
    @PostMapping("/sendAuth")
    public ResponseEntity<Map<String, Object>> sendAuthEmail(@RequestBody Map<String, String> requestMap) {
        String email = requestMap.get("email");
        Map<String, Object> response = new HashMap<>();

        if (email == null || email.trim().isEmpty()) {
            response.put("success", false);
            response.put("message", "이메일 주소를 입력해주세요.");
            return ResponseEntity.badRequest().body(response);
        }

        try {
            emailService.sendAuthCode(email);
            response.put("success", true);
            response.put("message", "인증 메일이 발송되었습니다. 메일함을 확인해주세요.");
            return ResponseEntity.ok(response);
        } catch (IllegalArgumentException e) { // 💡 FIX: 이메일 중복 예외 처리
            response.put("success", false);
            response.put("message", e.getMessage()); // "이미 가입된 이메일 주소입니다."
            return ResponseEntity.ok(response); // 200 OK로 반환하여 프론트에서 메시지를 정상적으로 표시
        } catch (RuntimeException e) { // 이메일 발송 실패 등 기타 예외 처리
            response.put("success", false);
            response.put("message", "이메일 발송 시스템 오류가 발생했습니다.");
            // 💡 개발용: System.err.println(e.getMessage());
            return ResponseEntity.internalServerError().body(response);
        }
    }

    /**
     * 사용자로부터 받은 인증 코드를 검증하는 API 엔드포인트
     * POST /member/email/verifyAuth
     * @param requestMap { "email": "test@example.com", "authCode": "123456" }
     * @return { "success": true/false, "message": "인증 성공/실패 메시지" }
     */
    @PostMapping("/verifyAuth")
    public ResponseEntity<Map<String, Object>> verifyAuthCode(@RequestBody Map<String, String> requestMap) {
        String email = requestMap.get("email");
        String authCode = requestMap.get("authCode");
        Map<String, Object> response = new HashMap<>();

        if (email == null || authCode == null) {
            response.put("success", false);
            response.put("message", "이메일 또는 인증 코드를 입력해주세요.");
            return ResponseEntity.badRequest().body(response);
        }

        boolean isVerified = emailService.verifyAuthCode(email, authCode);

        if (isVerified) {
            response.put("success", true);
            response.put("message", "이메일 인증이 완료되었습니다.");
            return ResponseEntity.ok(response);
        } else {
            response.put("success", false);
            response.put("message", "인증 번호가 일치하지 않거나 만료되었습니다.");
            return ResponseEntity.ok(response); // 401 대신 200 OK로 처리하고 success: false 반환
        }
    }
}
