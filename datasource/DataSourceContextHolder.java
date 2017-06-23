package com.shouhuobao.guoer.service.datasource;

public class DataSourceContextHolder {

    public static final String EMOVE = "emove";
    public static final String ANALYZE = "analyze";
    private static final ThreadLocal<String> contextHolder = new ThreadLocal<String>();

    public static void setDsType(String dsType) {
        contextHolder.set(dsType);
    }

    public static String getDsType() {
        return contextHolder.get();
    }

    public static void clearDsType() {
        contextHolder.remove();
    }

}
