package com.edumate.boot.app.admin.controller;

import com.edumate.boot.common.util.ImageMigrationService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import jakarta.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@Slf4j
@Controller
@RequestMapping("/admin/migration")
@RequiredArgsConstructor
public class MigrationController {

    private final ImageMigrationService imageMigrationService;

    @GetMapping("/image")
    public String showImageMigration(HttpSession session, Model model) {
        String loginId = (String) session.getAttribute("loginId");
        String loginRole = (String) session.getAttribute("loginRole");
        
        // 관리자 권한 확인
        if (loginId == null || !"ADMIN".equals(loginRole)) {
            model.addAttribute("errorMsg", "관리자만 접근할 수 있습니다.");
            return "common/error";
        }
        
        return "admin/imageMigration";
    }

    @PostMapping("/migrate-all")
    @ResponseBody
    public Map<String, Object> migrateAllImages(HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        
        try {
            String loginId = (String) session.getAttribute("loginId");
            String loginRole = (String) session.getAttribute("loginRole");
            
            // 관리자 권한 확인
            if (loginId == null || !"ADMIN".equals(loginRole)) {
                response.put("success", false);
                response.put("message", "관리자만 접근할 수 있습니다.");
                return response;
            }
            
            log.info("관리자 {}가 전체 이미지 마이그레이션을 시작했습니다.", loginId);
            
            imageMigrationService.migrateAllImages();
            
            response.put("success", true);
            response.put("message", "모든 이미지가 성공적으로 Cloudflare로 마이그레이션되었습니다.");
            
            log.info("전체 이미지 마이그레이션이 완료되었습니다.");
            
        } catch (Exception e) {
            log.error("이미지 마이그레이션 중 오류 발생", e);
            response.put("success", false);
            response.put("message", "마이그레이션 중 오류가 발생했습니다: " + e.getMessage());
        }
        
        return response;
    }

    @PostMapping("/migrate-lectures")
    @ResponseBody
    public Map<String, Object> migrateLectureImages(HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        
        try {
            String loginId = (String) session.getAttribute("loginId");
            String loginRole = (String) session.getAttribute("loginRole");
            
            if (loginId == null || !"ADMIN".equals(loginRole)) {
                response.put("success", false);
                response.put("message", "관리자만 접근할 수 있습니다.");
                return response;
            }
            
            log.info("관리자 {}가 강의 이미지 마이그레이션을 시작했습니다.", loginId);
            
            imageMigrationService.migrateLectureImagesOnly();
            
            response.put("success", true);
            response.put("message", "강의 이미지가 성공적으로 마이그레이션되었습니다.");
            
        } catch (Exception e) {
            log.error("강의 이미지 마이그레이션 중 오류 발생", e);
            response.put("success", false);
            response.put("message", "마이그레이션 중 오류가 발생했습니다: " + e.getMessage());
        }
        
        return response;
    }

    @PostMapping("/migrate-events")
    @ResponseBody
    public Map<String, Object> migrateEventImages(HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        
        try {
            String loginId = (String) session.getAttribute("loginId");
            String loginRole = (String) session.getAttribute("loginRole");
            
            if (loginId == null || !"ADMIN".equals(loginRole)) {
                response.put("success", false);
                response.put("message", "관리자만 접근할 수 있습니다.");
                return response;
            }
            
            log.info("관리자 {}가 이벤트 이미지 마이그레이션을 시작했습니다.", loginId);
            
            imageMigrationService.migrateEventImagesOnly();
            
            response.put("success", true);
            response.put("message", "이벤트 이미지가 성공적으로 마이그레이션되었습니다.");
            
        } catch (Exception e) {
            log.error("이벤트 이미지 마이그레이션 중 오류 발생", e);
            response.put("success", false);
            response.put("message", "마이그레이션 중 오류가 발생했습니다: " + e.getMessage());
        }
        
        return response;
    }

    @PostMapping("/migrate-videos")
    @ResponseBody
    public Map<String, Object> migrateVideoFiles(HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        
        try {
            String loginId = (String) session.getAttribute("loginId");
            String loginRole = (String) session.getAttribute("loginRole");
            
            if (loginId == null || !"ADMIN".equals(loginRole)) {
                response.put("success", false);
                response.put("message", "관리자만 접근할 수 있습니다.");
                return response;
            }
            
            log.info("관리자 {}가 비디오 파일 마이그레이션을 시작했습니다.", loginId);
            
            imageMigrationService.migrateVideoFilesOnly();
            
            response.put("success", true);
            response.put("message", "비디오 파일이 성공적으로 마이그레이션되었습니다.");
            
        } catch (Exception e) {
            log.error("비디오 파일 마이그레이션 중 오류 발생", e);
            response.put("success", false);
            response.put("message", "마이그레이션 중 오류가 발생했습니다: " + e.getMessage());
        }
        
        return response;
    }

    @PostMapping("/migrate-archives")
    @ResponseBody
    public Map<String, Object> migrateArchiveAttachments(HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        
        try {
            String loginId = (String) session.getAttribute("loginId");
            String loginRole = (String) session.getAttribute("loginRole");
            
            if (loginId == null || !"ADMIN".equals(loginRole)) {
                response.put("success", false);
                response.put("message", "관리자만 접근할 수 있습니다.");
                return response;
            }
            
            log.info("관리자 {}가 아카이브 첨부파일 마이그레이션을 시작했습니다.", loginId);
            
            imageMigrationService.migrateArchiveAttachmentsOnly();
            
            response.put("success", true);
            response.put("message", "아카이브 첨부파일이 성공적으로 마이그레이션되었습니다.");
            
        } catch (Exception e) {
            log.error("아카이브 첨부파일 마이그레이션 중 오류 발생", e);
            response.put("success", false);
            response.put("message", "마이그레이션 중 오류가 발생했습니다: " + e.getMessage());
        }
        
        return response;
    }
}