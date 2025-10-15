package com.edumate.boot.domain.teacher.model.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import com.edumate.boot.domain.teacher.model.vo.Question;

@Mapper
public interface TeacherMapper {

	int getTotalCount();

	int getSearchTotalCount(Map<String, Object> searchMap);
	
	List<Question> selectQuestionList(RowBounds rowBounds);

	List<Question> selectSearchList(Map<String, Object> searchMap, RowBounds rowBounds);


}
