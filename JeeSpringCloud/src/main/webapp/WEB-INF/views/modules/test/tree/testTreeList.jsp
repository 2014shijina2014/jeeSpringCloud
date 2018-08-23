<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>机构管理</title>
	<meta name="decorator" content="default"/>
	<%@include file="/WEB-INF/views/include/head.jsp"%>
	<%@include file="/WEB-INF/views/include/treetable.jsp" %>
	<script type="text/javascript">
		$(document).ready(function() {
			var tpl = $("#treeTableTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
			var data = ${fns:toJson(list)}, ids = [], rootIds = [];
			for (var i=0; i<data.length; i++){
				ids.push(data[i].id);
			}
			ids = ',' + ids.join(',') + ',';
			for (var i=0; i<data.length; i++){
				if (ids.indexOf(','+data[i].parentId+',') == -1){
					if ((','+rootIds.join(',')+',').indexOf(','+data[i].parentId+',') == -1){
						rootIds.push(data[i].parentId);
					}
				}
			}
			for (var i=0; i<rootIds.length; i++){
				addRow("#treeTableList", tpl, data, rootIds[i], true);
			}
			$("#treeTable").treeTable({expandLevel : 5});
		});
		function addRow(list, tpl, data, pid, root){
			for (var i=0; i<data.length; i++){
				var row = data[i];
				if ((${fns:jsGetVal('row.parentId')}) == pid){
					$(list).append(Mustache.render(tpl, {
						dict: {
						blank123:0}, pid: (root?0:pid), row: row
					}));
					addRow(list, tpl, data, row.id);
				}
			}
		}
		
		function refresh(){//刷新
			
			window.location="${ctx}/test/tree/testTree/";
		}
	</script>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content content-background">
	<div class="ibox">
    <div class="ibox-content content">
	<sys:message content="${message}"/>

	<!--查询条件-->
	<div class="row">
	<div class="col-sm-12">
	<form:form id="searchForm" modelAttribute="testTree" action="${ctx}/test/tree/testTree/" method="post" class="form-inline">
		<div class="form-group">
				<label>名称：</label>
				<form:input path="name" htmlEscape="false" maxlength="100" class="form-control input-sm"/>
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
			<button  class="btn btn-success btn-sm" onclick="search()" ><i class="fa fa-search"></i> 查询</button>
			<shiro:hasPermission name="test:tree:testTree:add">
				<table:addRow url="${ctx}/test/tree/testTree/form" title="机构"></table:addRow><!-- 增加按钮 -->
			</shiro:hasPermission>
	       <button class="btn btn-white btn-sm " data-toggle="tooltip" data-placement="left" onclick="refresh()" title="刷新"><i class="glyphicon glyphicon-repeat"></i> 刷新</button>
	       <button  class="btn btn-white btn-sm  " onclick="reset()" ><i class="fa fa-refresh"></i> 重置</button>
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
	</div>
	</div>
	
	<table id="treeTable" class="table table-hover table-condensed dataTables-example dataTable">
		<thead>
			<tr>
				<th>名称</th>
				<th>备注信息</th>
				<shiro:hasPermission name="test:tree:testTree:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody id="treeTableList"></tbody>
	</table>
	<script type="text/template" id="treeTableTpl">
		<tr id="{{row.id}}" pId="{{pid}}">
			<td><a  href="#" onclick="openDialogView('查看机构', '${ctx}/test/tree/testTree/form?id={{row.id}}','800px', '500px')">
				{{row.name}}
			</a></td>
			<td>
				{{row.remarks}}
			</td>
			<td>
			<shiro:hasPermission name="test:tree:testTree:view">
				<a href="#" onclick="openDialogView('查看机构', '${ctx}/test/tree/testTree/form?id={{row.id}}','800px', '500px')" class="btn btn-info btn-sm" ><i class="fa fa-search-plus"></i>  查看</a>
				</shiro:hasPermission>
			<shiro:hasPermission name="test:tree:testTree:edit">
   				<a href="#" onclick="openDialog('修改机构', '${ctx}/test/tree/testTree/form?id={{row.id}}','800px', '500px')" class="btn btn-success btn-sm" ><i class="fa fa-edit"></i> 修改</a>
   			</shiro:hasPermission>
   			<shiro:hasPermission name="test:tree:testTree:del">
				<a href="${ctx}/test/tree/testTree/delete?id={{row.id}}" onclick="return confirmx('确认要删除该机构及所有子机构吗？', this.href)" class="btn btn-danger btn-sm" ><i class="fa fa-trash"></i> 删除</a>
			</shiro:hasPermission>
   			<shiro:hasPermission name="test:tree:testTree:add">
				<a href="#" onclick="openDialog('添加下级机构', '${ctx}/test/tree/testTree/form?parent.id={{row.id}}','800px', '500px')" class="btn btn-white btn-sm" ><i class="fa fa-plus"></i> 添加下级机构</a>
			</shiro:hasPermission>
			</td>
		</tr>
	</script>
</body>
</html>