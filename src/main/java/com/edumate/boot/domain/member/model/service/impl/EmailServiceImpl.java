package com.edumate.boot.domain.member.model.service.impl;

import java.security.SecureRandom;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.edumate.boot.domain.member.model.service.EmailService;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class EmailServiceImpl implements EmailService {

private final JavaMailSender mailSender;
    
    // 💡 인증 코드를 저장할 임시 저장소 (Key: Email, Value: AuthCode) 실제 서비스 X
    private final Map<String, String> authCodeStore = new ConcurrentHashMap<>();

    // 💡 인증 코드 생성 (6자리 숫자)
    private String createCode() {
        SecureRandom random = new SecureRandom();
        int code = random.nextInt(900000) + 100000; // 100000 ~ 999999
        return String.valueOf(code);
    }

    @Override
    public String sendAuthCode(String toEmail) {
        String authCode = createCode();
        String title = "[EduMateBoot] 회원가입 이메일 인증 번호";
        String content = "인증 번호는 " + authCode + " 입니다.";

        try {
            MimeMessage message = mailSender.createMimeMessage();
            // true: MultipartMessage, 인코딩: UTF-8, true: HTML 형식 사용
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8"); 

            helper.setTo(toEmail);
            helper.setSubject(title);
            helper.setText(content, true); // true: HTML 형식
            
            // 발신자 설정 (application.properties의 username을 따름)
            // helper.setFrom("your-email@gmail.com", "EduMate 관리자"); 

            mailSender.send(message);

            // 💡 성공 시 임시 저장소에 인증 코드 저장
            authCodeStore.put(toEmail, authCode);
            return authCode;
            
        } catch (MessagingException e) {
            // 이메일 전송 실패 시 예외 처리
            e.printStackTrace();
            throw new RuntimeException("이메일 전송에 실패했습니다.", e);
        }
    }

    @Override
    public boolean verifyAuthCode(String email, String authCode) {
        // 1. 저장된 코드가 있는지 확인
        String storedCode = authCodeStore.get(email);
        
        // 2. 코드가 일치하는지 확인
        if (storedCode != null && storedCode.equals(authCode)) {
            // 3. 인증 성공 시, 저장된 코드 삭제 (일회용)
            authCodeStore.remove(email);
            return true;
        }
        return false;
    }
}
