/**
 * Copyright &copy; 2012-2016 <a href="https://gitee.com/JeeHuangBingGui/JeeSpring">JeeSpring</a> All rights reserved.
 */
package com;

import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.support.SpringBootServletInitializer;

/**
 * Web程序启动类
 *
 * @author 黄炳桂 516821420@qq.com
 * @date 2017-05-21 9:43
 */
public class JeeSpringServlet extends SpringBootServletInitializer
{

    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder builder) {
        return builder.sources(JeeSpringDriver.class);
    }

}
