import java.io.*;
import java.net.*;
import java.util.*;
import java.security.MessageDigest;
import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import java.text.SimpleDateFormat;
import java.nio.file.*;

public class upload_all_files {
    private static final String ACCESS_KEY = "7de029bbac8e5545039f1a5e680cb18c";
    private static final String SECRET_KEY = "4911a65055712481ffb8db0e7823baaa07dafa71b5acbb0616ae773b2e583f01";
    private static final String ENDPOINT = "https://d9ccd44892a955eb74f49169431509a8.r2.cloudflarestorage.com";
    private static final String BUCKET = "edumate-files";
    private static final String PUBLIC_URL = "https://pub-f8fd744877724e40a29110baaa7d9f66.r2.dev";
    
    public static void main(String[] args) {
        System.out.println("===========================================");
        System.out.println("Uploading ALL project files to Cloudflare R2");
        System.out.println("===========================================");
        
        try {
            // Upload static event images
            uploadFilesFromDirectory("src/main/resources/static/resources/images/event/0/content", "event/content");
            uploadFilesFromDirectory("src/main/resources/static/resources/images/event/0/thumbnail", "event/thumbnail");
            uploadFilesFromDirectory("src/main/resources/static/resources/images/event/thumbnail", "event/thumbnail");
            
            // Upload webapp resources
            uploadFilesFromDirectory("src/main/webapp/resources/images/adv", "common/adv");
            uploadFilesFromDirectory("src/main/webapp/resources/images/common", "common/images");
            uploadFilesFromDirectory("src/main/webapp/resources/images/event/icon", "common/event");
            uploadFilesFromDirectory("src/main/webapp/resources/images/member", "common/member");
            uploadFilesFromDirectory("src/main/webapp/resources/images/notice", "common/notice");
            uploadFilesFromDirectory("src/main/webapp/resources/images/reference", "common/reference");
            uploadFilesFromDirectory("src/main/webapp/resources/images/request", "common/request");
            uploadFilesFromDirectory("src/main/webapp/resources/images/teacher", "common/teacher");
            
            // Upload event content and thumbnails from webapp
            uploadFilesFromDirectory("src/main/webapp/resources/images/event/content/24", "event/content");
            uploadFilesFromDirectory("src/main/webapp/resources/images/event/content/26", "event/content");
            uploadFilesFromDirectory("src/main/webapp/resources/images/event/content/27", "event/content");
            uploadFilesFromDirectory("src/main/webapp/resources/images/event/thumbnail/24", "event/thumbnail");
            uploadFilesFromDirectory("src/main/webapp/resources/images/event/thumbnail/26", "event/thumbnail");
            uploadFilesFromDirectory("src/main/webapp/resources/images/event/thumbnail/27", "event/thumbnail");
            
            System.out.println("\n===========================================");
            System.out.println("All files uploaded successfully!");
            System.out.println("===========================================");
            
        } catch (Exception e) {
            System.err.println("Error: " + e.getMessage());
            e.printStackTrace();
        }
    }
    
    private static void uploadFilesFromDirectory(String localDir, String s3Prefix) throws Exception {
        File directory = new File(localDir);
        if (!directory.exists()) {
            System.out.println("Directory not found: " + localDir);
            return;
        }
        
        System.out.println("\nUploading from: " + localDir + " -> " + s3Prefix);
        
        File[] files = directory.listFiles();
        if (files != null) {
            for (File file : files) {
                if (file.isFile() && isMediaFile(file.getName())) {
                    String fileName = file.getName();
                    String s3Key = s3Prefix + "/" + fileName;
                    
                    try {
                        uploadFile(file, s3Key);
                        System.out.println("  Uploaded: " + fileName + " -> " + PUBLIC_URL + "/" + s3Key);
                    } catch (Exception e) {
                        System.err.println("  Failed to upload " + fileName + ": " + e.getMessage());
                    }
                }
            }
        }
    }
    
    private static boolean isMediaFile(String fileName) {
        String lowerName = fileName.toLowerCase();
        return lowerName.endsWith(".jpg") || lowerName.endsWith(".jpeg") || lowerName.endsWith(".png") ||
               lowerName.endsWith(".gif") || lowerName.endsWith(".bmp") || lowerName.endsWith(".webp") ||
               lowerName.endsWith(".svg") || lowerName.endsWith(".mp4") || lowerName.endsWith(".avi") ||
               lowerName.endsWith(".mov") || lowerName.endsWith(".wmv") || lowerName.endsWith(".flv") ||
               lowerName.endsWith(".mkv");
    }
    
    private static void uploadFile(File file, String s3Key) throws Exception {
        String contentType = getContentType(file.getName());
        
        // Prepare the request
        String method = "PUT";
        String host = "d9ccd44892a955eb74f49169431509a8.r2.cloudflarestorage.com";
        String uri = "/" + BUCKET + "/" + s3Key;
        
        // Create AWS Signature Version 4
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd'T'HHmmss'Z'");
        dateFormat.setTimeZone(TimeZone.getTimeZone("UTC"));
        String timestamp = dateFormat.format(new Date());
        String date = timestamp.substring(0, 8);
        
        // Read file content
        byte[] fileContent = Files.readAllBytes(file.toPath());
        
        // Create canonical request
        String canonicalRequest = method + "\n" +
                uri + "\n" +
                "\n" +
                "host:" + host + "\n" +
                "x-amz-content-sha256:" + sha256Hex(fileContent) + "\n" +
                "x-amz-date:" + timestamp + "\n" +
                "\n" +
                "host;x-amz-content-sha256;x-amz-date\n" +
                sha256Hex(fileContent);
        
        // Create string to sign
        String credentialScope = date + "/auto/s3/aws4_request";
        String stringToSign = "AWS4-HMAC-SHA256\n" +
                timestamp + "\n" +
                credentialScope + "\n" +
                sha256Hex(canonicalRequest.getBytes("UTF-8"));
        
        // Create signature
        byte[] signingKey = getSigningKey(SECRET_KEY, date, "auto", "s3");
        String signature = hmacSha256Hex(signingKey, stringToSign);
        
        // Create authorization header
        String authorization = "AWS4-HMAC-SHA256 " +
                "Credential=" + ACCESS_KEY + "/" + credentialScope + ", " +
                "SignedHeaders=host;x-amz-content-sha256;x-amz-date, " +
                "Signature=" + signature;
        
        // Upload file
        URL url = new URL(ENDPOINT + uri);
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        connection.setRequestMethod(method);
        connection.setDoOutput(true);
        connection.setRequestProperty("Host", host);
        connection.setRequestProperty("Authorization", authorization);
        connection.setRequestProperty("x-amz-date", timestamp);
        connection.setRequestProperty("x-amz-content-sha256", sha256Hex(fileContent));
        connection.setRequestProperty("Content-Type", contentType);
        connection.setRequestProperty("Content-Length", String.valueOf(fileContent.length));
        
        try (OutputStream os = connection.getOutputStream()) {
            os.write(fileContent);
        }
        
        int responseCode = connection.getResponseCode();
        if (responseCode != 200) {
            throw new Exception("Upload failed with response code: " + responseCode);
        }
    }
    
    private static String getContentType(String fileName) {
        String lowerName = fileName.toLowerCase();
        if (lowerName.endsWith(".jpg") || lowerName.endsWith(".jpeg")) {
            return "image/jpeg";
        } else if (lowerName.endsWith(".png")) {
            return "image/png";
        } else if (lowerName.endsWith(".gif")) {
            return "image/gif";
        } else if (lowerName.endsWith(".bmp")) {
            return "image/bmp";
        } else if (lowerName.endsWith(".webp")) {
            return "image/webp";
        } else if (lowerName.endsWith(".svg")) {
            return "image/svg+xml";
        } else if (lowerName.endsWith(".mp4")) {
            return "video/mp4";
        } else if (lowerName.endsWith(".avi")) {
            return "video/avi";
        } else if (lowerName.endsWith(".mov")) {
            return "video/quicktime";
        } else if (lowerName.endsWith(".wmv")) {
            return "video/x-ms-wmv";
        } else if (lowerName.endsWith(".flv")) {
            return "video/x-flv";
        } else if (lowerName.endsWith(".mkv")) {
            return "video/x-matroska";
        } else {
            return "application/octet-stream";
        }
    }
    
    private static String sha256Hex(byte[] data) throws Exception {
        MessageDigest digest = MessageDigest.getInstance("SHA-256");
        byte[] hash = digest.digest(data);
        return bytesToHex(hash);
    }
    
    private static String sha256Hex(String data) throws Exception {
        return sha256Hex(data.getBytes("UTF-8"));
    }
    
    private static String bytesToHex(byte[] bytes) {
        StringBuilder result = new StringBuilder();
        for (byte b : bytes) {
            result.append(String.format("%02x", b));
        }
        return result.toString();
    }
    
    private static byte[] getSigningKey(String key, String dateStamp, String regionName, String serviceName) throws Exception {
        byte[] kDate = hmacSha256(("AWS4" + key).getBytes("UTF-8"), dateStamp);
        byte[] kRegion = hmacSha256(kDate, regionName);
        byte[] kService = hmacSha256(kRegion, serviceName);
        byte[] kSigning = hmacSha256(kService, "aws4_request");
        return kSigning;
    }
    
    private static byte[] hmacSha256(byte[] key, String data) throws Exception {
        Mac mac = Mac.getInstance("HmacSHA256");
        mac.init(new SecretKeySpec(key, "HmacSHA256"));
        return mac.doFinal(data.getBytes("UTF-8"));
    }
    
    private static String hmacSha256Hex(byte[] key, String data) throws Exception {
        return bytesToHex(hmacSha256(key, data));
    }
}