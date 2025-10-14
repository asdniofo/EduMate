package com.edumate.boot.domain.lecture.model.service;

import com.edumate.boot.app.lecture.dto.LectureListRequest;
import com.edumate.boot.app.lecture.dto.ReviewListRequest;
import com.edumate.boot.domain.lecture.model.vo.Lecture;

import java.util.List;

public interface LectureService {

    int getTotalCount();

    List<LectureListRequest> selectList(int currentPage, int lectureCountPerPage, String sortValue);

    List<LectureListRequest> selectCategoryList(int currentPage, int lectureCountPerPage, String category, String sortValue);

    int getCategoryCount(String category);

    List<LectureListRequest> selectOneById(int lectureNo);

    List<ReviewListRequest> selectReviewById(int lectureNo);
}
