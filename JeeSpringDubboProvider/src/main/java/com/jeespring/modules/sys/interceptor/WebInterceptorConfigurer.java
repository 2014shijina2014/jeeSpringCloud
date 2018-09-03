package com.jeespring.modules.sys.interceptor;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

/**
 * Created by
 * Created on 2017/1/15 20:21
 * Mail zww199009@163.com
 */
@Component
public class WebInterceptorConfigurer extends WebMvcConfigurerAdapter{
    @Autowired
    private LogInterceptor logInterceptor;
    @Autowired
    private LogThread logThread;

    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(logInterceptor).addPathPatterns("/**");
        super.addInterceptors(registry);
        logThread.start();
    }
}
