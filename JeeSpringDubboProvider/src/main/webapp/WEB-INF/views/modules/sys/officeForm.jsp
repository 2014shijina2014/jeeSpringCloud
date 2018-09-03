<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>部门管理</title>
	<meta name="decorator" content="default"/>
		    <%@ include file="/WEB-INF/views/include/head.jsp"%>
	<script src="/static/views/formSubmit.js" type="text/javascript"></script>
</head>
<body  class="gray-bg">
	<form:form id="inputForm" modelAttribute="office" action="${ctx}/sys/office/save" method="post" class="form-horizontal content-background">
		<div class="content">
			<form:hidden path="id"/>
			<sys:message content="${message}"/>
			<table class="width-100 table-condensed dataTables-example dataTable no-footer">
			   <tbody>
				  <tr>
					 <td class="width-15 active" valign="top"><label class="pull-left">上级部门</label></td>
					 <td class="width-35"><sys:treeselect id="office" name="parent.id" value="${office.parent.id}" labelName="parent.name" labelValue="${office.parent.name}"
						title="部门" url="/sys/office/treeData" extId="${office.id}"  cssClass="form-control" allowClear="${office.currentUser.admin}"/></td>
					 <td  class="width-15 active" valign="top"><label class="pull-left"><font color="red">*</font>归属区域</label></td>
					 <td class="width-35"><sys:treeselect id="area" name="area.id" value="${office.area.id}" labelName="area.name" labelValue="${office.area.name}"
						title="区域" url="/sys/area/treeData" cssClass="form-control required"/></td>
				  </tr>
				   <tr>
					 <td class="width-15 active" valign="top"><label class="pull-left"><font color="red">*</font>部门名称</label></td>
					 <td class="width-35"><form:input path="name" htmlEscape="false" maxlength="50" class="form-control required"/></td>
					 <td  class="width-15 active" valign="top"><label class="pull-left">部门编码</label></td>
					 <td class="width-35"><form:input path="code" htmlEscape="false" maxlength="50" class="form-control"/></td>
				  </tr>
				   <tr>
					 <td class="width-15 active"  valign="top"><label class="pull-left">部门类型</label></td>
					 <td class="width-35"><form:select path="type" class="form-control">
						<form:options items="${fns:getDictList('sys_office_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						</form:select></td>
					 <td  class="width-15 active" valign="top"><label class="pull-left">部门级别</label></td>
					 <td class="width-35"><form:select path="grade" class="form-control">
						<form:options items="${fns:getDictList('sys_office_grade')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						</form:select></td>
				  </tr>
				  <tr>
					 <td class="width-15 active"  valign="top"><label class="pull-left">是否可用</label></td>
					 <td class="width-35"><form:select path="useable" class="form-control">
						<form:options items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						</form:select>
						<span class="help-inline">“是”代表此账号允许登陆，“否”则表示此账号不允许登陆</span></td>
					 <td class="width-15 active" valign="top"><label class="pull-left">主负责人</label></td>
					 <td class="width-35"><sys:treeselect id="primaryPerson" name="primaryPerson.id" value="${office.primaryPerson.id}" labelName="office.primaryPerson.name" labelValue="${office.primaryPerson.name}"
						title="用户" url="/sys/office/treeData?type=3" cssClass="form-control" allowClear="true" notAllowSelectParent="true"/></td>
				  </tr>
				  <tr>
					 <td class="width-15 active" valign="top"><label class="pull-left">副负责人</label></td>
					 <td class="width-35"><sys:treeselect id="deputyPerson" name="deputyPerson.id" value="${office.deputyPerson.id}" labelName="office.deputyPerson.name" labelValue="${office.deputyPerson.name}"
						title="用户" url="/sys/office/treeData?type=3" cssClass="form-control" allowClear="true" notAllowSelectParent="true"/></td>
					 <td class="width-15 active" valign="top"><label class="pull-left">联系地址</label></td>
					 <td class="width-35"><form:input path="address" htmlEscape="false" maxlength="50" cssClass="form-control" /></td>
				  </tr>
				  <tr>
					 <td class="width-15 active" valign="top"><label class="pull-left">邮政编码</label></td>
					 <td class="width-35"><form:input path="zipCode" htmlEscape="false" maxlength="50" cssClass="form-control" /></td>
					 <td  class="width-15 active" valign="top"><label class="pull-left">负责人</label></td>
					 <td class="width-35"><form:input path="master" htmlEscape="false" maxlength="50" cssClass="form-control" /></td>
				  </tr>
				  <tr>
					 <td class="width-15 active" valign="top"><label class="pull-left">电话</label></td>
					 <td class="width-35"><form:input path="phone" htmlEscape="false" maxlength="50" cssClass="form-control" /></td>
					 <td  class="width-15 active" valign="top"><label class="pull-left">传真</label></td>
					 <td class="width-35"><form:input path="fax" htmlEscape="false" maxlength="50" cssClass="form-control" /></td>
				  </tr>
				  <tr>
					 <td class="width-15 active"  valign="top"><label class="pull-left">邮箱</label></td>
					 <td class="width-35"><form:input path="email" htmlEscape="false" maxlength="50" cssClass="form-control" /></td>
					 <td  class="width-15 active" valign="top"><label class="pull-left">备注</label></td>
					 <td class="width-35"><form:textarea path="remarks" htmlEscape="false" rows="3" maxlength="200" class="form-control"/></td>
				  </tr>
			  </tbody>
			  </table>
			<div id="iframeSave" class="form-group ${param.action} ${action}">
				<a class="btn btn-success" onclick="doSubmit();">保存</a>
				<a class="btn btn-primary" onclick="javascript:history.back(-1);">返回</a>
				<!--a class="btn btn-primary" onclick="top.closeSelectTabs()">关闭</a-->
			</div>
		</div>
	</form:form>
</body>
</html>