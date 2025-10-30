package com.edumate.boot.common.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import software.amazon.awssdk.auth.credentials.AwsBasicCredentials;
import software.amazon.awssdk.auth.credentials.StaticCredentialsProvider;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.s3.S3Client;

import java.net.URI;

@Configuration
public class FileConfig {
	
	@Value("${cloud.r2.endpoint}")
	private String r2Endpoint;
	
	@Value("${cloud.r2.access-key}")
	private String r2AccessKey;
	
	@Value("${cloud.r2.secret-key}")
	private String r2SecretKey;
	
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