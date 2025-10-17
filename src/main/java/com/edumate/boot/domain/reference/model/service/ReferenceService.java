package com.edumate.boot.domain.reference.model.service;
import java.util.List;
import java.util.Map;
import com.edumate.boot.domain.reference.model.vo.Reference;

public interface ReferenceService {
	/**
	 * 전체 자료 개수 조회
	 * @return 자료 총 개수
	 */
	int getTotalCount();
	
	/**
	 * 자료 목록 조회 (페이징)
	 * @param paramMap offset, limit 포함
	 * @return 자료 목록
	 */
	List<Reference> selectList(Map<String, Object> paramMap);
	
	/**
	 * 자료 상세 조회
	 * @param referenceNo 자료 번호
	 * @return 자료 정보
	 */
	Reference selectOneByNo(int referenceNo);
	
	/**
	 * 자료 등록
	 * @param reference 자료 정보
	 * @return 등록된 행의 개수
	 */
	int insertReference(Reference reference);
	
	/**
	 * 자료 수정
	 * @param reference 자료 정보
	 * @return 수정된 행의 개수
	 */
	int updateReference(Reference reference);
	
	/**
	 * 자료 삭제
	 * @param referenceNo 자료 번호
	 * @return 삭제된 행의 개수
	 */
	int deleteReference(int referenceNo);
	
	/**
	 * 자료 검색 (조건검색 + 페이징)
	 * @param searchMap 검색 조건 (searchCondition, searchKeyword, offset, limit)
	 * @return 검색된 자료 목록
	 */
	List<Reference> selectSearchList(Map<String, Object> searchMap);
	
	/**
	 * 검색 결과 전체 개수 조회
	 * @param searchMap 검색 조건
	 * @return 검색된 자료 총 개수
	 */
	int getTotalCountBySearch(Map<String, Object> searchMap);
}