<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>定时任务调度日志管理</title>
	<meta name="decorator" content="default"/>
	<%@ include file="/WEB-INF/views/include/head.jsp"%>
	<script src="/static/views/modules/job//sysJobLogForm.js" type="text/javascript"></script>
	<link href="/static/views/modules/job//sysJobLogForm.css" rel="stylesheet" />
</head>
<body  class="gray-bg">
		<form:form id="inputForm" modelAttribute="sysJobLog" action="${ctx}/job/sysJobLog/save" method="post" class="form-horizontal content-background">
			<div class="content">
				<form:hidden path="id"/>
				<sys:message content="${message}"/>
					<div class="form-group">
						<label class="col-sm-2 pull-left">任务名称<font color="red">*</font></label>
						<div class="col-sm-9 col-lg-10 col-xs-12">
								<form:input placeholder="任务名称" path="jobName" htmlEscape="false" maxlength="64" class="form-control required"/>
							<div class="help-block">请填写任务名称</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 pull-left">任务组名<font color="red">*</font></label>
						<div class="col-sm-9 col-lg-10 col-xs-12">
								<form:input placeholder="任务组名" path="jobGroup" htmlEscape="false" maxlength="64" class="form-control required"/>
							<div class="help-block">请填写任务组名</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 pull-left">任务方法</label>
						<div class="col-sm-9 col-lg-10 col-xs-12">
								<form:input placeholder="任务方法" path="methodName" htmlEscape="false" maxlength="500" class="form-control "/>
							<div class="help-block">请填写任务方法</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 pull-left">方法参数</label>
						<div class="col-sm-9 col-lg-10 col-xs-12">
								<form:input placeholder="方法参数" path="methodParams" htmlEscape="false" maxlength="200" class="form-control "/>
							<div class="help-block">请填写方法参数</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 pull-left">日志信息</label>
						<div class="col-sm-9 col-lg-10 col-xs-12">
								<form:input placeholder="日志信息" path="jobMessage" htmlEscape="false" maxlength="500" class="form-control "/>
							<div class="help-block">请填写日志信息</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 pull-left">执行状态（0正常 1失败）</label>
						<div class="col-sm-9 col-lg-10 col-xs-12">
								<form:radiobuttons path="status" items="${fns:getDictList('job_status')}" itemLabel="label" itemValue="value" htmlEscape="false" class="i-checks "/>
								<div class="help-block">请选择执行状态（0正常 1失败）</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 pull-left">异常信息</label>
						<div class="col-sm-9 col-lg-10 col-xs-12">
								<form:textarea path="exceptionInfo" htmlEscape="false" rows="4" class="form-control "/>
								<sys:ckeditor replace="exceptionInfo" height="400" uploadPath="/job/sysJobLog" />
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