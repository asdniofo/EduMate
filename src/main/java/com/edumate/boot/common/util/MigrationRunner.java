package com.edumate.boot.common.util;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

import java.sql.Timestamp;

@Slf4j
@Component
@ConditionalOnProperty(name = "migration.run", havingValue = "true")
@RequiredArgsConstructor
public class MigrationRunner implements CommandLineRunner {

    private final ImageMigrationService imageMigrationService;
    private final JdbcTemplate jdbcTemplate;

    @Override
    public void run(String... args) throws Exception {
        log.info("===========================================");
        log.info("Cloudflare R2 마이그레이션 시작");
        log.info("===========================================");
        
        try {
            // 마이그레이션 시작 로그
            logMigrationStart();
            
            // 전체 마이그레이션 실행
            imageMigrationService.migrateAllImages();
            
            // 마이그레이션 완료 로그
            logMigrationComplete();
            
            log.info("===========================================");
            log.info("마이그레이션이 성공적으로 완료되었습니다!");
            log.info("===========================================");
            
        } catch (Exception e) {
            log.error("===========================================");
            log.error("마이그레이션 중 오류 발생: {}", e.getMessage());
            log.error("===========================================");
            throw e;
        }
    }
    
    private void logMigrationStart() {
        try {
            // 마이그레이션 대상 파일 수 조회
            String lectureSql = "SELECT COUNT(*) FROM LECTURE WHERE LECTURE_PATH IS NOT NULL AND LECTURE_PATH NOT LIKE '%pub-f8fd744877724e40a29110baaa7d9f66.r2.dev%'";
            String eventSql = "SELECT COUNT(*) FROM EVENT_BOARD WHERE (EVENT_PATH IS NOT NULL AND EVENT_PATH NOT LIKE '%pub-f8fd744877724e40a29110baaa7d9f66.r2.dev%') OR (EVENT_SUBPATH IS NOT NULL AND EVENT_SUBPATH NOT LIKE '%pub-f8fd744877724e40a29110baaa7d9f66.r2.dev%')";
            String videoSql = "SELECT COUNT(*) FROM LECTURE_VIDEO WHERE VIDEO_PATH IS NOT NULL AND VIDEO_PATH NOT LIKE '%pub-f8fd744877724e40a29110baaa7d9f66.r2.dev%'";
            String contentSql = "SELECT COUNT(*) FROM EVENT_CONTENT WHERE E_CONTENT_PATH IS NOT NULL AND E_CONTENT_PATH NOT LIKE '%pub-f8fd744877724e40a29110baaa7d9f66.r2.dev%'";
            String archiveSql = "SELECT COUNT(*) FROM ARCHIVE_BOARD WHERE ATTACHMENT_PATH IS NOT NULL AND ATTACHMENT_PATH NOT LIKE '%pub-f8fd744877724e40a29110baaa7d9f66.r2.dev%'";
            
            int lectureCount = jdbcTemplate.queryForObject(lectureSql, Integer.class);
            int eventCount = jdbcTemplate.queryForObject(eventSql, Integer.class);
            int videoCount = jdbcTemplate.queryForObject(videoSql, Integer.class);
            int contentCount = jdbcTemplate.queryForObject(contentSql, Integer.class);
            int archiveCount = jdbcTemplate.queryForObject(archiveSql, Integer.class);
            
            int totalCount = lectureCount + eventCount + videoCount + contentCount + archiveCount;
            
            log.info("마이그레이션 대상 파일 현황:");
            log.info("- 강의 이미지: {}개", lectureCount);
            log.info("- 이벤트 이미지: {}개", eventCount);
            log.info("- 비디오 파일: {}개", videoCount);
            log.info("- 이벤트 콘텐츠: {}개", contentCount);
            log.info("- 아카이브 첨부파일: {}개", archiveCount);
            log.info("- 총 {}개 파일을 마이그레이션합니다.", totalCount);
            
        } catch (Exception e) {
            log.warn("마이그레이션 대상 파일 수 조회 실패: {}", e.getMessage());
        }
    }
    
    private void logMigrationComplete() {
        try {
            // 마이그레이션 결과 조회
            String lectureSql = "SELECT COUNT(*) FROM LECTURE WHERE LECTURE_PATH LIKE '%pub-f8fd744877724e40a29110baaa7d9f66.r2.dev%'";
            String eventPathSql = "SELECT COUNT(*) FROM EVENT_BOARD WHERE EVENT_PATH LIKE '%pub-f8fd744877724e40a29110baaa7d9f66.r2.dev%'";
            String eventSubpathSql = "SELECT COUNT(*) FROM EVENT_BOARD WHERE EVENT_SUBPATH LIKE '%pub-f8fd744877724e40a29110baaa7d9f66.r2.dev%'";
            String videoSql = "SELECT COUNT(*) FROM LECTURE_VIDEO WHERE VIDEO_PATH LIKE '%pub-f8fd744877724e40a29110baaa7d9f66.r2.dev%'";
            String contentSql = "SELECT COUNT(*) FROM EVENT_CONTENT WHERE E_CONTENT_PATH LIKE '%pub-f8fd744877724e40a29110baaa7d9f66.r2.dev%'";
            String archiveSql = "SELECT COUNT(*) FROM ARCHIVE_BOARD WHERE ATTACHMENT_PATH LIKE '%pub-f8fd744877724e40a29110baaa7d9f66.r2.dev%'";
            
            int lectureCount = jdbcTemplate.queryForObject(lectureSql, Integer.class);
            int eventPathCount = jdbcTemplate.queryForObject(eventPathSql, Integer.class);
            int eventSubpathCount = jdbcTemplate.queryForObject(eventSubpathSql, Integer.class);
            int videoCount = jdbcTemplate.queryForObject(videoSql, Integer.class);
            int contentCount = jdbcTemplate.queryForObject(contentSql, Integer.class);
            int archiveCount = jdbcTemplate.queryForObject(archiveSql, Integer.class);
            
            int totalMigrated = lectureCount + eventPathCount + eventSubpathCount + videoCount + contentCount + archiveCount;
            
            log.info("마이그레이션 완료 현황:");
            log.info("- 강의 이미지: {}개 완료", lectureCount);
            log.info("- 이벤트 메인 이미지: {}개 완료", eventPathCount);
            log.info("- 이벤트 썸네일: {}개 완료", eventSubpathCount);
            log.info("- 비디오 파일: {}개 완료", videoCount);
            log.info("- 이벤트 콘텐츠: {}개 완료", contentCount);
            log.info("- 아카이브 첨부파일: {}개 완료", archiveCount);
            log.info("- 총 {}개 파일이 Cloudflare R2로 마이그레이션되었습니다.", totalMigrated);
            
        } catch (Exception e) {
            log.warn("마이그레이션 결과 조회 실패: {}", e.getMessage());
        }
    }
}