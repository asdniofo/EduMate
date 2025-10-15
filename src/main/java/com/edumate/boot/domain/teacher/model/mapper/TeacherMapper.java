package com.edumate.boot.domain.teacher.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import com.edumate.boot.domain.teacher.model.vo.Question;

@Mapper
public interface TeacherMapper {

	int getTotalCount();

	List<Question> selectQuestionList(RowBounds rowBounds);

}
