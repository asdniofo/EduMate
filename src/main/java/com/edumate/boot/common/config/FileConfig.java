package com.edumate.boot.common.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import software.amazon.awssdk.auth.credentials.AwsBasicCredentials;
import software.amazon.awssdk.auth.credentials.StaticCredentialsProvider;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.s3.S3Client;

import java.net.URI;

@Configuration
public class FileConfig implements WebMvcConfigurer{

	private final String LECTURE_IMAGE_WEB_PATH = "/images/lecture/**";
	private final String LECTURE_IMAGE_REAL_PATH = "file:///" + System.getProperty("user.dir") + "/src/main/webapp/resources/images/lecture/";
	
	private final String LECTURE_VIDEO_WEB_PATH = "/videos/lecture/**";
	private final String LECTURE_VIDEO_REAL_PATH = "file:///" + System.getProperty("user.dir") + "/src/main/webapp/resources/videos/lecture/";
	
	@Value("${cloud.r2.endpoint}")
	private String r2Endpoint;
	
	@Value("${cloud.r2.access-key}")
	private String r2AccessKey;
	
	@Value("${cloud.r2.secret-key}")
	private String r2SecretKey;
	
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {

		registry.addResourceHandler(LECTURE_IMAGE_WEB_PATH)
				.addResourceLocations(LECTURE_IMAGE_REAL_PATH);
		
		registry.addResourceHandler(LECTURE_VIDEO_WEB_PATH)
				.addResourceLocations(LECTURE_VIDEO_REAL_PATH);
	}
	
	@Bean
	public S3Client defaultS3Client() {
		AwsBasicCredentials credentials = AwsBasicCredentials.create(r2AccessKey, r2SecretKey);
		
		return S3Client.builder()
				.endpointOverride(URI.create(r2Endpoint))
				.credentialsProvider(StaticCredentialsProvider.create(credentials))
				.region(Region.US_EAST_1)
				.build();
	}
}