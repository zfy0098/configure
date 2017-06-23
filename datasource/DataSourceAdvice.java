package com.shouhuobao.guoer.service.datasource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.aop.AfterReturningAdvice;
import org.springframework.aop.MethodBeforeAdvice;
import org.springframework.aop.ThrowsAdvice;
import org.springframework.core.Ordered;

import java.lang.reflect.Method;


public class DataSourceAdvice implements MethodBeforeAdvice, AfterReturningAdvice, ThrowsAdvice, Ordered {


    private Logger logger = LoggerFactory.getLogger(DataSourceAdvice.class);


    @Override
    public void afterReturning(Object arg0, Method method, Object[] arg2, Object arg3) throws Throwable {


    }

    @Override
    public void before(Method method, Object[] arg1, Object target) throws Throwable {

        //		logger.info("aop select db with class: " + target.getClass().getName() + " method:" + method.getName());
        if (method.getName().toLowerCase().startsWith(DataSourceContextHolder.ANALYZE)) {
            //			logger.info("select: analyze");
            DataSourceContextHolder.setDsType(DataSourceContextHolder.ANALYZE);
        }
        else {
            //			logger.info("select: emove");
            DataSourceContextHolder.setDsType(DataSourceContextHolder.EMOVE);
        }
    }

    public void afterThrowing(Method method, Object[] args, Object target, Exception ex) throws Throwable {
        ex.printStackTrace();
        logger.error("-----error", ex.getMessage());
    }

    public int getOrder() {

        return 1;
    }
}
