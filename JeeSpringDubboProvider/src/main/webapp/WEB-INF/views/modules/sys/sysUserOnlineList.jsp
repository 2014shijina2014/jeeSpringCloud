<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>在线用户记录管理</title>
	<meta name="decorator" content="default"/>
	<%@ include file="/WEB-INF/views/include/head.jsp"%>
	<%@ include file="/WEB-INF/views/include/echarts.jsp"%>
	<script src="/static/views/modules/sys//sysUserOnlineList.js" type="text/javascript"></script>
	<link href="/static/views/modules/sys//sysUserOnlineList.css" rel="stylesheet" />
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content content-background">
	<div class="ibox">
    <div class="ibox-content content">
	<sys:message content="${message}"/>
	
	<!--查询条件-->
	<div class="row">
	<div class="col-sm-12">
	<form:form id="searchForm" modelAttribute="sysUserOnline" action="${ctx}/sys/sysUserOnline/" method="post" class="form-inline">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
		<div class="form-group">
			<span>登录账号：</span>
				<form:input path="loginName" htmlEscape="false" maxlength="50"  class=" form-control input-sm"/>
			<span>部门名称：</span>
				<form:input path="deptName" htmlEscape="false" maxlength="50"  class=" form-control input-sm"/>
			<span>登录IP地址：</span>
				<form:input path="ipaddr" htmlEscape="false" maxlength="50"  class=" form-control input-sm"/>
			<span>登录地点：</span>
				<form:input path="loginLocation" htmlEscape="false" maxlength="255"  class=" form-control input-sm"/>
			<span>浏览器类型：</span>
				<form:input path="browser" htmlEscape="false" maxlength="50"  class=" form-control input-sm"/>
			<span>操作系统：</span>
				<form:input path="os" htmlEscape="false" maxlength="50"  class=" form-control input-sm"/>
			<span>在线状态on_line在线off_line离线：</span>
				<form:radiobuttons class="i-checks" path="status" items="${fns:getDictList('on_line_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
			<span>session创建时间：</span>
				<input id="beginStartTimestsamp" name="beginStartTimestsamp" type="text" maxlength="20" class="laydate-icon form-control layer-date input-sm"
					value="<fmt:formatDate value="${sysUserOnline.beginStartTimestsamp}" pattern="yyyy-MM-dd HH:mm:ss"/>"/> - 
				<input id="endStartTimestsamp" name="endStartTimestsamp" type="text" maxlength="20" class="laydate-icon form-control layer-date input-sm"
					value="<fmt:formatDate value="${sysUserOnline.endStartTimestsamp}" pattern="yyyy-MM-dd HH:mm:ss"/>"/>
			<span>session最后访问时间：</span>
				<input id="beginLastAccessTime" name="beginLastAccessTime" type="text" maxlength="20" class="laydate-icon form-control layer-date input-sm"
					value="<fmt:formatDate value="${sysUserOnline.beginLastAccessTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"/> - 
				<input id="endLastAccessTime" name="endLastAccessTime" type="text" maxlength="20" class="laydate-icon form-control layer-date input-sm"
					value="<fmt:formatDate value="${sysUserOnline.endLastAccessTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"/>
			<span>超时时间，单位为分钟：</span>
				<form:input path="expireTime" htmlEscape="false" maxlength="5"  class=" form-control input-sm"/>
			<span>创建者：</span>
				<form:input path="createBy.id" htmlEscape="false" maxlength="64"  class=" form-control input-sm"/>
			<span>创建时间：</span>
				<input id="beginCreateDate" name="beginCreateDate" type="text" maxlength="20" class="laydate-icon form-control layer-date input-sm"
					value="<fmt:formatDate value="${sysUserOnline.beginCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"/> - 
				<input id="endCreateDate" name="endCreateDate" type="text" maxlength="20" class="laydate-icon form-control layer-date input-sm"
					value="<fmt:formatDate value="${sysUserOnline.endCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"/>
			<span>更新者：</span>
				<form:input path="updateBy.id" htmlEscape="false" maxlength="64"  class=" form-control input-sm"/>
		 </div>	
	</form:form>
	<br/>
	</div>
	</div>
	
	<!-- 工具栏 -->
	<div class="row">
	<div class="col-sm-12">
		<div class="pull-left">
			<button  class="btn btn-success btn-sm " onclick="$('#searchForm').toggle();$('.fa-chevron').toggle();"  title="检索">
				<i class="fa-chevron fa fa-chevron-up"></i><i class="fa-chevron fa fa-chevron-down" style="display:none"></i> 检索
			</button>
			<button  class="btn btn-success btn-sm " onclick="$('#total').toggle();$('.fa-chevron').toggle();"  title="统计">
				<i class="fa-chevron fa fa-chevron-up"></i><i class="fa-chevron fa fa-chevron-down" style="display:none"></i> 统计
			</button>
			<button  class="btn btn-success btn-sm " onclick="search()" title="查询"><i class="fa fa-search"></i> 查询</button>
			<shiro:hasPermission name="sys:sysUserOnline:add">
				<table:addRow url="${ctx}/sys/sysUserOnline/form" title="在线用户记录"></table:addRow><!-- 增加按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="sys:sysUserOnline:edit">
			    <table:editRow url="${ctx}/sys/sysUserOnline/form" title="在线用户记录" id="contentTable"></table:editRow><!-- 编辑按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="sys:sysUserOnline:del">
				<table:delRow url="${ctx}/sys/sysUserOnline/deleteAll" id="contentTable"></table:delRow><!-- 删除按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="sys:sysUserOnline:import">
				<table:importExcel url="${ctx}/sys/sysUserOnline/import"></table:importExcel><!-- 导入按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="sys:sysUserOnline:export">
	       		<table:exportExcel url="${ctx}/sys/sysUserOnline/export"></table:exportExcel><!-- 导出按钮 -->
	       	</shiro:hasPermission>
	        <button class="btn btn-white btn-sm " data-toggle="tooltip" data-placement="left" onclick="sortOrRefresh()" title="刷新"><i class="glyphicon glyphicon-repeat"></i> 刷新</button>
	       	<button  class="btn btn-white btn-sm " onclick="reset()"  title="重置"><i class="fa fa-refresh"></i> 重置</button>
		</div>
		<div class="pull-right">
			<button class="btn btn-white btn-sm " data-toggle="tooltip" data-placement="left" onclick="top.openTab('${ctx}/sys/sysUserOnline/listVue','Vue在线用户记录', false)" title="Vue.js"><i class="glyphicon glyphicon-repeat"></i> Vue.js</button>
			<shiro:hasPermission name="sys:sysUserOnline:total">
			<button class="btn btn-white btn-sm " data-toggle="tooltip" data-placement="left" onclick="top.openTab('${ctx}/sys/sysUserOnline/total','统计在线用户记录', false)" title="统计图表"><i class="glyphicon glyphicon-repeat"></i> 统计图表</button>
			<button class="btn btn-white btn-sm " data-toggle="tooltip" data-placement="left" onclick="top.openTab('${ctx}/sys/sysUserOnline/totalMap','统计在线用户记录', false)" title="统计地图"><i class="glyphicon glyphicon-repeat"></i> 统计地图</button>
			</shiro:hasPermission>
			<button class="btn btn-success " type="button" name="toggle" title="切换" onclick="$('.table').toggle()"><i class="glyphicon glyphicon-list-alt icon-list-alt"></i></button>
			<div class="btn-group" title="其他">
				<button class="btn btn-success btn-sm dropdown-toggle" data-toggle="dropdown" type="button" aria-expanded="false">
					<i class="glyphicon glyphicon-th icon-th"></i>
					<span class="caret"></span>
				</button>
				<ul class="dropdown-menu" role="menu">
					<li data-type="放大"><a href="javascript:void(0)" onclick="$('body').css({zoom:Number($('body').css('zoom'))+0.1})">放大</a></li>
					<li data-type="缩小"><a href="javascript:void(0)" onclick="$('body').css({zoom:$('body').css('zoom')-0.1})">缩小</a></li>
				</ul>
			</div>
		</div>
	</div>
	</div>

	<!-- 表格 -->
	<div class="table" style="display:none">
		<c:forEach items="${page.list}" var="sysUserOnline">
			<div style="border: 1px solid #e7eaec;padding: 8px;" class="row">
				<div>
				<input type="checkbox" id="${sysUserOnline.id}"
					loginName="${sysUserOnline.loginName}"
					deptName="${sysUserOnline.deptName}"
					ipaddr="${sysUserOnline.ipaddr}"
					loginLocation="${sysUserOnline.loginLocation}"
					browser="${sysUserOnline.browser}"
					os="${sysUserOnline.os}"
					status="${sysUserOnline.status}"
				class="i-checks">
				</div>
				<div class="col-xs-6 col-sm-4 col-md-3 col-lg-2">
				登录账号:
				<a  href="#" onclick="openDialogView('查看在线用户记录', '${ctx}/sys/sysUserOnline/form?id=${sysUserOnline.id}','800px', '500px')">
					${sysUserOnline.loginName}
				</a></span>
						</div>
				<div class="col-xs-6 col-sm-4 col-md-3 col-lg-2">
				部门名称:
				
					${sysUserOnline.deptName}
				</span>
						</div>
				<div class="col-xs-6 col-sm-4 col-md-3 col-lg-2">
				登录IP地址:
				
					${sysUserOnline.ipaddr}
				</span>
						</div>
				<div class="col-xs-6 col-sm-4 col-md-3 col-lg-2">
				登录地点:
				
					${sysUserOnline.loginLocation}
				</span>
						</div>
				<div class="col-xs-6 col-sm-4 col-md-3 col-lg-2">
				浏览器类型:
				
					${sysUserOnline.browser}
				</span>
						</div>
				<div class="col-xs-6 col-sm-4 col-md-3 col-lg-2">
				操作系统:
				
					${sysUserOnline.os}
				</span>
						</div>
				<div class="col-xs-6 col-sm-4 col-md-3 col-lg-2">
				在线状态on_line在线off_line离线:
				
					${fns:getDictLabel(sysUserOnline.status, 'on_line_status', '')}
				</span>
						</div>
				<div class="col-xs-6 col-sm-4 col-md-3 col-lg-2">
				session创建时间:
				
					<fmt:formatDate value="${sysUserOnline.startTimestsamp}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</span>
						</div>
				<div class="col-xs-6 col-sm-4 col-md-3 col-lg-2">
				更新时间:
				
					<fmt:formatDate value="${sysUserOnline.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</span>
						</div>
				<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
					<shiro:hasPermission name="sys:sysUserOnline:view">
						<a href="#" onclick="openDialogView('查看在线用户记录', '${ctx}/sys/sysUserOnline/form?id=${sysUserOnline.id}&action=view','800px', '500px')" class="btn btn-info btn-sm" title="查看"><i class="fa fa-search-plus"></i>查看</a>
					</shiro:hasPermission>
					<shiro:hasPermission name="sys:sysUserOnline:edit">
    					<a href="#" onclick="openDialog('修改在线用户记录', '${ctx}/sys/sysUserOnline/form?id=${sysUserOnline.id}','800px', '500px')" class="btn btn-success btn-sm" title="修改"><i class="fa fa-edit"></i>修改</a>
    				</shiro:hasPermission>
					<shiro:hasPermission name="sys:sysUserOnline:edit">
    					<a href="#" onclick="top.openTab('${ctx}/sys/sysUserOnline/form?id=${sysUserOnline.id}','修改在线用户记录', false)" title="修改" class="btn btn-success btn-sm" title="修改(页签)"><i class="fa fa-edit"></i>修改(页签)</a>
    				</shiro:hasPermission>
    				<shiro:hasPermission name="sys:sysUserOnline:edit">
    					<a href="#" onclick="top.openTab('${ctx}/sys/sysUserOnline/form?id=${sysUserOnline.id}&ViewFormType=FormTwo','修改在线用户记录', false)" title="修改2" class="btn btn-success btn-sm" title="修改(页签)2"><i class="fa fa-edit"></i>修改(页签)2</a>
    				</shiro:hasPermission>
    				<shiro:hasPermission name="sys:sysUserOnline:del">
						<a href="${ctx}/sys/sysUserOnline/delete?id=${sysUserOnline.id}" onclick="return confirmx('确认要删除该在线用户记录吗？', this.href)"   class="btn btn-danger btn-sm"  title="删除"><i class="fa fa-trash"></i>删除</a>
					</shiro:hasPermission>
				</div>
			</div>
		</c:forEach>
	</div>

	<!-- 表格 -->
	<table id="contentTable" class="table table-hover table-condensed dataTables-example dataTable">
		<thead>
			<tr>
				<th> <input type="checkbox" class="i-checks"></th>
				<th  class="sort-column loginName ">登录账号</th>
				<th  class="sort-column deptName ">部门名称</th>
				<th  class="sort-column ipaddr ">登录IP地址</th>
				<th  class="sort-column loginLocation hidden-xs">登录地点</th>
				<th  class="sort-column browser hidden-xs">浏览器类型</th>
				<th  class="sort-column os hidden-xs">操作系统</th>
				<th  class="sort-column status hidden-xs">在线状态on_line在线off_line离线</th>
				<th  class="sort-column startTimestsamp hidden-xs">session创建时间</th>
				<th  class="sort-column updateDate hidden-xs">更新时间</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="sysUserOnline">
			<tr>
				<td>
				<input type="checkbox" id="${sysUserOnline.id}"
					loginName="${sysUserOnline.loginName}"
					deptName="${sysUserOnline.deptName}"
					ipaddr="${sysUserOnline.ipaddr}"
					loginLocation="${sysUserOnline.loginLocation}"
					browser="${sysUserOnline.browser}"
					os="${sysUserOnline.os}"
					status="${sysUserOnline.status}"
				class="i-checks"></td>
				<td class=""><a  href="#" onclick="openDialogView('查看在线用户记录', '${ctx}/sys/sysUserOnline/form?id=${sysUserOnline.id}&action=view','800px', '500px')">
					${sysUserOnline.loginName}
				</a></td>
				<td class="">
					${sysUserOnline.deptName}
				</td>
				<td class="">
					${sysUserOnline.ipaddr}
				</td>
				<td class="hidden-xs">
					${sysUserOnline.loginLocation}
				</td>
				<td class="hidden-xs">
					${sysUserOnline.browser}
				</td>
				<td class="hidden-xs">
					${sysUserOnline.os}
				</td>
				<td class="hidden-xs">
					${fns:getDictLabel(sysUserOnline.status, 'on_line_status', '')}
				</td>
				<td class="hidden-xs">
					<fmt:formatDate value="${sysUserOnline.startTimestsamp}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td class="hidden-xs">
					<fmt:formatDate value="${sysUserOnline.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					<shiro:hasPermission name="sys:sysUserOnline:view">
						<a href="#" onclick="openDialogView('查看在线用户记录', '${ctx}/sys/sysUserOnline/form?id=${sysUserOnline.id}&action=view','800px', '500px')" class="btn btn-info btn-sm" title="查看"><i class="fa fa-search-plus"></i>查看</a>
					</shiro:hasPermission>
					<shiro:hasPermission name="sys:sysUserOnline:edit">
    					<!--a href="#" onclick="openDialog('修改在线用户记录', '${ctx}/sys/sysUserOnline/form?id=${sysUserOnline.id}','800px', '500px',null,true)" class="btn btn-success btn-sm" title="修改(弹窗)"><i class="fa fa-edit"></i>修改(弹窗)</a-->
    				</shiro:hasPermission>
    				 <shiro:hasPermission name="sys:sysUserOnline:edit">
    					<a href="${ctx}/sys/sysUserOnline/form?id=${sysUserOnline.id}" title="修改" class="btn btn-success btn-sm" title="修改"><i class="fa fa-edit"></i>修改</a>
    				</shiro:hasPermission>
    				<shiro:hasPermission name="sys:sysUserOnline:edit">
    					<!--a href="#" onclick="top.openTab('${ctx}/sys/sysUserOnline/form?id=${sysUserOnline.id}','修改在线用户记录', false)" title="修改" class="btn btn-success btn-sm" title="修改(页签)"><i class="fa fa-edit"></i>修改(页签)</a-->
    				</shiro:hasPermission>
    				<shiro:hasPermission name="sys:sysUserOnline:edit">
    					<!--a href="#" onclick="top.openTab('${ctx}/sys/sysUserOnline/form?id=${sysUserOnline.id}&ViewFormType=FormTwo','修改在线用户记录', false)" title="修改2" class="btn btn-success btn-sm" title="修改(页签)2"><i class="fa fa-edit"></i>修改(页签)2</a-->
    				</shiro:hasPermission>
    				<shiro:hasPermission name="sys:sysUserOnline:del">
						<a href="${ctx}/sys/sysUserOnline/delete?id=${sysUserOnline.id}" onclick="return confirmx('确认要删除该在线用户记录吗？', this.href)"   class="btn btn-danger btn-sm" title="删除"><i class="fa fa-trash"></i>删除</a>
					</shiro:hasPermission>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
		<!-- 分页代码 -->
	<table:page page="${page}"></table:page>
	<br/>
		<!-- 统计 -->
	<div class="row" id="total" style="margin-top: 10px;">
		<div class="col-sm-12 echartsEval">
			<h4>合计：${sumTotalCount}行;
			</h4>
			<div id="pie"  class="main000"></div>
			<echarts:pie
					id="pie"
					title="在线用户记录数量饼图"
					subtitle="在线用户记录数量饼图"
					orientData="${orientData}"/>

			<div id="line_normal"  class="main000"></div>
			<echarts:line
			id="line_normal"
			title="在线用户记录曲线"
			subtitle="在线用户记录曲线"
			xAxisData="${xAxisData}"
			yAxisData="${yAxisData}"
			xAxisName="时间"
			yAxisName="数量" />
		</div>
	</div>

	</div>
	</div>
</div>
</body>
</html>