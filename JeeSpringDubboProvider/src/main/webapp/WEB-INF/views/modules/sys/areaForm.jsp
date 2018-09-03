<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>区域管理</title>
	<meta name="decorator" content="default"/>
	<%@ include file="/WEB-INF/views/include/head.jsp"%>
	<script src="/static/views/formSubmit.js" type="text/javascript"></script>
</head>
<body class="gray-bg">
	<form:form id="inputForm" modelAttribute="area" action="${ctx}/sys/area/save" method="post" class="form-horizontal content-background">
		<div class="content">
			<form:hidden path="id"/>
			<sys:message content="${message}"/>
			<table class="width-100 table-condensed dataTables-example dataTable no-footer">
			   <tbody>
				  <tr>
					 <td  class="width-15 active" valign="top"><label class="pull-left">上级区域</label></td>
					 <td class="width-35" ><sys:treeselect id="area" name="parent.id" value="${area.parent.id}" labelName="parent.name" labelValue="${area.parent.name}"
						title="区域" url="/sys/area/treeData" extId="${area.id}" cssClass="form-control m-s" allowClear="true"/></td>
					 <td  class="width-15 active" valign="top"><label class="pull-left">区域名称</label></td>
					 <td  class="width-35" ><form:input path="name" htmlEscape="false" maxlength="50" class="form-control required"/></td>
				  </tr>
				  <tr>
					 <td  class="width-15 active" valign="top"><label class="pull-left"><font color="red">*</font>区域编码</label></td>
					 <td class="width-35" ><form:input path="code" htmlEscape="false" maxlength="50" class="form-control"/></td>
					 <td  class="width-15 active" valign="top"><label class="pull-left">区域类型</label></td>
					 <td  class="width-35" ><form:select path="type" class="form-control">
						<form:options items="${fns:getDictList('sys_area_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						</form:select></td>
				  </tr>
				  <tr>
					 <td  class="width-15 active" valign="top"><label class="pull-left">备注</label></td>
					 <td class="width-35" ><form:textarea path="remarks" htmlEscape="false" rows="3" maxlength="200" class="form-control"/></td>
					 <td  class="width-15 active" valign="top"><label class="pull-left"></label></td>
					 <td  class="width-35" ></td>
				  </tr>
			</tbody>
			</table>
			<div id="iframeSave" class="form-group  ${action}">
				<a class="btn btn-success" onclick="doSubmit();">保存</a>
				<a class="btn btn-primary" onclick="javascript:history.back(-1);">返回</a>
				<!--a class="btn btn-primary" onclick="top.closeSelectTabs()">关闭</a-->
			</div>
		</div>
	</form:form>
</body>
</html>