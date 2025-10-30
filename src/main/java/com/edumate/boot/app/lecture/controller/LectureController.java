package com.edumate.boot.app.lecture.controller;

import com.edumate.boot.app.lecture.dto.LectureListRequest;
import com.edumate.boot.app.lecture.dto.ReviewListRequest;
import com.edumate.boot.app.lecture.dto.VideoListRequest;
import com.edumate.boot.common.util.CloudflareR2Service;
import com.edumate.boot.domain.lecture.model.service.LectureService;
import com.edumate.boot.domain.purchase.model.service.PurchaseService;
import com.edumate.boot.domain.lecture.model.vo.Lecture;
import com.edumate.boot.domain.lecture.model.vo.LectureVideo;
import com.edumate.boot.domain.member.model.vo.Member;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
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
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/lecture")
@RequiredArgsConstructor
public class LectureController {

    private final LectureService lService;
    private final PurchaseService pService;
    private final CloudflareR2Service cloudflareR2Service;

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

    /**
     * 동영상 파일을 업로드하고 시간을 추출합니다.
     * @param videoFile 업로드할 동영상 파일
     * @return [업로드된 URL, 영상 시간(초)]
     */
    private String[] uploadVideoWithDuration(MultipartFile videoFile) throws IOException {
        File tempFile = null;
        try {
            // 임시 파일 생성
            String originalFilename = videoFile.getOriginalFilename();
            String extension = originalFilename != null && originalFilename.contains(".")
                ? originalFilename.substring(originalFilename.lastIndexOf("."))
                : ".tmp";
            tempFile = File.createTempFile("video_", extension);
            videoFile.transferTo(tempFile);

            // FFprobe 명령어로 영상 길이 추출
            int videoDuration = 0;
            try {
                ProcessBuilder pb = new ProcessBuilder("ffprobe", "-v", "quiet", "-show_entries", "format=duration", "-of", "csv=p=0", tempFile.getAbsolutePath());
                Process process = pb.start();
                BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()));
                String duration = reader.readLine();
                if (duration != null && !duration.trim().isEmpty()) {
                    videoDuration = (int) Double.parseDouble(duration.trim());
                }
            } catch (Exception e) {
                System.err.println("영상 시간 추출 실패: " + e.getMessage());
            }

            // Cloudflare R2에 업로드 (임시 파일을 직접 업로드)
            String fileName = java.util.UUID.randomUUID().toString() + extension;
            String videoFileUrl = cloudflareR2Service.uploadFile(tempFile, "lecture/videos", fileName, videoFile.getContentType());

            return new String[]{videoFileUrl, String.valueOf(videoDuration)};
        } finally {
            // 임시 파일 삭제
            if (tempFile != null && tempFile.exists()) {
                tempFile.delete();
            }
        }
    }


    private String saveFile(MultipartFile file) throws IOException {
        String originalFileName = file.getOriginalFilename();
        String fileType = getFileType(originalFileName);
        String folder;

        // 확장자에 따라 저장 경로 결정
        if ("image".equals(fileType)) {
            folder = "lecture/images";
        } else if ("video".equals(fileType)) {
            folder = "lecture/videos";
        } else {
            throw new IllegalArgumentException("지원하지 않는 파일 형식입니다: " + originalFileName);
        }

        // Cloudflare R2에 업로드
        return cloudflareR2Service.uploadFile(file, folder);
    }

    @GetMapping("/list")
    public String showLectureList(@ModelAttribute LectureListRequest Lecture
            , @RequestParam(value = "page", defaultValue = "1") int currentPage
            , @RequestParam(value = "category", defaultValue = "전체") String category
            , @RequestParam(value = "sort", defaultValue = "인기순") String sort
            , @RequestParam(value = "search", defaultValue = "") String search, Model model) {
        try {
            List<LectureListRequest> lList = null;
            int totalCount = 0;
            int lectureCountPerPage = 9;
            String sortValue = null;

            // 정렬 조건 설정
            if (sort.equals("인기순")) {
                sortValue = "COUNT_STUDENT DESC";
            } else if (sort.equals("최신순")) {
                sortValue = "LECTURE_CREATED_DATE DESC";
            } else if (sort.equals("낮은가격순")) {
                sortValue = "LECTURE_PRICE ASC";
            } else if (sort.equals("높은가격순")) {
                sortValue = "LECTURE_PRICE DESC";
            } else if (sort.equals("별점높은순")) {
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
            , @ModelAttribute ReviewListRequest review
            , @ModelAttribute VideoListRequest video
            , @RequestParam int lectureNo, Model model
            , HttpSession session) {
        try {
            String memberId = (String) session.getAttribute("loginId");
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

            if (memberId != null) {
                int purchaseYn = lService.findPurchaseById(memberId, lectureNo);
                int findOwner = lService.findOwnerBYId(memberId, lectureNo);
                String courseStatus;
                if (findOwner == 1) {
                    courseStatus = "OWNER";      // 본인 강의
                } else if (purchaseYn == 1) {
                    courseStatus = "PURCHASED";  // 구매함
                    int videoNo = lService.selectVideo(memberId, lectureNo);
                    model.addAttribute("videoNo", videoNo);
                } else {
                    courseStatus = "AVAILABLE";  // 미구매
                }
                model.addAttribute("courseStatus", courseStatus);
            }

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
    public String showLecturePlayer(@ModelAttribute VideoListRequest video, @RequestParam int videoNo, Model model, HttpSession session) {
        try {
            String memberId = (String) session.getAttribute("loginId");

            if (memberId == null) {
                return "member/login";
            }

            List<VideoListRequest> currentVideo = lService.selectVideoById(videoNo);
            int lectureNo = currentVideo.get(0).getLectureNo();
            int nextVideoNo = currentVideo.get(0).getVideoOrder() + 1;

            int result = lService.checkPurchase(memberId, lectureNo);
            int result2 = lService.findOwnerBYId(memberId, lectureNo);
            if (result > 0 || result2 > 0) {
                // 최근 시청한 비디오 업데이트
                pService.updateRecentVideo(memberId, lectureNo, videoNo);
                
                List<VideoListRequest> nextVideo = lService.selectNextVideoById(lectureNo, nextVideoNo);
                String lectureName = lService.selectNameById(lectureNo);
                model.addAttribute("currentVideo", currentVideo);
                model.addAttribute("nextVideo", nextVideo);
                model.addAttribute("lectureName", lectureName);
                return "lecture/player";
            } else {
                return "redirect:/lecture/payment?lectureNo=" + lectureNo;
            }
        } catch (Exception e) {
            model.addAttribute("errorMsg", e.getMessage());
            return "common/error";
        }
    }

    @GetMapping("/add")
    public String showLectureAdd(HttpSession session, Model model) {
        String loginId = (String) session.getAttribute("loginId");
        int result = lService.checkTeacher(loginId);
        if (result > 0) {
            return "lecture/add";
        } else {
            model.addAttribute("errorMsg", "선생님만 추가 가능합니다.");
            return "common/error";
        }
    }

    @PostMapping("/add")
    public String addLecture(@RequestParam("lectureName") String lectureName, @RequestParam("lectureCategory") String lectureCategory, @RequestParam("lectureDescription") String lectureDescription, @RequestParam("lecturePrice") int lecturePrice, @RequestParam("thumbnailImage") MultipartFile thumbnailImage, @RequestParam("lectureVideos[]") MultipartFile[] lectureVideos, @RequestParam("videoTitles[]") String[] videoTitles, HttpSession session, Model model) {
        try {
            Lecture lecture = new Lecture();
            String thumbnailFileName = null;

            if (!thumbnailImage.isEmpty()) {
                thumbnailFileName = saveFile(thumbnailImage);
            }

            String memberId = (String) session.getAttribute("loginId");
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
                    String fileType = getFileType(lectureVideos[i].getOriginalFilename());

                    if ("video".equals(fileType)) {
                        // 동영상: 시간 추출과 함께 업로드
                        String[] uploadResult = uploadVideoWithDuration(lectureVideos[i]);
                        String videoFileUrl = uploadResult[0];
                        int videoDuration = Integer.parseInt(uploadResult[1]);

                        LectureVideo video = new LectureVideo();
                        video.setLectureNo(lectureNo);
                        video.setVideoTitle(videoTitles[i]);
                        video.setVideoOrder(i + 1);
                        video.setVideoTime(videoDuration);
                        video.setVideoPath(videoFileUrl);

                        int result2 = lService.insertVideo(video);
                    } else {
                        // 이미지: 일반 업로드
                        String videoFileUrl = saveFile(lectureVideos[i]);

                        LectureVideo video = new LectureVideo();
                        video.setLectureNo(lectureNo);
                        video.setVideoTitle(videoTitles[i]);
                        video.setVideoOrder(i + 1);
                        video.setVideoTime(0);
                        video.setVideoPath(videoFileUrl);

                        int result2 = lService.insertVideo(video);
                    }
                }
            }
            return "redirect:/lecture/list";
        } catch (Exception e) {
            model.addAttribute("errorMsg", e.getMessage());
            return "common/error";
        }
    }

    @GetMapping("/payment")
    public String showPayment(HttpSession session, @RequestParam("lectureNo") int lectureNo, Model model) {
        try {
            String memberId = (String) session.getAttribute("loginId");
            if (memberId == null) {
                return "member/login";
            }

            int result = lService.checkPurchase(memberId, lectureNo);
            if (result > 0) {
                return "member/mypage";
            } else {
                session.setAttribute("currentLectureNo", lectureNo);
                Member member = lService.selectMember(memberId);
                List<LectureListRequest> lList = lService.selectOneById(lectureNo);
                model.addAttribute("member", member);
                model.addAttribute("lList", lList);
                return "lecture/payment";
            }
        } catch (Exception e) {
            model.addAttribute("errorMsg", e.getMessage());
            return "common/error";
        }
    }

    @GetMapping("/edit")
    public String showLectureEdit(@RequestParam("lectureNo") int lectureNo, HttpSession session, Model model) {
        try {
            String memberId = (String) session.getAttribute("loginId");
            if (memberId == null) {
                return "member/login";
            }

            // 강의 소유자 확인
            int isOwner = lService.findOwnerBYId(memberId, lectureNo);
            if (isOwner != 1) {
                model.addAttribute("errorMsg", "강의 소유자만 수정할 수 있습니다.");
                return "common/error";
            }

            // 강의 정보 조회
            List<LectureListRequest> lectureList = lService.selectOneById(lectureNo);
            Lecture lecture = lService.selectLectureForEdit(lectureNo);
            
            // 비디오 목록 조회
            List<VideoListRequest> videoList = lService.selectVideoListById(lectureNo);

            model.addAttribute("lecture", lecture);
            model.addAttribute("videoList", videoList);
            return "lecture/edit";
        } catch (Exception e) {
            model.addAttribute("errorMsg", e.getMessage());
            return "common/error";
        }
    }

    @PostMapping("/edit")
    public String editLecture(@RequestParam("lectureNo") int lectureNo,
                             @RequestParam("lectureName") String lectureName,
                             @RequestParam("lectureCategory") String lectureCategory,
                             @RequestParam("lectureDescription") String lectureDescription,
                             @RequestParam("lecturePrice") int lecturePrice,
                             @RequestParam(value = "thumbnailImage", required = false) MultipartFile thumbnailImage,
                             HttpSession session, Model model) {
        try {
            String memberId = (String) session.getAttribute("loginId");
            if (memberId == null) {
                return "member/login";
            }

            // 강의 소유자 확인
            int isOwner = lService.findOwnerBYId(memberId, lectureNo);
            if (isOwner != 1) {
                model.addAttribute("errorMsg", "강의 소유자만 수정할 수 있습니다.");
                return "common/error";
            }

            Lecture lecture = new Lecture();
            lecture.setLectureNo(lectureNo);
            lecture.setLectureName(lectureName);
            lecture.setLectureContent(lectureDescription);
            lecture.setLecturePrice(lecturePrice);
            lecture.setLectureCategory(lectureCategory);

            // 새 썸네일이 업로드된 경우
            if (thumbnailImage != null && !thumbnailImage.isEmpty()) {
                String thumbnailFileName = saveFile(thumbnailImage);
                lecture.setLecturePath(thumbnailFileName);
            }

            int result = lService.updateLecture(lecture);
            if (result > 0) {
                return "redirect:/lecture/details?lectureNo=" + lectureNo;
            } else {
                model.addAttribute("errorMsg", "강의 수정에 실패했습니다.");
                return "common/error";
            }
        } catch (Exception e) {
            model.addAttribute("errorMsg", e.getMessage());
            return "common/error";
        }
    }

    @PostMapping("/addChapter")
    @ResponseBody
    public Map<String, Object> addChapter(@RequestParam("lectureNo") int lectureNo,
                                         @RequestParam("videoTitle") String videoTitle,
                                         @RequestParam("videoFile") MultipartFile videoFile,
                                         HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        try {
            String memberId = (String) session.getAttribute("loginId");
            if (memberId == null) {
                response.put("success", false);
                response.put("message", "로그인이 필요합니다.");
                return response;
            }

            // 강의 소유자 확인
            int isOwner = lService.findOwnerBYId(memberId, lectureNo);
            if (isOwner != 1) {
                response.put("success", false);
                response.put("message", "권한이 없습니다.");
                return response;
            }

            if (!videoFile.isEmpty()) {
                String fileType = getFileType(videoFile.getOriginalFilename());

                String videoFileUrl;
                int videoDuration = 0;

                if ("video".equals(fileType)) {
                    // 동영상: 시간 추출과 함께 업로드
                    String[] uploadResult = uploadVideoWithDuration(videoFile);
                    videoFileUrl = uploadResult[0];
                    videoDuration = Integer.parseInt(uploadResult[1]);
                } else {
                    // 이미지: 일반 업로드
                    videoFileUrl = saveFile(videoFile);
                }

                // 다음 순서 번호 조회
                int nextOrder = lService.getNextVideoOrder(lectureNo);

                LectureVideo video = new LectureVideo();
                video.setLectureNo(lectureNo);
                video.setVideoTitle(videoTitle);
                video.setVideoOrder(nextOrder);
                video.setVideoTime(videoDuration);
                video.setVideoPath(videoFileUrl);

                int result = lService.insertVideo(video);
                if (result > 0) {
                    response.put("success", true);
                    response.put("message", "챕터가 추가되었습니다.");
                } else {
                    response.put("success", false);
                    response.put("message", "챕터 추가에 실패했습니다.");
                }
            } else {
                response.put("success", false);
                response.put("message", "영상 파일을 선택해주세요.");
            }
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "오류가 발생했습니다: " + e.getMessage());
        }
        return response;
    }

    @PostMapping("/updateChapter")
    @ResponseBody
    public Map<String, Object> updateChapter(@RequestParam("videoNo") int videoNo,
                                            @RequestParam("videoTitle") String videoTitle,
                                            @RequestParam(value = "videoFile", required = false) MultipartFile videoFile,
                                            HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        try {
            String memberId = (String) session.getAttribute("loginId");
            if (memberId == null) {
                response.put("success", false);
                response.put("message", "로그인이 필요합니다.");
                return response;
            }

            LectureVideo video = new LectureVideo();
            video.setVideoNo(videoNo);
            video.setVideoTitle(videoTitle);

            // 새 영상 파일이 업로드된 경우
            if (videoFile != null && !videoFile.isEmpty()) {
                String fileType = getFileType(videoFile.getOriginalFilename());

                String videoFileUrl;
                int videoDuration = 0;

                if ("video".equals(fileType)) {
                    // 동영상: 시간 추출과 함께 업로드
                    String[] uploadResult = uploadVideoWithDuration(videoFile);
                    videoFileUrl = uploadResult[0];
                    videoDuration = Integer.parseInt(uploadResult[1]);
                } else {
                    // 이미지: 일반 업로드
                    videoFileUrl = saveFile(videoFile);
                }

                video.setVideoPath(videoFileUrl);
                video.setVideoTime(videoDuration);
            }

            int result = lService.updateVideo(video);
            if (result > 0) {
                response.put("success", true);
                response.put("message", "챕터가 수정되었습니다.");
            } else {
                response.put("success", false);
                response.put("message", "챕터 수정에 실패했습니다.");
            }
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "오류가 발생했습니다: " + e.getMessage());
        }
        return response;
    }

    @PostMapping("/deleteChapter")
    @ResponseBody
    public Map<String, Object> deleteChapter(@RequestParam("videoNo") int videoNo,
                                            @RequestParam("lectureNo") int lectureNo,
                                            HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        try {
            String memberId = (String) session.getAttribute("loginId");
            if (memberId == null) {
                response.put("success", false);
                response.put("message", "로그인이 필요합니다.");
                return response;
            }

            // 강의 소유자 확인
            int isOwner = lService.findOwnerBYId(memberId, lectureNo);
            if (isOwner != 1) {
                response.put("success", false);
                response.put("message", "권한이 없습니다.");
                return response;
            }

            int result = lService.deleteVideo(videoNo, lectureNo);
            if (result > 0) {
                response.put("success", true);
                response.put("message", "챕터가 삭제되었습니다.");
            } else {
                response.put("success", false);
                response.put("message", "챕터 삭제에 실패했습니다.");
            }
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "오류가 발생했습니다: " + e.getMessage());
        }
        return response;
    }

    @PostMapping("/updateChapterOrder")
    @ResponseBody
    public Map<String, Object> updateChapterOrder(@RequestBody Map<String, Object> requestData,
                                                  HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        try {
            String memberId = (String) session.getAttribute("loginId");
            if (memberId == null) {
                response.put("success", false);
                response.put("message", "로그인이 필요합니다.");
                return response;
            }

            int lectureNo = (Integer) requestData.get("lectureNo");
            
            // 강의 소유자 확인
            int isOwner = lService.findOwnerBYId(memberId, lectureNo);
            if (isOwner != 1) {
                response.put("success", false);
                response.put("message", "권한이 없습니다.");
                return response;
            }

            @SuppressWarnings("unchecked")
            List<Map<String, Object>> chapters = (List<Map<String, Object>>) requestData.get("chapters");
            
            int result = lService.updateVideoOrder(chapters);
            if (result > 0) {
                response.put("success", true);
                response.put("message", "순서가 변경되었습니다.");
            } else {
                response.put("success", false);
                response.put("message", "순서 변경에 실패했습니다.");
            }
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "오류가 발생했습니다: " + e.getMessage());
        }
        return response;
    }
}
