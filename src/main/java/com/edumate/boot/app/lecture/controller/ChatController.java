package com.edumate.boot.app.lecture.controller;

import com.edumate.boot.app.lecture.dto.LectureQuestionRequest;
import com.edumate.boot.domain.lecture.model.service.LectureService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;

import java.util.Map;
import java.util.List;

@RestController
@RequestMapping("/api/chat")
@RequiredArgsConstructor
public class ChatController {

    private final LectureService lService;

    @Value("${gemini.api.key}")
    private String geminiApiKey;

    @Value("${gemini.api.url}")
    private String geminiApiUrl;

    @GetMapping("/send")
    public String ai(Model model) {
        return "chat";
    }

    @PostMapping("/send")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> sendMessage(@RequestBody Map<String, String> request) {
        try {
            String userMessage = request.get("message");
            String isDetailed = request.get("detailed"); // "true"면 자세한 답변

            String promptMessage;
            if ("true".equals(isDetailed)) {
                // 자세한 답변 - 교육적 프롬프트 추가
                promptMessage = "당신은 온라인 강의 플랫폼의 AI 강의 도우미입니다. " +
                        "학습자가 강의 내용에 대해 질문했을 때 친근하고 교육적인 방식으로 답변해주세요. " +
                        "답변은 이해하기 쉽고 실용적이어야 하며, 추가 학습을 격려하는 내용을 포함해주세요.\n\n" +
                        "질문: " + userMessage;
            } else {
                // 간단한 답변 - 프롬프트 없이
                promptMessage = userMessage;
            }

            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);
            headers.set("x-goog-api-key", geminiApiKey);

            Map<String, Object> requestBody = Map.of(
                    "contents", List.of(
                            Map.of("parts", List.of(
                                    Map.of("text", promptMessage)
                            ))
                    )
            );

            HttpEntity<Map<String, Object>> entity = new HttpEntity<>(requestBody, headers);
            ResponseEntity<Map<String, Object>> response = new RestTemplate().postForEntity(geminiApiUrl, entity, (Class<Map<String, Object>>) (Class<?>) Map.class);

            if (response.getStatusCode().is2xxSuccessful() && response.getBody() != null) {
                @SuppressWarnings("unchecked")
                List<Map<String, Object>> candidates = (List<Map<String, Object>>) response.getBody().get("candidates");
                if (candidates != null && !candidates.isEmpty()) {
                    @SuppressWarnings("unchecked")
                    Map<String, Object> content = (Map<String, Object>) candidates.get(0).get("content");
                    @SuppressWarnings("unchecked")
                    List<Map<String, Object>> parts = (List<Map<String, Object>>) content.get("parts");
                    if (parts != null && !parts.isEmpty()) {
                        String geminiResponse = (String) parts.get(0).get("text");
                        return ResponseEntity.ok(Map.of("success", true, "response", geminiResponse));
                    }
                }
            }

            return ResponseEntity.ok(Map.of("success", false, "error", "API 응답 실패"));

        } catch (Exception e) {
            return ResponseEntity.ok(Map.of("success", false, "error", "오류: " + e.getMessage()));
        }
    }

    @PostMapping("/teacher")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> submitTeacherQuestion(
            @RequestBody Map<String, String> request
            , HttpSession session) {
        try {
            LectureQuestionRequest qList = new LectureQuestionRequest();
            String id = (String) session.getAttribute("loginId");
            String title = request.get("title");
            String content = request.get("content");

            qList.setMemberId(id);
            qList.setQuestionTitle(title);
            qList.setQuestionContent(content);
            int result = lService.insertQuestion(qList);
            if (result > 0) {
                return ResponseEntity.ok(Map.of(
                    "success", true,
                    "message", "질문이 성공적으로 등록되었습니다."
                ));
            } else {
                return ResponseEntity.ok(Map.of(
                    "success", false,
                    "error", "질문 등록에 실패했습니다."
                ));
            }
        } catch (Exception e) {
            return ResponseEntity.ok(Map.of(
                "success", false,
                "error", "질문 등록 중 오류가 발생했습니다: " + e.getMessage()
            ));
        }
    }

}
