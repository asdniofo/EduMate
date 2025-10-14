package com.edumate.boot.domain.reference.model.service.impl;

import com.edumate.boot.domain.reference.model.service.ReferenceService;
import com.edumate.boot.domain.reference.model.mapper.ReferenceMapper;
import org.springframework.stereotype.Service;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ReferenceServiceImpl implements ReferenceService {

    private final ReferenceMapper referenceMapper;

}
