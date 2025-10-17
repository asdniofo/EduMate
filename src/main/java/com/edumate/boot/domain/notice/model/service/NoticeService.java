package com.edumate.boot.domain.notice.model.service;

import java.util.List;
import java.util.Map;

import com.edumate.boot.domain.notice.model.vo.Notice;

public interface NoticeService {


	int getTotalCount();

	List<Notice> selectNoticeList(int currentPage, int boardCountPerPage);

	List<Notice> selectSearchList(Map<String, Object> searchMap);

	int getTotalCount(Map<String, Object> searchMap);

}
