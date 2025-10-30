import java.sql.*;
import java.io.*;
import java.nio.file.*;
import java.util.*;

public class upload_files {
    private static final String DB_URL = "jdbc:oracle:thin:@20.249.165.235:1521/XEPDB1";
    private static final String DB_USER = "EDUMATE";
    private static final String DB_PASSWORD = "EDUMATE";
    
    private static final String CLOUDFLARE_URL = "https://pub-f8fd744877724e40a29110baaa7d9f66.r2.dev";
    
    public static void main(String[] args) {
        System.out.println("===========================================");
        System.out.println("Checking actual files for upload");
        System.out.println("===========================================");
        
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            
            checkLectureImages(conn);
            checkVideoFiles(conn);
            
            conn.close();
            
        } catch (Exception e) {
            System.err.println("Error: " + e.getMessage());
            e.printStackTrace();
        }
    }
    
    private static void checkLectureImages(Connection conn) throws Exception {
        System.out.println("\nChecking lecture images...");
        
        String selectSql = "SELECT LECTURE_NO, LECTURE_PATH FROM LECTURE WHERE LECTURE_PATH LIKE '%pub-f8fd744877724e40a29110baaa7d9f66.r2.dev%' AND ROWNUM <= 10";
        PreparedStatement selectStmt = conn.prepareStatement(selectSql);
        ResultSet rs = selectStmt.executeQuery();
        
        while (rs.next()) {
            int lectureNo = rs.getInt("LECTURE_NO");
            String lecturePath = rs.getString("LECTURE_PATH");
            String fileName = extractFileName(lecturePath);
            
            System.out.println("Lecture " + lectureNo + ": " + fileName);
            
            // Check if file exists locally
            String[] possiblePaths = {
                "src/main/webapp/images/lecture/" + fileName,
                "src/main/webapp/resources/images/lecture/" + fileName,
                "images/lecture/" + fileName,
                fileName
            };
            
            boolean fileFound = false;
            for (String path : possiblePaths) {
                File file = new File(path);
                if (file.exists()) {
                    System.out.println("  Found at: " + path + " (Size: " + file.length() + " bytes)");
                    fileFound = true;
                    break;
                }
            }
            
            if (!fileFound) {
                System.out.println("  File NOT FOUND locally: " + fileName);
            }
        }
        
        rs.close();
        selectStmt.close();
    }
    
    private static void checkVideoFiles(Connection conn) throws Exception {
        System.out.println("\nChecking video files...");
        
        String selectSql = "SELECT VIDEO_NO, VIDEO_PATH FROM LECTURE_VIDEO WHERE VIDEO_PATH LIKE '%pub-f8fd744877724e40a29110baaa7d9f66.r2.dev%' AND ROWNUM <= 5";
        PreparedStatement selectStmt = conn.prepareStatement(selectSql);
        ResultSet rs = selectStmt.executeQuery();
        
        while (rs.next()) {
            int videoNo = rs.getInt("VIDEO_NO");
            String videoPath = rs.getString("VIDEO_PATH");
            String fileName = extractFileName(videoPath);
            
            System.out.println("Video " + videoNo + ": " + fileName);
            
            // Check if file exists locally
            String[] possiblePaths = {
                "src/main/webapp/videos/lecture/" + fileName,
                "src/main/webapp/resources/videos/lecture/" + fileName,
                "videos/lecture/" + fileName,
                fileName
            };
            
            boolean fileFound = false;
            for (String path : possiblePaths) {
                File file = new File(path);
                if (file.exists()) {
                    System.out.println("  Found at: " + path + " (Size: " + file.length() + " bytes)");
                    fileFound = true;
                    break;
                }
            }
            
            if (!fileFound) {
                System.out.println("  File NOT FOUND locally: " + fileName);
            }
        }
        
        rs.close();
        selectStmt.close();
    }
    
    private static String extractFileName(String path) {
        if (path == null) return "";
        
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