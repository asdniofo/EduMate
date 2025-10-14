package com.edumate.boot.domain.lecture.model.service;

import com.edumate.boot.domain.lecture.model.vo.Lecture;

import java.util.List;

public interface LectureService {

    int getTotalCount();

    List<Lecture> selectList(int currentPage, int lectureCountPerPage, String sortValue);

    List<Lecture> selectCategoryList(int currentPage, int lectureCountPerPage, String category, String sortValue);

    int getCategoryCount(String category);

    List<Lecture> selectOneById(int lectureNo);
}
