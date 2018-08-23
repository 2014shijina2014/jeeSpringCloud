<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>通知管理</title>
	<meta name="decorator" content="default"/>
	<%@ include file="/WEB-INF/views/include/head.jsp"%>
	<script src="/static/views/formSubmit.js" type="text/javascript"></script>
</head>
<body class="gray-bg">
	<form:form id="inputForm" modelAttribute="oaNotify" action="${ctx}/oa/oaNotify/save" method="post" class="form-horizontal  content-background">
		<div class="content">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
				<div class="form-group">
					<label class="col-sm-2 pull-left">类型<font color="red">*</font></label>
					<div class="col-sm-9 col-lg-10 col-xs-12">
						<form:select path="type" class="form-control required">
							<form:option value="" label=""/>
							<form:options items="${fns:getDictList('oa_notify_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						</form:select>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 pull-left">标题<font color="red">*</font></label>
					<div class="col-sm-9 col-lg-10 col-xs-12">
		         		<form:input path="title" htmlEscape="false" maxlength="200" class="form-control required"/>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 pull-left">内容<font color="red">*</font></label>
					<div class="col-sm-9 col-lg-10 col-xs-12">
		         		<form:textarea path="content" htmlEscape="false" rows="6" maxlength="2000" class="form-control required"/>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 pull-left">附件：</label>
					<div class="col-sm-9 col-lg-10 col-xs-12">
						 <c:if test="${oaNotify.status ne '1'}">
							<form:hidden id="files" path="files" htmlEscape="false" maxlength="255" class="form-control"/>
							<sys:ckfinder input="files" type="files" uploadPath="/oa/notify" selectMultiple="true"/>
						</c:if>
						 <c:if test="${oaNotify.status eq '1'}">
							<form:hidden id="files" path="files" htmlEscape="false" maxlength="255" class="form-control"/>
							<sys:ckfinder input="files" type="files" uploadPath="/oa/notify" selectMultiple="true" readonly="true" />
						 </c:if>
					</div>
				</div>
		      
		      <c:if test="${oaNotify.status ne '1'}">
				<div class="form-group">
					<label class="col-sm-2 pull-left">状态<font color="red">*</font></label>
					<div class="col-sm-9 col-lg-10 col-xs-12">
						 <form:radiobuttons path="status" items="${fns:getDictList('oa_notify_status')}" itemLabel="label" itemValue="value" htmlEscape="false" class="i-checks required"/>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 pull-left">接受人<font color="red">*</font></label>
					<div class="col-sm-9 col-lg-10 col-xs-12">
			         	<sys:treeselect id="oaNotifyRecord" name="oaNotifyRecordIds" value="${oaNotify.oaNotifyRecordIds}" labelName="oaNotifyRecordNames" labelValue="${oaNotify.oaNotifyRecordNames}"
							title="用户" url="/sys/office/treeData?type=3" cssClass="form-control required" notAllowSelectParent="true" checked="true"/>
					</div>
				</div>
			</c:if>
				<c:if test="${oaNotify.status eq '1'}">
				<div class="form-group">
					<label class="col-sm-2 pull-left">接受人：</label>
					<div class="col-sm-9 col-lg-10 col-xs-12">
						 <table id="contentTable" class="table table-striped table-hover table-condensed dataTables-example dataTable">
							<thead>
								<tr>
									<th>接受人</th>
									<th>接受部门</th>
									<th>阅读状态</th>
									<th>阅读时间</th>
								</tr>
							</thead>
							<tbody>
							<c:forEach items="${oaNotify.oaNotifyRecordList}" var="oaNotifyRecord">
								<tr>
									<td>
										${oaNotifyRecord.user.name}
									</td>
									<td>
										${oaNotifyRecord.user.office.name}
									</td>
									<td>
										${fns:getDictLabel(oaNotifyRecord.readFlag, 'oa_notify_read', '')}
									</td>
									<td>
										<fmt:formatDate value="${oaNotifyRecord.readDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
									</td>
								</tr>
							</c:forEach>
							</tbody>
						</table>
						已查阅：${oaNotify.readNum} &nbsp; 未查阅：${oaNotify.unReadNum} &nbsp; 总共：${oaNotify.readNum + oaNotify.unReadNum}</td>
					</div>
				</div>
		</c:if>
			<div id="iframeSave" class="form-group ${action}">
				<a class="btn btn-success" onclick="doSubmit();">保存</a>
				<a class="btn btn-primary" onclick="javascript:history.back(-1);">返回</a>
				<!--a class="btn btn-primary" onclick="top.closeSelectTabs()">关闭</a-->
			</div>
		</div>
	</form:form>
</body>
</html>