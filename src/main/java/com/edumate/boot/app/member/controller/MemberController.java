package com.edumate.boot.app.member.controller;

import com.edumate.boot.domain.member.model.service.MemberService;
import org.springframework.web.bind.annotation.*;
import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/member")
@RequiredArgsConstructor
public class MemberController {

    private final MemberService memberService;

}
