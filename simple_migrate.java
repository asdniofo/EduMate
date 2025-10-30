import java.sql.*;

public class simple_migrate {
    private static final String DB_URL = "jdbc:oracle:thin:@20.249.165.235:1521/XEPDB1";
    private static final String DB_USER = "EDUMATE";
    private static final String DB_PASSWORD = "EDUMATE";
    
    private static final String CLOUDFLARE_URL = "https://pub-f8fd744877724e40a29110baaa7d9f66.r2.dev";
    
    public static void main(String[] args) {
        System.out.println("===========================================");
        System.out.println("Cloudflare URL 업데이트 시작");
        System.out.println("===========================================");
        
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            
            // 기존 파일명을 Cloudflare URL로 변경
            updateLectureImages(conn);
            updateEventImages(conn);
            updateVideoFiles(conn);
            updateEventContent(conn);
            updateArchiveAttachments(conn);
            
            conn.close();
            
            System.out.println("===========================================");
            System.out.println("모든 URL이 Cloudflare로 업데이트되었습니다!");
            System.out.println("===========================================");
            
        } catch (Exception e) {
            System.err.println("업데이트 중 오류 발생: " + e.getMessage());
            e.printStackTrace();
        }
    }
    
    private static void updateLectureImages(Connection conn) throws Exception {
        System.out.println("\n강의 이미지 URL 업데이트 중...");
        
        String updateSql = "UPDATE LECTURE SET LECTURE_PATH = ? WHERE LECTURE_PATH IS NOT NULL AND LECTURE_PATH NOT LIKE '%pub-f8fd744877724e40a29110baaa7d9f66.r2.dev%'";
        String selectSql = "SELECT LECTURE_NO, LECTURE_PATH FROM LECTURE WHERE LECTURE_PATH IS NOT NULL AND LECTURE_PATH NOT LIKE '%pub-f8fd744877724e40a29110baaa7d9f66.r2.dev%'";
        
        PreparedStatement selectStmt = conn.prepareStatement(selectSql);
        ResultSet rs = selectStmt.executeQuery();
        
        PreparedStatement updateStmt = conn.prepareStatement("UPDATE LECTURE SET LECTURE_PATH = ? WHERE LECTURE_NO = ?");
        
        int count = 0;
        while (rs.next()) {
            int lectureNo = rs.getInt("LECTURE_NO");
            String lecturePath = rs.getString("LECTURE_PATH");
            
            String newUrl = CLOUDFLARE_URL + "/lecture/images/" + extractFileName(lecturePath);
            
            updateStmt.setString(1, newUrl);
            updateStmt.setInt(2, lectureNo);
            updateStmt.executeUpdate();
            
            count++;
            System.out.println("강의 " + lectureNo + ": " + lecturePath + " -> " + newUrl);
        }
        
        System.out.println("강의 이미지 " + count + "개 업데이트 완료");
        rs.close();
        selectStmt.close();
        updateStmt.close();
    }
    
    private static void updateEventImages(Connection conn) throws Exception {
        System.out.println("\n이벤트 이미지 URL 업데이트 중...");
        
        String selectSql = "SELECT EVENT_ID, EVENT_PATH, EVENT_SUBPATH FROM EVENT_BOARD WHERE (EVENT_PATH IS NOT NULL AND EVENT_PATH NOT LIKE '%pub-f8fd744877724e40a29110baaa7d9f66.r2.dev%') OR (EVENT_SUBPATH IS NOT NULL AND EVENT_SUBPATH NOT LIKE '%pub-f8fd744877724e40a29110baaa7d9f66.r2.dev%')";
        PreparedStatement selectStmt = conn.prepareStatement(selectSql);
        ResultSet rs = selectStmt.executeQuery();
        
        PreparedStatement updateStmt = conn.prepareStatement("UPDATE EVENT_BOARD SET EVENT_PATH = COALESCE(?, EVENT_PATH), EVENT_SUBPATH = COALESCE(?, EVENT_SUBPATH) WHERE EVENT_ID = ?");
        
        int count = 0;
        while (rs.next()) {
            int eventId = rs.getInt("EVENT_ID");
            String eventPath = rs.getString("EVENT_PATH");
            String eventSubpath = rs.getString("EVENT_SUBPATH");
            
            String newEventPath = null;
            String newEventSubpath = null;
            
            if (eventPath != null && !eventPath.contains("pub-f8fd744877724e40a29110baaa7d9f66.r2.dev")) {
                newEventPath = CLOUDFLARE_URL + "/event/thumbnail/" + extractFileName(eventPath);
            }
            
            if (eventSubpath != null && !eventSubpath.contains("pub-f8fd744877724e40a29110baaa7d9f66.r2.dev")) {
                newEventSubpath = CLOUDFLARE_URL + "/event/thumbnail/" + extractFileName(eventSubpath);
            }
            
            if (newEventPath != null || newEventSubpath != null) {
                updateStmt.setString(1, newEventPath);
                updateStmt.setString(2, newEventSubpath);
                updateStmt.setInt(3, eventId);
                updateStmt.executeUpdate();
                count++;
                System.out.println("이벤트 " + eventId + " 업데이트 완료");
            }
        }
        
        System.out.println("이벤트 이미지 " + count + "개 업데이트 완료");
        rs.close();
        selectStmt.close();
        updateStmt.close();
    }
    
    private static void updateVideoFiles(Connection conn) throws Exception {
        System.out.println("\n비디오 파일 URL 업데이트 중...");
        
        String selectSql = "SELECT VIDEO_NO, VIDEO_PATH FROM LECTURE_VIDEO WHERE VIDEO_PATH IS NOT NULL AND VIDEO_PATH NOT LIKE '%pub-f8fd744877724e40a29110baaa7d9f66.r2.dev%'";
        PreparedStatement selectStmt = conn.prepareStatement(selectSql);
        ResultSet rs = selectStmt.executeQuery();
        
        PreparedStatement updateStmt = conn.prepareStatement("UPDATE LECTURE_VIDEO SET VIDEO_PATH = ? WHERE VIDEO_NO = ?");
        
        int count = 0;
        while (rs.next()) {
            int videoNo = rs.getInt("VIDEO_NO");
            String videoPath = rs.getString("VIDEO_PATH");
            
            String newUrl = CLOUDFLARE_URL + "/lecture/videos/" + extractFileName(videoPath);
            
            updateStmt.setString(1, newUrl);
            updateStmt.setInt(2, videoNo);
            updateStmt.executeUpdate();
            
            count++;
            System.out.println("비디오 " + videoNo + ": " + videoPath + " -> " + newUrl);
        }
        
        System.out.println("비디오 파일 " + count + "개 업데이트 완료");
        rs.close();
        selectStmt.close();
        updateStmt.close();
    }
    
    private static void updateEventContent(Connection conn) throws Exception {
        System.out.println("\n이벤트 콘텐츠 URL 업데이트 중...");
        
        String selectSql = "SELECT E_CONTENT_ID, E_CONTENT_PATH FROM EVENT_CONTENT WHERE E_CONTENT_PATH IS NOT NULL AND E_CONTENT_PATH NOT LIKE '%pub-f8fd744877724e40a29110baaa7d9f66.r2.dev%'";
        PreparedStatement selectStmt = conn.prepareStatement(selectSql);
        ResultSet rs = selectStmt.executeQuery();
        
        PreparedStatement updateStmt = conn.prepareStatement("UPDATE EVENT_CONTENT SET E_CONTENT_PATH = ? WHERE E_CONTENT_ID = ?");
        
        int count = 0;
        while (rs.next()) {
            int contentId = rs.getInt("E_CONTENT_ID");
            String contentPath = rs.getString("E_CONTENT_PATH");
            
            String newUrl = CLOUDFLARE_URL + "/event/content/" + extractFileName(contentPath);
            
            updateStmt.setString(1, newUrl);
            updateStmt.setInt(2, contentId);
            updateStmt.executeUpdate();
            
            count++;
            System.out.println("이벤트 콘텐츠 " + contentId + " 업데이트 완료");
        }
        
        System.out.println("이벤트 콘텐츠 " + count + "개 업데이트 완료");
        rs.close();
        selectStmt.close();
        updateStmt.close();
    }
    
    private static void updateArchiveAttachments(Connection conn) throws Exception {
        System.out.println("\n아카이브 첨부파일 URL 업데이트 중...");
        
        String selectSql = "SELECT BOARD_NO, ATTACHMENT_PATH FROM ARCHIVE_BOARD WHERE ATTACHMENT_PATH IS NOT NULL AND ATTACHMENT_PATH NOT LIKE '%pub-f8fd744877724e40a29110baaa7d9f66.r2.dev%'";
        PreparedStatement selectStmt = conn.prepareStatement(selectSql);
        ResultSet rs = selectStmt.executeQuery();
        
        PreparedStatement updateStmt = conn.prepareStatement("UPDATE ARCHIVE_BOARD SET ATTACHMENT_PATH = ? WHERE BOARD_NO = ?");
        
        int count = 0;
        while (rs.next()) {
            int boardNo = rs.getInt("BOARD_NO");
            String attachmentPath = rs.getString("ATTACHMENT_PATH");
            
            String newUrl = CLOUDFLARE_URL + "/archive/attachments/" + extractFileName(attachmentPath);
            
            updateStmt.setString(1, newUrl);
            updateStmt.setInt(2, boardNo);
            updateStmt.executeUpdate();
            
            count++;
            System.out.println("아카이브 " + boardNo + " 첨부파일 업데이트 완료");
        }
        
        System.out.println("아카이브 첨부파일 " + count + "개 업데이트 완료");
        rs.close();
        selectStmt.close();
        updateStmt.close();
    }
    
    private static String extractFileName(String path) {
        if (path == null) return "";
        
        // 경로에서 파일명만 추출
        String fileName = path;
        if (path.contains("/")) {
            fileName = path.substring(path.lastIndexOf("/") + 1);
        }
        if (path.contains("\\")) {
            fileName = path.substring(path.lastIndexOf("\\") + 1);
        }
        
        return fileName;
    }
}