package com.edumate.boot.domain.lecture.model.service.impl;

import com.edumate.boot.app.lecture.dto.*;
import com.edumate.boot.domain.lecture.model.service.LectureService;
import com.edumate.boot.domain.lecture.model.mapper.LectureMapper;
import com.edumate.boot.domain.lecture.model.vo.Lecture;
import com.edumate.boot.domain.lecture.model.vo.LectureVideo;
import com.edumate.boot.domain.member.model.vo.Member;
import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import lombok.RequiredArgsConstructor;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

@Service
@RequiredArgsConstructor
public class LectureServiceImpl implements LectureService {

    private final LectureMapper lMapper;


    @Override
    public int getTotalCount() {
        int result = lMapper.totalCount();
        return result;
    }

    @Override
    public List<LectureListRequest> selectList(int currentPage, int lectureCountPerPage, String sortValue) {
        int offset = (currentPage - 1) * lectureCountPerPage;
        RowBounds rowBounds = new RowBounds(offset, lectureCountPerPage);
        Map<String, Object> params = new HashMap<>();
        params.put("sortValue", sortValue);
        List<LectureListRequest> lList = lMapper.selectList(rowBounds, params);
        return lList;
    }

    @Override
    public List<LectureListRequest> selectCategoryList(int currentPage, int lectureCountPerPage, String category, String sortValue) {
        int offset = (currentPage - 1) * lectureCountPerPage;
        RowBounds rowBounds = new RowBounds(offset, lectureCountPerPage);
        Map<String, Object> params = new HashMap<>();
        params.put("category", category);
        params.put("sortValue", sortValue);
        List<LectureListRequest> lList = lMapper.selectCategoryList(rowBounds, params);
        return lList;
    }

    @Override
    public int getCategoryCount(String category) {
        int result = lMapper.categoryCount(category);
        return result;
    }

    @Override
    public List<LectureListRequest> selectOneById(int lectureNo) {
        List<LectureListRequest> lList = lMapper.selectOneById(lectureNo);
        return lList;
    }

    @Override
    public List<ReviewListRequest> selectReviewById(int lectureNo) {
        List<ReviewListRequest> rList = lMapper.selectReviewById(lectureNo);
        return rList;
    }

    @Override
    public List<VideoListRequest> selectVideoListById(int lectureNo) {
        List<VideoListRequest> vList = lMapper.selectVideoListById(lectureNo);
        return vList;
    }

    @Override
    public int totalVideoById(int lectureNo) {
        int result = lMapper.totalVideoById(lectureNo);
        return result;
    }

    @Override
    public int totalTimeById(int lectureNo) {
        int result = lMapper.totalTimeById(lectureNo);
        return result;
    }

    @Override
    public List<VideoListRequest> selectVideoById(int videoNo) {
        List<VideoListRequest> vList = lMapper.selectVideoById(videoNo);
        return vList;
    }

    @Override
    public List<VideoListRequest> selectNextVideoById(int lectureNo, int nextVideoNo) {
        List<VideoListRequest> vList = lMapper.selectNextVideoById(lectureNo, nextVideoNo);
        return vList;
    }

    @Override
    public String selectNameById(int lectureNo) {
        String result = lMapper.selectNameById(lectureNo);
        return result;
    }

    @Override
    public int insertLecture(Lecture lecture) {
        int result = lMapper.insertLecture(lecture);
        return result;
    }

    @Override
    public int insertVideo(LectureVideo video) {
        int result = lMapper.insertVideo(video);
        return result;
    }

    @Override
    public int getSearchCountAll(String search) {
        Map<String, Object> params = new HashMap<>();
        params.put("search", search);
        int result = lMapper.getSearchCountAll(params);
        return result;
    }

    @Override
    public List<LectureListRequest> selectSearchAll(int currentPage, int lectureCountPerPage, String search, String sortValue) {
        int startRow = (currentPage - 1) * lectureCountPerPage + 1;
        int endRow = currentPage * lectureCountPerPage;
        
        Map<String, Object> params = new HashMap<>();
        params.put("search", search);
        params.put("sortValue", sortValue);
        params.put("startRow", startRow);
        params.put("endRow", endRow);
        
        List<LectureListRequest> lList = lMapper.selectSearchAll(params);
        return lList;
    }

    @Override
    public int getSearchCategoryCount(String search, String category) {
        Map<String, Object> params = new HashMap<>();
        params.put("search", search);
        params.put("category", category);
        
        int result = lMapper.getSearchCategoryCount(params);
        return result;
    }

    @Override
    public List<LectureListRequest> selectSearchCategoryList(int currentPage, int lectureCountPerPage, String search, String category, String sortValue) {
        int startRow = (currentPage - 1) * lectureCountPerPage + 1;
        int endRow = currentPage * lectureCountPerPage;
        
        Map<String, Object> params = new HashMap<>();
        params.put("search", search);
        params.put("category", category);
        params.put("sortValue", sortValue);
        params.put("startRow", startRow);
        params.put("endRow", endRow);
        
        List<LectureListRequest> lList = lMapper.selectSearchCategoryList(params);
        return lList;
    }

    @Override
    public int getSearchCountAllForAdmin(String search) {
        Map<String, Object> params = new HashMap<>();
        params.put("search", search);
        params.put("isAdmin", true);
        int result = lMapper.getSearchCountAll(params);
        return result;
    }

    @Override
    public List<LectureListRequest> selectSearchAllForAdmin(int currentPage, int lectureCountPerPage, String search, String sortValue) {
        int startRow = (currentPage - 1) * lectureCountPerPage + 1;
        int endRow = currentPage * lectureCountPerPage;
        
        Map<String, Object> params = new HashMap<>();
        params.put("search", search);
        params.put("sortValue", sortValue);
        params.put("startRow", startRow);
        params.put("endRow", endRow);
        params.put("isAdmin", true);
        
        List<LectureListRequest> lList = lMapper.selectSearchAll(params);
        return lList;
    }

    @Override
    public int getSearchCategoryCountForAdmin(String search, String category) {
        Map<String, Object> params = new HashMap<>();
        params.put("search", search);
        params.put("category", category);
        params.put("isAdmin", true);
        
        int result = lMapper.getSearchCategoryCount(params);
        return result;
    }

    @Override
    public List<LectureListRequest> selectSearchCategoryListForAdmin(int currentPage, int lectureCountPerPage, String search, String category, String sortValue) {
        int startRow = (currentPage - 1) * lectureCountPerPage + 1;
        int endRow = currentPage * lectureCountPerPage;
        
        Map<String, Object> params = new HashMap<>();
        params.put("search", search);
        params.put("category", category);
        params.put("sortValue", sortValue);
        params.put("startRow", startRow);
        params.put("endRow", endRow);
        params.put("isAdmin", true);
        
        List<LectureListRequest> lList = lMapper.selectSearchCategoryList(params);
        return lList;
    }

    @Override
    public int checkTeacher(String loginId) {
        int result = lMapper.checkTeacher(loginId);
        return result;
    }

    @Override
    public int checkPurchase(String memberId, int lectureNo) {
        int result = lMapper.checkPurchase(memberId, lectureNo);
        return result;
    }

    @Override
    public Member selectMember(String memberId) {
        Member member = lMapper.selectMember(memberId);
        return member;
    }

    @Override
    public Lecture selectLecture(int lectureNo) {
        Lecture lecture = lMapper.selectLecture(lectureNo);
        return lecture;
    }

    @Override
    public int checkLogin(String memberId) {
        int result = lMapper.checkLogin(memberId);
        return result;
    }

    @Override
    public int insertQuestion(LectureQuestionRequest qList) {
        int result = lMapper.insertQuestion(qList);
        return result;
    }
    
    @Override
    public void deleteVideo(int videoNo) {
        lMapper.deleteVideo(videoNo);
    }
    
    @Override
    @Transactional
    public void deleteVideoAndReorder(int videoNo, int lectureNo) {
        // 1. 삭제할 비디오의 순서 조회
        int deletedOrder = lMapper.getVideoOrder(videoNo);
        
        // 2. 비디오 삭제 (VIDEO_YN = 'N')
        lMapper.deleteVideo(videoNo);
        
        // 3. 삭제된 순서보다 큰 순서들을 1씩 감소
        lMapper.reorderVideosAfterDelete(lectureNo, deletedOrder);
    }
    
    @Override
    public void deleteLecture(int lectureNo) {
        lMapper.deleteLecture(lectureNo);
    }

}
