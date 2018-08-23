<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="renderer" content="webkit">
	<meta http-equiv="x-ua-compatible" content="IE=7,9,10" >
    <title>${fns:getConfig('productName')} </title>

    <!-- 设置浏览器图标 -->
    <link rel="shortcut icon" href="../static/favicon.ico">

	<%@ include file="/WEB-INF/views/include/head.jsp"%>
	<script src="${ctxStatic}/common/inspinia.js?v=3.2.0"></script>
	<script src="${ctxStatic}/common/contabs.js"></script> 
    <meta name="keywords" content="jeespring快速开发平台">
    <meta name="description" content="jeespring，采用spring mvc+mybatis+shiro+bootstrap，集成代码生成器的快速开发平台">
    <script type="text/javascript">
	$(document).ready(function() {
        $("#logo").attr("src","../static/common/login/images/flat-avatar"+Math.floor(Math.random() * (4 - 1 + 1) + 1)+".png");

        $('#vid').hide();
        //var random=Math.floor(Math.random() * (4 - 1 + 1) + 1);
        var random=1;
        $("#vid").attr("src","../static/common/login/images/flat-avatar"+random+".mp4");
        setTimeout(function(){document.getElementById("vid").play();},1000);
        $('#vid').show(2000);

        $("#modifyPassword").click(function(){
            top.layer.open({
                type: 2,
                area: ['600px', '350px'],
                title:"修改密码",
                content: "/admin/sys/user/modifyPwd" ,
                btn: ['确定', '关闭'],
                yes: function(index, layero){
                    var body = top.layer.getChildFrame('body', index);
                    var inputForm = body.find('#inputForm');
                    var btn = body.find('#btnSubmit');
                    var top_iframe = top.getActiveTab().attr("name");//获取当前active的tab的iframe
                    inputForm.attr("target",top_iframe);//表单提交成功后，从服务器返回的url在当前tab中展示
                    inputForm.validate({
                        rules: {
                        },
                        messages: {
                            confirmNewPassword: {equalTo: "输入与上面相同的密码"}
                        },
                        submitHandler: function(form){
                            loading('正在提交，请稍等...');
                            form.submit();

                        },
                        errorContainer: "#messageBox",
                        errorPlacement: function(error, element) {
                            $("#messageBox").text("输入有误，请先更正。");
                            if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
                                error.appendTo(element.parent().parent());
                            } else {
                                error.insertAfter(element);
                            }
                        }
                    });
                    if(inputForm.valid()){
                        loading("正在提交，请稍等...");
                        inputForm.submit();
                        ////top.layer.close(index);//关闭对话框。
                    }else{
                        return;
                    }


                },
                cancel: function(index){
                }
            });
        });

		 if('${fns:getDictLabel(cookie.theme.value,'theme','默认主题')}' == '天蓝主题'){
			    // 蓝色主题
			        $("body").removeClass("skin-2");
			        $("body").removeClass("skin-3");
			        $("body").addClass("skin-1");
		 }else  if('${fns:getDictLabel(cookie.theme.value,'theme','默认主题')}' == '橙色主题'){
			    // 黄色主题
			        $("body").removeClass("skin-1");
			        $("body").removeClass("skin-2");
			        $("body").addClass("skin-3");
		 }else {
			 // 默认主题
			        $("body").removeClass("skin-2");
			        $("body").removeClass("skin-3");
			        $("body").removeClass("skin-1");
		 };
			// <c:if test="${tabmode eq '1'}"> 初始化页签
            /*var tabTitleHeight=40;
			$.fn.initJerichoTab({
                renderTo: '#right', uniqueId: 'jerichotab',
                contentCss: { 'height': $('#right').height() - tabTitleHeight },
                tabs: [], loadOnce: true, tabWidth: 110, titleHeight: tabTitleHeight
            });*/
            </c:if>
			// 绑定菜单单击事件
			$("#menu a.menu").click(function(){
				// 一级菜单焦点
				$("#menu li.menu").removeClass("active");
				$(this).parent().addClass("active");
				// 左侧区域隐藏
				if ($(this).attr("target") == "mainFrame"){
					$("#left,#openClose").hide();
					wSizeWidth();
					// <c:if test="${tabmode eq '1'}"> 隐藏页签
					$(".jericho_tab").hide();
					$("#mainFrame").show();//</c:if>
					return true;
				}
				// 左侧区域显示
				$("#left,#openClose").show();
				if(!$("#openClose").hasClass("close")){
					$("#openClose").click();
				}
				// 显示二级菜单
				var menuId = "#menu-" + $(this).attr("data-id");
				if ($(menuId).length > 0){
					$("#left .accordion").hide();
					$(menuId).show();
					// 初始化点击第一个二级菜单
					if (!$(menuId + " .accordion-body:first").hasClass('in')){
						$(menuId + " .accordion-heading:first a").click();
					}
					if (!$(menuId + " .accordion-body li:first ul:first").is(":visible")){
						$(menuId + " .accordion-body a:first i").click();
					}
					// 初始化点击第一个三级菜单
					$(menuId + " .accordion-body li:first li:first a:first i").click();
				}else{
					// 获取二级菜单数据
					$.get($(this).attr("data-href"), function(data){
						if (data.indexOf("id=\"loginForm\"") != -1){
							alert('未登录或登录超时。请重新登录，谢谢！');
							top.location = "${ctx}";
							return false;
						}
						$("#left .accordion").hide();
						$("#left").append(data);
						// 链接去掉虚框
						$(menuId + " a").bind("focus",function() {
							if(this.blur) {this.blur()};
						});
						// 二级标题
						$(menuId + " .accordion-heading a").click(function(){
							$(menuId + " .accordion-toggle i").removeClass('icon-chevron-down').addClass('icon-chevron-right');
							if(!$($(this).attr('data-href')).hasClass('in')){
								$(this).children("i").removeClass('icon-chevron-right').addClass('icon-chevron-down');
							}
						});
						// 二级内容
						$(menuId + " .accordion-body a").click(function(){
							$(menuId + " li").removeClass("active");
							$(menuId + " li i").removeClass("icon-white");
							$(this).parent().addClass("active");
							$(this).children("i").addClass("icon-white");
						});
						// 展现三级
						$(menuId + " .accordion-inner a").click(function(){
							var href = $(this).attr("data-href");
							if($(href).length > 0){
								$(href).toggle().parent().toggle();
								return false;
							}
							// <c:if test="${tabmode eq '1'}"> 打开显示页签
							return addTab($(this)); // </c:if>
						});
						// 默认选中第一个菜单
						$(menuId + " .accordion-body a:first i").click();
						$(menuId + " .accordion-body li:first li:first a:first i").click();
					});
				}
				// 大小宽度调整
				wSizeWidth();
				return false;
			});
			// 初始化点击第一个一级菜单
			$("#menu a.menu:first span").click();
			// <c:if test="${tabmode eq '1'}"> 下拉菜单以选项卡方式打开
			$("#userInfo .dropdown-menu a").mouseup(function(){
				return addTab($(this), true);
			});// </c:if>
			// 鼠标移动到边界自动弹出左侧菜单
			$("#openClose").mouseover(function(){
				if($(this).hasClass("open")){
					$(this).click();
				}
			});
			// 获取通知数目  <c:set var="oaNotifyRemindInterval" value="${fns:getConfig('oa.notify.remind.interval')}"/>
			function getNotifyNum(){
				$.get("${ctx}/oa/oaNotify/self/count?updateSession=0&t="+new Date().getTime(),function(data){
					var num = parseFloat(data);
					if (num > 0){
						$("#notifyNum,#notifyNum2").show().html("("+num+")");
					}else{
						$("#notifyNum,#notifyNum2").hide()
					}
				});
			}
			getNotifyNum(); //<c:if test="${oaNotifyRemindInterval ne '' && oaNotifyRemindInterval ne '0'}">
			setInterval(getNotifyNum, ${oaNotifyRemindInterval}); //</c:if>
		});
		// <c:if test="${tabmode eq '1'}"> 添加一个页签
		function addTab($this, refresh){
			$(".jericho_tab").show();
			$("#mainFrame").hide();
			$.fn.jerichoTab.addTab({
                tabFirer: $this,
                title: $this.text(),
                closeable: true,
                data: {
                    dataType: 'iframe',
                    dataLink: $this.attr('href')
                }
            }).loadData(refresh);
			return false;
		}// </c:if>
	</script>

</head>

<body class="fixed-sidebar full-height-layout gray-bg">
    <div id="wrapper">
        <!--左侧导航开始-->
        <nav class="navbar-default navbar-static-side" role="navigation"  style="border-top: 1px solid #e7eaec !important;">
            <div class="nav-close"><i class="fa fa-times-circle"></i>
            </div>
            <div class="sidebar-collapse">
                <ul class="nav" id="side-menu">
                    <li class="nav-header">
                        <video id="vid" width="100%" height="100%" onended="setTimeout(function(){$('#vid').hide(3000)},3000);" autoplay="autoplay" muted="muted" autobuffer="autobuffer" preload="auto" oncontextmenu="return false" data-hasaudio=""
                               style="background-color: white;opacity: 1;visibility: visible;position: absolute;top: 0px;bottom: 0px;left: 0px;right: 0px;height: 100%;width: 100%;object-fit:cover;object-position: center center;"
                               src="../static/common/login/images/flat-avatar1.mp4"></video>
                        <div class="dropdown profile-element">
                            <span>
                                <img alt="image" class="img-circle" style="height:64px;width:64px;" src="${fns:getUser().photo }" /></span>
                            <a data-toggle="dropdown" class="dropdown-toggle" href="#">
                                <span class="clear">
                               <span class="block m-t-xs"><strong class="font-bold">${fns:getUser().name}</strong></span>
                               <span class="text-muted text-xs block">${fns:getUser().roleNames}<b class="caret"></b></span>
                                </span>
                            </a>
                            <ul class="dropdown-menu animated fadeInRight m-t-xs">
                                <li><a class="J_menuItem" href="${ctx}/sys/user/imageEdit">修改头像</a>
                                </li>
                                <li><a class="J_menuItem" href="${ctx }/sys/user/info">个人资料</a>
                                </li>
                                <li><a class="J_menuItem" href="contacts.html">联系我们</a>
                                </li>
                                <li><a class="J_menuItem" href="${ctx }/iim/mailBox/list">信箱</a>
                                </li>
                                <li><a href="${ctx}/logout">安全退出</a>
                                </li>
                            </ul>
                        </div>
                        <div class="logo-element">云
                        </div>
                    </li>
                  <t:menu  menu="${fns:getTopMenu()}"></t:menu>
                </ul>
            </div>
        </nav>
        <!--左侧导航结束-->
        <!--右侧部分开始-->
        <div id="page-wrapper" class="gray-bg dashbard-1">
            <div class="row border-bottom">
                <nav class="navbar navbar-static-top" role="navigation" style="margin-bottom: 0">
                    <div class="navbar-header">
                        <!--a class="navbar-minimalize minimalize-styl-2 btn btn-success " href="#"><i class="fa fa-bars"></i> </a-->
                        <a href="#" style="float: left;">
                            <img id="logo" alt="image" class="img-circle" style="height: 60px;width:60px;margin-left: 10px;border: 2px solid #e7eaec;" src="/static/common/login/images/flat-avatar.png">
                        </a>
                        <form role="search" class="navbar-form-custom" method="post" action="search_results.html">
                            <div class="form-group">
                                <input type="text" placeholder="${fns:getConfig('productName')}-${systemMode}-${version}" readonly="true" enabled="false" class="form-control" name="top-search" id="top-search" style="font-weight:700;font-size:20px;width: 350px;">
                            </div>
                        </form>
                    </div>
                    <ul class="nav navbar-top-links navbar-right">
                        <li class="dropdown">
                            <a class="dropdown-toggle count-info" data-toggle="dropdown" href="#">
                                <i class="fa fa-envelope"></i> <span class="label label-warning">0${noReadCount}</span>
                            </a>
                            <ul class="dropdown-menu dropdown-messages">
                            	 <c:forEach items="${mailPage.list}" var="mailBox">
	                                <li class="m-t-xs">
	                                    <div class="dropdown-messages-box">
	                                   
	                                        <a  href="#" onclick='top.openTab("${ctx}/iim/contact/index?name=${mailBox.sender.name }","通讯录", false)' class="pull-left">
	                                            <img alt="image" class="img-circle" src="${mailBox.sender.photo }">
	                                        </a>
	                                        <div class="media-body">
	                                            <small class="pull-right">${fns:getTime(mailBox.sendtime)}前</small>
	                                            <strong>${mailBox.sender.name }</strong>
	                                            <a class="J_menuItem" href="${ctx}/iim/mailBox/detail?id=${mailBox.id}"> ${fns:abbr(mailBox.mail.title,50)}</a>
	                                            <br>
	                                            <a class="J_menuItem" href="${ctx}/iim/mailBox/detail?id=${mailBox.id}">
	                                             ${mailBox.mail.overview}
	                                            </a>
	                                            <br>
	                                            <small class="text-muted">
	                                            <fmt:formatDate value="${mailBox.sendtime}" pattern="yyyy-MM-dd HH:mm:ss"/></small>
	                                        </div>
	                                    </div>
	                                </li>
	                                <li class="divider"></li>
                                </c:forEach>
                                <li>
                                    <div class="text-center link-block">
                                        <a class="J_menuItem" href="${ctx}/iim/mailBox/list?orderBy=sendtime desc">
                                            <i class="fa fa-envelope"></i> <strong> 查看所有邮件</strong>
                                        </a>
                                    </div>
                                </li>
                            </ul>
                        </li>
                        <li class="dropdown">
                            <a class="dropdown-toggle count-info" data-toggle="dropdown" href="#">
                                <i class="fa fa-bell"></i> <span class="label label-primary">0${count }</span>
                            </a>
                            <ul class="dropdown-menu dropdown-alerts">
                                <li>
                                
                                <c:forEach items="${page.list}" var="oaNotify">
                         
                                        <div>
                                        	   <a class="J_menuItem" href="${ctx}/oa/oaNotify/view?id=${oaNotify.id}&">
                                            	<i class="fa fa-envelope fa-fw"></i> ${fns:abbr(oaNotify.title,50)}
                                               </a>
                                            <span class="pull-right text-muted small">${fns:getTime(oaNotify.updateDate)}前</span>
                                        </div>
                                 
								</c:forEach>
                                   
                                </li>
                                <li class="divider"></li>
                                <li>
                                    <div class="text-center link-block">
                                       您有${count }条未读消息 <a class="J_menuItem" href="${ctx }/oa/oaNotify/self ">
                                            <strong>查看所有 </strong>
                                            <i class="fa fa-angle-right"></i>
                                        </a>
                                    </div>
                                </li>
                            </ul>
                        </li>
                        <li class="dropdown user-menu mr5">
                            <a href="javascript:" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" aria-expanded="false" style="padding: 10px 10px;">
                                <img src="${fns:getUser().photo }" class="img-circle" style="height:30px;width:30px;"  class="user-image">
                                <span class="hidden-xs">${fns:getUser().name}</span>
                            </a>
                            <ul class="dropdown-menu">
                                <li class="mt5">
                                    <a id="userInfo" href="#" onclick="top.openTab('admin/sys/user/info','个人中心', false)">
                                        <i class="fa fa-user"></i> 个人中心</a>
                                </li>
                                <li>
                                    <a id="modifyPassword" href="javascript:" class="addTabPage">
                                        <i class="fa fa-key"></i> 修改密码</a>
                                </li>
                                <li class="divider"></li>
                                <li><a href="#" onclick="toggleFullScreen(this)" ><i class="fa fa-arrows-alt"></i> 全屏</a></li>
                                <li><a href="#" onclick="cancleRedis()"><i class="fa fa-qrcode"></i> <span id="cancleRedis">清除缓存 </span></a></li>
                                <li><a href="#" onclick="cancleShiroRedis()"><i class="fa fa-qrcode"></i> <span id="cancleShiroRedis">清除单点登录缓存 </span></a></li>
                                <li><a href="#" ><i class="fa fa-qrcode"></i> <span id="userOnlineAmount">在线人数 </span></a></li>
                                <li><a href="#" ><i class="fa fa-qrcode"></i> <span id="getApiTimeLimi">访问次数 </span></a></li>
                                <li><a href="#" ><i class="fa fa-qrcode"></i> <span id="getApiTime">调用次数 </span></a></li>
                                <li><a href="#" ><i class="fa fa-qrcode"></i> <span id="getExpire">缓存有效时间 </span></a></li>
                                <li><a href="#" ><i class="fa fa-qrcode"></i> <span id="getExpireShiro">单点登录缓存有效时间 </span></a></li>
                                <li class="divider"></li>
                                <li>
                                    <a href="/admin/logout">
                                        <i class="fa fa-sign-out"></i> 退出登录</a>
                                </li>
                                <li class="divider"></li>
                                <li class="dropdown-header mb5">系统切换：</li>
                                <li>
                                    <a href="/admin">
                                        <i class="fa fa-check-circle-o"></i> 主导航菜单
                                    </a>
                                </li>
                                <li class="mt10"></li>
                            </ul>
                        </li>

                        <li class="divider"></li>
                      <!-- 国际化功能预留接口 -->
                       <%--  <li class="dropdown">
							<a id="lang-switch" class="lang-selector dropdown-toggle" href="#" data-toggle="dropdown" aria-expanded="true">
								<span class="lang-selected">
										<img  class="lang-flag" src="${ctxStatic}/common/img/china.png" alt="中国">
										<span class="lang-id">中国</span>
										<span class="lang-name">中文</span>
									</span>
							</a>

							<!--Language selector menu-->
							<ul class="head-list dropdown-menu with-arrow">
								<li>
									<!--English-->
									<a class="lang-select">
										<img class="lang-flag" src="${ctxStatic}/common/img/china.png" alt="中国">
										<span class="lang-id">中国</span>
										<span class="lang-name">中文</span>
									</a>
								</li>
								<li>
									<!--English-->
									<a class="lang-select">
										<img class="lang-flag" src="${ctxStatic}/common/img/united-kingdom.png" alt="English">
										<span class="lang-id">EN</span>
										<span class="lang-name">English</span>
									</a>
								</li>
								<li>
									<!--France-->
									<a class="lang-select">
										<img class="lang-flag" src="${ctxStatic}/common/img/france.png" alt="France">
										<span class="lang-id">FR</span>
										<span class="lang-name">Français</span>
									</a>
								</li>
								<li>
									<!--Germany-->
									<a class="lang-select">
										<img class="lang-flag" src="${ctxStatic}/common/img/germany.png" alt="Germany">
										<span class="lang-id">DE</span>
										<span class="lang-name">Deutsch</span>
									</a>
								</li>
								<li>
									<!--Italy-->
									<a class="lang-select">
										<img class="lang-flag" src="${ctxStatic}/common/img/italy.png" alt="Italy">
										<span class="lang-id">IT</span>
										<span class="lang-name">Italiano</span>
									</a>
								</li>
								<li>
									<!--Spain-->
									<a class="lang-select">
										<img class="lang-flag" src="${ctxStatic}/common/img/spain.png" alt="Spain">
										<span class="lang-id">ES</span>
										<span class="lang-name">Español</span>
									</a>
								</li>
							</ul>
						</li> --%>
                    </ul>
                </nav>
            </div>
            <div class="row content-tabs">
                <button class="roll-nav roll-left J_tabLeft navbar-minimalize">
                    <a href="#" style="background-color: transparent;"><i class="fa fa-bars"></i> </a>
                    <!--i class="fa fa-home"></i-->
                </button>
                <nav class="page-tabs J_menuTabs">
                    <div class="page-tabs-content">
                        <a href="javascript:;" class="active J_menuTab" data-id="${ctx}/home">
                            首页
                        </a>
                    </div>
                </nav>
                <button class="roll-nav roll-right J_tabRight"  style="display: none;"><i class="fa fa-forward"></i>
                </button>
                <div class="btn-group roll-nav roll-right" title="关闭操作" style="width:40px">
                    <button class="dropdown J_tabClose"  data-toggle="dropdown"  style="width:40px"><span class="caret"></span>

                    </button>
                    <ul role="menu" class="dropdown-menu dropdown-menu-right">
                        <li class="J_tabShowActive"><a>定位当前选项卡</a>
                        </li>
                        <li class="divider"></li>
                        <li class="J_tabCloseAll"><a>关闭全部选项卡</a>
                        </li>
                        <li class="J_tabCloseOther"><a>关闭其他选项卡</a>
                        </li>
                    </ul>
                </div>
                <a href="${ctx}/logout" class="roll-nav roll-right J_tabExit" title="退出"><i class="fa fa fa-sign-out"></i> </a>
            </div>
            <div class="row J_mainContent" id="content-main">
                <iframe class="J_iframe" name="iframe0" width="100%" height="100%" src="${ctx}/home" frameborder="0" data-id="${ctx}/home" seamless></iframe>
            </div>
            <div class="footer">
                <div class="pull-left"><a href="http://www.jeespring.org"></a> © 2018 All Rights Reserved. JeeSpring</div>
            </div>
        </div>
        <!--右侧部分结束-->
       
       
    </div>
    <c:if test="${skinSetttings eq 'true'}">
    <%@ include file="/static/common/skin-config.jsp"%>
    </c:if>
</body>

<!-- 语言切换草插件，为国际化功能预留插件 -->
<script type="text/javascript">
$(document).ready(function(){
	$("a.lang-select").click(function(){
		$(".lang-selected").find(".lang-flag").attr("src",$(this).find(".lang-flag").attr("src"));
		$(".lang-selected").find(".lang-flag").attr("alt",$(this).find(".lang-flag").attr("alt"));
		$(".lang-selected").find(".lang-id").text($(this).find(".lang-id").text());
		$(".lang-selected").find(".lang-name").text($(this).find(".lang-name").text());
	});
    getCount();
});

function getCount(){
    $.ajax({
        type: "GET",
        url: "/rest/redis/getCount",
        success: function(data){
            data=eval(data);
            $("#cancleRedis").html("清除缓存("+data.RESULT+")");
        }
    });
    $.ajax({
        type: "GET",
        url: "/rest/redis/getCountShiro",
        success: function(data){
            data=eval(data);
            $("#cancleShiroRedis").html("清除单点登录缓存("+data.RESULT+")");
        }
    });
    $.ajax({
        type: "GET",
        url: "/rest/redis/getExpire",
        success: function(data){
            data=eval(data);
            $("#getExpire").html("缓存有效时间("+data.RESULT+")");
        }
    });
    $.ajax({
        type: "GET",
        url: "/rest/redis/getExpireShiro",
        success: function(data){
            data=eval(data);
            $("#getExpireShiro").html("单点登录缓存有效时间("+data.RESULT+")");
        }
    });
    $.ajax({
        type: "GET",
        url: "/rest/oauth/getApiTimeLimi",
        success: function(data){
            data=eval(data);
            $("#getApiTimeLimi").html("访问次数("+data.MESSAGE+")");
        }
    });
    $.ajax({
        type: "GET",
        url: "/rest/oauth/getApiTime",
        success: function(data){
            data=eval(data);
            $("#getApiTime").html("调用次数("+data.MESSAGE+")");
        }
    });
    $.ajax({
        type: "GET",
        url: "/rest/oauth/userOnlineAmount",
        success: function(data){
            data=eval(data);
            $("#userOnlineAmount").html("在线人数("+data.MESSAGE+")");
        }
    });
}
// 清除缓存
function cancleRedis() {
    $.ajax({url:"/rest/redis/removePattern",async:false});
    getCount()
}
function cancleShiroRedis() {
    $.ajax({url:"/rest/redis/removePatternShiroRedis",async:false});
    getCount()
}

</script>

<c:if test="${IMEnable eq 'true'}"> 初始化页签
    <!-- 即时聊天插件 -->
    <link href="${ctxStatic}/layer-v2.0/layim/layim.css" type="text/css" rel="stylesheet"/>
    <script type="text/javascript">
        var currentId = '${fns:getUser().loginName}';
        var currentName = '${fns:getUser().name}';
        var currentFace ='${fns:getUser().photo}';
        var url="${ctx}";
        var wsServer = 'ws://'+window.document.domain+':8668';

    </script>
    <script src="${ctxStatic}/layer-v2.0/layim/layer.min.js"></script>
    <script src="${ctxStatic}/layer-v2.0/layim/layim.js"></script>
</c:if>

</html>