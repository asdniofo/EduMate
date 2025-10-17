package com.edumate.boot.app.lecture.controller;

import com.edumate.boot.app.lecture.dto.LectureListRequest;
import com.edumate.boot.app.lecture.dto.ReviewListRequest;
import com.edumate.boot.app.lecture.dto.VideoListRequest;
import com.edumate.boot.domain.lecture.model.service.LectureService;
import com.edumate.boot.domain.lecture.model.vo.Lecture;
import com.edumate.boot.domain.lecture.model.vo.LectureVideo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import lombok.RequiredArgsConstructor;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/lecture")
@RequiredArgsConstructor
public class LectureController {

    private final LectureService lService;

    private String getFileType(String fileName) {
        String lowerFileName = fileName.toLowerCase();
        String[] imageType = {".jpg", ".jpeg", ".png", ".gif", ".bmp"};
        String[] videoType = {".mp4", ".avi", ".mov", ".wmv", ".flv", ".mkv"};

        for (String ext : imageType) {
            if (lowerFileName.endsWith(ext)) {
                return "image";
            }
        }

        for (String ext : videoType) {
            if (lowerFileName.endsWith(ext)) {
                return "video";
            }
        }
        return "unknown";
    }

    private int getVideoDuration(String filePath) {
        try {
            // FFprobe 명령어로 영상 길이 추출
            ProcessBuilder pb = new ProcessBuilder(
                "ffprobe",
                "-v", "quiet",
                "-show_entries", "format=duration",
                "-of", "csv=p=0",
                filePath
            );
            Process process = pb.start();
            BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()));
            String duration = reader.readLine();
            if (duration != null && !duration.trim().isEmpty()) {
                return (int) Double.parseDouble(duration.trim());
            }
        } catch (Exception e) {
            System.err.println("영상 시간 추출 실패: " + e.getMessage());
        }
        return 0;
    }

    private String generateSequentialFileName(String originalFileName, String uploadPath) {
        String fileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
        String dateStr = sdf.format(new Date());

        File uploadDir = new File(uploadPath);
        int sequenceNumber = 1;
        if (uploadDir.exists()) {
            File[] files = uploadDir.listFiles();
            if (files != null) {
                for (File file : files) {
                    String fileName = file.getName();
                    if (fileName.startsWith(dateStr + "_")) {
                        sequenceNumber++;
                    }
                }
            }
        }
        return dateStr + "_" + String.format("%05d", sequenceNumber) + fileExtension;
    }

    private String saveFile(MultipartFile file) throws IOException {
        String originalFileName = file.getOriginalFilename();
        String fileType = getFileType(originalFileName);
        String uploadPath;

        // 확장자에 따라 저장 경로 결정
        if ("image".equals(fileType)) {
            uploadPath = System.getProperty("user.dir") + "/src/main/webapp/resources/images/lecture/";
        } else if ("video".equals(fileType)) {
            uploadPath = System.getProperty("user.dir") + "/src/main/webapp/resources/videos/lecture/";
        } else {
            throw new IllegalArgumentException("지원하지 않는 파일 형식입니다: " + originalFileName);
        }
        String newFileName = generateSequentialFileName(originalFileName, uploadPath);
        File saveFile = new File(uploadPath + newFileName);
        file.transferTo(saveFile);

        return newFileName;
    }

    @GetMapping("/list")
    public String showLectureList(@ModelAttribute LectureListRequest Lecture
            ,@RequestParam(value = "page", defaultValue = "1") int currentPage
            ,@RequestParam(value = "category", defaultValue = "전체") String category
            ,@RequestParam(value = "sort", defaultValue = "인기순") String sort
            ,@RequestParam(value = "search", defaultValue = "") String search, Model model) {
        try {
            List<LectureListRequest> lList = null;
            int totalCount = 0;
            int lectureCountPerPage = 9;
            String sortValue = null;

            // 정렬 조건 설정
            if (sort.equals("인기순")) {
                sortValue = "COUNT_STUDENT DESC";
            } else if (sort.equals("최신순")){
                sortValue = "LECTURE_CREATED_DATE DESC";
            } else if (sort.equals("낮은가격순")){
                sortValue = "LECTURE_PRICE ASC";
            } else if (sort.equals("높은가격순")){
                sortValue = "LECTURE_PRICE DESC";
            } else if (sort.equals("별점높은순")){
                sortValue = "LECTURE_RATING DESC";
            }

            // 검색어 처리
            boolean hasSearch = search != null && !search.trim().isEmpty();

            if (hasSearch) {
                // 검색 모드 (통합 검색)
                if (category.equals("전체")) {
                    totalCount = lService.getSearchCountAll(search);
                    lList = lService.selectSearchAll(currentPage, lectureCountPerPage, search, sortValue);
                } else {
                    totalCount = lService.getSearchCategoryCount(search, category);
                    lList = lService.selectSearchCategoryList(currentPage, lectureCountPerPage, search, category, sortValue);
                }
            } else {
                // 일반 모드
                if (category.equals("전체")) {
                    totalCount = lService.getTotalCount();
                    lList = lService.selectList(currentPage, lectureCountPerPage, sortValue);
                } else {
                    totalCount = lService.getCategoryCount(category);
                    lList = lService.selectCategoryList(currentPage, lectureCountPerPage, category, sortValue);
                }
            }
            int maxPage = (int) Math.ceil((double) totalCount / lectureCountPerPage);
            int naviCountPerPage = 5;
            int startNavi = ((currentPage - 1) / naviCountPerPage) * naviCountPerPage + 1;
            int endNavi = (startNavi - 1) + naviCountPerPage;
            if (endNavi > maxPage) endNavi = maxPage;
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("currentPage", currentPage);
            model.addAttribute("lectureCountPerPage", lectureCountPerPage);
            model.addAttribute("maxPage", maxPage);
            model.addAttribute("startNavi", startNavi);
            model.addAttribute("endNavi", endNavi);
            model.addAttribute("lList", lList);
            model.addAttribute("category", category);
            model.addAttribute("sort", sort);
            model.addAttribute("search", search);
            return "lecture/list";
        } catch (Exception e) {
            model.addAttribute("errorMsg", e.getMessage());
            return "common/error";
        }
    }

    @GetMapping("/details")
    public String showLectureDetails(@ModelAttribute LectureListRequest lecture
            ,@ModelAttribute ReviewListRequest review
            ,@ModelAttribute VideoListRequest video
            ,@RequestParam int lectureNo, Model model) {
        try {
            List<LectureListRequest> lList = lService.selectOneById(lectureNo);
            List<ReviewListRequest> rList = lService.selectReviewById(lectureNo);
            int videoCount = lService.totalVideoById(lectureNo);
            int totalTime = lService.totalTimeById(lectureNo);
            List<VideoListRequest> vList = lService.selectVideoListById(lectureNo);

            StringBuilder totalTimeFormatted = new StringBuilder();
            int totalHour = totalTime / 3600;
            int totalMinute = (totalTime % 3600) / 60;
            int totalSecond = totalTime % 60;
            if (totalHour > 0) totalTimeFormatted.append(totalHour).append("시간 ");
            if (totalMinute > 0) totalTimeFormatted.append(totalMinute).append("분 ");
            if (totalSecond > 0) totalTimeFormatted.append(totalSecond).append("초");
            
            model.addAttribute("lList", lList);
            model.addAttribute("rList", rList);
            model.addAttribute("vList", vList);
            model.addAttribute("videoCount", videoCount);
            model.addAttribute("totalTimeFormatted", totalTimeFormatted.toString().trim());
            return "lecture/details";
        } catch (Exception e) {
            model.addAttribute("errorMsg", e.getMessage());
            return "common/error";
        }
    }

    @GetMapping("/player")
    public String showLecturePlayer(@ModelAttribute VideoListRequest video
            ,@RequestParam int videoNo, Model model) {
        try {
            List<VideoListRequest> currentVideo = lService.selectVideoById(videoNo);
            int lectureNo =  currentVideo.get(0).getLectureNo();
            int nextVideoNo = currentVideo.get(0).getVideoOrder()+1;
            List<VideoListRequest> nextVideo = lService.selectNextVideoById(lectureNo,nextVideoNo);
            String lectureName = lService.selectNameById(lectureNo);
            model.addAttribute("currentVideo", currentVideo);
            model.addAttribute("nextVideo", nextVideo);
            model.addAttribute("lectureName", lectureName);
        } catch (Exception e) {
            model.addAttribute("errorMsg", e.getMessage());
            return "common/error";
        }
        return "lecture/player";
    }

    @GetMapping("/add")
    public String showLectureAdd(Model model) {
        return "lecture/add";
    }

    @PostMapping("/add")
    public String addLecture(@RequestParam("lectureName") String lectureName,
                           @RequestParam("lectureCategory") String lectureCategory,
                           @RequestParam("lectureDescription") String lectureDescription,
                           @RequestParam("lecturePrice") int lecturePrice,
                           @RequestParam("thumbnailImage") MultipartFile thumbnailImage,
                           @RequestParam("lectureVideos[]") MultipartFile[] lectureVideos,
                           @RequestParam("videoTitles[]") String[] videoTitles,
                           Model model) {
        try {
            Lecture lecture = new Lecture();
            String thumbnailFileName = null;

            if (!thumbnailImage.isEmpty()) {
                thumbnailFileName = saveFile(thumbnailImage);
            }
            String memberId = "teacher02"; // 세션처리 해야함

            lecture.setMemberId(memberId);
            lecture.setLectureName(lectureName);
            lecture.setLectureContent(lectureDescription);
            lecture.setLecturePrice(lecturePrice);
            lecture.setLectureCategory(lectureCategory);
            lecture.setLecturePath(thumbnailFileName);
            lecture.setLectureCreatedDate(new Timestamp(System.currentTimeMillis()));

            int result = lService.insertLecture(lecture);
            int lectureNo = lecture.getLectureNo();

            for (int i = 0; i < lectureVideos.length; i++) {
                if (!lectureVideos[i].isEmpty()) {
                    // 영상 파일 저장
                    String videoFileName = saveFile(lectureVideos[i]);

                    // 저장된 영상 파일의 실제 시간 추출
                    String uploadPath = "video".equals(getFileType(lectureVideos[i].getOriginalFilename()))
                        ? System.getProperty("user.dir") + "/src/main/webapp/resources/videos/lecture/"
                        : System.getProperty("user.dir") + "/src/main/webapp/resources/images/lecture/";
                    String fullFilePath = uploadPath + videoFileName;
                    int videoDuration = getVideoDuration(fullFilePath);

                    LectureVideo video = new LectureVideo();
                    video.setLectureNo(lectureNo);
                    video.setVideoTitle(videoTitles[i]);
                    video.setVideoOrder(i + 1);
                    video.setVideoTime(videoDuration);
                    video.setVideoPath(videoFileName);

                    int result2 = lService.insertVideo(video);
                }
            }

            return "redirect:/lecture/list";
        } catch (Exception e) {
            model.addAttribute("errorMsg", e.getMessage());
            return "common/error";
        }
    }
}
