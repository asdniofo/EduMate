import java.sql.*;
import java.io.*;
import java.util.*;
import java.nio.file.*;
import software.amazon.awssdk.auth.credentials.AwsBasicCredentials;
import software.amazon.awssdk.auth.credentials.StaticCredentialsProvider;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.*;
import software.amazon.awssdk.core.sync.RequestBody;

public class migrate_now {
    private static final String DB_URL = "jdbc:oracle:thin:@20.249.165.235:1521/XEPDB1";
    private static final String DB_USER = "EDUMATE";
    private static final String DB_PASSWORD = "EDUMATE";
    
    private static final String R2_ENDPOINT = "https://d9ccd44892a955eb74f49169431509a8.r2.cloudflarestorage.com";
    private static final String R2_ACCESS_KEY = "7de029bbac8e5545039f1a5e680cb18c";
    private static final String R2_SECRET_KEY = "4911a65055712481ffb8db0e7823baaa07dafa71b5acbb0616ae773b2e583f01";
    private static final String R2_BUCKET = "edumate-files";
    private static final String R2_PUBLIC_URL = "https://pub-f8fd744877724e40a29110baaa7d9f66.r2.dev";
    
    private static S3Client s3Client;
    private static Connection conn;
    
    public static void main(String[] args) {
        System.out.println("===========================================");
        System.out.println("Cloudflare R2 마이그레이션 시작");
        System.out.println("===========================================");
        
        try {
            // S3 클라이언트 초기화
            initializeS3Client();
            
            // 데이터베이스 연결
            connectToDatabase();
            
            // 마이그레이션 실행
            migrateAllFiles();
            
            System.out.println("===========================================");
            System.out.println("마이그레이션이 성공적으로 완료되었습니다!");
            System.out.println("===========================================");
            
        } catch (Exception e) {
            System.err.println("마이그레이션 중 오류 발생: " + e.getMessage());
            e.printStackTrace();
        } finally {
            try {
                if (conn != null) conn.close();
                if (s3Client != null) s3Client.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
    
    private static void initializeS3Client() {
        AwsBasicCredentials credentials = AwsBasicCredentials.create(R2_ACCESS_KEY, R2_SECRET_KEY);
        
        s3Client = S3Client.builder()
                .endpointOverride(java.net.URI.create(R2_ENDPOINT))
                .credentialsProvider(StaticCredentialsProvider.create(credentials))
                .region(Region.US_EAST_1)
                .build();
                
        System.out.println("S3 클라이언트 초기화 완료");
    }
    
    private static void connectToDatabase() throws Exception {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
        System.out.println("데이터베이스 연결 완료");
    }
    
    private static void migrateAllFiles() throws Exception {
        System.out.println("\n강의 이미지 마이그레이션 시작...");
        migrateLectureImages();
        
        System.out.println("\n이벤트 이미지 마이그레이션 시작...");
        migrateEventImages();
        
        System.out.println("\n비디오 파일 마이그레이션 시작...");
        migrateVideoFiles();
        
        System.out.println("\n이벤트 콘텐츠 마이그레이션 시작...");
        migrateEventContent();
        
        System.out.println("\n아카이브 첨부파일 마이그레이션 시작...");
        migrateArchiveAttachments();
    }
    
    private static void migrateLectureImages() throws Exception {
        String selectSql = "SELECT LECTURE_NO, LECTURE_PATH FROM LECTURE WHERE LECTURE_PATH IS NOT NULL AND LECTURE_PATH NOT LIKE '%pub-f8fd744877724e40a29110baaa7d9f66.r2.dev%'";
        PreparedStatement selectStmt = conn.prepareStatement(selectSql);
        ResultSet rs = selectStmt.executeQuery();
        
        String updateSql = "UPDATE LECTURE SET LECTURE_PATH = ? WHERE LECTURE_NO = ?";
        PreparedStatement updateStmt = conn.prepareStatement(updateSql);
        
        int count = 0;
        while (rs.next()) {
            int lectureNo = rs.getInt("LECTURE_NO");
            String lecturePath = rs.getString("LECTURE_PATH");
            
            try {
                String newUrl = uploadToCloudflare(lecturePath, "lecture/images");
                if (newUrl != null) {
                    updateStmt.setString(1, newUrl);
                    updateStmt.setInt(2, lectureNo);
                    updateStmt.executeUpdate();
                    count++;
                    System.out.println("강의 " + lectureNo + " 이미지 마이그레이션 완료: " + newUrl);
                }
            } catch (Exception e) {
                System.err.println("강의 " + lectureNo + " 마이그레이션 실패: " + e.getMessage());
            }
        }
        System.out.println("강의 이미지 " + count + "개 마이그레이션 완료");
        
        rs.close();
        selectStmt.close();
        updateStmt.close();
    }
    
    private static void migrateEventImages() throws Exception {
        String selectSql = "SELECT EVENT_ID, EVENT_PATH, EVENT_SUBPATH FROM EVENT_BOARD WHERE (EVENT_PATH IS NOT NULL AND EVENT_PATH NOT LIKE '%pub-f8fd744877724e40a29110baaa7d9f66.r2.dev%') OR (EVENT_SUBPATH IS NOT NULL AND EVENT_SUBPATH NOT LIKE '%pub-f8fd744877724e40a29110baaa7d9f66.r2.dev%')";
        PreparedStatement selectStmt = conn.prepareStatement(selectSql);
        ResultSet rs = selectStmt.executeQuery();
        
        String updateSql = "UPDATE EVENT_BOARD SET EVENT_PATH = COALESCE(?, EVENT_PATH), EVENT_SUBPATH = COALESCE(?, EVENT_SUBPATH) WHERE EVENT_ID = ?";
        PreparedStatement updateStmt = conn.prepareStatement(updateSql);
        
        int count = 0;
        while (rs.next()) {
            int eventId = rs.getInt("EVENT_ID");
            String eventPath = rs.getString("EVENT_PATH");
            String eventSubpath = rs.getString("EVENT_SUBPATH");
            
            try {
                String newEventPath = null;
                String newEventSubpath = null;
                
                if (eventPath != null && !eventPath.contains("pub-f8fd744877724e40a29110baaa7d9f66.r2.dev")) {
                    newEventPath = uploadToCloudflare(eventPath, "event/thumbnail");
                }
                
                if (eventSubpath != null && !eventSubpath.contains("pub-f8fd744877724e40a29110baaa7d9f66.r2.dev")) {
                    newEventSubpath = uploadToCloudflare(eventSubpath, "event/thumbnail");
                }
                
                if (newEventPath != null || newEventSubpath != null) {
                    updateStmt.setString(1, newEventPath);
                    updateStmt.setString(2, newEventSubpath);
                    updateStmt.setInt(3, eventId);
                    updateStmt.executeUpdate();
                    count++;
                    System.out.println("이벤트 " + eventId + " 이미지 마이그레이션 완료");
                }
            } catch (Exception e) {
                System.err.println("이벤트 " + eventId + " 마이그레이션 실패: " + e.getMessage());
            }
        }
        System.out.println("이벤트 이미지 " + count + "개 마이그레이션 완료");
        
        rs.close();
        selectStmt.close();
        updateStmt.close();
    }
    
    private static void migrateVideoFiles() throws Exception {
        String selectSql = "SELECT VIDEO_NO, VIDEO_PATH FROM LECTURE_VIDEO WHERE VIDEO_PATH IS NOT NULL AND VIDEO_PATH NOT LIKE '%pub-f8fd744877724e40a29110baaa7d9f66.r2.dev%'";
        PreparedStatement selectStmt = conn.prepareStatement(selectSql);
        ResultSet rs = selectStmt.executeQuery();
        
        String updateSql = "UPDATE LECTURE_VIDEO SET VIDEO_PATH = ? WHERE VIDEO_NO = ?";
        PreparedStatement updateStmt = conn.prepareStatement(updateSql);
        
        int count = 0;
        while (rs.next()) {
            int videoNo = rs.getInt("VIDEO_NO");
            String videoPath = rs.getString("VIDEO_PATH");
            
            try {
                String newUrl = uploadToCloudflare(videoPath, "lecture/videos");
                if (newUrl != null) {
                    updateStmt.setString(1, newUrl);
                    updateStmt.setInt(2, videoNo);
                    updateStmt.executeUpdate();
                    count++;
                    System.out.println("비디오 " + videoNo + " 마이그레이션 완료: " + newUrl);
                }
            } catch (Exception e) {
                System.err.println("비디오 " + videoNo + " 마이그레이션 실패: " + e.getMessage());
            }
        }
        System.out.println("비디오 파일 " + count + "개 마이그레이션 완료");
        
        rs.close();
        selectStmt.close();
        updateStmt.close();
    }
    
    private static void migrateEventContent() throws Exception {
        String selectSql = "SELECT E_CONTENT_ID, E_CONTENT_PATH FROM EVENT_CONTENT WHERE E_CONTENT_PATH IS NOT NULL AND E_CONTENT_PATH NOT LIKE '%pub-f8fd744877724e40a29110baaa7d9f66.r2.dev%'";
        PreparedStatement selectStmt = conn.prepareStatement(selectSql);
        ResultSet rs = selectStmt.executeQuery();
        
        String updateSql = "UPDATE EVENT_CONTENT SET E_CONTENT_PATH = ? WHERE E_CONTENT_ID = ?";
        PreparedStatement updateStmt = conn.prepareStatement(updateSql);
        
        int count = 0;
        while (rs.next()) {
            int contentId = rs.getInt("E_CONTENT_ID");
            String contentPath = rs.getString("E_CONTENT_PATH");
            
            try {
                String newUrl = uploadToCloudflare(contentPath, "event/content");
                if (newUrl != null) {
                    updateStmt.setString(1, newUrl);
                    updateStmt.setInt(2, contentId);
                    updateStmt.executeUpdate();
                    count++;
                    System.out.println("이벤트 콘텐츠 " + contentId + " 마이그레이션 완료");
                }
            } catch (Exception e) {
                System.err.println("이벤트 콘텐츠 " + contentId + " 마이그레이션 실패: " + e.getMessage());
            }
        }
        System.out.println("이벤트 콘텐츠 " + count + "개 마이그레이션 완료");
        
        rs.close();
        selectStmt.close();
        updateStmt.close();
    }
    
    private static void migrateArchiveAttachments() throws Exception {
        String selectSql = "SELECT BOARD_NO, ATTACHMENT_PATH FROM ARCHIVE_BOARD WHERE ATTACHMENT_PATH IS NOT NULL AND ATTACHMENT_PATH NOT LIKE '%pub-f8fd744877724e40a29110baaa7d9f66.r2.dev%'";
        PreparedStatement selectStmt = conn.prepareStatement(selectSql);
        ResultSet rs = selectStmt.executeQuery();
        
        String updateSql = "UPDATE ARCHIVE_BOARD SET ATTACHMENT_PATH = ? WHERE BOARD_NO = ?";
        PreparedStatement updateStmt = conn.prepareStatement(updateSql);
        
        int count = 0;
        while (rs.next()) {
            int boardNo = rs.getInt("BOARD_NO");
            String attachmentPath = rs.getString("ATTACHMENT_PATH");
            
            try {
                String newUrl = uploadToCloudflare(attachmentPath, "archive/attachments");
                if (newUrl != null) {
                    updateStmt.setString(1, newUrl);
                    updateStmt.setInt(2, boardNo);
                    updateStmt.executeUpdate();
                    count++;
                    System.out.println("아카이브 " + boardNo + " 첨부파일 마이그레이션 완료");
                }
            } catch (Exception e) {
                System.err.println("아카이브 " + boardNo + " 마이그레이션 실패: " + e.getMessage());
            }
        }
        System.out.println("아카이브 첨부파일 " + count + "개 마이그레이션 완료");
        
        rs.close();
        selectStmt.close();
        updateStmt.close();
    }
    
    private static String uploadToCloudflare(String originalPath, String folder) {
        if (originalPath == null || originalPath.isEmpty()) {
            return null;
        }
        
        try {
            // 가능한 파일 경로들
            String[] possiblePaths = {
                originalPath,
                "src/main/webapp/uploads/" + originalPath,
                "src/main/webapp/images/" + originalPath,
                "src/main/webapp/videos/" + originalPath,
                "src/main/webapp/resources/images/" + originalPath,
                "src/main/webapp/resources/videos/" + originalPath,
                "uploads/" + originalPath,
                "images/" + originalPath,
                "videos/" + originalPath
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
                System.out.println("파일을 찾을 수 없음: " + originalPath);
                // 원본 URL이 이미 Cloudflare URL인 경우 그대로 반환
                if (originalPath.contains("http")) {
                    return originalPath;
                }
                return null;
            }
            
            // 파일명과 확장자 추출
            String fileName = targetFile.getName();
            String contentType = determineContentType(fileName);
            
            // Cloudflare에 업로드
            String key = folder.endsWith("/") ? folder + fileName : folder + "/" + fileName;
            
            PutObjectRequest putObjectRequest = PutObjectRequest.builder()
                    .bucket(R2_BUCKET)
                    .key(key)
                    .contentType(contentType)
                    .contentLength(targetFile.length())
                    .build();
            
            s3Client.putObject(putObjectRequest, RequestBody.fromFile(targetFile));
            
            String cloudflareUrl = R2_PUBLIC_URL + "/" + key;
            System.out.println("업로드 성공: " + originalPath + " -> " + cloudflareUrl);
            
            return cloudflareUrl;
            
        } catch (Exception e) {
            System.err.println("업로드 실패: " + originalPath + " - " + e.getMessage());
            return null;
        }
    }
    
    private static String determineContentType(String fileName) {
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
}