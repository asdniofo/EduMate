package com.edumate.boot.common;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;
import org.springframework.util.StopWatch;

@Component
@Aspect
public class AopAspect {

	//@Before("execution(* com.elon.boot.app..*Controller.*(..))")
	public void advice1() {
		System.out.println("Before");
	}
	
	//@Around("execution(* com.elon.boot.domain..*Impl.*(..))")
	public Object stopWatchAdvice(ProceedingJoinPoint joinPoint) throws Throwable {
		StopWatch stopWatch = new StopWatch();
		// 메소드 실행시간 측정 
		// 측정 시작
		stopWatch.start();
		// 메소드 실행
		Object result = joinPoint.proceed();
		// 측정 끝
		stopWatch.stop();
		// 측정 결과
		long executionTime = stopWatch.getTotalTimeMillis();
		String className = joinPoint.getTarget().getClass().getName();
		String methodName = joinPoint.getSignature().getName();
		String task = className + "-" + methodName;
		System.out.println("[ExecutionTime " + task + "-->" + executionTime + "(ms)");
		return result;
	}
}
