package com.edumate.boot.app.main.controller;

import com.edumate.boot.domain.main.model.service.MainService;
import org.springframework.web.bind.annotation.*;
import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/main")
@RequiredArgsConstructor
public class MainController {

    private final MainService mainService;

}
