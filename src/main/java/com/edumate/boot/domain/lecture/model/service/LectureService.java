package com.edumate.boot.domain.lecture.model.service;

import com.edumate.boot.app.lecture.dto.LectureListRequest;
import com.edumate.boot.app.lecture.dto.ReviewListRequest;
import com.edumate.boot.app.lecture.dto.VideoDetailRequest;
import com.edumate.boot.app.lecture.dto.VideoListRequest;
import com.edumate.boot.domain.lecture.model.vo.Lecture;
import com.edumate.boot.domain.lecture.model.vo.LectureVideo;

import java.util.List;

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
}
