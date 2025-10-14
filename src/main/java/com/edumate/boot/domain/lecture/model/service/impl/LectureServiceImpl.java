package com.edumate.boot.domain.lecture.model.service.impl;

import com.edumate.boot.domain.lecture.model.service.LectureService;
import com.edumate.boot.domain.lecture.model.mapper.LectureMapper;
import com.edumate.boot.domain.lecture.model.vo.Lecture;
import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Service;
import lombok.RequiredArgsConstructor;

import java.util.List;
import java.util.Map;
import java.util.HashMap;

@Service
@RequiredArgsConstructor
public class LectureServiceImpl implements LectureService {

    private final LectureMapper lMapper;


    @Override
    public int getTotalCount() {
        int result = lMapper.totalCount();
        return result;
    }

    @Override
    public List<Lecture> selectList(int currentPage, int lectureCountPerPage, String sortValue) {
        int offset = (currentPage - 1) * lectureCountPerPage;
        RowBounds rowBounds = new RowBounds(offset, lectureCountPerPage);
        Map<String, Object> params = new HashMap<>();
        params.put("sortValue", sortValue);
        List<Lecture> lList = lMapper.selectList(rowBounds, params);
        return lList;
    }

    @Override
    public List<Lecture> selectCategoryList(int currentPage, int lectureCountPerPage, String category, String sortValue) {
        int offset = (currentPage - 1) * lectureCountPerPage;
        RowBounds rowBounds = new RowBounds(offset, lectureCountPerPage);
        Map<String, Object> params = new HashMap<>();
        params.put("category", category);
        params.put("sortValue", sortValue);
        List<Lecture> lList = lMapper.selectCategoryList(rowBounds, params);
        return lList;
    }

    @Override
    public int getCategoryCount(String category) {
        int result = lMapper.categoryCount(category);
        return result;
    }

    @Override
    public List<Lecture> selectOneById(int lectureNo) {
        List<Lecture> lList = lMapper.selectOneById(lectureNo);
        return lList;
    }


}
