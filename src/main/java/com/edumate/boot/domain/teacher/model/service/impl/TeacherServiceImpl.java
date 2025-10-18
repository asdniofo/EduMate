package com.edumate.boot.domain.teacher.model.service.impl;

import com.edumate.boot.domain.teacher.model.service.TeacherService;
import com.edumate.boot.domain.teacher.model.vo.Question;
import com.edumate.boot.domain.teacher.model.mapper.TeacherMapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Service;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class TeacherServiceImpl implements TeacherService {

    private final TeacherMapper tMapper;

	@Override
	public int getTotalCount(String filter) {
		Map<String, Object> params = new HashMap<>();
	    params.put("filter", filter);
	    int totalCount = tMapper.getTotalCount(params);
	    return totalCount;
	}
	
	@Override
	public int getTotalCount(Map<String, Object> searchMap) {
		int totalCount = tMapper.getSearchTotalCount(searchMap);
		return totalCount;
	}

	@Override
	public List<Question> selectList(int currentPage, int boardCountPerPage, String filter) {
		int offset = (currentPage-1)*boardCountPerPage;
		RowBounds rowBounds = new RowBounds(offset, boardCountPerPage);
		Map<String, Object> params = new HashMap<>();
	    params.put("filter", filter);
		List<Question> tList = tMapper.selectQuestionList(params, rowBounds);
		return tList;
	}

	@Override
	public List<Question> selectSearchList(Map<String, Object> searchMap) {
		int currentPage = (int)searchMap.get("currentPage");
		int boardLimit = (int)searchMap.get("boardLimit");
		int offset = (currentPage-1)*boardLimit;
		RowBounds rowBounds = new RowBounds(offset, boardLimit);
		List<Question> searchList = tMapper.selectSearchList(searchMap, rowBounds);
		return searchList;
	}

	@Override
	public Question selectOneByNo(int questionNo) {
		Question question = tMapper.selectOneByNo(questionNo);
		return question;
	}

	@Override
	public Integer selectPrevQuestionNo(int currentQuestionNo) {
		return tMapper.selectPrevQuestionNo(currentQuestionNo);
	}

	@Override
	public Integer selectNextQuestionNo(int currentQuestionNo) {
		return tMapper.selectNextQuestionNo(currentQuestionNo);
	}


}
