package com.edumate.boot.app.purchase.controller;

import com.edumate.boot.domain.purchase.model.service.PurchaseService;
import com.edumate.boot.domain.lecture.model.service.LectureService;
import com.edumate.boot.app.lecture.dto.LectureListRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/purchase")
@RequiredArgsConstructor
public class PurchaseController {

    private final PurchaseService pService;
    private final LectureService lService;
    
    @Value("${toss.payments.client.key}")
    private String tossPaymentsClientKey;

    @PostMapping("/toss/charge")
    @ResponseBody
    public Map<String, Object> requestTossPayment(@RequestBody Map<String, Object> requestData, HttpSession session) {
        Map<String, Object> response = new HashMap<>();

        try {
            String memberId = (String) session.getAttribute("loginId");
            if (memberId == null) {
                response.put("success", false);
                response.put("message", "로그인이 필요합니다.");
                return response;
            }

            int amount = (int) requestData.get("amount");
            String orderId = "charge_" + memberId + "_" + System.currentTimeMillis();


            response.put("success", true);
            response.put("clientKey", tossPaymentsClientKey);
            response.put("amount", amount);
            response.put("orderId", orderId);
            response.put("orderName", "EduMate 잔액 충전");
            response.put("successUrl", "http://localhost:8080/purchase/payment/success");
            response.put("failUrl", "http://localhost:8080/common/error");

        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "결제 요청 중 오류가 발생했습니다.");
        }
        return response;
    }

    @GetMapping("/payment/success")
    public String paymentSuccess(@RequestParam String paymentKey
            ,@RequestParam int amount, HttpSession session, Model model) {
        try {
            String memberId = (String) session.getAttribute("loginId");
            if (memberId == null) {
               return "member/login";
            }

            int result = pService.updateMoney(memberId, amount);
            if (result > 0) {
                Object lectureNoObj = session.getAttribute("currentLectureNo");
                if (lectureNoObj != null) {
                    int lectureNo = (int) lectureNoObj;
                    return "redirect:/lecture/payment?lectureNo=" + lectureNo + "&chargeSuccess=true&chargeAmount=" + amount;
                } else {
                    // 마이페이지에서 충전한 경우 마이페이지로 리다이렉트
                    return "redirect:/member/mypage?chargeSuccess=true&chargeAmount=" + amount;
                }
            } else {
                model.addAttribute("errorMsg", "충전 처리 중 오류가 발생했습니다.");
                return "common/error";
            }
        } catch (Exception e) {
            model.addAttribute("errorMsg", e.getMessage());
            return "common/error";
        }
    }

    @PostMapping("/lecture")
    @ResponseBody
    public Map<String, Object> purchaseLecture(@RequestBody Map<String, Object> requestData, HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        try {
            String memberId = (String) session.getAttribute("loginId");
            if (memberId == null) {
                response.put("success", false);
                response.put("message", "로그인이 필요합니다.");
                response.put("redirectUrl", "/member/login");
                return response;
            }
            int lectureNo = (int) requestData.get("lectureNo"); //강의 번호
            String paymentMethod = (String) requestData.get("paymentMethod"); // 결제방식
            int amount = (int) requestData.get("amount"); // 강의 가격
            String lectureName = (String) requestData.get("lectureName");

            boolean purchaseSuccess = false;
            if ("balance".equals(paymentMethod)) {
                int result1 = pService.minusMoney(memberId, amount);
                int videoNo = pService.findVideo(lectureNo);
                int result2 = pService.updatePurchase(lectureNo, memberId, videoNo);
                
                // 강사에게 돈 지급
                List<LectureListRequest> lectureInfo = lService.selectOneById(lectureNo);
                if (!lectureInfo.isEmpty()) {
                    String teacherId = lectureInfo.get(0).getMemberId();
                    int result3 = pService.payToTeacher(teacherId, amount);
                    if (result1 > 0 && result2 > 0 && result3 > 0) {
                        purchaseSuccess = true;
                    }
                } else if (result1 > 0 && result2 > 0) {
                    purchaseSuccess = true;
                }
            } else if ("external".equals(paymentMethod)) {
                // 외부 결제 - 토스페이먼츠
                String orderId = "lecture_" + memberId + "_" + lectureNo + "_" + System.currentTimeMillis();
                response.put("success", true);
                response.put("paymentType", "external");
                response.put("clientKey", tossPaymentsClientKey);
                response.put("amount", amount);
                response.put("orderId", orderId);
                response.put("orderName", lectureName);
                response.put("successUrl", "http://localhost:8080/purchase/lecture/success");
                response.put("failUrl", "http://localhost:8080/purchase/lecture/fail");
                return response;
            }
            if (purchaseSuccess) {
                response.put("success", true);
                response.put("message", "강의 구매가 완료되었습니다.");
            } else {
                response.put("success", false);
                response.put("message", "결제 처리 중 오류가 발생했습니다.");
            }
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "결제 요청 중 오류가 발생했습니다.");
            e.printStackTrace();
        }
        return response;
    }

    @GetMapping("/lecture/success")
    public String lecturePaymentSuccess(@RequestParam String paymentKey
            ,@RequestParam String orderId, @RequestParam int amount
            ,HttpSession session, Model model) {
        try {
            String memberId = (String) session.getAttribute("loginId");
            if (memberId == null) {
                return "member/login";
            }
            String[] orderParts = orderId.split("_");
            if (orderParts.length >= 3) {
                int lectureNo = Integer.parseInt(orderParts[2]);
                int videoNo = pService.findVideo(lectureNo);
                int purchaseResult = pService.updatePurchase(lectureNo, memberId, videoNo);
                
                // 강사에게 돈 지급
                List<LectureListRequest> lectureList = lService.selectOneById(lectureNo);
                String lectureName = !lectureList.isEmpty() ? lectureList.get(0).getLectureName() : "강의명";
                String teacherId = !lectureList.isEmpty() ? lectureList.get(0).getMemberId() : null;
                
                boolean paymentComplete = purchaseResult > 0;
                if (teacherId != null && purchaseResult > 0) {
                    int teacherPayResult = pService.payToTeacher(teacherId, amount);
                    paymentComplete = teacherPayResult > 0;
                }
                
                if (paymentComplete) {
                    model.addAttribute("lectureNo", lectureNo);
                    model.addAttribute("lectureName", lectureName);
                    model.addAttribute("orderId", orderId);
                    model.addAttribute("amount", amount);
                    model.addAttribute("paymentMethod", "external");
                    return "purchase/success";
                }
            }

            model.addAttribute("errorMsg", "결제 처리 중 오류가 발생했습니다.");
            return "common/error";
            
        } catch (Exception e) {
            model.addAttribute("errorMsg", e.getMessage());
            return "common/error";
        }
    }

    @GetMapping("/balance/success")
    public String balancePaymentSuccess(@RequestParam int lectureNo
            ,@RequestParam int amount, @RequestParam String lectureName
            ,HttpSession session, Model model) {
        try {
            String memberId = (String) session.getAttribute("loginId");
            if (memberId == null) {
                return "member/login";
            }
            model.addAttribute("lectureNo", lectureNo);
            model.addAttribute("lectureName", lectureName);
            model.addAttribute("orderId", "balance_" + memberId + "_" + lectureNo + "_" + System.currentTimeMillis());
            model.addAttribute("amount", amount);
            model.addAttribute("paymentMethod", "balance");
            return "purchase/success";
            
        } catch (Exception e) {
            model.addAttribute("errorMsg", "결제 처리 중 오류가 발생했습니다.");
            return "common/error";
        }
    }
}
