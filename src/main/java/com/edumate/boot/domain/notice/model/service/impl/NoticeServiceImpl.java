package com.edumate.boot.domain.notice.model.service.impl;

import com.edumate.boot.domain.notice.model.service.NoticeService;
import com.edumate.boot.domain.notice.model.vo.Notice;
import com.edumate.boot.app.teacher.controller.TeacherController;
import com.edumate.boot.domain.notice.model.mapper.NoticeMapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Service;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class NoticeServiceImpl implements NoticeService {

    private final TeacherController teacherController;

    private final NoticeMapper noticeMapper;

	@Override
	public int getTotalCount() {
		 int totalCount = noticeMapper.getTotalCount();
		return totalCount;
	}

	@Override
	public List<Notice> selectNoticeList(int currentPage, int boardCountPerPage) {
		int offset = (currentPage-1)*boardCountPerPage;
		RowBounds rowBounds = new RowBounds(offset, boardCountPerPage);
		List<Notice> nList = noticeMapper.selectNoticeList(rowBounds);
		return nList;
	}

	@Override
	public List<Notice> selectSearchList(Map<String, Object> searchMap) {
		int currentPage = (int)searchMap.get("currentPage");
		int boardLimit = (int)searchMap.get("boardLimit");
		int offset = (currentPage-1)*boardLimit;
		RowBounds rowBounds = new RowBounds(offset, boardLimit);
		List<Notice> searchList = noticeMapper.selectSearchList(searchMap, rowBounds);
		return searchList;
	}

	@Override
	public int getTotalCount(Map<String, Object> searchMap) {
		int totalCount = noticeMapper.getSearchTotalCount(searchMap);
		return totalCount;
	}

	@Override
	public Notice selectByOneNo(int noticeId) {
		Notice notice = noticeMapper.selectByOneNo(noticeId);
		return notice;
	}

	@Override
	public Integer selectPrevNotice(int currentNoticeId) {
		return noticeMapper.selectPrevNotice(currentNoticeId);
	}

	@Override
	public Integer selectNextNotice(int currentNoticeId) {
		return noticeMapper.selectNextNotice(currentNoticeId);
	}

	@Override
	public int updateNotice(Notice notice) {
		int result = noticeMapper.updateNotice(notice);
		return result;
	}

	@Override
	public int deleteNotice(int noticeId) {
		int result = noticeMapper.deleteNotice(noticeId);
		return result;
	}

	@Override
	public void increaseViewCount(int noticeId) {
        noticeMapper.increaseViewCount(noticeId);
	}

	@Override
	public int insertNotice(Notice notice) {
		int result = noticeMapper.insertNotice(notice);
		return result;
	}

}
