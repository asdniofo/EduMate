package com.edumate.boot.app.reference.controller;

import com.edumate.boot.domain.reference.model.service.ReferenceService;
import org.springframework.web.bind.annotation.*;
import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/reference")
@RequiredArgsConstructor
public class ReferenceController {

    private final ReferenceService referenceService;

}
