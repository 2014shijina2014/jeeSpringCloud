<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>服务器监控管理</title>
	<meta name="decorator" content="default"/>
	<%@ include file="/WEB-INF/views/include/head.jsp"%>
	<script src="/static/views/modules/sys//sysServerForm.js" type="text/javascript"></script>
	<link href="/static/views/modules/sys//sysServerForm.css" rel="stylesheet" />
</head>
<body  class="gray-bg">
		<form:form id="inputForm" modelAttribute="sysServer" action="${ctx}/sys/sysServer/save" method="post" class="form-horizontal content-background">
			<div class="content">
				<form:hidden path="id"/>
				<sys:message content="${message}"/>
					<div class="form-group">
						<label class="col-sm-2 pull-left">服务器编号</label>
						<div class="col-sm-9 col-lg-10 col-xs-12">
								<form:input placeholder="服务器编号" path="serverNumber" htmlEscape="false" maxlength="255" class="form-control "/>
							<div class="help-block">请填写服务器编号</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 pull-left">服务器监控地址</label>
						<div class="col-sm-9 col-lg-10 col-xs-12">
								<form:input placeholder="服务器监控地址" path="serverAddress" htmlEscape="false" maxlength="100" class="form-control "/>
							<div class="help-block">请填写服务器监控地址</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 pull-left">名称</label>
						<div class="col-sm-9 col-lg-10 col-xs-12">
								<form:input placeholder="名称" path="name" htmlEscape="false" maxlength="255" class="form-control "/>
							<div class="help-block">请填写名称</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 pull-left">标签名</label>
						<div class="col-sm-9 col-lg-10 col-xs-12">
								<form:input placeholder="标签名" path="label" htmlEscape="false" maxlength="50" class="form-control "/>
							<div class="help-block">请填写标签名</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 pull-left">图片</label>
						<div class="col-sm-9 col-lg-10 col-xs-12">
								<form:hidden id="picture" path="picture" htmlEscape="false" maxlength="100" class="form-control"/>
								<sys:ckfinder input="picture" type="files" uploadPath="/sys/sysServer" selectMultiple="true"/>
								<div class="help-block">请上传图片</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 pull-left">类型</label>
						<div class="col-sm-9 col-lg-10 col-xs-12">
								<form:radiobuttons path="type" items="${fns:getDictList('server_type')}" itemLabel="label" itemValue="value" htmlEscape="false" class="i-checks "/>
								<div class="help-block">请选择类型</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 pull-left">排序（升序）<font color="red">*</font></label>
						<div class="col-sm-9 col-lg-10 col-xs-12">
								<form:input placeholder="排序（升序）" path="sort" htmlEscape="false" class="form-control required digits"/>
							<div class="help-block">请填写排序（升序）</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 pull-left">描述</label>
						<div class="col-sm-9 col-lg-10 col-xs-12">
								<form:input placeholder="描述" path="description" htmlEscape="false" maxlength="100" class="form-control "/>
							<div class="help-block">请填写描述</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 pull-left">备注信息</label>
						<div class="col-sm-9 col-lg-10 col-xs-12">
								<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="100" class="form-control "/>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 pull-left">备注信息</label>
						<div class="col-sm-9 col-lg-10 col-xs-12">
								<form:textarea path="html" htmlEscape="false" rows="4" class="form-control "/>
								<sys:ckeditor replace="html" height="400" uploadPath="/sys/sysServer" />
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 pull-left">在线状态on_line在线off_line离线</label>
						<div class="col-sm-9 col-lg-10 col-xs-12">
								<form:radiobuttons path="status" items="${fns:getDictList('on_line_status')}" itemLabel="label" itemValue="value" htmlEscape="false" class="i-checks "/>
								<div class="help-block">请选择在线状态on_line在线off_line离线</div>
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