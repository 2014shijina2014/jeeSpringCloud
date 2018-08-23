<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>服务器监控管理</title>
	<meta name="decorator" content="default"/>
	<%@ include file="/WEB-INF/views/include/head.jsp"%>
	<%@ include file="/WEB-INF/views/include/echarts.jsp"%>
	<script src="/static/views/modules/sys//sysServerList.js" type="text/javascript"></script>
	<link href="/static/views/modules/sys//sysServerList.css" rel="stylesheet" />
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content content-background">
	<div class="ibox">
    <div class="ibox-content content">
	<sys:message content="${message}"/>
	
	<!--查询条件-->
	<div class="row">
	<div class="col-sm-12">
	<form:form id="searchForm" modelAttribute="sysServer" action="${ctx}/sys/sysServer/" method="post" class="form-inline">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
		<div class="form-group">
			<span>服务器编号：</span>
				<form:input path="serverNumber" htmlEscape="false" maxlength="255"  class=" form-control input-sm"/>
			<span>服务器监控地址：</span>
				<form:input path="serverAddress" htmlEscape="false" maxlength="50"  class=" form-control input-sm"/>
			<span>名称：</span>
				<form:input path="name" htmlEscape="false" maxlength="255"  class=" form-control input-sm"/>
			<span>标签名：</span>
				<form:input path="label" htmlEscape="false" maxlength="50"  class=" form-control input-sm"/>
			<span>类型：</span>
				<form:radiobuttons class="i-checks" path="type" items="${fns:getDictList('server_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
			<span>排序（升序）：</span>
				<form:input path="sort" htmlEscape="false"  class=" form-control input-sm"/>
			<span>描述：</span>
				<form:input path="description" htmlEscape="false" maxlength="100"  class=" form-control input-sm"/>
			<span>备注信息：</span>
				<form:input path="remarks" htmlEscape="false" maxlength="100"  class=" form-control input-sm"/>
			<span>在线状态on_line在线off_line离线：</span>
				<form:radiobuttons class="i-checks" path="status" items="${fns:getDictList('on_line_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
			<span>创建时间：</span>
				<input id="beginCreateDate" name="beginCreateDate" type="text" maxlength="20" class="laydate-icon form-control layer-date input-sm"
					value="<fmt:formatDate value="${sysServer.beginCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"/> - 
				<input id="endCreateDate" name="endCreateDate" type="text" maxlength="20" class="laydate-icon form-control layer-date input-sm"
					value="<fmt:formatDate value="${sysServer.endCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"/>
			<span>更新时间：</span>
				<input id="beginUpdateDate" name="beginUpdateDate" type="text" maxlength="20" class="laydate-icon form-control layer-date input-sm"
					value="<fmt:formatDate value="${sysServer.beginUpdateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"/> - 
				<input id="endUpdateDate" name="endUpdateDate" type="text" maxlength="20" class="laydate-icon form-control layer-date input-sm"
					value="<fmt:formatDate value="${sysServer.endUpdateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"/>
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
			<shiro:hasPermission name="sys:sysServer:add">
				<table:addRow url="${ctx}/sys/sysServer/form" title="服务器监控"></table:addRow><!-- 增加按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="sys:sysServer:edit">
			    <table:editRow url="${ctx}/sys/sysServer/form" title="服务器监控" id="contentTable"></table:editRow><!-- 编辑按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="sys:sysServer:del">
				<table:delRow url="${ctx}/sys/sysServer/deleteAll" id="contentTable"></table:delRow><!-- 删除按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="sys:sysServer:import">
				<table:importExcel url="${ctx}/sys/sysServer/import"></table:importExcel><!-- 导入按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="sys:sysServer:export">
	       		<table:exportExcel url="${ctx}/sys/sysServer/export"></table:exportExcel><!-- 导出按钮 -->
	       	</shiro:hasPermission>
	        <button class="btn btn-white btn-sm " data-toggle="tooltip" data-placement="left" onclick="sortOrRefresh()" title="刷新"><i class="glyphicon glyphicon-repeat"></i> 刷新</button>
	       	<button  class="btn btn-white btn-sm " onclick="reset()"  title="重置"><i class="fa fa-refresh"></i> 重置</button>
		</div>
		<div class="pull-right">
			<button class="btn btn-white btn-sm " data-toggle="tooltip" data-placement="left" onclick="top.openTab('${ctx}/sys/sysServer/listVue','Vue服务器监控', false)" title="Vue.js"><i class="glyphicon glyphicon-repeat"></i> Vue.js</button>
			<shiro:hasPermission name="sys:sysServer:total">
			<button class="btn btn-white btn-sm " data-toggle="tooltip" data-placement="left" onclick="top.openTab('${ctx}/sys/sysServer/total','统计服务器监控', false)" title="统计图表"><i class="glyphicon glyphicon-repeat"></i> 统计图表</button>
			<button class="btn btn-white btn-sm " data-toggle="tooltip" data-placement="left" onclick="top.openTab('${ctx}/sys/sysServer/totalMap','统计服务器监控', false)" title="统计地图"><i class="glyphicon glyphicon-repeat"></i> 统计地图</button>
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
		<c:forEach items="${page.list}" var="sysServer">
			<div style="border: 1px solid #e7eaec;padding: 8px;" class="row">
				<div>
				<input type="checkbox" id="${sysServer.id}"
					serverNumber="${sysServer.serverNumber}"
					serverAddress="${sysServer.serverAddress}"
					name="${sysServer.name}"
					label="${sysServer.label}"
					picture="${sysServer.picture}"
					type="${sysServer.type}"
					sort="${sysServer.sort}"
					description="${sysServer.description}"
				class="i-checks">
				</div>
				<div class="col-xs-6 col-sm-4 col-md-3 col-lg-2">
				服务器编号:
				<a  href="#" onclick="openDialogView('查看服务器监控', '${ctx}/sys/sysServer/form?id=${sysServer.id}','800px', '500px')">
					${sysServer.serverNumber}
				</a></span>
						</div>
				<div class="col-xs-6 col-sm-4 col-md-3 col-lg-2">
				服务器监控地址:
				
					${sysServer.serverAddress}
				</span>
						</div>
				<div class="col-xs-6 col-sm-4 col-md-3 col-lg-2">
				名称:
				
					${sysServer.name}
				</span>
						</div>
				<div class="col-xs-6 col-sm-4 col-md-3 col-lg-2">
				标签名:
				
					${sysServer.label}
				</span>
						</div>
				<div class="col-xs-6 col-sm-4 col-md-3 col-lg-2">
				图片:
				
					${sysServer.picture}
				</span>
						</div>
				<div class="col-xs-6 col-sm-4 col-md-3 col-lg-2">
				类型:
				
					${fns:getDictLabel(sysServer.type, 'server_type', '')}
				</span>
						</div>
				<div class="col-xs-6 col-sm-4 col-md-3 col-lg-2">
				排序（升序）:
				
					${sysServer.sort}
				</span>
						</div>
				<div class="col-xs-6 col-sm-4 col-md-3 col-lg-2">
				描述:
				
					${sysServer.description}
				</span>
						</div>
				<div class="col-xs-6 col-sm-4 col-md-3 col-lg-2">
				创建时间:
				
					<fmt:formatDate value="${sysServer.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</span>
						</div>
				<div class="col-xs-6 col-sm-4 col-md-3 col-lg-2">
				更新时间:
				
					<fmt:formatDate value="${sysServer.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</span>
						</div>
				<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
					<shiro:hasPermission name="sys:sysServer:view">
						<a href="#" onclick="openDialogView('查看服务器监控', '${ctx}/sys/sysServer/form?id=${sysServer.id}&action=view','800px', '500px')" class="btn btn-info btn-sm" title="查看"><i class="fa fa-search-plus"></i>查看</a>
					</shiro:hasPermission>
					<shiro:hasPermission name="sys:sysServer:edit">
    					<a href="#" onclick="openDialog('修改服务器监控', '${ctx}/sys/sysServer/form?id=${sysServer.id}','800px', '500px')" class="btn btn-success btn-sm" title="修改"><i class="fa fa-edit"></i>修改</a>
    				</shiro:hasPermission>
					<shiro:hasPermission name="sys:sysServer:edit">
    					<a href="#" onclick="top.openTab('${ctx}/sys/sysServer/form?id=${sysServer.id}','修改服务器监控', false)" title="修改" class="btn btn-success btn-sm" title="修改(页签)"><i class="fa fa-edit"></i>修改(页签)</a>
    				</shiro:hasPermission>
    				<shiro:hasPermission name="sys:sysServer:edit">
    					<a href="#" onclick="top.openTab('${ctx}/sys/sysServer/form?id=${sysServer.id}&ViewFormType=FormTwo','修改服务器监控', false)" title="修改2" class="btn btn-success btn-sm" title="修改(页签)2"><i class="fa fa-edit"></i>修改(页签)2</a>
    				</shiro:hasPermission>
    				<shiro:hasPermission name="sys:sysServer:del">
						<a href="${ctx}/sys/sysServer/delete?id=${sysServer.id}" onclick="return confirmx('确认要删除该服务器监控吗？', this.href)"   class="btn btn-danger btn-sm"  title="删除"><i class="fa fa-trash"></i>删除</a>
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
				<th  class="sort-column serverNumber ">服务器编号</th>
				<th  class="sort-column serverAddress ">服务器监控地址</th>
				<th  class="sort-column name ">名称</th>
				<th  class="sort-column label hidden-xs">标签名</th>
				<th  class="sort-column picture hidden-xs">图片</th>
				<th  class="sort-column type hidden-xs">类型</th>
				<th  class="sort-column status hidden-xs">状态</th>
				<th  class="sort-column sort hidden-xs">排序（升序）</th>
				<th  class="sort-column description hidden-xs">描述</th>
				<th  class="sort-column createDate hidden-xs">创建时间</th>
				<th  class="sort-column updateDate hidden-xs">更新时间</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="sysServer">
			<tr>
				<td>
				<input type="checkbox" id="${sysServer.id}"
					serverNumber="${sysServer.serverNumber}"
					serverAddress="${sysServer.serverAddress}"
					name="${sysServer.name}"
					label="${sysServer.label}"
					picture="${sysServer.picture}"
					type="${sysServer.type}"
					sort="${sysServer.sort}"
					description="${sysServer.description}"
				class="i-checks"></td>
				<td class=""><a  href="#" onclick="openDialogView('查看服务器监控', '${ctx}/sys/sysServer/form?id=${sysServer.id}&action=view','800px', '500px')">
					${sysServer.serverNumber}
				</a></td>
				<td class="">
					${sysServer.serverAddress}
				</td>
				<td class="">
					${sysServer.name}
				</td>
				<td class="hidden-xs">
					${sysServer.label}
				</td>
				<td class="hidden-xs">
					${sysServer.picture}
				</td>
				<td class="hidden-xs">
					${fns:getDictLabel(sysServer.type, 'server_type', '')}
				</td>

				<td class="hidden-xs">
						${fns:getDictLabel(sysServer.status, 'on_line_status', '')}
				</td>
				<td class="hidden-xs">
					${sysServer.sort}
				</td>
				<td class="hidden-xs">
					${sysServer.description}
				</td>
				<td class="hidden-xs">
					<fmt:formatDate value="${sysServer.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td class="hidden-xs">
					<fmt:formatDate value="${sysServer.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					<shiro:hasPermission name="sys:sysServer:view">
						<a href="#" onclick="openDialogView('查看服务器监控', '${ctx}/sys/sysServer/form?id=${sysServer.id}&action=view','800px', '500px')" class="btn btn-info btn-sm" title="查看"><i class="fa fa-search-plus"></i>查看</a>
					</shiro:hasPermission>
					<shiro:hasPermission name="sys:sysServer:edit">
    					<!--a href="#" onclick="openDialog('修改服务器监控', '${ctx}/sys/sysServer/form?id=${sysServer.id}','800px', '500px',null,true)" class="btn btn-success btn-sm" title="修改(弹窗)"><i class="fa fa-edit"></i>修改(弹窗)</a-->
    				</shiro:hasPermission>
    				 <shiro:hasPermission name="sys:sysServer:edit">
    					<a href="${ctx}/sys/sysServer/form?id=${sysServer.id}" title="修改" class="btn btn-success btn-sm" title="修改"><i class="fa fa-edit"></i>修改</a>
    				</shiro:hasPermission>
    				<shiro:hasPermission name="sys:sysServer:edit">
    					<!--a href="#" onclick="top.openTab('${ctx}/sys/sysServer/form?id=${sysServer.id}','修改服务器监控', false)" title="修改" class="btn btn-success btn-sm" title="修改(页签)"><i class="fa fa-edit"></i>修改(页签)</a-->
    				</shiro:hasPermission>
    				<shiro:hasPermission name="sys:sysServer:edit">
    					<!--a href="#" onclick="top.openTab('${ctx}/sys/sysServer/form?id=${sysServer.id}&ViewFormType=FormTwo','修改服务器监控', false)" title="修改2" class="btn btn-success btn-sm" title="修改(页签)2"><i class="fa fa-edit"></i>修改(页签)2</a-->
    				</shiro:hasPermission>
    				<shiro:hasPermission name="sys:sysServer:del">
						<a href="${ctx}/sys/sysServer/delete?id=${sysServer.id}" onclick="return confirmx('确认要删除该服务器监控吗？', this.href)"   class="btn btn-danger btn-sm" title="删除"><i class="fa fa-trash"></i>删除</a>
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
					title="服务器监控数量饼图"
					subtitle="服务器监控数量饼图"
					orientData="${orientData}"/>

			<div id="line_normal"  class="main000"></div>
			<echarts:line
			id="line_normal"
			title="服务器监控曲线"
			subtitle="服务器监控曲线"
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