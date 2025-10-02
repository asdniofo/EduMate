package com.edumate.boot.common.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class FileConfig implements WebMvcConfigurer{
	private final String BOARD_WEB_PATH = "/images/board/**";
	private final String BOARD_REAL_PATH = "file:///C:/uploadImage/board/";
	
	private final String PHOTO_WEB_PATH = "/images/photo/**";
	private final String PHOTO_REAL_PATH = "file:///C:/uploadImage/photo/";
	
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler(BOARD_WEB_PATH)
				.addResourceLocations(BOARD_REAL_PATH);
		
		registry.addResourceHandler(PHOTO_WEB_PATH)
				.addResourceLocations(PHOTO_REAL_PATH);
	}
}