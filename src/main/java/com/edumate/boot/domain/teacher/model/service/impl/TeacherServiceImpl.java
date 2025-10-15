package com.edumate.boot.domain.teacher.model.service.impl;

import com.edumate.boot.domain.teacher.model.service.TeacherService;
import com.edumate.boot.domain.teacher.model.vo.Question;
import com.edumate.boot.domain.teacher.model.mapper.TeacherMapper;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Service;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class TeacherServiceImpl implements TeacherService {

    private final TeacherMapper tMapper;

	@Override
	public int getTotalCount() {
		int totalCount = tMapper.getTotalCount();
		return totalCount;
	}

	@Override
	public List<Question> selectList(int currentPage, int boardCountPerPage) {
		int offset = (currentPage-1)*boardCountPerPage;
		RowBounds rowBounds = new RowBounds(offset, boardCountPerPage);
		List<Question> tList = tMapper.selectQuestionList(rowBounds);
		return tList;
	}

}
