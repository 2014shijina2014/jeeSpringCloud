<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>系统配置管理</title>
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
			
			window.location="${ctx}/sys/sysConfigTree/";
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
	<form:form id="searchForm" modelAttribute="sysConfigTree" action="${ctx}/sys/sysConfigTree/" method="post" class="form-inline">
		<div class="form-group">
				<label>类型：</label>
				<form:input path="type" htmlEscape="false" maxlength="100" class="form-control input-sm"/>
				<label>数据值：</label>
				<form:input path="value" htmlEscape="false" maxlength="100" class="form-control input-sm"/>
				<label>标签名：</label>
				<form:input path="label" htmlEscape="false" maxlength="100" class="form-control input-sm"/>
				<label>描述：</label>
				<form:input path="description" htmlEscape="false" maxlength="4000" class="form-control input-sm"/>
				<label>创建者：</label>
				<form:input path="createBy.id" htmlEscape="false" maxlength="64" class="form-control input-sm"/>
				<label>创建时间：</label>
				<input id="beginCreateDate" name="beginCreateDate" type="text" maxlength="20" class="laydate-icon form-control layer-date input-sm"
					value="<fmt:formatDate value="${sysConfig.beginCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"/> - 
				<input id="endCreateDate" name="endCreateDate" type="text" maxlength="20" class="laydate-icon form-control layer-date input-sm"
					value="<fmt:formatDate value="${sysConfig.endCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"/>
				<label>更新者：</label>
				<form:input path="updateBy.id" htmlEscape="false" maxlength="64" class="form-control input-sm"/>
				<label>更新时间：</label>
				<input id="beginUpdateDate" name="beginUpdateDate" type="text" maxlength="20" class="laydate-icon form-control layer-date input-sm"
					value="<fmt:formatDate value="${sysConfig.beginUpdateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"/> - 
				<input id="endUpdateDate" name="endUpdateDate" type="text" maxlength="20" class="laydate-icon form-control layer-date input-sm"
					value="<fmt:formatDate value="${sysConfig.endUpdateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"/>
				<label>备注信息：</label>
				<label>删除标记：</label>
				<form:radiobuttons class="i-checks" path="delFlag" items="${fns:getDictList('del_flag')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
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
			<shiro:hasPermission name="sys:sysConfig:add">
				<table:addRow url="${ctx}/sys/sysConfigTree/form" title="系统配置"></table:addRow><!-- 增加按钮 -->
			</shiro:hasPermission>
	       <button class="btn btn-white btn-sm " data-toggle="tooltip" data-placement="left" onclick="refresh()" title="刷新"><i class="glyphicon glyphicon-repeat"></i> 刷新</button>
	       <button  class="btn btn-white btn-sm  " onclick="reset()" ><i class="fa fa-refresh"></i> 重置</button>
		</div>
		<div class="pull-right">
			<button class="btn btn-white btn-sm " data-toggle="tooltip" data-placement="left" onclick="top.openTab('${ctx}/sys/sysConfig/','系统配置列表', false)" title="系统配置列表"><i class="glyphicon glyphicon-repeat"></i> 系统配置列表</button>
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
				<th>类型</th>
				<th>数据值</th>
				<th>标签名</th>
				<th>图片</th>
				<th>排序（升序）</th>
				<th  class="sort-column description">描述</th>
				<th>更新时间</th>
				<shiro:hasPermission name="sys:sysConfig:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody id="treeTableList"></tbody>
	</table>
	<script type="text/template" id="treeTableTpl">
		<tr id="{{row.id}}" pId="{{pid}}">
			<td><a  href="#" onclick="openDialogView('查看系统配置', '${ctx}/sys/sysConfigTree/form?id={{row.id}}','800px', '500px')">
				{{row.type}}
			</a></td>
			<td>
				{{row.value}}
			</td>
			<td>
				{{row.label}}
			</td>
			<td>
				<img src="{{row.picture}}" width="100px" height="50px"/>
			</td>
			<td>
				{{row.sort}}
			</td>
			<td>
				{{row.description}}
			</td>
			<td>
				{{row.updateDate}}
			</td>
			<td>
			<shiro:hasPermission name="sys:sysConfig:view">
				<a href="#" onclick="openDialogView('查看系统配置', '${ctx}/sys/sysConfigTree/form?id={{row.id}}','800px', '500px')" class="btn btn-info btn-sm" ><i class="fa fa-search-plus"></i>  查看</a>
				</shiro:hasPermission>
			<shiro:hasPermission name="sys:sysConfig:edit">
   				<a href="#" onclick="openDialog('修改系统配置', '${ctx}/sys/sysConfigTree/form?id={{row.id}}','800px', '500px')" class="btn btn-success btn-sm" ><i class="fa fa-edit"></i> 修改</a>
   			</shiro:hasPermission>
   			<shiro:hasPermission name="sys:sysConfig:del">
				<a href="${ctx}/sys/sysConfigTree/delete?id={{row.id}}" onclick="return confirmx('确认要删除该系统配置及所有子系统配置吗？', this.href)" class="btn btn-danger btn-sm" ><i class="fa fa-trash"></i> 删除</a>
			</shiro:hasPermission>
   			<shiro:hasPermission name="sys:sysConfig:add">
				<a href="#" onclick="openDialog('添加下级系统配置', '${ctx}/sys/sysConfigTree/form?parent.id={{row.id}}','800px', '500px')" class="btn btn-white btn-sm" ><i class="fa fa-plus"></i> 添加下级系统配置</a>
			</shiro:hasPermission>
			</td>
		</tr>
	</script>
</body>
</html>