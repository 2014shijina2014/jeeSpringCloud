<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>定时任务调度日志管理</title>
	<meta name="decorator" content="default"/>
	<%@ include file="/WEB-INF/views/include/head.jsp"%>
	<%@ include file="/WEB-INF/views/include/echarts.jsp"%>
	<script src="/static/views/modules/job//sysJobLogList.js" type="text/javascript"></script>
	<link href="/static/views/modules/job//sysJobLogList.css" rel="stylesheet" />
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content content-background">
	<div class="ibox">
    <div class="ibox-content content">
	<sys:message content="${message}"/>
	
	<!--查询条件-->
	<div class="row">
	<div class="col-sm-12">
	<form:form id="searchForm" modelAttribute="sysJobLog" action="${ctx}/job/sysJobLog/" method="post" class="form-inline">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
		<div class="form-group">
			<span>任务名称：</span>
				<form:input path="jobName" htmlEscape="false" maxlength="64"  class=" form-control input-sm"/>
			<span>任务组名：</span>
				<form:input path="jobGroup" htmlEscape="false" maxlength="64"  class=" form-control input-sm"/>
			<span>任务方法：</span>
				<form:input path="methodName" htmlEscape="false" maxlength="500"  class=" form-control input-sm"/>
			<span>方法参数：</span>
				<form:input path="methodParams" htmlEscape="false" maxlength="200"  class=" form-control input-sm"/>
			<span>日志信息：</span>
				<form:input path="jobMessage" htmlEscape="false" maxlength="500"  class=" form-control input-sm"/>
			<span>执行状态（0正常 1失败）：</span>
				<form:radiobuttons class="i-checks" path="status" items="${fns:getDictList('job_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
			<span>异常信息：</span>
			<span>创建时间：</span>
				<input id="beginCreateDate" name="beginCreateDate" type="text" maxlength="20" class="laydate-icon form-control layer-date input-sm"
					value="<fmt:formatDate value="${sysJobLog.beginCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"/> - 
				<input id="endCreateDate" name="endCreateDate" type="text" maxlength="20" class="laydate-icon form-control layer-date input-sm"
					value="<fmt:formatDate value="${sysJobLog.endCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"/>
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
			<shiro:hasPermission name="job:sysJobLog:add">
				<table:addRow url="${ctx}/job/sysJobLog/form" title="定时任务调度日志"></table:addRow><!-- 增加按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="job:sysJobLog:edit">
			    <table:editRow url="${ctx}/job/sysJobLog/form" title="定时任务调度日志" id="contentTable"></table:editRow><!-- 编辑按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="job:sysJobLog:del">
				<table:delRow url="${ctx}/job/sysJobLog/deleteAll" id="contentTable"></table:delRow><!-- 删除按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="job:sysJobLog:import">
				<table:importExcel url="${ctx}/job/sysJobLog/import"></table:importExcel><!-- 导入按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="job:sysJobLog:export">
	       		<table:exportExcel url="${ctx}/job/sysJobLog/export"></table:exportExcel><!-- 导出按钮 -->
	       	</shiro:hasPermission>
	        <button class="btn btn-white btn-sm " data-toggle="tooltip" data-placement="left" onclick="sortOrRefresh()" title="刷新"><i class="glyphicon glyphicon-repeat"></i> 刷新</button>
	       	<button  class="btn btn-white btn-sm " onclick="reset()"  title="重置"><i class="fa fa-refresh"></i> 重置</button>
		</div>
		<div class="pull-right">
			<button class="btn btn-white btn-sm " data-toggle="tooltip" data-placement="left" onclick="top.openTab('${ctx}/job/sysJobLog/listVue','Vue定时任务调度日志', false)" title="Vue.js"><i class="glyphicon glyphicon-repeat"></i> Vue.js</button>
			<shiro:hasPermission name="job:sysJobLog:total">
			<button class="btn btn-white btn-sm " data-toggle="tooltip" data-placement="left" onclick="top.openTab('${ctx}/job/sysJobLog/total','统计定时任务调度日志', false)" title="统计图表"><i class="glyphicon glyphicon-repeat"></i> 统计图表</button>
			<button class="btn btn-white btn-sm " data-toggle="tooltip" data-placement="left" onclick="top.openTab('${ctx}/job/sysJobLog/totalMap','统计定时任务调度日志', false)" title="统计地图"><i class="glyphicon glyphicon-repeat"></i> 统计地图</button>
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
		<c:forEach items="${page.list}" var="sysJobLog">
			<div style="border: 1px solid #e7eaec;padding: 8px;" class="row">
				<div>
				<input type="checkbox" id="${sysJobLog.id}"
					jobName="${sysJobLog.jobName}"
					jobGroup="${sysJobLog.jobGroup}"
					methodName="${sysJobLog.methodName}"
					methodParams="${sysJobLog.methodParams}"
					jobMessage="${sysJobLog.jobMessage}"
					status="${sysJobLog.status}"
					exceptionInfo="${sysJobLog.exceptionInfo}"
					createBy="${sysJobLog.createBy}"
					updateDate="${sysJobLog.updateDate}"
					updateBy="${sysJobLog.updateBy}"
					delFlag="${sysJobLog.delFlag}"
				class="i-checks">
				</div>
				<div class="col-xs-6 col-sm-4 col-md-3 col-lg-2">
				任务名称:
				<a  href="#" onclick="openDialogView('查看定时任务调度日志', '${ctx}/job/sysJobLog/form?id=${sysJobLog.id}','800px', '500px')">
					${sysJobLog.jobName}
				</a></span>
						</div>
				<div class="col-xs-6 col-sm-4 col-md-3 col-lg-2">
				任务组名:
				
					${sysJobLog.jobGroup}
				</span>
						</div>
				<div class="col-xs-6 col-sm-4 col-md-3 col-lg-2">
				任务方法:
				
					${sysJobLog.methodName}
				</span>
						</div>
				<div class="col-xs-6 col-sm-4 col-md-3 col-lg-2">
				方法参数:
				
					${sysJobLog.methodParams}
				</span>
						</div>
				<div class="col-xs-6 col-sm-4 col-md-3 col-lg-2">
				日志信息:
				
					${sysJobLog.jobMessage}
				</span>
						</div>
				<div class="col-xs-6 col-sm-4 col-md-3 col-lg-2">
				执行状态（0正常 1失败）:
				
					${fns:getDictLabel(sysJobLog.status, 'job_status', '')}
				</span>
						</div>
				<div class="col-xs-6 col-sm-4 col-md-3 col-lg-2">
				异常信息:
				
					${sysJobLog.exceptionInfo}
				</span>
						</div>
				<div class="col-xs-6 col-sm-4 col-md-3 col-lg-2">
				创建时间:
				
					<fmt:formatDate value="${sysJobLog.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</span>
						</div>
				<div class="col-xs-6 col-sm-4 col-md-3 col-lg-2">
				创建者:
				
					${sysJobLog.createBy}
				</span>
						</div>
				<div class="col-xs-6 col-sm-4 col-md-3 col-lg-2">
				修改时间:
				
					${sysJobLog.updateDate}
				</span>
						</div>
				<div class="col-xs-6 col-sm-4 col-md-3 col-lg-2">
				修改者:
				
					${sysJobLog.updateBy}
				</span>
						</div>
				<div class="col-xs-6 col-sm-4 col-md-3 col-lg-2">
				删除标记:
				
					${fns:getDictLabel(sysJobLog.delFlag, 'del_flag', '')}
				</span>
						</div>
				<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
					<shiro:hasPermission name="job:sysJobLog:view">
						<a href="#" onclick="openDialogView('查看定时任务调度日志', '${ctx}/job/sysJobLog/form?id=${sysJobLog.id}&action=view','800px', '500px')" class="btn btn-info btn-sm" title="查看"><i class="fa fa-search-plus"></i>查看</a>
					</shiro:hasPermission>
					<shiro:hasPermission name="job:sysJobLog:edit">
    					<a href="#" onclick="openDialog('修改定时任务调度日志', '${ctx}/job/sysJobLog/form?id=${sysJobLog.id}','800px', '500px')" class="btn btn-success btn-sm" title="修改"><i class="fa fa-edit"></i>修改</a>
    				</shiro:hasPermission>
					<shiro:hasPermission name="job:sysJobLog:edit">
    					<a href="#" onclick="top.openTab('${ctx}/job/sysJobLog/form?id=${sysJobLog.id}','修改定时任务调度日志', false)" title="修改" class="btn btn-success btn-sm" title="修改(页签)"><i class="fa fa-edit"></i>修改(页签)</a>
    				</shiro:hasPermission>
    				<shiro:hasPermission name="job:sysJobLog:edit">
    					<a href="#" onclick="top.openTab('${ctx}/job/sysJobLog/form?id=${sysJobLog.id}&ViewFormType=FormTwo','修改定时任务调度日志', false)" title="修改2" class="btn btn-success btn-sm" title="修改(页签)2"><i class="fa fa-edit"></i>修改(页签)2</a>
    				</shiro:hasPermission>
    				<shiro:hasPermission name="job:sysJobLog:del">
						<a href="${ctx}/job/sysJobLog/delete?id=${sysJobLog.id}" onclick="return confirmx('确认要删除该定时任务调度日志吗？', this.href)"   class="btn btn-danger btn-sm"  title="删除"><i class="fa fa-trash"></i>删除</a>
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
				<th  class="sort-column jobName ">任务名称</th>
				<th  class="sort-column jobGroup ">任务组名</th>
				<th  class="sort-column methodName ">任务方法</th>
				<th  class="sort-column methodParams hidden-xs">方法参数</th>
				<th  class="sort-column jobMessage hidden-xs">日志信息</th>
				<th  class="sort-column status hidden-xs">执行状态（0正常 1失败）</th>
				<th  class="sort-column exceptionInfo hidden-xs">异常信息</th>
				<th  class="sort-column createDate hidden-xs">创建时间</th>
				<th  class="sort-column createBy hidden-xs">创建者</th>
				<th  class="sort-column updateDate hidden-xs">修改时间</th>
				<th  class="sort-column updateBy hidden-xs">修改者</th>
				<th  class="sort-column delFlag hidden-xs">删除标记</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="sysJobLog">
			<tr>
				<td>
				<input type="checkbox" id="${sysJobLog.id}"
					jobName="${sysJobLog.jobName}"
					jobGroup="${sysJobLog.jobGroup}"
					methodName="${sysJobLog.methodName}"
					methodParams="${sysJobLog.methodParams}"
					jobMessage="${sysJobLog.jobMessage}"
					status="${sysJobLog.status}"
					createBy="${sysJobLog.createBy}"
					updateDate="${sysJobLog.updateDate}"
					updateBy="${sysJobLog.updateBy}"
					delFlag="${sysJobLog.delFlag}"
				class="i-checks"></td>
				<td class=""><a  href="#" onclick="openDialogView('查看定时任务调度日志', '${ctx}/job/sysJobLog/form?id=${sysJobLog.id}&action=view','800px', '500px')">
					${sysJobLog.jobName}
				</a></td>
				<td class="">
					${sysJobLog.jobGroup}
				</td>
				<td class="">
					${sysJobLog.methodName}
				</td>
				<td class="hidden-xs">
					${sysJobLog.methodParams}
				</td>
				<td class="hidden-xs">
					${sysJobLog.jobMessage}
				</td>
				<td class="hidden-xs">
					${fns:getDictLabel(sysJobLog.status, 'job_status', '')}
				</td>
				<td class="hidden-xs">
					${sysJobLog.exceptionInfo}
				</td>
				<td class="hidden-xs">
					<fmt:formatDate value="${sysJobLog.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td class="hidden-xs">
					${sysJobLog.createBy}
				</td>
				<td class="hidden-xs">
					${sysJobLog.updateDate}
				</td>
				<td class="hidden-xs">
					${sysJobLog.updateBy}
				</td>
				<td class="hidden-xs">
					${fns:getDictLabel(sysJobLog.delFlag, 'del_flag', '')}
				</td>
				<td>
					<shiro:hasPermission name="job:sysJobLog:view">
						<a href="#" onclick="openDialogView('查看定时任务调度日志', '${ctx}/job/sysJobLog/form?id=${sysJobLog.id}&action=view','800px', '500px')" class="btn btn-info btn-sm" title="查看"><i class="fa fa-search-plus"></i>查看</a>
					</shiro:hasPermission>
					<shiro:hasPermission name="job:sysJobLog:edit">
    					<!--a href="#" onclick="openDialog('修改定时任务调度日志', '${ctx}/job/sysJobLog/form?id=${sysJobLog.id}','800px', '500px',null,true)" class="btn btn-success btn-sm" title="修改(弹窗)"><i class="fa fa-edit"></i>修改(弹窗)</a-->
    				</shiro:hasPermission>
    				 <shiro:hasPermission name="job:sysJobLog:edit">
    					<a href="${ctx}/job/sysJobLog/form?id=${sysJobLog.id}" title="修改" class="btn btn-success btn-sm" title="修改"><i class="fa fa-edit"></i>修改</a>
    				</shiro:hasPermission>
    				<shiro:hasPermission name="job:sysJobLog:edit">
    					<!--a href="#" onclick="top.openTab('${ctx}/job/sysJobLog/form?id=${sysJobLog.id}','修改定时任务调度日志', false)" title="修改" class="btn btn-success btn-sm" title="修改(页签)"><i class="fa fa-edit"></i>修改(页签)</a-->
    				</shiro:hasPermission>
    				<shiro:hasPermission name="job:sysJobLog:edit">
    					<!--a href="#" onclick="top.openTab('${ctx}/job/sysJobLog/form?id=${sysJobLog.id}&ViewFormType=FormTwo','修改定时任务调度日志', false)" title="修改2" class="btn btn-success btn-sm" title="修改(页签)2"><i class="fa fa-edit"></i>修改(页签)2</a-->
    				</shiro:hasPermission>
    				<shiro:hasPermission name="job:sysJobLog:del">
						<a href="${ctx}/job/sysJobLog/delete?id=${sysJobLog.id}" onclick="return confirmx('确认要删除该定时任务调度日志吗？', this.href)"   class="btn btn-danger btn-sm" title="删除"><i class="fa fa-trash"></i>删除</a>
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
					title="定时任务调度日志数量饼图"
					subtitle="定时任务调度日志数量饼图"
					orientData="${orientData}"/>

			<div id="line_normal"  class="main000"></div>
			<echarts:line
			id="line_normal"
			title="定时任务调度日志曲线"
			subtitle="定时任务调度日志曲线"
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