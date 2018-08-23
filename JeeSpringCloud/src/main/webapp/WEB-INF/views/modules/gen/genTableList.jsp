<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>表单管理</title>
	<meta name="decorator" content="default"/>
				    <%@ include file="/WEB-INF/views/include/head.jsp"%>
	<script type="text/javascript">
	$(document).ready(function() {
	    $('#contentTable thead tr th input.i-checks').on('ifChecked', function(event){ //ifCreated 事件应该在插件初始化之前绑定 
	    	  $('#contentTable tbody tr td input.i-checks').iCheck('check');
	    	});

	    $('#contentTable thead tr th input.i-checks').on('ifUnchecked', function(event){ //ifCreated 事件应该在插件初始化之前绑定 
	    	  $('#contentTable tbody tr td input.i-checks').iCheck('uncheck');
	    	});
	    
	});

		function genCode(){

			// var url = $(this).attr('data-url');
			  var size = $("#contentTable tbody tr td input.i-checks:checked").size();
			  if(size == 0 ){
					top.layer.alert('请至少选择一条数据!', {icon: 0, title:'警告'});
					return;
				  }

			  if(size > 1 ){
					top.layer.alert('只能选择一条数据!', {icon: 0, title:'警告'});
					return;
				  }
			    var id =  $("#contentTable tbody tr td input.i-checks:checkbox:checked").attr("id");
			    var tableType =  $("#contentTable tbody tr td input.i-checks:checkbox:checked").closest("td").next().text();
			    if(tableType.indexOf("附表")>=0){

			    	top.layer.alert('不能选择附表生成代码，请选择主表!', {icon: 0, title:'警告'});
					return;

			    }
			    var isSync = $("#contentTable tbody tr td input.i-checks:checkbox:checked").closest("td").next().next().next().next().next().next().text();
			    if(isSync.indexOf("未同步")>=0){

			    	//top.layer.alert('请同步数据库!', {icon: 0, title:'警告'});
					//return;
			    }
			    openDialog('生成代码','${ctx}/gen/genTable/genCodeForm?genTable.id='+id,'800px', '500px',null,null);
			}
		function page(n,s){
			if(n) $("#pageNo").val(n);
			if(s) $("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content">
	<div class="ibox">
	
	<div class="ibox-content">
	<sys:message content="${message}"/>
	
	<!--查询条件-->
	<div class="row">
	<div class="col-sm-12">
		<form:form id="searchForm" modelAttribute="genTable" action="${ctx}/gen/genTable/" method="post" class="form-inline">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<div class="form-group">
		<span>表名：</span><form:input path="nameLike" htmlEscape="false" maxlength="50" class=" form-control input-sm"/>
		<span>说明：</span><form:input path="comments" htmlEscape="false" maxlength="50" class=" form-control input-sm"/>
		<span>父表表名：</span><form:input path="parentTable" htmlEscape="false" maxlength="50" class=" form-control input-sm"/>
		</div>
	</form:form>
	<br/>
	</div>
	</div>
    	
	<!-- 工具栏 -->
	<div class="row ">
	<div class="col-sm-12">
		<div class="pull-left">
				<button  class="btn btn-success btn-sm " onclick="$('#searchForm').toggle();$('.fa-chevron').toggle();"  title="检索">
					<i class="fa-chevron fa fa-chevron-up"></i><i class="fa-chevron fa fa-chevron-down" style="display:none"></i> 检索
				</button>
	        	<button  class="btn btn-success e btn-sm " onclick="search()" ><i class="fa fa-search"></i>查询</button>
				<shiro:hasPermission name="gen:genTable:add">
				<table:addRow url="${ctx}/gen/genTable/form" title="表单" width="1000px" height="700px"></table:addRow><!-- 增加按钮 -->
				</shiro:hasPermission>
			    <shiro:hasPermission name="gen:genTable:edit">
			    <table:editRow url="${ctx}/gen/genTable/form" title="表单" id="contentTable" width="1000px" height="700px"></table:editRow><!-- 编辑按钮 -->
			    </shiro:hasPermission>
			    <shiro:hasPermission name="gen:genTable:del">
				<table:delRow url="${ctx}/gen/genTable/deleteAll" id="contentTable" label="删除"></table:delRow><!-- 删除按钮 -->
				</shiro:hasPermission>
				<shiro:hasPermission name="gen:genTable:importDb">
					<button  class="btn btn-white btn-sm " data-toggle="tooltip" data-placement="left" title="导入" onclick="openDialog('导入表单','${ctx}/gen/genTable/importTableFromDB','700px', '300px')"><i class="fa fa-folder-open-o"></i>导入表单</button>
				</shiro:hasPermission>
				<shiro:hasPermission name="gen:genTable:genCode">
	       		<button  class="btn btn-white btn-sm " data-toggle="tooltip" data-placement="left" title="生成代码" onclick="genCode()"><i class="fa fa-folder-open-o"></i> 生成代码</button>
	       		</shiro:hasPermission>
	       		
	           <button class="btn btn-white btn-sm " data-toggle="tooltip" data-placement="left" onclick="sortOrRefresh()" title="刷新"><i class="glyphicon glyphicon-repeat"></i> 刷新</button>
		       <button  class="btn btn-white  btn-sm " onclick="reset()" ><i class="fa fa-refresh"></i> 重置</button>	
			</div>
			<div class="pull-right">
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
			<div class="form-group pull-left">
				<label class="control-label pull-left">代码生成:单表、主附表、树表、列表和表单、增删改查云接口、redis高速缓存对接代码、图表统计、地图统计、vue.js</label>
			</div>
	</div>
	</div>
	
	<table id="contentTable" class="table table-hover table-condensed dataTables-example dataTable">
		<thead>
		<tr>
			<th> <input type="checkbox" class="i-checks"></th>
			<th class="sort-column table_type">表类型</th>
			<th class="sort-column name">表名</th>
			<th>说明</th>
			<th class="sort-column class_name">类名</th>
			<th class="sort-column parent_table">主表</th>
			<th class="sort-column isSync">同步数据库</th>
			<th>操作</th>
		</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="genTable">
			<tr>
				<td> <input type="checkbox" id="${genTable.id}" class="i-checks"></td>
				<td>${ fns:getDictLabel (genTable.tableType,'table_type',null)}</td>
				<td><a  href="#" onclick="openDialogView('查看表单', '${ctx}/gen/genTable/form?id=${genTable.id}','1000px', '700px')">${genTable.name}</a></td>
				<td>${genTable.comments}</td>
				<td>${genTable.className}</td>
				<td title="点击查询子表"><a href="javascript:" onclick="$('#parentTable').val('${genTable.parentTable}');$('#searchForm').submit();">${genTable.parentTable}</a></td>
				<td ${genTable.isSync == '0'?'style="background-color:red"':''}>${genTable.isSync == '0'?'<font color=\"white\">未同步</font>':'已同步'}</td>
				<td>
					<shiro:hasPermission name="gen:genTable:edit">
					<a href="#" onclick="openDialog('修改业务表', '${ctx}/gen/genTable/form?id=${genTable.id}','1000px', '700px')" class="incon-white btn btn-success btn-sm" ><i class="fa fa-edit"></i> 修改</a>
					</shiro:hasPermission>
					<shiro:hasPermission name="gen:genTable:del">
    				<a href="${ctx}/gen/genTable/delete?id=${genTable.id}" onclick="return confirmx('确认要移除该条记录吗？', this.href)" class="incon-white btn btn-white btn-sm" ><i class="fa fa-trash"></i> 移除</a>
    				</shiro:hasPermission>
    				<shiro:hasPermission name="gen:genTable:del">
					<a href="${ctx}/gen/genTable/deleteDb?id=${genTable.id}" onclick="return confirmx('确认要删除该条记录并删除对应的数据库表吗？', this.href)" class="incon-white btn btn-white btn-sm" ><i class="fa fa-trash"></i> 删除</a>
					</shiro:hasPermission>
					<shiro:hasPermission name="gen:genTable:synchDb">
					<a href="${ctx}/gen/genTable/synchDb?id=${genTable.id}" onclick="return confirmx('确认要强制同步数据库吗？同步数据库将删除所有数据重新建表！', this.href)" class="incon-white btn btn-white btn-sm" ><i class="fa fa-database"></i> 同步数据库</a>
					</shiro:hasPermission>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
		<!-- 分页代码 -->
	<table:page page="${page}"></table:page>
	<br/>
	<br/>
	</div>
	</div>
</div>
</body>
</html>
