package com.edumate.boot.domain.lectures.model.service.impl;

import com.edumate.boot.domain.lectures.model.service.LecturesService;
import com.edumate.boot.domain.lectures.model.mapper.LecturesMapper;
import org.springframework.stereotype.Service;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class LecturesServiceImpl implements LecturesService {

    private final LecturesMapper lecturesMapper;

}
