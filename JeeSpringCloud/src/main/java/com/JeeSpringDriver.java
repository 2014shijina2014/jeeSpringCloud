/**
 * Copyright &copy; 2012-2016 <a href="https://gitee.com/JeeHuangBingGui/JeeSpring">JeeSpring</a> All rights reserved.
 */
package com;

import com.jeespring.common.redis.RedisUtils;
import com.jeespring.common.websocket.WebSockertFilter;
import com.jeespring.modules.scheduling.JeeSpringTaskSchedulerConfig;
import com.jeespring.modules.sys.service.SystemService;

import org.apache.activemq.command.ActiveMQQueue;
import org.apache.catalina.connector.Connector;
import org.apache.coyote.http11.Http11NioProtocol;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.context.embedded.EmbeddedServletContainerFactory;
import org.springframework.boot.context.embedded.tomcat.TomcatEmbeddedServletContainerFactory;
import org.springframework.boot.web.servlet.ServletComponentScan;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.ClassPathResource;
import org.springframework.scheduling.annotation.EnableScheduling;

import javax.jms.Queue;
import java.io.File;
import java.io.IOException;

/**
 * jeespring
 * springboot的启动类
 * * * @author 黄炳桂 516821420@qq.com
 * Created on 2017/1/8 16:20
 */
@EnableCaching
@SpringBootApplication
@ServletComponentScan(value = {"com.jeespring","com.company"})
@ComponentScan(value = {"com.jeespring","com.company"})//,lazyInit = true
@EnableScheduling
@ComponentScan
@EnableAutoConfiguration
@Configuration
public class JeeSpringDriver {

    @Value("${http.port}")
    private Integer port;

    public static void main(String[] args) {
    	//Spring boot run
        new SpringApplicationBuilder(JeeSpringDriver.class).web(true).run(args);
        SystemService.printKeyLoadMessage();

        //IM WebSocker
        WebSockertFilter w=new WebSockertFilter();
        w.startWebsocketChatServer();

        printGods();
    }

    @Bean
    public EmbeddedServletContainerFactory servletContainer() {
        TomcatEmbeddedServletContainerFactory tomcat = new TomcatEmbeddedServletContainerFactory();
        tomcat.addAdditionalTomcatConnectors(createStandardConnector()); // 添加http
        return tomcat;
    }

    // 配置http
    private Connector createStandardConnector() {
        Connector connector = new Connector("org.apache.coyote.http11.Http11NioProtocol");
        connector.setPort(port);
        return connector;
    }

    public static void printGods(){
        System.out.println(
                "--------------- 佛祖保佑 神兽护体 女神助攻 流量冲天 ---------------\n" +
                        "                             _ooOoo_                                 \n" +
                        "                            o8888888o                                \n" +
                        "                            88\" . \"88                              \n" +
                        "                            (| ^_^ |)                                \n" +
                        "                            O\\  =  /O                               \n" +
                        "                         ____/`---'\\____                            \n" +
                        "                       .'  \\\\|     |//  `.                         \n" +
                        "                      /   \\|||  :  |||//  \\                        \n" +
                        "                     /  _||||| -:- |||||-  \\                        \n" +
                        "                     |   | \\\\\\  -  /// |   |                      \n" +
                        "                     | \\_|  ''\\---/''  |   |                       \n" +
                        "                     \\  .-\\__  `-`  ___/-. /                       \n" +
                        "                   ___`. .'  /--.--\\  `. . ___                      \n" +
                        "                 .\"\" '<  `.___\\_<|>_/___.'  >'\"\".               \n" +
                        "               | | :  `- \\`.;`\\ _ /`;.`/ - ` : | |                 \n" +
                        "               \\  \\ `-.   \\_ __\\ /__ _/   .-` /  /               \n" +
                        "         ========`-.____`-.___\\_____/___.-`____.-'========          \n" +
                        "                              `=---='                                \n" +
                        "         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^          \n" +
                        "            佛祖保佑       永不宕机     永无BUG    流量冲天             \n" +
                        "");
        System.out.println(
                "\n" +
                        "　　　　　　　  ┏┓             ┏┓+ +                                    \n" +
                        "　　　　　　　┏┛┻━━━━━━━┛┻┓ + +                          \n" +
                        "　　　　　　　┃　　　　　　         ┃                                       \n" +
                        "　　　　　　　┃　　　━　　　       ┃ ++ + + +                             \n" +
                        "　　　　　　 █████━█████  ┃+                              \n" +
                        "　　　　　　　┃　　　　　　         ┃ +                                     \n" +
                        "　　　　　　　┃　　　┻　　　       ┃                                      \n" +
                        "　　　　　　　┃　　　　　　         ┃ + +                                   \n" +
                        "　　　　　　　┗━━┓　   ┏━━━━┛                                   \n" +
                        "                  ┃　　  ┃                                            \n" +
                        "　　　　　　　　　 ┃　　  ┃ + + + +                                  \n" +
                        "　　　　　　　　 　┃　　　┃　                                         \n" +
                        "　　　　　　　 　　┃　　　┃ + 　　　　神兽护体,流量冲天       \n" +
                        "　　　　　　　 　　┃　　　┃          永不宕机,代码无bug                   \n" +
                        "　　　　　　　　 　┃　　　┃　　+                                        \n" +
                        "　　　　　　　　 　┃　 　 ┗━━━━━┓ + +                                  \n" +
                        "　　　　　　　　 　┃ 　　　　　       ┣┓                                       \n" +
                        "　　　　　　　　 　┃ 　　　　　       ┏┛                                       \n" +
                        "　　　　　　　　 　┗┓┓┏━━━┳┓┏┛ + + + +                           \n" +
                        "　　　　　　　　 　  ┃┫┫　    ┃┫┫                                        \n" +
                        "　　　　　　　　 　  ┗┻┛　    ┗┻┛+ + + +                                 \n" +
                        "");
        System.out.println(
                "\n" +
                        "　　　　　　 ┏┓           ┏┓                                    \n" +
                        "          ┏┛┻━━━━━━┛┻┓   \n" +
                        "          ┃　　　　　　        ┃   \n" +
                        "          ┃　　　━　　　      ┃   \n" +
                        "          ┃　┳┛　  ┗┳　    ┃   \n" +
                        "          ┃　　　　　　        ┃   \n" +
                        "          ┃　　　┻　　　      ┃   \n" +
                        "          ┃　　　　　　       ┃   \n" +
                        "          ┗━┓　　　┏━━━┛   \n" +
                        "              ┃　　　┃   神兽护体 流量冲天   \n" +
                        "              ┃　　　┃   永不宕机 代码无BUG！   \n" +
                        "              ┃　　　┗━━━━━━━━━┓   \n" +
                        "              ┃　　　　　　　            ┣┓   \n" +
                        "              ┃　　　　                  ┏┛   \n" +
                        "              ┗━┓ ┓ ┏━━━┳ ┓ ┏━┛   \n" +
                        "                  ┃ ┫  ┫    ┃  ┫ ┫   \n" +
                        "                  ┗━┻━┛   ┗━┻━┛   \n" +
                        "");
        System.out.println(
                "\n" +
                        "                       .::::.                                     \n" +
                        "                     .::::::::.                                   \n" +
                        "                    :::::::::::                                   \n" +
                        "                 ..:::::::::::'                                   \n" +
                        "              '::::::::::::'                                      \n" +
                        "                .::::::::::                                       \n" +
                        "           '::::::::::::::..        女神助攻,流量冲天               \n" +
                        "                ..::::::::::::.     永不宕机,代码无bug              \n" +
                        "              ``::::::::::::::::                                   \n" +
                        "               ::::``:::::::::'        .:::.                      \n" +
                        "              ::::'   ':::::'       .::::::::.                    \n" +
                        "            .::::'      ::::     .:::::::'::::.                   \n" +
                        "           .:::'       :::::  .:::::::::' ':::::.                 \n" +
                        "          .::'        :::::.:::::::::'      ':::::.               \n" +
                        "         .::'         ::::::::::::::'         ``::::.              \n" +
                        "     ...:::           ::::::::::::'              ``::.             \n" +
                        "    ```` ':.          ':::::::::'                  ::::..           \n" +
                        "                       '.:::::'                    ':'````..        \n" +
                        "");
        System.out.println(
                "\n" +
                        "           唐伯虎:\n" +
                        "                             桃花庵歌                           \n" +
                        "                  桃花坞里桃花庵，桃花庵下桃花仙；                \n" +
                        "                  桃花仙人种桃树，又摘桃花卖酒钱。                \n" +
                        "                  酒醒只在花前坐，酒醉还来花下眠；                \n" +
                        "                  半醒半醉日复日，花落花开年复年。                \n" +
                        "                  但愿老死花酒间，不愿鞠躬车马前；                \n" +
                        "                  车尘马足富者趣，酒盏花枝贫者缘。                \n" +
                        "                  若将富贵比贫贱，一在平地一在天；                \n" +
                        "                  若将贫贱比车马，他得驱驰我得闲。                \n" +
                        "                  别人笑我太疯癫，我笑他人看不穿；                \n" +
                        "                  不见五陵豪杰墓，无花无酒锄作田。                \n" +
                        "");
        System.out.println(
                "\n" +
                        "           曹操:\n" +
                        "                                  短歌行                  \n" +
                        "                  对酒当歌，人生几何？譬如朝露，去日苦多。                  \n" +
                        "                  概当以慷，忧思难忘。何以解忧？唯有杜康。                  \n" +
                        "                  青青子衿，悠悠我心。但为君故，沈吟至今。                  \n" +
                        "                  呦呦鹿鸣，食野之苹。我有嘉宾，鼓瑟吹笙。                  \n" +
                        "                  明明如月，何时可掇？忧从中来，不可断绝。                  \n" +
                        "                  越陌度阡，枉用相存。契阔谈咽，心念旧恩。                  \n" +
                        "                  月明星稀，乌鹊南飞。绕树三匝，何枝可依。                  \n" +
                        "                  山不厌高，海不厌深，周公吐哺，天下归心。                  \n" +
                        "");
        System.out.println(
                "\n" +
                        "          关羽：                                                \n" +
                        "                             咏关公                             \n" +
                        "                 桃园结义薄云天，偃月青龙刀刃寒。                  \n" +
                        "                 一骑绝尘走千里，五关斩将震坤乾。                  \n" +
                        "                 忠心报国为梁栋，肝胆护兄铸铁肩。                  \n" +
                        "                 一去麦城无复返，英魂庙里化青烟。                  \n" +
                        "");
        System.out.println(
                "\n" +
                        "          程序员:                                               \n" +
                        "                            程序开发行                            \n" +
                        "                  写字楼里写字间，写字间里程序员；                \n" +
                        "                  程序人员做开发，又拿程序换活钱。                \n" +
                        "                  上班只在网上坐，下班还来网下眠；                \n" +
                        "                  奔驰宝马贵者趣，公交自行程序员。                \n" +
                        "                  不见满街漂亮妹，哪个归得程序员；                \n" +
                        "                  别人笑我忒疯癫，我笑他人看不穿。                \n" +
                        "                  年复一年代码圈，精益求精产品圈；                \n" +
                        "                  至情之人同成长，缔造和谐至情间。                \n" +
                        "                  千锤百炼飞冲天，辉煌有为戏人间；                \n" +
                        "                  谈笑风生社会圈，享天福天下归心。                \n" +
                        "\n" +
                        "          产品专员:征集中                                   \n" +
                        "          美工专员:征集中                                   \n" +
                        "          UI专员:征集中                                     \n" +
                        "          测试专员:征集中                                   \n" +
                        "          老董:征集中                                       \n" +
                        "          JeeSpring官方QQ群：328910546                                       \n" +
                        "          JeeSpring官方QQ群(VIP)：558699173                                       \n" +
                        "          JeeSpring官方架构群：464865153                                       \n" +
                        "          JeeSpring是官方分布式微服务集群开源框架，使用前端HTML或后端模板引擎+mvvm+spring mvc+spring boot+spring cloud、mybatis、alibaba dubbo 分布式、\n" +
                        "          微服务、集群、代码生成（前端界面、底层代码、dubbo、微服务的生成）等核心技术。\n" +
                        "          开源中国 https://git.oschina.net/JeeHuangBingGui/JeeSpring\n" +
                        "");
    }
}
