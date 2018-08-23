<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>订票管理</title>
	<meta name="decorator" content="default"/>
	<%@ include file="/WEB-INF/views/include/head.jsp"%>
	<%@ include file="/WEB-INF/views/include/echarts.jsp"%>
	<script src="/static/views/modules/test/onetomany/testDataMainList.js" type="text/javascript"></script>
	<link href="/static/views/modules/test/onetomany/testDataMainList.css" rel="stylesheet" />
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content content-background">
	<div class="ibox">
    <div class="ibox-content content">
	<sys:message content="${message}"/>
	
	<!--查询条件-->
	<div class="row">
	<div class="col-sm-12">
	<form:form id="searchForm" modelAttribute="testDataMain" action="${ctx}/test/onetomany/testDataMain/" method="post" class="form-inline">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
		<div class="form-group">
			<span>名称：</span>
				<form:input path="name" htmlEscape="false" maxlength="100"  class=" form-control input-sm"/>
			<span>性别：</span>
				<form:radiobuttons class="i-checks" path="sex" items="${fns:getDictList('sex')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
			<span>加入日期：</span>
				<input id="beginInDate" name="beginInDate" type="text" maxlength="20" class="laydate-icon form-control layer-date input-sm"
					value="<fmt:formatDate value="${testDataMain.beginInDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"/> - 
				<input id="endInDate" name="endInDate" type="text" maxlength="20" class="laydate-icon form-control layer-date input-sm"
					value="<fmt:formatDate value="${testDataMain.endInDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"/>
			<span>更新时间：</span>
				<input id="updateDate" name="updateDate" type="text" maxlength="20" class="laydate-icon form-control layer-date input-sm"
					value="<fmt:formatDate value="${testDataMain.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"/>
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
			<shiro:hasPermission name="test:onetomany:testDataMain:add">
				<table:addRow url="${ctx}/test/onetomany/testDataMain/form" title="订票"></table:addRow><!-- 增加按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="test:onetomany:testDataMain:edit">
			    <table:editRow url="${ctx}/test/onetomany/testDataMain/form" title="订票" id="contentTable"></table:editRow><!-- 编辑按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="test:onetomany:testDataMain:del">
				<table:delRow url="${ctx}/test/onetomany/testDataMain/deleteAll" id="contentTable"></table:delRow><!-- 删除按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="test:onetomany:testDataMain:import">
				<table:importExcel url="${ctx}/test/onetomany/testDataMain/import"></table:importExcel><!-- 导入按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="test:onetomany:testDataMain:export">
	       		<table:exportExcel url="${ctx}/test/onetomany/testDataMain/export"></table:exportExcel><!-- 导出按钮 -->
	       	</shiro:hasPermission>
	        <button class="btn btn-white btn-sm " data-toggle="tooltip" data-placement="left" onclick="sortOrRefresh()" title="刷新"><i class="glyphicon glyphicon-repeat"></i> 刷新</button>
	       	<button  class="btn btn-white btn-sm " onclick="reset()"  title="重置"><i class="fa fa-refresh"></i> 重置</button>
		</div>
		<div class="pull-right">
			<button class="btn btn-white btn-sm " data-toggle="tooltip" data-placement="left" onclick="top.openTab('${ctx}/test/onetomany/testDataMain/listVue','Vue订票', false)" title="Vue.js"><i class="glyphicon glyphicon-repeat"></i> Vue.js</button>
			<shiro:hasPermission name="test:onetomany:testDataMain:total">
			<button class="btn btn-white btn-sm " data-toggle="tooltip" data-placement="left" onclick="top.openTab('${ctx}/test/onetomany/testDataMain/total','统计订票', false)" title="统计图表"><i class="glyphicon glyphicon-repeat"></i> 统计图表</button>
			<button class="btn btn-white btn-sm " data-toggle="tooltip" data-placement="left" onclick="top.openTab('${ctx}/test/onetomany/testDataMain/totalMap','统计订票', false)" title="统计地图"><i class="glyphicon glyphicon-repeat"></i> 统计地图</button>
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
		<c:forEach items="${page.list}" var="testDataMain">
			<div style="border: 1px solid #e7eaec;padding: 8px;" class="row">
				<div>
				<input type="checkbox" id="${testDataMain.id}"
					office.id="${testDataMain.office.id}"
					area.id="${testDataMain.area.id}"
					name="${testDataMain.name}"
					sex="${testDataMain.sex}"
					remarks="${testDataMain.remarks}"
				class="i-checks">
				</div>
				<div class="col-xs-6 col-sm-4 col-md-3 col-lg-2">
				归属部门:
				<a  href="#" onclick="openDialogView('查看订票', '${ctx}/test/onetomany/testDataMain/form?id=${testDataMain.id}','800px', '500px')">
					${testDataMain.office.name}
				</a></span>
						</div>
				<div class="col-xs-6 col-sm-4 col-md-3 col-lg-2">
				归属区域:
				
					${testDataMain.area.name}
				</span>
						</div>
				<div class="col-xs-6 col-sm-4 col-md-3 col-lg-2">
				名称:
				
					${testDataMain.name}
				</span>
						</div>
				<div class="col-xs-6 col-sm-4 col-md-3 col-lg-2">
				性别:
				
					${fns:getDictLabel(testDataMain.sex, 'sex', '')}
				</span>
						</div>
				<div class="col-xs-6 col-sm-4 col-md-3 col-lg-2">
				加入日期:
				
					<fmt:formatDate value="${testDataMain.inDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</span>
						</div>
				<div class="col-xs-6 col-sm-4 col-md-3 col-lg-2">
				创建时间:
				
					<fmt:formatDate value="${testDataMain.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</span>
						</div>
				<div class="col-xs-6 col-sm-4 col-md-3 col-lg-2">
				更新时间:
				
					<fmt:formatDate value="${testDataMain.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</span>
						</div>
				<div class="col-xs-6 col-sm-4 col-md-3 col-lg-2">
				备注信息:
				
					${testDataMain.remarks}
				</span>
						</div>
				<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
					<shiro:hasPermission name="test:onetomany:testDataMain:view">
						<a href="#" onclick="openDialogView('查看订票', '${ctx}/test/onetomany/testDataMain/form?id=${testDataMain.id}&action=view','800px', '500px')" class="btn btn-info btn-sm" title="查看"><i class="fa fa-search-plus"></i>查看</a>
					</shiro:hasPermission>
					<shiro:hasPermission name="test:onetomany:testDataMain:edit">
    					<a href="#" onclick="openDialog('修改订票', '${ctx}/test/onetomany/testDataMain/form?id=${testDataMain.id}','800px', '500px')" class="btn btn-success btn-sm" title="修改"><i class="fa fa-edit"></i>修改</a>
    				</shiro:hasPermission>
					<shiro:hasPermission name="test:onetomany:testDataMain:edit">
    					<a href="#" onclick="top.openTab('${ctx}/test/onetomany/testDataMain/form?id=${testDataMain.id}','修改订票', false)" title="修改" class="btn btn-success btn-sm" title="修改(页签)"><i class="fa fa-edit"></i>修改(页签)</a>
    				</shiro:hasPermission>
    				<shiro:hasPermission name="test:onetomany:testDataMain:edit">
    					<a href="#" onclick="top.openTab('${ctx}/test/onetomany/testDataMain/form?id=${testDataMain.id}&ViewFormType=FormTwo','修改订票', false)" title="修改2" class="btn btn-success btn-sm" title="修改(页签)2"><i class="fa fa-edit"></i>修改(页签)2</a>
    				</shiro:hasPermission>
    				<shiro:hasPermission name="test:onetomany:testDataMain:del">
						<a href="${ctx}/test/onetomany/testDataMain/delete?id=${testDataMain.id}" onclick="return confirmx('确认要删除该订票吗？', this.href)"   class="btn btn-danger btn-sm"  title="删除"><i class="fa fa-trash"></i>删除</a>
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
				<th  class="sort-column office.name ">归属部门</th>
				<th  class="sort-column area.name ">归属区域</th>
				<th  class="sort-column name hidden-xs">名称</th>
				<th  class="sort-column sex hidden-xs">性别</th>
				<th  class="sort-column inDate hidden-xs">加入日期</th>
				<th  class="sort-column createDate hidden-xs">创建时间</th>
				<th  class="sort-column updateDate hidden-xs">更新时间</th>
				<th  class="sort-column remarks hidden-xs">备注信息</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="testDataMain">
			<tr>
				<td>
				<input type="checkbox" id="${testDataMain.id}"
					office.id="${testDataMain.office.id}"
					area.id="${testDataMain.area.id}"
					name="${testDataMain.name}"
					sex="${testDataMain.sex}"
					remarks="${testDataMain.remarks}"
				class="i-checks"></td>
				<td class=""><a  href="#" onclick="openDialogView('查看订票', '${ctx}/test/onetomany/testDataMain/form?id=${testDataMain.id}','800px', '500px')">
					${testDataMain.office.name}
				</a></td>
				<td class="">
					${testDataMain.area.name}
				</td>
				<td class="hidden-xs">
					${testDataMain.name}
				</td>
				<td class="hidden-xs">
					${fns:getDictLabel(testDataMain.sex, 'sex', '')}
				</td>
				<td class="hidden-xs">
					<fmt:formatDate value="${testDataMain.inDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td class="hidden-xs">
					<fmt:formatDate value="${testDataMain.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td class="hidden-xs">
					<fmt:formatDate value="${testDataMain.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td class="hidden-xs">
					${testDataMain.remarks}
				</td>
				<td>
					<shiro:hasPermission name="test:onetomany:testDataMain:view">
						<a href="#" onclick="openDialogView('查看订票', '${ctx}/test/onetomany/testDataMain/form?id=${testDataMain.id}&action=view','800px', '500px')" class="btn btn-info btn-sm" title="查看"><i class="fa fa-search-plus"></i>查看</a>
					</shiro:hasPermission>
					<shiro:hasPermission name="test:onetomany:testDataMain:edit">
    					<!--a href="#" onclick="openDialog('修改订票', '${ctx}/test/onetomany/testDataMain/form?id=${testDataMain.id}','800px', '500px',null,true)" class="btn btn-success btn-sm" title="修改(弹窗)"><i class="fa fa-edit"></i>修改(弹窗)</a-->
    				</shiro:hasPermission>
    				 <shiro:hasPermission name="test:onetomany:testDataMain:edit">
    					<a href="${ctx}/test/onetomany/testDataMain/form?id=${testDataMain.id}" title="修改" class="btn btn-success btn-sm" title="修改"><i class="fa fa-edit"></i>修改</a>
    				</shiro:hasPermission>
    				<shiro:hasPermission name="test:onetomany:testDataMain:edit">
    					<!--a href="#" onclick="top.openTab('${ctx}/test/onetomany/testDataMain/form?id=${testDataMain.id}','修改订票', false)" title="修改" class="btn btn-success btn-sm" title="修改(页签)"><i class="fa fa-edit"></i>修改(页签)</a-->
    				</shiro:hasPermission>
    				<shiro:hasPermission name="test:onetomany:testDataMain:edit">
    					<!--a href="#" onclick="top.openTab('${ctx}/test/onetomany/testDataMain/form?id=${testDataMain.id}&ViewFormType=FormTwo','修改订票', false)" title="修改2" class="btn btn-success btn-sm" title="修改(页签)2"><i class="fa fa-edit"></i>修改(页签)2</a-->
    				</shiro:hasPermission>
    				<shiro:hasPermission name="test:onetomany:testDataMain:del">
						<a href="${ctx}/test/onetomany/testDataMain/delete?id=${testDataMain.id}" onclick="return confirmx('确认要删除该订票吗？', this.href)"   class="btn btn-danger btn-sm" title="删除"><i class="fa fa-trash"></i>删除</a>
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
					title="订票数量饼图"
					subtitle="订票数量饼图"
					orientData="${orientData}"/>

			<div id="line_normal"  class="main000"></div>
			<echarts:line
			id="line_normal"
			title="订票曲线"
			subtitle="订票曲线"
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