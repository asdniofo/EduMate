package com.edumate.boot.domain.teacher.model.service;

import java.util.List;
import java.util.Map;

import com.edumate.boot.domain.teacher.model.vo.Question;

public interface TeacherService {

	int getTotalCount(String filter);

	int getTotalCount(Map<String, Object> searchMap);
	
	List<Question> selectList(int currentPage, int boardCountPerPage, String filter);

	List<Question> selectSearchList(Map<String, Object> searchMap);
}
