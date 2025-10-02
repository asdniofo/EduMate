package com.edumate.boot.domain.main.model.service.impl;

import com.edumate.boot.domain.main.model.service.MainService;
import com.edumate.boot.domain.main.model.mapper.MainMapper;
import org.springframework.stereotype.Service;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MainServiceImpl implements MainService {

    private final MainMapper mainMapper;

}
