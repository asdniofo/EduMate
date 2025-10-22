package com.edumate.boot.domain.event.model.service.impl;

import org.springframework.stereotype.Service;

import com.edumate.boot.domain.event.model.mapper.EventMapper;
import com.edumate.boot.domain.event.model.service.EventService;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class EventServiceImpl implements EventService {
	private final EventMapper eMapper;
}
