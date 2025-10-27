package com.edumate.boot.domain.lecture.model.service;

import com.edumate.boot.app.lecture.dto.*;
import com.edumate.boot.domain.lecture.model.vo.Lecture;
import com.edumate.boot.domain.lecture.model.vo.LectureVideo;
import com.edumate.boot.domain.member.model.vo.Member;

import java.util.List;
import java.util.Map;

public interface LectureService {

    int getTotalCount();

    List<LectureListRequest> selectList(int currentPage, int lectureCountPerPage, String sortValue);

    List<LectureListRequest> selectCategoryList(int currentPage, int lectureCountPerPage, String category, String sortValue);

    int getCategoryCount(String category);

    List<LectureListRequest> selectOneById(int lectureNo);

    List<ReviewListRequest> selectReviewById(int lectureNo);

    List<VideoListRequest> selectVideoListById(int lectureNo);

    int totalVideoById(int lectureNo);

    int totalTimeById(int lectureNo);

    List<VideoListRequest> selectVideoById(int videoNo);

    List<VideoListRequest> selectNextVideoById(int lectureNo, int nextVideoNo);

    String selectNameById(int lectureNo);

    int insertLecture(Lecture lecture);

    int insertVideo(LectureVideo video);

    int getSearchCountAll(String search);

    List<LectureListRequest> selectSearchAll(int currentPage, int lectureCountPerPage, String search, String sortValue);

    int getSearchCategoryCount(String search, String category);

    List<LectureListRequest> selectSearchCategoryList(int currentPage, int lectureCountPerPage, String search, String category, String sortValue);
    
    // 관리자용 검색 메서드
    int getSearchCountAllForAdmin(String search);

    List<LectureListRequest> selectSearchAllForAdmin(int currentPage, int lectureCountPerPage, String search, String sortValue);

    int getSearchCategoryCountForAdmin(String search, String category);

    List<LectureListRequest> selectSearchCategoryListForAdmin(int currentPage, int lectureCountPerPage, String search, String category, String sortValue);

    int checkTeacher(String loginId);

    int checkPurchase(String memberId, int lectureNo);

    Member selectMember(String memberId);

    Lecture selectLecture(int lectureNo);

    int checkLogin(String memberId);

    int insertQuestion(LectureQuestionRequest qList);
    
    void deleteVideo(int videoNo);
    
    void deleteVideoAndReorder(int videoNo, int lectureNo);
    
    void deleteLecture(int lectureNo);

    int findPurchaseById(String memberId, int lectureNo);

    int findOwnerBYId(String memberId, int lectureNo);

    int selectVideo(String memberId, int lectureNo);

    // 강의 수정 관련 메서드
    Lecture selectLectureForEdit(int lectureNo);
    
    int updateLecture(Lecture lecture);
    
    int getNextVideoOrder(int lectureNo);
    
    int updateVideo(LectureVideo video);
    
    int deleteVideo(int videoNo, int lectureNo);
    
    int updateVideoOrder(List<Map<String, Object>> chapters);
}
