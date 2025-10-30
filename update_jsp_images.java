import java.io.*;
import java.nio.file.*;
import java.util.*;
import java.util.regex.*;

public class update_jsp_images {
    private static final String CLOUDFLARE_BASE = "https://pub-f8fd744877724e40a29110baaa7d9f66.r2.dev";
    private static int totalUpdates = 0;
    
    public static void main(String[] args) {
        System.out.println("===========================================");
        System.out.println("Updating JSP image paths to Cloudflare URLs");
        System.out.println("===========================================");
        
        try {
            // Find all JSP files
            List<String> jspFiles = findJspFiles("src/main/webapp/WEB-INF/views");
            
            for (String jspFile : jspFiles) {
                updateJspFile(jspFile);
            }
            
            System.out.println("\n===========================================");
            System.out.println("Total updates: " + totalUpdates);
            System.out.println("All JSP files updated successfully!");
            System.out.println("===========================================");
            
        } catch (Exception e) {
            System.err.println("Error: " + e.getMessage());
            e.printStackTrace();
        }
    }
    
    private static List<String> findJspFiles(String directory) throws IOException {
        List<String> jspFiles = new ArrayList<>();
        Files.walk(Paths.get(directory))
             .filter(path -> path.toString().endsWith(".jsp"))
             .forEach(path -> jspFiles.add(path.toString().replace("\\", "/")));
        return jspFiles;
    }
    
    private static void updateJspFile(String filePath) throws IOException {
        System.out.println("\nProcessing: " + filePath);
        
        String content = new String(Files.readAllBytes(Paths.get(filePath)));
        String originalContent = content;
        int fileUpdates = 0;
        
        // Define replacement patterns
        Map<String, String> replacements = new HashMap<>();
        
        // Common images - using contextPath
        replacements.put("\\$\\{pageContext\\.request\\.contextPath\\}/resources/images/common/logo\\.png", 
                        CLOUDFLARE_BASE + "/common/images/logo.png");
        replacements.put("\\$\\{pageContext\\.request\\.contextPath\\}/resources/images/common/logo2\\.png", 
                        CLOUDFLARE_BASE + "/common/images/logo2.png");
        replacements.put("\\$\\{pageContext\\.request\\.contextPath\\}/resources/images/common/mypage1\\.png", 
                        CLOUDFLARE_BASE + "/common/images/mypage1.png");
        replacements.put("\\$\\{pageContext\\.request\\.contextPath\\}/resources/images/common/mypage2\\.png", 
                        CLOUDFLARE_BASE + "/common/images/mypage2.png");
        replacements.put("\\$\\{pageContext\\.request\\.contextPath\\}/resources/images/common/mypage3\\.png", 
                        CLOUDFLARE_BASE + "/common/images/mypage3.png");
        replacements.put("\\$\\{pageContext\\.request\\.contextPath\\}/resources/images/common/mypage4\\.png", 
                        CLOUDFLARE_BASE + "/common/images/mypage4.png");
        
        // Direct paths (without contextPath)
        replacements.put("/resources/images/teacher/QnAIcon\\.png", 
                        CLOUDFLARE_BASE + "/common/teacher/QnAIcon.png");
        replacements.put("/resources/images/reference/reference-icon\\.png", 
                        CLOUDFLARE_BASE + "/common/reference/reference-icon.png");
        replacements.put("/resources/images/notice/noticeIcon\\.png", 
                        CLOUDFLARE_BASE + "/common/notice/noticeIcon.png");
        replacements.put("/resources/images/request/requestIcon\\.png", 
                        CLOUDFLARE_BASE + "/common/request/requestIcon.png");
        replacements.put("/resources/images/member/mypage\\.png", 
                        CLOUDFLARE_BASE + "/common/member/mypage.png");
        replacements.put("/resources/images/member/postcomment\\.png", 
                        CLOUDFLARE_BASE + "/common/member/postcomment.png");
        replacements.put("/resources/images/adv/gemini\\.png", 
                        CLOUDFLARE_BASE + "/common/adv/gemini.png");
        replacements.put("/resources/images/event/icon/event_icon\\.png", 
                        CLOUDFLARE_BASE + "/common/event/event_icon.png");
        replacements.put("/resources/images/event/icon/event_insert_icon\\.png", 
                        CLOUDFLARE_BASE + "/common/event/event_insert_icon.png");
        replacements.put("/resources/images/event_icon\\.png", 
                        CLOUDFLARE_BASE + "/common/event/event_icon.png");
        
        // Apply replacements
        for (Map.Entry<String, String> entry : replacements.entrySet()) {
            Pattern pattern = Pattern.compile(entry.getKey());
            Matcher matcher = pattern.matcher(content);
            if (matcher.find()) {
                content = matcher.replaceAll(entry.getValue());
                fileUpdates++;
                System.out.println("  Updated: " + entry.getKey() + " -> " + entry.getValue());
            }
        }
        
        // Write back if changes were made
        if (!content.equals(originalContent)) {
            Files.write(Paths.get(filePath), content.getBytes());
            totalUpdates += fileUpdates;
            System.out.println("  " + fileUpdates + " updates applied to " + filePath);
        } else {
            System.out.println("  No changes needed for " + filePath);
        }
    }
}