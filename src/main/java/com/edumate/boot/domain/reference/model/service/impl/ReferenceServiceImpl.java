package com.edumate.boot.domain.reference.model.service.impl;

import com.edumate.boot.domain.reference.model.service.ReferenceService;
import com.edumate.boot.domain.reference.model.vo.Reference;
import com.edumate.boot.domain.reference.model.mapper.ReferenceMapper;

import java.util.List;
import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Service;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ReferenceServiceImpl implements ReferenceService {

	private final ReferenceMapper referenceMapper;

	@Override
	public int getTotalCount() {
		return referenceMapper.getTotalCount();
	}

	@Override
	public List<Reference> selectList(int currentPage, int boardCountPerPage) {
		// 페이징 처리를 위한 offset 계산
		// currentPage: 1 -> offset: 0
		// currentPage: 2 -> offset: 5
		// currentPage: 3 -> offset: 10
		int offset = (currentPage - 1) * boardCountPerPage;
		
		Map<String, Object> params = new HashMap<>();
		params.put("offset", offset);
		params.put("limit", boardCountPerPage);
		
		return referenceMapper.selectList(params);
	}

	@Override
	public Reference selectOneByNo(int referenceNo) {
		return referenceMapper.selectOneByNo(referenceNo);
	}

	@Override
	public int insertReference(Reference reference) {
		return referenceMapper.insertReference(reference);
	}

	@Override
	public int updateReference(Reference reference) {
		return referenceMapper.updateReference(reference);
	}

	@Override
	public int deleteReference(int referenceNo) {
		return referenceMapper.deleteReference(referenceNo);
	}

	@Override
	public List<Reference> selectSearchList(Map<String, Object> searchMap) {
		// 페이징 처리
		int currentPage = (int) searchMap.get("currentPage");
		int boardLimit = (int) searchMap.get("boardLimit");
		int offset = (currentPage - 1) * boardLimit;
		
		searchMap.put("offset", offset);
		searchMap.put("limit", boardLimit);
		
		return referenceMapper.selectSearchList(searchMap);
	}

	@Override
	public int getTotalCount(Map<String, Object> searchMap) {
		return referenceMapper.getTotalCountBySearch(searchMap);
	}

}