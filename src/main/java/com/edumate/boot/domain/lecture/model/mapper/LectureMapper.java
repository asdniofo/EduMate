package com.edumate.boot.domain.lecture.model.mapper;

import com.edumate.boot.app.lecture.dto.*;
import com.edumate.boot.domain.lecture.model.vo.Lecture;
import com.edumate.boot.domain.lecture.model.vo.LectureVideo;
import com.edumate.boot.domain.member.model.vo.Member;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import java.util.List;
import java.util.Map;

@Mapper
public interface LectureMapper {
    int totalCount();
    List<LectureListRequest> selectList(RowBounds rowBounds, Map<String, Object> params);

    List<LectureListRequest> selectCategoryList(RowBounds rowBounds, Map<String, Object> params);

    int categoryCount(String category);

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

    int getSearchCountAll(Map<String, Object> params);

    List<LectureListRequest> selectSearchAll(Map<String, Object> params);

    int getSearchCategoryCount(Map<String, Object> params);

    List<LectureListRequest> selectSearchCategoryList(Map<String, Object> params);

    int checkTeacher(String loginId);

    int checkPurchase(String memberId, int lectureNo);

    Member selectMember(String memberId);

    Lecture selectLecture(int lectureNo);

    int checkLogin(String memberId);

    int insertQuestion(LectureQuestionRequest qList);
    
    void deleteVideo(int videoNo);
    
    int getVideoOrder(int videoNo);
    
    void reorderVideosAfterDelete(int lectureNo, int deletedOrder);
    
    void deleteLecture(int lectureNo);

    int findPurchaseById(String memberId, int lectureNo);

    int findOwnerBYId(String memberId, int lectureNo);

    int selectVideo(String memberId, int lectureNo);

    // 강의 수정 관련 메서드
    Lecture selectLectureForEdit(int lectureNo);
    
    int updateLecture(Lecture lecture);
    
    int getNextVideoOrder(int lectureNo);
    
    int updateVideo(LectureVideo video);
    
    void updateVideoOrder(int videoNo, int newOrder);
}
