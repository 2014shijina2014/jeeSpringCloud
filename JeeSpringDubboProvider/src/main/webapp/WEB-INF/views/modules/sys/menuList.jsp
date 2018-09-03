<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>菜单管理</title>
	<meta name="decorator" content="default"/>
	<%@include file="/WEB-INF/views/include/head.jsp"%>
	<%@include file="/WEB-INF/views/include/treetable.jsp" %>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#treeTable").treeTable({expandLevel : 1,column:1}).show();
		});
    	function updateSort() {
			loading('正在提交，请稍等...');
	    	$("#listForm").attr("action", "${ctx}/sys/menu/updateSort");
	    	$("#listForm").submit();
    	}
		function refresh(){//刷新
			
			window.location="${ctx}/sys/menu/";
		}
	</script>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content">
	<div class="ibox">
    <div class="ibox-content">
	<sys:message content="${message}"/>
			<!-- 工具栏 -->
	<div class="row">
	<div class="col-sm-12">
		<div class="pull-left">
			<shiro:hasPermission name="sys:menu:add">
				<table:addRow url="${ctx}/sys/menu/form" title="菜单"></table:addRow><!-- 增加按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="sys:menu:edit">
			    <table:editRow url="${ctx}/sys/menu/form" id="treeTable"  title="菜单"></table:editRow><!-- 编辑按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="sys:menu:del">
				<table:delRow url="${ctx}/sys/menu/deleteAll" id="treeTable"></table:delRow><!-- 删除按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="sys:menu:updateSort">
				<button id="btnSubmit" class="btn btn-white btn-sm " data-toggle="tooltip" data-placement="left" onclick="updateSort()" title="保存排序"><i class="fa fa-save"></i> 保存排序</button>
			</shiro:hasPermission>
				<button class="btn btn-white btn-sm " data-toggle="tooltip" data-placement="left" onclick="refresh()" title="刷新"><i class="glyphicon glyphicon-repeat"></i> 刷新</button>
		
		</div>
	</div>
	</div>
	<form id="listForm" method="post">
		<table id="treeTable" class="table table-hover table-condensed dataTables-example dataTable">
			<thead>
				<tr>
					<th><input type="checkbox" class="i-checks"></th>
					<th>名称</th>
					<th>链接</th>
					<th style="text-align:center;">排序</th>
					<th class="hidden-xs">可见</th>
					<th class="hidden-xs">权限标识</th>
					<shiro:hasPermission name="sys:menu:edit">
						<th>操作</th>
					</shiro:hasPermission>
				</tr>
			</thead>
			<tbody><c:forEach items="${list}" var="menu">
				<tr id="${menu.id}" pId="${menu.parent.id ne '1'?menu.parent.id:'0'}">
					<td> <input type="checkbox" id="${menu.id}" class="i-checks"></td>
					<td nowrap><i class="icon-${not empty menu.icon?menu.icon:' hide'}"></i><a  href="#" onclick="openDialogView('查看菜单', '${ctx}/sys/menu/form?id=${menu.id}','800px', '500px')">${menu.name}</a></td>
					<td title="${menu.href}">${fns:abbr(menu.href,30)}</td>
					<td style="text-align:center;">
						<shiro:hasPermission name="sys:menu:updateSort">
							<input type="hidden" name="ids" value="${menu.id}"/>
							<input name="sorts" type="text" value="${menu.sort}" class="form-control" style="width:100px;margin:0;padding:0;text-align:center;">
						</shiro:hasPermission><shiro:lacksPermission name="sys:menu:updateSort">
							${menu.sort}
						</shiro:lacksPermission>
					</td>
					<td  class="hidden-xs">${menu.isShow eq '1'?'显示':'隐藏'}</td>
					<td  class="hidden-xs" title="${menu.permission}">${fns:abbr(menu.permission,30)}</td>
					<td nowrap>
						<shiro:hasPermission name="sys:menu:view">
							<a href="#" onclick="openDialogView('查看菜单', '${ctx}/sys/menu/form?id=${menu.id}','800px', '500px')" class="btn btn-success btn-sm" ><i class="fa fa-search-plus"></i> 查看</a>
						</shiro:hasPermission>
						<shiro:hasPermission name="sys:menu:edit">
	    					<a href="#" onclick="openDialog('修改菜单', '${ctx}/sys/menu/form?id=${menu.id}','800px', '500px')" class="btn btn-white btn-sm" ><i class="fa fa-edit"></i> 修改</a>
	    				</shiro:hasPermission>
	    				<shiro:hasPermission name="sys:menu:del">
							<a href="${ctx}/sys/menu/delete?id=${menu.id}" onclick="return confirmx('要删除该菜单及所有子菜单项吗？', this.href)" class="btn btn-white btn-sm" ><i class="fa fa-trash"></i> 删除</a>
						</shiro:hasPermission>
						<shiro:hasPermission name="sys:menu:add">
							<a href="#" onclick="openDialog('添加下级菜单', '${ctx}/sys/menu/form?parent.id=${menu.id}','800px', '500px')" class="btn btn-white btn-sm" ><i class="fa fa-plus"></i> 添加下级菜单</a>
						</shiro:hasPermission>
					</td>
				</tr>
			</c:forEach></tbody>
		</table>
	 </form>
	 </div>
	</div>
	</div>
</body>
</html>