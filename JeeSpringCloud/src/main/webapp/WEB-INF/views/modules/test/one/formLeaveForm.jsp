<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>请假单管理</title>
	<meta name="decorator" content="default"/>
	<%@ include file="/WEB-INF/views/include/head.jsp"%>
	<script src="/static/views/modules/test/one/formLeaveForm.js" type="text/javascript"></script>
	<link href="/static/views/modules/test/one/formLeaveForm.css" rel="stylesheet" />
</head>
<body  class="gray-bg">
		<form:form id="inputForm" modelAttribute="formLeave" action="${ctx}/test/one/formLeave/save" method="post" class="form-horizontal content-background">
			<div class="content">
				<form:hidden path="id"/>
				<sys:message content="${message}"/>
					<div class="form-group">
						<label class="col-sm-2 pull-left">员工<font color="red">*</font></label>
						<div class="col-sm-9 col-lg-10 col-xs-12">
								<sys:treeselect id="user" name="user.id" value="${formLeave.user.id}" labelName="user.name" labelValue="${formLeave.user.name}"
									title="用户" url="/sys/office/treeData?type=3" cssClass="form-control required" allowClear="true" notAllowSelectParent="true"/>
								<div class="help-block">请选择员工</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 pull-left">归属部门<font color="red">*</font></label>
						<div class="col-sm-9 col-lg-10 col-xs-12">
								<sys:treeselect id="office" name="office.id" value="${formLeave.office.id}" labelName="office.name" labelValue="${formLeave.office.name}"
									title="部门" url="/sys/office/treeData?type=2" cssClass="form-control required" allowClear="true" notAllowSelectParent="true"/>
								<div class="help-block">请选择归属部门</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 pull-left">归属区域</label>
						<div class="col-sm-9 col-lg-10 col-xs-12">
								<sys:treeselect id="area" name="area.id" value="${formLeave.area.id}" labelName="area.name" labelValue="${formLeave.area.name}"
									title="区域" url="/sys/area/treeData" cssClass="form-control " allowClear="true" notAllowSelectParent="true"/>
								<div class="help-block">请选择归属区域</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 pull-left">请假开始日期<font color="red">*</font></label>
						<div class="col-sm-9 col-lg-10 col-xs-12">
								<input id="beginDate" name="beginDate" type="text" maxlength="20" class="laydate-icon form-control layer-date required"
									value="<fmt:formatDate value="${formLeave.beginDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"/>
								<div class="help-block">请选择请假开始日期</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 pull-left">请假结束日期<font color="red">*</font></label>
						<div class="col-sm-9 col-lg-10 col-xs-12">
								<input id="endDate" name="endDate" type="text" maxlength="20" class="laydate-icon form-control layer-date required"
									value="<fmt:formatDate value="${formLeave.endDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"/>
								<div class="help-block">请选择请假结束日期</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 pull-left">备注信息</label>
						<div class="col-sm-9 col-lg-10 col-xs-12">
								<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="form-control "/>
						</div>
					</div>
				<div id="iframeSave" class="form-group ${action}">
					<a class="btn btn-success" onclick="doSubmit();">保存</a>
					<a class="btn btn-primary" onclick="javascript:history.back(-1);">返回</a>
					<!--a class="btn btn-primary" onclick="top.closeSelectTabs()">关闭</a-->
				</div>
			</div>
	</form:form>
</body>
</html>