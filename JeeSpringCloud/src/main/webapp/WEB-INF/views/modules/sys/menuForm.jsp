<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>菜单管理</title>
	<meta name="decorator" content="default"/>
	<%@include file="/WEB-INF/views/include/head.jsp"%>
	<script src="/static/views/formSubmit.js" type="text/javascript"></script>
</head>
<body class="gray-bg">
	<form:form id="inputForm" modelAttribute="menu" action="${ctx}/sys/menu/save" method="post" class="form-horizontal content-background">
		<div class="content">
			<form:hidden path="id"/>
			<sys:message content="${message}"/>
			<table class="width-100 table-condensed dataTables-example dataTable no-footer">
			   <tbody>
				  <tr>
					 <td  class="width-15 active" valign="top"><label class="pull-left">上级菜单</label></td>
					 <td class="width-35" ><sys:treeselect id="menu" name="parent.id" value="${menu.parent.id}" labelName="parent.name" labelValue="${menu.parent.name}"
						title="菜单" url="/sys/menu/treeData" extId="${menu.id}" cssClass="form-control required"/></td>
					 <td  class="width-15 active" valign="top"><label class="pull-left"><font color="red">*</font> 名称</label></td>
					 <td  class="width-35" ><form:input path="name" htmlEscape="false" maxlength="50" class="required form-control "/></td>
				  </tr>
				  <tr>
					 <td  class="width-15 active" valign="top"><label class="pull-left">链接</label></td>
					 <td class="width-35" ><form:input path="href" htmlEscape="false" maxlength="2000" class="form-control "/>
						<span class="help-inline">点击菜单跳转的页面</span></td>
					 <td  class="width-15 active" valign="top"><label class="pull-left">目标</label></td>
					 <td  class="width-35" ><form:input path="target" htmlEscape="false" maxlength="10" class="form-control "/>
						<span class="help-inline">链接打开的目标窗口，默认：mainFrame</span></td>
				  </tr>
				  <tr>
					 <td  class="width-15 active" valign="top"><label class="pull-left">图标</label></td>
					 <td class="width-35" ><sys:iconselect id="icon" name="icon" value="${menu.icon}"/></td>
					 <td  class="width-15 active" valign="top"><label class="pull-left">排序</label></td>
					 <td  class="width-35" ><form:input path="sort" htmlEscape="false" maxlength="50" class="required digits form-control "/>
						<span class="help-inline">排列顺序，升序。</span></td>
				  </tr>
				  <tr>
					 <td  class="width-15 active" valign="top"><label class="pull-left">可见</label></td>
					 <td class="width-35" >
						 <form:radiobuttons path="isShow" items="${fns:getDictList('show_hide')}" itemLabel="label" itemValue="value" htmlEscape="false" class="required i-checks "/>
						<span class="help-inline">该菜单或操作是否显示到系统菜单中</span></td>
					 <td  class="width-15 active" valign="top"><label class="pull-left">权限标识</label></td>
					 <td  class="width-35" ><form:input path="permission" htmlEscape="false" maxlength="100" class="form-control "/>
						<span class="help-inline">控制器中定义的权限标识，如：@RequiresPermissions("权限标识")</span></td>
				  </tr>
				  <tr>
					 <td  class="width-15 active" valign="top"><label class="pull-left">备注</label></td>
					 <td class="width-35" ><form:textarea path="remarks" htmlEscape="false" rows="3" maxlength="200" class="form-control "/></td>
					 <td  class="width-15 active" valign="top"><label class="pull-left"></label></td>
					 <td  class="width-35" ></td>
				  </tr>
				</tbody>
			  </table>
			<div id="iframeSave" class="form-group ${action}">
				<a class="btn btn-success" onclick="doSubmit();">保存</a>
				<a class="btn btn-primary" onclick="javascript:history.back(-1);">返回</a>
				<!--a class="btn btn-primary" onclick="top.closeSelectTabs()">关闭</a-->
			</div>
		</div>
	</form:form>
</body>
</html>