package com.edumate.boot.domain.lecture.model.mapper;

import com.edumate.boot.domain.lecture.model.vo.Lecture;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import java.util.List;
import java.util.Map;

@Mapper
public interface LectureMapper {
    int totalCount();
    List<Lecture> selectList(RowBounds rowBounds, Map<String, Object> params);

    List<Lecture> selectCategoryList(RowBounds rowBounds, Map<String, Object> params);

    int categoryCount(String category);

    List<Lecture> selectOneById(int lectureNo);
}
