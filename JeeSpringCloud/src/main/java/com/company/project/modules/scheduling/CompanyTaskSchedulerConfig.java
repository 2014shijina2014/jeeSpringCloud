package com.company.project.modules.scheduling;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableScheduling;

@Configuration
@ComponentScan("com.company.project.modules.scheduling")
@EnableScheduling
public class CompanyTaskSchedulerConfig {

}