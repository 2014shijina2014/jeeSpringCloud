<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>首页</title>
	<meta name="decorator" content="default"/>
		    <%@ include file="/WEB-INF/views/include/head.jsp"%>
	<script type="text/javascript">
		$(document).ready(function() {
		     WinMove();
		});
	</script>
</head>
<body class="gray-bg">
   <div class="row  border-bottom white-bg dashboard-header">
        <div class="col-sm-12">
            <blockquote class="text-info" style="font-size:14px">JeeSpring是基于Spring+SpringMVC+Mybatis+Redis+阿里巴巴dubbo+Javax.ws微服务分布式代码生成的敏捷开发系统架构。项目代码简洁,注释丰富,上手容易,还同时集中分布式、微服务,同时包含许多基础模块(用户管理,角色管理,部门管理,字典管理等10个模块。成为大众认同、大众参与、成就大众、大众分享的开发平台。JeeSpring官方qq群(328910546)。代码生成前端界面、底层代码（spring mvc、mybatis、dubbo、微服务的生成）、安全框架、视图框架、服务端验证、任务调度、持久层框架、数据库连接池、缓存框架、日志管理、IM等核心技术。努力用心为大中小型企业打造全方位J2EE企业级平台ORM/Redis/Service仓库开发解决方案。一个RepositoryService仓库就直接实现dubbo、微服务、基础服务器对接接口和实现。
努力用心为大中小型企业打造全方位J2EE企业级平台开发解决方案。
    			<br/>
               <br>阿里巴巴<a target="_blank" href="http://dubbo.io/">DUBBO</a>(点击访问）是一个分布式服务框架，致力于提供高性能和透明化的RPC远程服务调用方案，分布式微服务集群核心框架，每天为2,000+个服务提供3,000,000,000+次访问量支持。
Javax.ws微服务是利用云平台开发企业应用程序的最新技术，它是小型、轻量和过程驱动的组件。微服务适合设计可扩展、易于维护的应用程序。它可以使开发更容易，还能使资源得到最佳利用。
                <br>JeeSpring一直坚信：大众认同、大众参与、成就大众、大众分享的开发平台。
                <br>…………
            </blockquote>

            <hr>
        </div>
    </div>
      
    <div class="wrapper wrapper-content">
        <div class="row">
            <div class="col-sm-4">

                <div class="ibox float-e-margins">
                     <div class="ibox-title">
                        <h5>JeeSpring 技术特点</h5>
                        <div class="ibox-tools">
                            <a class="collapse-link">
                                <i class="fa fa-chevron-up"></i>
                            </a>
                           <!--  <a class="dropdown-toggle" data-toggle="dropdown" href="index.html#">
                                <i class="fa fa-wrench"></i>
                            </a> -->
                            <!-- <ul class="dropdown-menu dropdown-user">
                                <li><a href="index.html#">选项1</a>
                                </li>
                                <li><a href="index.html#">选项2</a>
                                </li>
                            </ul> -->
                            <a class="close-link">
                                <i class="fa fa-times"></i>
                            </a>
                        </div>
                    </div>
                    <div class="ibox-content">
                        <p style="color:#000;"> 分布式/集群(zookeeper)</p>
                        <span>在大规模服务化之前，应用可能只是通过RMI或Hessian等工具，简单的暴露和引用远程服务，通过配置服务的URL地址进行调用，通过F5等硬件进行负载均衡。</span>
                        <ol>
						<li>当服务越来越多时，服务URL配置管理变得非常困难，F5硬件负载均衡器的单点压力也越来越大。此时需要一个服务注册中心，动态的注册和发现服务，使服务的位置透明。并通过在消费方获取服务提供方地址列表，实现软负载均衡和Failover，降低对F5硬件负载均衡器的依赖，也能减少部分成本。</li>
						<li> 当进一步发展，服务间依赖关系变得错踪复杂，甚至分不清哪个应用要在哪个应用之前启动，架构师都不能完整的描述应用的架构关系。这时，需要自动画出应用间的依赖关系图，以帮助架构师理清理关系。</li>
						<li>接着，服务的调用量越来越大，服务的容量问题就暴露出来，这个服务需要多少机器支撑？什么时候该加机器？为了解决这些问题，第一步，要将服务现在每天的调用量，响应时间，都统计出来，作为容量规划的参考指标。其次，要可以动态调整权重，在线上，将某台机器的权重一直加大，并在加大的过程中记录响应时间的变化，直到响应时间到达阀值，记录此时的访问量，再以此访问量乘以机器数反推总容量。</li>
                        </ol>
                         <p style="color:#000;"> 微服务/集群(nignx)</p>
                          <ol>
						<li>支持REST风格远程调用（HTTP + JSON/XML)：基于非常成熟的JBoss RestEasy框架，在dubbo中实现了REST风格（HTTP + JSON/XML）的远程调用，以显著简化企业内部的跨语言交互，同时显著简化企业对外的Open API、无线API甚至AJAX服务端等等的开发。</li>
						<li>事实上，这个REST调用也使得Dubbo可以对当今特别流行的“微服务”架构提供基础性支持。 另外，REST调用也达到了比较高的性能，在基准测试下，HTTP + JSON与Dubbo 2.x默认的RPC协议（即TCP + Hessian2二进制序列化）之间只有1.5倍左右的差距，详见下文的基准测试报告。</li>
						<li>支持基于Kryo和FST的Java高效序列化实现：基于当今比较知名的Kryo和FST高性能序列化库，为Dubbo 默认的RPC协议添加新的序列化实现，并优化调整了其序列化体系，比较显著的提高了Dubbo RPC的性能，详见下图和文档中的基准测试报告。</li>
						<li>支持基于嵌入式Tomcat的HTTP remoting体系：基于嵌入式tomcat实现dubbo的 HTTP remoting体系（即dubbo-remoting-http），用以逐步取代Dubbo中旧版本的嵌入式Jetty，可以显著的提高REST等的远 程调用性能，并将Servlet API的支持从2.5升级到3.1。（注：除了REST，dubbo中的WebServices、Hessian、HTTP Invoker等协议都基于这个HTTP remoting体系）。</li>li>
                        </ol>
                        <p style="color:#000;"> ORM/Redis/Service仓库</p>
                        <ol>
						<li>RepositoryORM仓库,提供ORM接口和多种实现,可进行配置实现。</li>
						<li>RepositoryRedis仓库,提供Redis接口和多种实现,可进行配置实现。可以配置调用单机、redis、云redis对接。</li>
						<li>RepositoryService仓库,提供Service接口和多种实现,可进行配置实现。一个RepositoryService仓库就直接实现dubbo、微服务、基础服务器对接接口和实现。</li>
                        </ol>
                         <p style="color:#000;"> 技术选型</p>
                        <ol>
						<li>使用目前流行的多种web技术，包括spring mvc、mybatis。</li>
						<li>alibaba dubbo 分布式、微服务、集群、zookeper、nignx。</li>
						<li>代码生成（前端界面、底层代码、dubbo、微服务的生成）。</li>
						<li>RepositoryORM仓库,提供ORM接口和多种实现,可进行配置实现。</li>
						<li>RepositoryRedis仓库,提供Redis接口和多种实现,可进行配置实现。可以配置调用单机、redis、云redis对接。</li>
						<li>RepositoryService仓库,提供Service接口和多种实现,可进行配置实现。可以配置调用dubbo、微服务、基础服务器对接接口和实现。</li>
                        </ol>
                        <p style="color:#000;"> 代码生成器</p>
                        <ol>
						<li>spring mvc</li>
						<li>Redis</li>
						<li>mybatis</li>
						<li>alibaba dubbo</li>
						<li>微服务</li>
						<li>集群</li>
						<li>前端界面</li>
                        </ol>
                        <p style="color:#000;"> 如何交流、反馈、参与贡献？</p>
                        <ol>
						<li>JeeSpring官方QQ群：328910546</li>
						<li><a target="_blank" href="https://github.com/HuangBingGui/JeeRTD.git">GitHub</a>(点击访问)</li>
						<li><a target="_blank" href="http://git.oschina.net/guanshijiehnan/JeeRTD">开源中国</a>(点击访问)</li>
                        </ol>
                    </div>
                </div>
              
            </div>
            <div class="col-sm-4">
                <div class="ibox float-e-margins">
                     <div class="ibox-title">
                        <h5>升级日志</h5> <span class="label label-primary">K+</span>
                        <div class="ibox-tools">
                            <a class="collapse-link">
                                <i class="fa fa-chevron-up"></i>
                            </a>
                           <!--  <a class="dropdown-toggle" data-toggle="dropdown" href="index.html#">
                                <i class="fa fa-wrench"></i>
                            </a>
                            <ul class="dropdown-menu dropdown-user">
                                <li><a href="index.html#">选项1</a>
                                </li>
                                <li><a href="index.html#">选项2</a>
                                </li>
                            </ul>
                            <a class="close-link">
                                <i class="fa fa-times"></i>
                            </a> -->
                        </div>
                    </div>
                    <div class="ibox-content">
                        <div class="panel-body">
                            <div class="panel-group" id="version">
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h5 class="panel-title">
                                                <a data-toggle="collapse" data-parent="#version" href="#v1.0">v1.0</a><code class="pull-right">2017.06.15更新</code>
                                            </h5>
                                    </div>
                                    <div id="v2.0" class="panel-collapse collapse in">
                                        <div class="panel-body">
                                            <ol>
                                                <li>对dubbo服务、微服务接口、redis的测试完成</li>
                                                <li>优化了系统主题显示效果、统一界面风格</li>
                                            </ol>
                                        </div>
                                    </div>
                                </div>
                                  <!--  <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h5 class="panel-title">
                                                <a data-toggle="collapse" data-parent="#version" href="#v1.0">v1.9</a><code class="pull-right"></code>
                                            </h5>
                                    </div>
                                </div>
                                   <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h5 class="panel-title">
                                                <a data-toggle="collapse" data-parent="#version" href="#v1.0">v1.8</a><code class="pull-right"></code>
                                            </h5>
                                    </div>
                                </div>
                                   <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h5 class="panel-title">
                                                <a data-toggle="collapse" data-parent="#version" href="#v1.0">v1.7</a><code class="pull-right"></code>
                                            </h5>
                                    </div>
                                </div>
                                   <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h5 class="panel-title">
                                                <a data-toggle="collapse" data-parent="#version" href="#v1.0">v1.6</a><code class="pull-right"></code>
                                            </h5>
                                    </div>
                                </div>
                                   <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h5 class="panel-title">
                                                <a data-toggle="collapse" data-parent="#version" href="#v1.0">v1.5</a><code class="pull-right"></code>
                                            </h5>
                                    </div>
                                </div>
                                   <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h5 class="panel-title">
                                                <a data-toggle="collapse" data-parent="#version" href="#v1.0">v1.4</a><code class="pull-right"></code>
                                            </h5>
                                    </div>
                                </div>
                                   <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h5 class="panel-title">
                                                <a data-toggle="collapse" data-parent="#version" href="#v1.0">v1.3</a><code class="pull-right"></code>
                                            </h5>
                                    </div>
                                </div>
                                   <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h5 class="panel-title">
                                                <a data-toggle="collapse" data-parent="#version" href="#v1.0">v1.2</a><code class="pull-right"></code>
                                            </h5>
                                    </div>
                                </div>
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h5 class="panel-title">
                                                <a data-toggle="collapse" data-parent="#version" href="#v1.1">v1.1</a><code class="pull-right"></code>
                                            </h5>
                                    </div>
                                </div>
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h5 class="panel-title">
                                                <a data-toggle="collapse" data-parent="#version" href="#v1.0">v1.0</a><code class="pull-right"></code>
                                            </h5>
                                    </div>
                                </div> -->
                               
                </div>
            </div>
            </div>
            </div>
            </div>
            <div class="col-sm-4">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>商业授权 </h5>
                    </div>
                    <div class="ibox-content">
                        <p>JeeSpring是一款收费开源的快速开发平台，购买后您将获得以下内容</p>
                        <ol>
                            <li>源码(带注释)；</li>
                            <li>代码生成器；</li>
                            <li>开发者文档；</li>
                            <li>永久的免费升级服务；</li>
                            <li>授权许可；</li>
                            <li>付费二次开发服务；</li>
                            <li>……</li>
                        </ol>
                        <hr>
                    

                    </div>
                </div>
                  <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>联系信息</h5>

                    </div>
                    <div class="ibox-content">
                        <p><i class="fa fa-send-o"></i> 网址：<a href="http://www.jeespring.org" target="_blank">http://www.jeespring.org</a>
                        </p>
                        <p><i class="fa fa-qq"></i> QQ：
                        <a href="http://wpa.qq.com/msgrd?v=3&uin=516821420&site=qq&menu=yes" target="_blank">Suncos:516821420</a>
                        <a href="http://wpa.qq.com/msgrd?v=3&uin=357719949&site=qq&menu=yes" target="_blank">teacher kwan:357719949</a>
                        </p>
                        <p><i class="fa fa-qq"></i> <span>QQ群：JeeSpring官方开源群:328910546</span>
                        <p><i class="fa fa-weixin"></i> 微信：<a href="javascript:;">待填写</a>
                        </p>
                        <p><i class="fa fa-credit-card"></i> 支付宝：<a href="javascript:;" class="支付宝信息">待填写</a>
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>

</body>
</html>