package com.edumate.boot.app.reference.controller;

import com.edumate.boot.domain.reference.model.service.ReferenceService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/reference")
@RequiredArgsConstructor
public class ReferenceController {

    private final ReferenceService referenceService;

}
