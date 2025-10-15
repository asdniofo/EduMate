package com.edumate.boot.domain.teacher.model.service;

import java.util.List;

import com.edumate.boot.domain.teacher.model.vo.Question;

public interface TeacherService {

	int getTotalCount();

	List<Question> selectList(int currentPage, int boardCountPerPage);

}
