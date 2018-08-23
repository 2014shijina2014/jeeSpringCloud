package com.company.project.modules.scheduling;

import com.company.project.modules.activeMQ.CompanyProducer;
import com.jeespring.common.config.Global;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Component
public class CompanyScheduledTaskService {
    private static final SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    //@Autowired
    //private XXXService xxxxService;

    @Autowired
    private CompanyProducer companyProducer;

    //每个2s执行一次任务
    @Scheduled(fixedRate = 2000)
    public void run(){
        //xxxxService.method();
        //System.out.println(dateFormat.format(new Date()) + " | " + "com.company.project.modules.scheduling:每隔2s执行一次任务");
    }
    //每个2s执行一次任务#朝九晚七工作时间内每五分钟
    @Scheduled(cron = "0 0/3 9-19 * * ?")
    public void run2(){
        //xxxxService.method();
        //System.out.println(dateFormat.format(new Date()) + " | " + "com.company.project.modules.scheduling:朝九晚七工作时间内每五分钟执行一次任务");
        //companyProducer.sendMessageA( "ActiveMQ CompanyProducer queueA。");
        //companyProducer.sendMessageB("ActiveMQ CompanyProducer queueB。");
    }

    //每天15点29分执行该任务
    @Scheduled(cron = "0 29 15 ? * *")
    public void run3()
    {
        //System.out.println(dateFormat.format(new Date()) + " | " + "com.company.project.modules.scheduling:每天在指定时间执行任务");
    }
}