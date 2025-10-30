package com.edumate.boot.common.util;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.Map;

@Slf4j
@Service
@RequiredArgsConstructor
public class ImageMigrationService {

    private final CloudflareR2Service cloudflareR2Service;
    private final JdbcTemplate jdbcTemplate;

    /**
     * 기존 로컬 이미지를 Cloudflare R2로 마이그레이션하고 DB URL 업데이트
     */
    public void migrateAllImages() {
        log.info("이미지 마이그레이션 시작");
        
        try {
            migrateLectureImages();
            migrateEventImages();
            migrateVideoFiles();
            migrateArchiveAttachments();
            
            log.info("모든 이미지 마이그레이션 완료");
        } catch (Exception e) {
            log.error("이미지 마이그레이션 중 오류 발생", e);
            throw new RuntimeException("이미지 마이그레이션 실패", e);
        }
    }

    /**
     * 강의 이미지 마이그레이션
     */
    public void migrateLectureImages() {
        log.info("강의 이미지 마이그레이션 시작");
        
        String selectSql = "SELECT LECTURE_NO, LECTURE_PATH FROM LECTURE WHERE LECTURE_PATH IS NOT NULL";
        List<Map<String, Object>> lectures = jdbcTemplate.queryForList(selectSql);
        
        for (Map<String, Object> lecture : lectures) {
            Integer lectureNo = (Integer) lecture.get("LECTURE_NO");
            String lecturePath = (String) lecture.get("LECTURE_PATH");
            
            if (lecturePath != null && !lecturePath.contains("pub-f8fd744877724e40a29110baaa7d9f66.r2.dev")) {
                try {
                    String newUrl = migrateFile(lecturePath, "lecture/images");
                    if (newUrl != null) {
                        String updateSql = "UPDATE LECTURE SET LECTURE_PATH = ? WHERE LECTURE_NO = ?";
                        jdbcTemplate.update(updateSql, newUrl, lectureNo);
                        log.info("강의 {} 이미지 마이그레이션 완료: {} -> {}", lectureNo, lecturePath, newUrl);
                    }
                } catch (Exception e) {
                    log.error("강의 {} 이미지 마이그레이션 실패: {}", lectureNo, e.getMessage());
                }
            }
        }
    }

    /**
     * 이벤트 이미지 마이그레이션
     */
    public void migrateEventImages() {
        log.info("이벤트 이미지 마이그레이션 시작");
        
        // 메인 이미지 마이그레이션
        String selectSql = "SELECT EVENT_ID, EVENT_PATH, EVENT_SUBPATH FROM EVENT_BOARD WHERE EVENT_PATH IS NOT NULL OR EVENT_SUBPATH IS NOT NULL";
        List<Map<String, Object>> events = jdbcTemplate.queryForList(selectSql);
        
        for (Map<String, Object> event : events) {
            Integer eventId = (Integer) event.get("EVENT_ID");
            String eventPath = (String) event.get("EVENT_PATH");
            String eventSubpath = (String) event.get("EVENT_SUBPATH");
            
            try {
                String newEventPath = null;
                String newEventSubpath = null;
                
                if (eventPath != null && !eventPath.contains("pub-f8fd744877724e40a29110baaa7d9f66.r2.dev")) {
                    newEventPath = migrateFile(eventPath, "event/thumbnail");
                }
                
                if (eventSubpath != null && !eventSubpath.contains("pub-f8fd744877724e40a29110baaa7d9f66.r2.dev")) {
                    newEventSubpath = migrateFile(eventSubpath, "event/thumbnail");
                }
                
                if (newEventPath != null || newEventSubpath != null) {
                    String updateSql = "UPDATE EVENT_BOARD SET EVENT_PATH = COALESCE(?, EVENT_PATH), EVENT_SUBPATH = COALESCE(?, EVENT_SUBPATH) WHERE EVENT_ID = ?";
                    jdbcTemplate.update(updateSql, newEventPath, newEventSubpath, eventId);
                    log.info("이벤트 {} 이미지 마이그레이션 완료", eventId);
                }
            } catch (Exception e) {
                log.error("이벤트 {} 이미지 마이그레이션 실패: {}", eventId, e.getMessage());
            }
        }
        
        // 이벤트 콘텐츠 이미지 마이그레이션
        String contentSelectSql = "SELECT E_CONTENT_ID, E_CONTENT_PATH FROM EVENT_CONTENT WHERE E_CONTENT_PATH IS NOT NULL";
        List<Map<String, Object>> contents = jdbcTemplate.queryForList(contentSelectSql);
        
        for (Map<String, Object> content : contents) {
            Integer contentId = (Integer) content.get("E_CONTENT_ID");
            String contentPath = (String) content.get("E_CONTENT_PATH");
            
            if (contentPath != null && !contentPath.contains("pub-f8fd744877724e40a29110baaa7d9f66.r2.dev")) {
                try {
                    String newUrl = migrateFile(contentPath, "event/content");
                    if (newUrl != null) {
                        String updateSql = "UPDATE EVENT_CONTENT SET E_CONTENT_PATH = ? WHERE E_CONTENT_ID = ?";
                        jdbcTemplate.update(updateSql, newUrl, contentId);
                        log.info("이벤트 콘텐츠 {} 이미지 마이그레이션 완료", contentId);
                    }
                } catch (Exception e) {
                    log.error("이벤트 콘텐츠 {} 이미지 마이그레이션 실패: {}", contentId, e.getMessage());
                }
            }
        }
    }

    /**
     * 비디오 파일 마이그레이션
     */
    public void migrateVideoFiles() {
        log.info("비디오 파일 마이그레이션 시작");
        
        String selectSql = "SELECT VIDEO_NO, VIDEO_PATH FROM LECTURE_VIDEO WHERE VIDEO_PATH IS NOT NULL";
        List<Map<String, Object>> videos = jdbcTemplate.queryForList(selectSql);
        
        for (Map<String, Object> video : videos) {
            Integer videoNo = (Integer) video.get("VIDEO_NO");
            String videoPath = (String) video.get("VIDEO_PATH");
            
            if (videoPath != null && !videoPath.contains("pub-f8fd744877724e40a29110baaa7d9f66.r2.dev")) {
                try {
                    String newUrl = migrateFile(videoPath, "lecture/videos");
                    if (newUrl != null) {
                        String updateSql = "UPDATE LECTURE_VIDEO SET VIDEO_PATH = ? WHERE VIDEO_NO = ?";
                        jdbcTemplate.update(updateSql, newUrl, videoNo);
                        log.info("비디오 {} 마이그레이션 완료: {} -> {}", videoNo, videoPath, newUrl);
                    }
                } catch (Exception e) {
                    log.error("비디오 {} 마이그레이션 실패: {}", videoNo, e.getMessage());
                }
            }
        }
    }

    /**
     * 아카이브 첨부파일 마이그레이션
     */
    public void migrateArchiveAttachments() {
        log.info("아카이브 첨부파일 마이그레이션 시작");
        
        String selectSql = "SELECT BOARD_NO, ATTACHMENT_PATH FROM ARCHIVE_BOARD WHERE ATTACHMENT_PATH IS NOT NULL";
        List<Map<String, Object>> archives = jdbcTemplate.queryForList(selectSql);
        
        for (Map<String, Object> archive : archives) {
            Integer boardNo = (Integer) archive.get("BOARD_NO");
            String attachmentPath = (String) archive.get("ATTACHMENT_PATH");
            
            if (attachmentPath != null && !attachmentPath.contains("pub-f8fd744877724e40a29110baaa7d9f66.r2.dev")) {
                try {
                    String newUrl = migrateFile(attachmentPath, "archive/attachments");
                    if (newUrl != null) {
                        String updateSql = "UPDATE ARCHIVE_BOARD SET ATTACHMENT_PATH = ? WHERE BOARD_NO = ?";
                        jdbcTemplate.update(updateSql, newUrl, boardNo);
                        log.info("아카이브 {} 첨부파일 마이그레이션 완료", boardNo);
                    }
                } catch (Exception e) {
                    log.error("아카이브 {} 첨부파일 마이그레이션 실패: {}", boardNo, e.getMessage());
                }
            }
        }
    }

    /**
     * 개별 파일(이미지/동영상)을 Cloudflare로 마이그레이션
     * @param originalPath 원본 파일 경로
     * @param folder Cloudflare 저장 폴더
     * @return 새로운 Cloudflare URL, 실패시 null
     */
    private String migrateFile(String originalPath, String folder) {
        if (originalPath == null || originalPath.isEmpty()) {
            return null;
        }

        try {
            // 기존 로컬 파일 경로들 처리
            String[] possiblePaths = {
                originalPath,
                "src/main/webapp/uploads/" + originalPath,
                "src/main/webapp/images/" + originalPath,
                "src/main/webapp/videos/" + originalPath,
                "src/main/webapp/resources/images/" + originalPath,
                "src/main/webapp/resources/videos/" + originalPath,
                "uploads/" + originalPath,
                "images/" + originalPath,
                "videos/" + originalPath,
                System.getProperty("user.dir") + "/src/main/webapp/resources/images/" + originalPath,
                System.getProperty("user.dir") + "/src/main/webapp/resources/videos/" + originalPath
            };

            File targetFile = null;
            for (String path : possiblePaths) {
                File file = new File(path);
                if (file.exists() && file.isFile()) {
                    targetFile = file;
                    break;
                }
            }

            if (targetFile == null) {
                log.warn("파일을 찾을 수 없습니다: {}", originalPath);
                return null;
            }

            // MIME 타입 결정
            String fileName = targetFile.getName();
            String contentType = Files.probeContentType(targetFile.toPath());
            if (contentType == null) {
                contentType = determineContentType(fileName);
            }

            // Cloudflare에 업로드
            String cloudflareUrl = cloudflareR2Service.uploadFile(targetFile, folder, fileName, contentType);
            log.info("파일 마이그레이션 성공: {} -> {}", originalPath, cloudflareUrl);
            
            return cloudflareUrl;
            
        } catch (Exception e) {
            log.error("파일 마이그레이션 실패: {} - {}", originalPath, e.getMessage());
            return null;
        }
    }

    /**
     * 파일 확장자로 Content-Type 결정
     */
    private String determineContentType(String fileName) {
        String lowerFileName = fileName.toLowerCase();
        
        if (lowerFileName.endsWith(".jpg") || lowerFileName.endsWith(".jpeg")) {
            return "image/jpeg";
        } else if (lowerFileName.endsWith(".png")) {
            return "image/png";
        } else if (lowerFileName.endsWith(".gif")) {
            return "image/gif";
        } else if (lowerFileName.endsWith(".bmp")) {
            return "image/bmp";
        } else if (lowerFileName.endsWith(".webp")) {
            return "image/webp";
        } else if (lowerFileName.endsWith(".mp4")) {
            return "video/mp4";
        } else if (lowerFileName.endsWith(".avi")) {
            return "video/avi";
        } else if (lowerFileName.endsWith(".mov")) {
            return "video/quicktime";
        } else if (lowerFileName.endsWith(".wmv")) {
            return "video/x-ms-wmv";
        } else if (lowerFileName.endsWith(".flv")) {
            return "video/x-flv";
        } else if (lowerFileName.endsWith(".mkv")) {
            return "video/x-matroska";
        } else {
            return "application/octet-stream";
        }
    }

    /**
     * 특정 테이블의 이미지만 마이그레이션
     */
    public void migrateLectureImagesOnly() {
        migrateLectureImages();
    }

    public void migrateEventImagesOnly() {
        migrateEventImages();
    }

    public void migrateVideoFilesOnly() {
        migrateVideoFiles();
    }

    public void migrateArchiveAttachmentsOnly() {
        migrateArchiveAttachments();
    }
}