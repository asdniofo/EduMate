package com.edumate.boot.common.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class FileConfig implements WebMvcConfigurer{

	private final String LECTURE_WEB_PATH = "/images/lecture/**";
	private final String LECTURE_REAL_PATH = "file:///" + System.getProperty("user.dir") + "/src/main/webapp/resources/images/lecture/";
	
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {

		registry.addResourceHandler(LECTURE_WEB_PATH)
				.addResourceLocations(LECTURE_REAL_PATH);
	}
}