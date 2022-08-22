package jp.taira.sample.presentation;

import jp.taira.sample.exception.BadRequestException;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Before;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.aspectj.lang.annotation.Aspect;

/**
 * コントローラ境界ログクラス
 */
@Aspect
@Component
public class LoggingAspects {

    private static final String ENTER = "[ENTER] ";
    private static final String ERROR = "[ERROR] ";
    private static final String EXIT = "[EXIT] ";

    /**
     * コントローラのメソッドのENTERログを出力する
     *
     * @param joinPoint
     */
    @Before("execution(* jp.taira.sample.presentation.controller..*.*(..))")
    public void invokeControllerBefore(JoinPoint joinPoint) {
        final Logger log = getLoggerClass(joinPoint);

        log.info(ENTER + getSignatureName(joinPoint));
    }

    /**
     * コントローラのメソッドのEXITログを出力する
     *
     * @param joinPoint
     * @param returnValue
     */
    @AfterReturning(pointcut = "execution(* jp.taira.sample.presentation.controller..*.*(..))", returning = "returnValue")
    public void invokeControllerAfterReturning(JoinPoint joinPoint, Object returnValue) {
        final Logger log = getLoggerClass(joinPoint);

        log.info(EXIT + getSignatureName(joinPoint));
    }

    /**
     * コントローラのメソッドのERRORログを出力する
     *
     * @param joinPoint
     * @param e
     */
    @AfterThrowing(value = "execution(* jp.taira.sample.presentation.controller..*.*(..))", throwing = "e")
    public void invokeControllerAfterThrowing(JoinPoint joinPoint, Throwable e) {
        final Logger log = getLoggerClass(joinPoint);
        if (e instanceof BadRequestException) {
            var exception = (BadRequestException) e;
            log.info(ERROR + getSignatureName(joinPoint), exception);
        }

        log.error(ERROR + getSignatureName(joinPoint), e);
    }

    /**
     * ログ出力クラスの名前を取得する
     *
     * @param joinPoint aop
     * @return ログ出力クラスの名前を返す
     */
    private Logger getLoggerClass(JoinPoint joinPoint) {
        return LoggerFactory.getLogger(joinPoint.getTarget().getClass().getName());
    }

    /**
     * メソッド名を取得する
     *
     * @param joinPoint
     * @return
     */
    private String getSignatureName(JoinPoint joinPoint) {
        return joinPoint.getTarget().getClass().getSimpleName() + " " + joinPoint.getSignature().getName() + " routing. ";
    }
}
