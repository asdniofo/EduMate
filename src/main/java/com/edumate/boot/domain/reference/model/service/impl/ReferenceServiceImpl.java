package com.edumate.boot.domain.reference.model.service.impl;
import com.edumate.boot.domain.reference.model.service.ReferenceService;
import com.edumate.boot.domain.reference.model.vo.Reference;
import com.edumate.boot.domain.reference.model.mapper.ReferenceMapper;
import java.util.List;
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
	public List<Reference> selectList(Map<String, Object> paramMap) {
		return referenceMapper.selectList(paramMap);
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
		return referenceMapper.selectSearchList(searchMap);
	}
	
	@Override
	public int getTotalCountBySearch(Map<String, Object> searchMap) {
		return referenceMapper.getTotalCountBySearch(searchMap);
	}
}