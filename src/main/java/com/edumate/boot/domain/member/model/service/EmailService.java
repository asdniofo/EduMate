package com.edumate.boot.domain.member.model.service;

public interface EmailService {

	String sendAuthCode(String toEmail);

	boolean verifyAuthCode(String email, String authCode);
}
