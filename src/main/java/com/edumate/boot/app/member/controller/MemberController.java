package com.edumate.boot.app.member.controller;

import com.edumate.boot.app.admin.dto.UserListRequest;
import com.edumate.boot.app.member.dto.MemberUpdateRequest;
import com.edumate.boot.app.member.dto.MemberStatsRequest;
import com.edumate.boot.app.member.dto.MyPostRequest;
import com.edumate.boot.app.member.dto.MyCommentRequest;
import com.edumate.boot.app.lecture.dto.LectureListRequest;
import com.edumate.boot.app.member.dto.InsertQuestionRequest;
import com.edumate.boot.app.member.dto.InsertRequestRequest;
import com.edumate.boot.app.purchase.dto.LectureNoRequest;
import com.edumate.boot.domain.admin.model.service.AdminService;
import com.edumate.boot.domain.lecture.model.service.LectureService;
import com.edumate.boot.domain.member.model.service.MemberService;
import com.edumate.boot.domain.member.model.vo.Member;
import com.edumate.boot.domain.member.model.vo.Request;
import com.edumate.boot.domain.purchase.model.vo.Purchase;
import com.edumate.boot.domain.teacher.model.vo.Question;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import jakarta.servlet.http.HttpSession;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.net.ssl.HttpsURLConnection;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/member")
@RequiredArgsConstructor
public class MemberController {

    private final MemberService memberService;
    private final AdminService aService;
    private final LectureService lService;

    @GetMapping("/login")
    public String showLogin() {
        return "member/login";
    }

    @PostMapping("/login")
    public String login(@RequestParam("memberId") String memberId, @RequestParam("memberPw") String memberPw, HttpSession session) {

        Member loginUser = memberService.login(memberId, memberPw);

        if (loginUser != null) {
            session.setAttribute("loginMember", loginUser);
            session.setAttribute("loginId", loginUser.getMemberId());
            session.setAttribute("adminYn", loginUser.getAdminYN());
            session.setAttribute("teacherYn", loginUser.getTeacherYN());
            if (loginUser.getAdminYN().equals("Y")) {
                return "redirect:/admin/main";
            } else {
                return "redirect:/";
            }
        } else {
            return "redirect:/member/login?error=1"; // 로그인 실패 시 다시 로그인 페이지
        }
    }

    // 로그아웃
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }

    @GetMapping("/signup/terms")
    public String showTerms() {
        return "member/signup_terms";
    }

    @GetMapping("/signup/info")
    public String showInfo() {
        return "member/signup_info";
    }

    @PostMapping("/signup/info")
    public String submitSignupInfo(@RequestParam String memberId, @RequestParam String memberPw, @RequestParam String memberName, @RequestParam String memberEmail, @RequestParam String memberBirth, @RequestParam("g-recaptcha-response") String recaptchaResponse, Model model) {

        // 1️⃣ 캡챠 검증
        boolean captchaValid = verifyRecaptcha(recaptchaResponse);
        if (!captchaValid) {
            model.addAttribute("errorMessage", "[reCaptcha] 인증에 실패했습니다.");
            return "error"; // 다시 회원가입 페이지로
        }

        // 2️⃣ DB 저장
        java.sql.Date birthDate = java.sql.Date.valueOf(memberBirth);
        Member member = new Member();
        member.setMemberId(memberId);
        member.setMemberPw(memberPw);
        member.setMemberName(memberName);
        member.setMemberEmail(memberEmail);
        member.setMemberBirth(memberBirth);
        member.setMemberMoney(0);
        member.setTeacherYN("N");
        member.setAdminYN("N");

        memberService.signup(member);

        // 3️⃣ 완료 후 페이지
        return "redirect:/member/signup/complete";
    }

    // 🔹 캡챠 검증 메서드
    private boolean verifyRecaptcha(String recaptchaResponse) {
        String secretKey = "6LdI9OorAAAAAGTZcJRgdBLA5VdUFxQN4-1s-aXL";
        String apiUrl = "https://www.google.com/recaptcha/api/siteverify";

        try {
            URL url = new URL(apiUrl);
            HttpsURLConnection conn = (HttpsURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setDoOutput(true);

            String postParams = "secret=" + secretKey + "&response=" + recaptchaResponse;
            OutputStream out = conn.getOutputStream();
            out.write(postParams.getBytes());
            out.flush();
            out.close();

            BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            StringBuilder response = new StringBuilder();
            String inputLine;
            while ((inputLine = in.readLine()) != null) {
                response.append(inputLine);
            }
            in.close();

            // Jackson으로 JSON 파싱
            ObjectMapper mapper = new ObjectMapper();
            JsonNode jsonNode = mapper.readTree(response.toString());
            return jsonNode.get("success").asBoolean();

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @GetMapping("/signup/complete")
    public String showComplete() {
        return "member/signup_done";
    }

    @GetMapping("/find")
    public String showFind() {
        return "member/find_info";
    }

    @PostMapping("/findId")
    public String findId(Member member, Model model) {
        String foundId = memberService.findMemberId(member);

        if (foundId != null) {
            model.addAttribute("foundId", foundId);
            return "member/find_id"; // 아이디 결과 페이지
        } else {
            model.addAttribute("msg", "일치하는 회원 정보가 없습니다.");
            return "member/find_info";
        }
    }

    @PostMapping("/findPw")
    public String findPw(Member member, Model model) {
        boolean exists = memberService.checkMemberForPwReset(member);

        if (exists) {
            model.addAttribute("memberId", member.getMemberId());
            return "member/find_pw"; // 비밀번호 재설정 페이지
        } else {
            model.addAttribute("msg", "입력하신 정보와 일치하는 회원이 없습니다.");
            return "member/find_info";
        }
    }

    @PostMapping("/updatePw")
    public String updatePw(Member member, Model model) {
        int result = memberService.updateMemberPw(member);

        if (result > 0) {
            model.addAttribute("msg", "비밀번호가 성공적으로 변경되었습니다.");
            model.addAttribute("url", "/member/login");
            return "common/success"; // 메시지 후 이동 (혹은 redirect)
        } else {
            model.addAttribute("msg", "비밀번호 변경에 실패했습니다. 다시 시도해주세요.");
            model.addAttribute("url", "/member/find_pw");
            return "common/fail"; // 실패 페이지 (선택)
        }
    }

    // 보여지는 화면
    @GetMapping("/insertQuestion")
    public String showInsertQuestion() {
        return "member/insertQuestion";
    }

    // 등록하기
    @PostMapping("/insertQuestion")
    public String insertQuestion(@ModelAttribute InsertQuestionRequest question, Model model, HttpSession session) {
        try {
            String loginId = (String) session.getAttribute("loginId");

            if (loginId == null) {
                return "redirect:/member/login";
            }
            question.setMemberId(loginId);
            int result = memberService.insertQuestion(question);
            return "redirect:/teacher/question/list";
        } catch (Exception e) {
            model.addAttribute("errorMsg", e.getMessage());
            return "common/error";
        }
    }

    @GetMapping("/request")
    public String showRequestList(@RequestParam(value = "searchKeyword", defaultValue = "") String searchKeyword, @RequestParam(value = "page", defaultValue = "1") int currentPage, @RequestParam(value = "filter", defaultValue = "ALL") String filter, Model model, HttpSession session) {

        String memberId = (String) session.getAttribute("loginId");
        String adminYn = (String) session.getAttribute("adminYn");

        String loginMemberId = null;
        String adminYN = "N";

        if (memberId == null) {
            return "redirect:/member/login";
        } else {
            loginMemberId = memberId;
            adminYN = adminYn;
        }
        try {
            int boardLimit = 5;
            String upperKeyword = searchKeyword.toUpperCase();
            Map<String, Object> searchMap = new HashMap<String, Object>();
            searchMap.put("filter", filter);
            searchMap.put("searchKeyword", upperKeyword);
            searchMap.put("currentPage", currentPage);
            searchMap.put("boardLimit", boardLimit);
            searchMap.put("memberId", loginMemberId);
            searchMap.put("adminYN", adminYN);
            List<Question> searchList = memberService.selectRequestList(searchMap);
            if (searchList != null && !searchList.isEmpty()) {
                // 페이징처리 코드 작성
                int totalCount = memberService.getTotalCount(searchMap);
                int maxPage = (int) Math.ceil((double) totalCount / boardLimit);
                int naviLimit = 5;
                int startNavi = ((currentPage - 1) / naviLimit) * naviLimit + 1;
                int endNavi = (startNavi - 1) + naviLimit;
                if (endNavi > maxPage) endNavi = maxPage;
                model.addAttribute("maxPage", maxPage);
                model.addAttribute("startNavi", startNavi);
                model.addAttribute("endNavi", endNavi);
                model.addAttribute("currentPage", currentPage);
            }
            model.addAttribute("searchList", searchList);
            model.addAttribute("searchKeyword", searchKeyword);
            model.addAttribute("filter", filter);
            return "member/requestList";
        } catch (Exception e) {
            model.addAttribute("errorMsg", e.getMessage());
            return "common/error";
        }
    }

    @GetMapping("/request/insert")
    public String showInsertRequest() {
        return "member/insertRequest";
    }

    @PostMapping("/request/insert")
    public String insertRequest(@ModelAttribute InsertRequestRequest request, Model model, HttpSession session) {
        try {
            String loginId = (String) session.getAttribute("loginId");

            if (loginId == null) {
                return "redirect:/member/login";
            }
            request.setMemberId(loginId);
            int result = memberService.insertRequest(request);
            return "redirect:/member/request";
        } catch (Exception e) {
            model.addAttribute("errorMsg", e.getMessage());
            return "common/error";
        }
    }

    @GetMapping("/request/detail")
    public String showRequestDetailView(@RequestParam("requestNo") int requestNo, Model model, HttpSession session) {
        // 1. 로그인 정보 가져오기 및 체크
        String memberId = (String) session.getAttribute("loginId");
        String adminYn = (String) session.getAttribute("adminYn");
        if (memberId == null) {
            return "redirect:/member/login";
        }

        String loginMemberId = memberId;
        String adminYN = adminYn;

        try {
            Request request = memberService.selectOneByNo(requestNo);

            if (!"Y".equals(adminYN) && !loginMemberId.equals(request.getMemberId())) {
                model.addAttribute("errorMsg", "해당 요청서에 접근할 권한이 없습니다.");
                return "common/error";
            }

            // 4. 이전/다음 요청 번호 조회를 위한 Map 준비 (사용자별 필터링을 위해)
            Map<String, Object> naviMap = new HashMap<>();
            naviMap.put("currentRequestNo", requestNo);
            naviMap.put("adminYN", adminYN);
            naviMap.put("memberId", loginMemberId); // 일반 사용자는 본인 글에서만 이전/다음이 작동하도록

            // 5. 수정된 Service 메소드 호출
            Integer prevRequestNo = memberService.selectPrevRequestNo(naviMap);
            Integer nextRequestNo = memberService.selectNextRequestNo(naviMap);

            // 6. Model에 담기
            model.addAttribute("request", request);
            model.addAttribute("prevRequestNo", prevRequestNo);
            model.addAttribute("nextRequestNo", nextRequestNo);

            return "member/requestDetail";

        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("errorMsg", "요청 상세 정보 조회 중 오류가 발생했습니다.");
            return "common/error";
        }
    }

    @GetMapping("/request/change/status")
    @ResponseBody
    public int changeRequestStatus(@RequestParam int requestNo) {
        try {
            int result = memberService.changeRequestStatus(requestNo);
            return result;
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    @GetMapping("/request/delete")
    @ResponseBody
    public int deleteRequestList(@RequestParam int requestNo) {
        try {
            int result = memberService.deleteRequest(requestNo);
            return result;
        } catch (Exception e) {
            e.printStackTrace();
            return -1;
        }
    }

    @GetMapping("/request/modify")
    public String showRequestModify(@RequestParam int requestNo, Model model) {
        Request request = memberService.selectOneByNo(requestNo);
        model.addAttribute("request", request);
        return "member/modifyRequest";
    }

    @PostMapping("/request/modify")
    public String modifyQuestion(@RequestParam("requestNo") int requestNo, @RequestParam("requestTitle") String requestTitle, @RequestParam("requestContent") String requestContent, Model model) {
        try {
            Request request = new Request(); // Question VO/DTO를 가정
            request.setRequestNo(requestNo);
            request.setRequestTitle(requestTitle);
            request.setRequestContent(requestContent);

            int result = memberService.updateQuestion(request);

            if (result > 0) {
                // 2. 성공 시 상세 페이지로 리다이렉트
                return "redirect:/member/request/detail?requestNo=" + requestNo;
            } else {
                // 실패 처리
                model.addAttribute("errorMsg", "건의사항 수정에 실패했습니다.");
                return "common/error";
            }
        } catch (Exception e) {
            model.addAttribute("errorMsg", "수정 중 오류 발생: " + e.getMessage());
            return "common/error";
        }
    }

    @GetMapping("/mypage")
    public String showMyPage(HttpSession session, Model model) {
        String memberId = (String) session.getAttribute("loginId");
        String adminYn = (String) session.getAttribute("adminYn");
        String teacherYn = (String) session.getAttribute("teacherYn");

        if (memberId == null) {
            return "redirect:/member/login";
        }
        try {
            Member memberInfo = memberService.findByMemberId(memberId);
            if (memberInfo != null) {
                String memberType = "일반 회원";
                if ("Y".equals(adminYn)) {
                    memberType = "관리자";
                } else if ("Y".equals(teacherYn)) {
                    memberType = "선생님";
                }

                List<LectureNoRequest> lList = memberService.findLectureById(memberId);
                List<LectureListRequest> dList = new ArrayList<>();
                // 전체 강의 정보 가져오기
                for (int i = 0; i < lList.size(); i++) {
                    List<LectureListRequest> lectureInfo = lService.selectOneById(lList.get(i).getLectureNo());
                    if (lectureInfo != null && !lectureInfo.isEmpty()) {
                        dList.addAll(lectureInfo);
                    }
                }

                // 통계 데이터 조회
                MemberStatsRequest stats = memberService.getMemberStats(memberId);

                model.addAttribute("memberInfo", memberInfo);
                model.addAttribute("memberType", memberType);
                model.addAttribute("memberId", memberId);
                model.addAttribute("lectureList", dList); // 전체 강의 리스트
                model.addAttribute("requestCount", stats.getRequestCount()); // 건의사항 수
                model.addAttribute("requestCommentCount", stats.getRequestCommentCount()); // 건의사항 댓글 수
                model.addAttribute("questionCount", stats.getQuestionCount()); // 질문 수
                model.addAttribute("questionCommentCount", stats.getQuestionCommentCount()); // 질문 댓글 수
            }
            return "member/mypage";
        } catch (Exception e) {
            model.addAttribute("errorMsg", e.getMessage());
            return "common/error";
        }
    }

    @PostMapping("/clearLectureSession")
    @ResponseBody
    public Map<String, Object> clearLectureSession(HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        try {
            // 마이페이지에서 충전할 때 강의 관련 세션 정보 제거
            session.removeAttribute("currentLectureNo");
            response.put("success", true);
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", e.getMessage());
        }
        return response;
    }

    @PostMapping("/delete")
    @ResponseBody
    public void delete(@RequestParam String memberId) {
        aService.deleteUser(memberId);
    }

    @GetMapping("/edit")
    public String showEditInfo(HttpSession session, Model model) {
        String memberId = (String) session.getAttribute("loginId");
        if (memberId == null) {
            return "redirect:/member/login";
        }
        
        try {
            Member memberInfo = memberService.findByMemberId(memberId);
            model.addAttribute("memberInfo", memberInfo);
            return "member/edit_info";
        } catch (Exception e) {
            model.addAttribute("errorMsg", e.getMessage());
            return "common/error";
        }
    }

    @PostMapping("/update")
    @ResponseBody
    public Map<String, Object> updateMemberInfo(@RequestBody MemberUpdateRequest memberUpdateRequest, HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        try {
            String currentMemberId = (String) session.getAttribute("loginId");
            
            // reCAPTCHA 검증
            String recaptchaResponse = memberUpdateRequest.getRecaptchaResponse();
            if (recaptchaResponse == null || recaptchaResponse.isEmpty()) {
                response.put("success", false);
                response.put("message", "캡챠 인증이 필요합니다.");
                return response;
            }
            
            boolean captchaValid = verifyRecaptcha(recaptchaResponse);
            if (!captchaValid) {
                response.put("success", false);
                response.put("message", "캡챠 인증에 실패했습니다.");
                return response;
            }
            
            // 본인의 정보만 수정 가능
            if (!currentMemberId.equals(memberUpdateRequest.getMemberId())) {
                response.put("success", false);
                response.put("message", "본인의 정보만 수정할 수 있습니다.");
                return response;
            }
            
            // MemberService에 회원 정보 업데이트 로직 추가 필요
            // 현재는 임시로 Member 객체 생성하여 처리
            Member memberToUpdate = new Member();
            memberToUpdate.setMemberId(memberUpdateRequest.getMemberId());
            memberToUpdate.setMemberPw(memberUpdateRequest.getMemberPw());
            memberToUpdate.setMemberName(memberUpdateRequest.getMemberName());
            memberToUpdate.setMemberEmail(memberUpdateRequest.getMemberEmail());
            memberToUpdate.setMemberBirth(memberUpdateRequest.getMemberBirth());
            
            // 기존 권한 정보 유지
            Member currentMember = memberService.findByMemberId(currentMemberId);
            memberToUpdate.setAdminYN(currentMember.getAdminYN());
            memberToUpdate.setTeacherYN(currentMember.getTeacherYN());
            memberToUpdate.setMemberMoney(currentMember.getMemberMoney());
            
            // 회원 정보 업데이트 (새로운 서비스 메소드 필요)
            int updateResult = memberService.updateMemberInfo(memberToUpdate);
            
            if (updateResult > 0) {
                response.put("success", true);
                response.put("message", "정보가 성공적으로 수정되었습니다.");
            } else {
                response.put("success", false);
                response.put("message", "정보 수정에 실패했습니다.");
            }
            
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "수정 중 오류가 발생했습니다: " + e.getMessage());
        }
        return response;
    }
    @GetMapping("/mypost")
    public String showMyPost(HttpSession session, Model model,
                            @RequestParam(value = "searchKeyword", defaultValue = "") String searchKeyword,
                            @RequestParam(value = "page", defaultValue = "1") int currentPage) {
        String memberId = (String) session.getAttribute("loginId");
        
        if (memberId == null) {
            return "redirect:/member/login";
        }
        
        try {
            int boardLimit = 5; // 페이지당 글 수
            
            // 검색 파라미터 설정
            Map<String, Object> searchMap = new HashMap<>();
            searchMap.put("memberId", memberId);
            searchMap.put("searchKeyword", searchKeyword.trim().toUpperCase());
            searchMap.put("currentPage", currentPage);
            searchMap.put("boardLimit", boardLimit);
            
            // 사용자의 작성글 조회 (검색 조건 포함)
            List<MyPostRequest> myPosts = memberService.getMyPostsWithSearch(searchMap);
            
            // 전체 게시글 수 조회 (페이징용)
            int totalCount = memberService.getMyPostsTotalCount(searchMap);
            
            // 페이징 처리
            int maxPage = (int) Math.ceil((double) totalCount / boardLimit);
            int naviLimit = 5;
            int startNavi = ((currentPage - 1) / naviLimit) * naviLimit + 1;
            int endNavi = (startNavi - 1) + naviLimit;
            if (endNavi > maxPage) endNavi = maxPage;
            
            model.addAttribute("myPosts", myPosts);
            model.addAttribute("memberId", memberId);
            model.addAttribute("totalPosts", totalCount);
            model.addAttribute("searchKeyword", searchKeyword);
            model.addAttribute("currentPage", currentPage);
            model.addAttribute("maxPage", maxPage);
            model.addAttribute("startNavi", startNavi);
            model.addAttribute("endNavi", endNavi);
            
            return "member/mypost";
        } catch (Exception e) {
            model.addAttribute("errorMsg", e.getMessage());
            return "common/error";
        }
    }

    
    @GetMapping("/mycomment")
    public String showMyComment(HttpSession session, Model model,
                              @RequestParam(value = "searchKeyword", defaultValue = "") String searchKeyword,
                              @RequestParam(value = "page", defaultValue = "1") int currentPage) {
        String memberId = (String) session.getAttribute("loginId");
        
        if (memberId == null) {
            return "redirect:/member/login";
        }
        
        try {
            int boardLimit = 5; // 페이지당 댓글 수
            
            // 검색 파라미터 설정
            Map<String, Object> searchMap = new HashMap<>();
            searchMap.put("memberId", memberId);
            searchMap.put("searchKeyword", searchKeyword.trim().toUpperCase());
            searchMap.put("currentPage", currentPage);
            searchMap.put("boardLimit", boardLimit);
            
            // 사용자의 작성 댓글 조회 (검색 조건 포함)
            List<MyCommentRequest> myComments = memberService.getMyCommentsWithSearch(searchMap);
            
            // 전체 댓글 수 조회 (페이징용)
            int totalCount = memberService.getMyCommentsTotalCount(searchMap);
            
            // 페이징 처리
            int maxPage = (int) Math.ceil((double) totalCount / boardLimit);
            int naviLimit = 5;
            int startNavi = ((currentPage - 1) / naviLimit) * naviLimit + 1;
            int endNavi = (startNavi - 1) + naviLimit;
            if (endNavi > maxPage) endNavi = maxPage;
            
            model.addAttribute("myComments", myComments);
            model.addAttribute("memberId", memberId);
            model.addAttribute("totalComments", totalCount);
            model.addAttribute("searchKeyword", searchKeyword);
            model.addAttribute("currentPage", currentPage);
            model.addAttribute("maxPage", maxPage);
            model.addAttribute("startNavi", startNavi);
            model.addAttribute("endNavi", endNavi);
            
            return "member/mycomment";
        } catch (Exception e) {
            model.addAttribute("errorMsg", e.getMessage());
            return "common/error";
        }
    }
}
