package com.edumate.boot.common.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class FileConfig implements WebMvcConfigurer{

	private final String LECTURE_IMAGE_WEB_PATH = "/images/lecture/**";
	private final String LECTURE_IMAGE_REAL_PATH = "file:///" + System.getProperty("user.dir") + "/src/main/webapp/resources/images/lecture/";
	
	private final String LECTURE_VIDEO_WEB_PATH = "/videos/lecture/**";
	private final String LECTURE_VIDEO_REAL_PATH = "file:///" + System.getProperty("user.dir") + "/src/main/webapp/resources/videos/lecture/";
	
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {

		registry.addResourceHandler(LECTURE_IMAGE_WEB_PATH)
				.addResourceLocations(LECTURE_IMAGE_REAL_PATH);
		
		registry.addResourceHandler(LECTURE_VIDEO_WEB_PATH)
				.addResourceLocations(LECTURE_VIDEO_REAL_PATH);
	}
}