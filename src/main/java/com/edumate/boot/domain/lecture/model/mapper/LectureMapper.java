package com.edumate.boot.domain.lecture.model.mapper;

import com.edumate.boot.app.lecture.dto.LectureListRequest;
import com.edumate.boot.app.lecture.dto.ReviewListRequest;
import com.edumate.boot.app.lecture.dto.VideoDetailRequest;
import com.edumate.boot.app.lecture.dto.VideoListRequest;
import com.edumate.boot.domain.lecture.model.vo.Lecture;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import java.util.List;
import java.util.Map;

@Mapper
public interface LectureMapper {
    int totalCount();
    List<LectureListRequest> selectList(RowBounds rowBounds, Map<String, Object> params);

    List<LectureListRequest> selectCategoryList(RowBounds rowBounds, Map<String, Object> params);

    int categoryCount(String category);

    List<LectureListRequest> selectOneById(int lectureNo);

    List<ReviewListRequest> selectReviewById(int lectureNo);

    List<VideoListRequest> selectVideoListById(int lectureNo);

    int totalVideoById(int lectureNo);

    int totalTimeById(int lectureNo);

    List<VideoListRequest> selectVideoById(int videoNo);

    List<VideoListRequest> selectNextVideoById(int lectureNo, int nextVideoNo);

    String selectNameById(int lectureNo);
}
