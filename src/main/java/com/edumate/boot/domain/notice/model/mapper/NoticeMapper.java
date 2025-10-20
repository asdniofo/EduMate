package com.edumate.boot.domain.notice.model.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import com.edumate.boot.domain.notice.model.vo.Notice;

@Mapper
public interface NoticeMapper {

	int getTotalCount();

	List<Notice> selectNoticeList(RowBounds rowBounds);

	int getSearchTotalCount(Map<String, Object> searchMap);

	List<Notice> selectSearchList(Map<String, Object> searchMap, RowBounds rowBounds);

	Notice selectByOneNo(int noticeId);

	Integer selectPrevNotice(int currentNoticeId);

	Integer selectNextNotice(int currentNoticeId);

}
