package com.edumate.boot.domain.teacher.model.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import com.edumate.boot.domain.teacher.model.vo.Question;

@Mapper
public interface TeacherMapper {

	int getTotalCount(Map<String, Object> params);

	int getSearchTotalCount(Map<String, Object> searchMap);
	
	List<Question> selectQuestionList(Map<String, Object> params, RowBounds rowBounds);

	List<Question> selectSearchList(Map<String, Object> searchMap, RowBounds rowBounds);

	Question selectOneByNo(int questionNo);

	Integer selectPrevQuestionNo(int currentQuestionNo);

	Integer selectNextQuestionNo(int currentQuestionNo);
}
