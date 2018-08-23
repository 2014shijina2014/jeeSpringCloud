<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>区域管理</title>
	<meta name="decorator" content="default"/>
		    <%@ include file="/WEB-INF/views/include/head.jsp"%>
	<%@include file="/WEB-INF/views/include/treetable.jsp" %>
	<script type="text/javascript">
		$(document).ready(function() {
			var tpl = $("#treeTableTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
			var data = ${fns:toJson(list)}, rootId = "0";
			addRow("#treeTableList", tpl, data, rootId, true);
			$("#treeTable").treeTable({expandLevel : 5});
		});
		function addRow(list, tpl, data, pid, root){
			for (var i=0; i<data.length; i++){
				var row = data[i];
				if ((${fns:jsGetVal('row.parentId')}) == pid){
					$(list).append(Mustache.render(tpl, {
						dict: {
							type: getDictLabel(${fns:toJson(fns:getDictList('sys_area_type'))}, row.type)
						}, pid: (root?0:pid), row: row
					}));
					addRow(list, tpl, data, row.id);
				}
			}
		}

		function refresh(){//刷新
			
			window.location="${ctx}/sys/area/";
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
			<shiro:hasPermission name="sys:area:add">
				<table:addRow url="${ctx}/sys/area/form" title="区域"></table:addRow><!-- 增加按钮 -->
			</shiro:hasPermission>
	       <button class="btn btn-white btn-sm " data-toggle="tooltip" data-placement="left" onclick="refresh()" title="刷新"><i class="glyphicon glyphicon-repeat"></i> 刷新</button>
		
		</div>
	</div>
	</div>
	
	<table id="treeTable"  class="table table-hover table-condensed dataTables-example dataTable">
		<thead><tr><th>区域名称</th><th>区域编码</th><th>区域类型</th><th>备注</th><th>操作</th></tr></thead>
		<tbody id="treeTableList"></tbody>
	</table>
	<br/>
	</div>
	</div>
</div>
	<script type="text/template" id="treeTableTpl">
		<tr id="{{row.id}}" pId="{{pid}}">
			<td><a  href="#" onclick="openDialogView('查看区域', '${ctx}/sys/area/form?id={{row.id}}','800px', '500px')">{{row.name}}</a></td>
			<td>{{row.code}}</td>
			<td>{{dict.type}}</td>
			<td>{{row.remarks}}</td>
			<td>
				<shiro:hasPermission name="sys:area:view">
				<a href="#" onclick="openDialogView('查看区域', '${ctx}/sys/area/form?id={{row.id}}','800px', '500px')" class="btn btn-success btn-sm" ><i class="fa fa-search-plus"></i>  查看</a>
				</shiro:hasPermission>
				<shiro:hasPermission name="sys:area:edit">
					<a href="#" onclick="openDialog('修改区域', '${ctx}/sys/area/form?id={{row.id}}','800px', '500px')" class="btn btn-white btn-sm" ><i class="fa fa-edit"></i> 修改</a>
				</shiro:hasPermission>
				<shiro:hasPermission name="sys:area:del">
					<a href="${ctx}/sys/area/delete?id={{row.id}}" onclick="return confirmx('要删除该区域及所有子区域项吗？', this.href)" class="btn btn-white btn-sm" ><i class="fa fa-trash"></i> 删除</a>
				</shiro:hasPermission>
				<shiro:hasPermission name="sys:area:add">
					<a href="#" onclick="openDialog('添加下级区域', '${ctx}/sys/area/form?parent.id={{row.id}}','800px', '500px')" class="btn btn-white btn-sm" ><i class="fa fa-plus"></i> 添加下级区域</a>
				</shiro:hasPermission>
			</td>
		</tr>
	</script>
</body>
</html>