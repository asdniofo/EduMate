package com.edumate.boot.app.main.controller;

import com.edumate.boot.domain.main.model.service.MainService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/main")
@RequiredArgsConstructor
public class MainController {

    private final MainService mainService;

}
