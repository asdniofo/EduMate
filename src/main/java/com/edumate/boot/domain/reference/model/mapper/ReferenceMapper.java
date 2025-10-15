package com.edumate.boot.domain.reference.model.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.edumate.boot.domain.reference.model.vo.Reference;

@Mapper
public interface ReferenceMapper {

	/**
	 * 전체 자료 개수 조회
	 */
	int getTotalCount();

	/**
	 * 자료 목록 조회 (페이징)
	 */
	List<Reference> selectList(Map<String, Object> params);

	/**
	 * 자료 상세 조회
	 */
	Reference selectOneByNo(int referenceNo);

	/**
	 * 자료 등록
	 */
	int insertReference(Reference reference);

	/**
	 * 자료 수정
	 */
	int updateReference(Reference reference);

	/**
	 * 자료 삭제
	 */
	int deleteReference(int referenceNo);

	/**
	 * 자료 검색 (조건검색 + 페이징)
	 */
	List<Reference> selectSearchList(Map<String, Object> searchMap);

	/**
	 * 검색 결과 전체 개수 조회
	 */
	int getTotalCountBySearch(Map<String, Object> searchMap);

}