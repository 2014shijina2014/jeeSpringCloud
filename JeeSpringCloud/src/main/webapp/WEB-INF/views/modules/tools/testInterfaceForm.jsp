<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>接口管理</title>
	<meta name="decorator" content="default"/>
			    <%@ include file="/WEB-INF/views/include/head.jsp"%>
	<script type="text/javascript">
		var validateForm;
		function doSubmit(){//回调函数，在编辑和保存动作时，供openDialog调用提交表单。
		  if(validateForm.form()){
			  $("#inputForm").submit();
			  return true;
		  }
	
		  return false;
		}
		$(document).ready(function() {
			validateForm = $("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
			
		});
	</script>
</head>
<body  class="gray-bg">
		<form:form id="inputForm" modelAttribute="testInterface" action="${ctx}/tools/testInterface/save" method="post" class="form-horizontal content-background">
		<div class="content">
			<form:hidden path="id"/>
			<sys:message content="${message}"/>
			<table class="width-100 table-condensed dataTables-example dataTable no-footer">
			   <tbody>
					<tr>
						<td class="width-15 active" valign="top"><label class="pull-left">接口名称</label></td>
						<td class="width-35">
							<form:input path="name" htmlEscape="false" maxlength="1024" class="form-control "/>
						</td>
						<td class="width-15 active" valign="top"><label class="pull-left">接口类型</label></td>
						<td class="width-35">
							<form:select path="type" class="form-control ">
								<form:option value="" label=""/>
								<form:options items="${fns:getDictList('interface_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
							</form:select>
						</td>
					</tr>
					<tr>
						<td class="width-15 active" valign="top"><label class="pull-left">请求URL</label></td>
						<td class="width-35">
							<form:input path="url" htmlEscape="false" maxlength="256" class="form-control "/>
						</td>
						<td class="width-15 active" valign="top"><label class="pull-left">请求body</label></td>
						<td class="width-35">
							<form:input path="body" htmlEscape="false" maxlength="2048" class="form-control "/>
						</td>
					</tr>
					<tr>
						<td class="width-15 active" valign="top"><label class="pull-left">成功时返回消息</label></td>
						<td class="width-35">
							<form:input path="successmsg" htmlEscape="false" maxlength="512" class="form-control "/>
						</td>
						<td class="width-15 active" valign="top"><label class="pull-left">失败时返回消息</label></td>
						<td class="width-35">
							<form:input path="errormsg" htmlEscape="false" maxlength="512" class="form-control "/>
						</td>
					</tr>
					<tr>
						<td class="width-15 active" valign="top"><label class="pull-left">备注</label></td>
						<td class="width-35">
							<form:textarea path="comment" htmlEscape="false" maxlength="512" class="form-control "/>
						</td>
						<td class="width-15 active"></td>
						<td class="width-35" ></td>
					</tr>
				</tbody>
			</table>
			<div id="iframeSave" class="form-group  ${action}">
				<a class="btn btn-success" onclick="doSubmit();">保存</a>
				<a class="btn btn-primary" onclick="top.closeSelectTabs()">关闭</a>
			</div>
		</div>
	</form:form>
</body>
</html>