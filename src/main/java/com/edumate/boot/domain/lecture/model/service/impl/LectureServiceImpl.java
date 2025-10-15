package com.edumate.boot.domain.lecture.model.service.impl;

import com.edumate.boot.app.lecture.dto.LectureListRequest;
import com.edumate.boot.app.lecture.dto.ReviewListRequest;
import com.edumate.boot.app.lecture.dto.VideoDetailRequest;
import com.edumate.boot.app.lecture.dto.VideoListRequest;
import com.edumate.boot.domain.lecture.model.service.LectureService;
import com.edumate.boot.domain.lecture.model.mapper.LectureMapper;
import com.edumate.boot.domain.lecture.model.vo.Lecture;
import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Service;
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


}
