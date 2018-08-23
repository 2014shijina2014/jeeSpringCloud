<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>订单管理</title>
	<meta name="decorator" content="default"/>
	<%@ include file="/WEB-INF/views/include/head.jsp"%>
	<script src="/static/views/modules/ylttrip//tfTicketForm.js" type="text/javascript"></script>
	<link href="/static/views/modules/ylttrip//tfTicketForm.css" rel="stylesheet" />
</head>
<body class="gray-bg">
	<form:form id="inputForm" modelAttribute="tfTicket" action="${ctx}/ylttrip/tfTicket/save" method="post" class="form-horizontal  content-background">
		<div class="content">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>	
		<table class="width-100 table-condensed dataTables-example dataTable no-footer">
		   <tbody>
				<tr>
					<td class="width-15 active" valign="top"><label class="pull-left"><font color="red">*</font>订单编号：</label></td>
					<td class="width-35">
							<form:input path="ticketNo" htmlEscape="false" maxlength="25" class="form-control required"/>
						<div class="help-block">请填写订单编号</div>
						</td>
					<td class="width-15 active" valign="top"><label class="pull-left">商品编号：</label></td>
					<td class="width-35">
							<form:input path="goodsNo" htmlEscape="false" maxlength="25" class="form-control "/>
						<div class="help-block">请填写商品编号</div>
						</td>
					</tr>
				<tr>
					<td class="width-15 active" valign="top"><label class="pull-left">种类编号：</label></td>
					<td class="width-35">
							<form:input path="goodsItemId" htmlEscape="false" maxlength="255" class="form-control "/>
						<div class="help-block">请填写种类编号</div>
						</td>
					<td class="width-15 active" valign="top"><label class="pull-left">种类名称：</label></td>
					<td class="width-35">
							<form:input path="goodsItemName" htmlEscape="false" maxlength="255" class="form-control "/>
						<div class="help-block">请填写种类名称</div>
						</td>
					</tr>
				<tr>
					<td class="width-15 active" valign="top"><label class="pull-left">商品数量：</label></td>
					<td class="width-35">
							<form:input path="goodsNum" htmlEscape="false" maxlength="11" class="form-control  digits"/>
						<div class="help-block">请填写商品数量</div>
						</td>
					<td class="width-15 active" valign="top"><label class="pull-left">商品单价：</label></td>
					<td class="width-35">
							<form:input path="price" htmlEscape="false" class="form-control  number"/>
						<div class="help-block">请填写商品单价</div>
						</td>
					</tr>
				<tr>
					<td class="width-15 active" valign="top"><label class="pull-left">订单金额：</label></td>
					<td class="width-35">
							<form:input path="salePrice" htmlEscape="false" class="form-control  number"/>
						<div class="help-block">请填写订单金额</div>
						</td>
					<td class="width-15 active" valign="top"><label class="pull-left">下单人：</label></td>
					<td class="width-35">
							<sys:treeselect id="user" name="user.id" value="${tfTicket.user.id}" labelName="user.name" labelValue="${tfTicket.user.name}"
								title="用户" url="/sys/office/treeData?type=3" cssClass="form-control " allowClear="true" notAllowSelectParent="true"/>
							<div class="help-block">请选择下单人</div>
						</td>
					</tr>
				<tr>
					<td class="width-15 active" valign="top"><label class="pull-left">下单时间：</label></td>
					<td class="width-35">
							<input id="orderDate" name="orderDate" type="text" maxlength="20" class="laydate-icon form-control layer-date "
								value="<fmt:formatDate value="${tfTicket.orderDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"/>
							<div class="help-block">请选择下单时间</div>
						</td>
					<td class="width-15 active" valign="top"><label class="pull-left">订单状态：</label></td>
					<td class="width-35">
							<form:radiobuttons path="state" items="${fns:getDictList('STATE')}" itemLabel="label" itemValue="value" htmlEscape="false" class="i-checks "/>
							<div class="help-block">请选择订单状态</div>
						</td>
					</tr>
				<tr>
					<td class="width-15 active" valign="top"><label class="pull-left">状态时间：</label></td>
					<td class="width-35">
							<input id="stateDate" name="stateDate" type="text" maxlength="20" class="laydate-icon form-control layer-date "
								value="<fmt:formatDate value="${tfTicket.stateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"/>
							<div class="help-block">请选择状态时间</div>
						</td>
					<td class="width-15 active" valign="top"><label class="pull-left">客户姓名：</label></td>
					<td class="width-35">
							<form:input path="custName" htmlEscape="false" maxlength="50" class="form-control "/>
						<div class="help-block">请填写客户姓名</div>
						</td>
					</tr>
				<tr>
					<td class="width-15 active" valign="top"><label class="pull-left">联系电话：</label></td>
					<td class="width-35">
							<form:input path="linkPhone" htmlEscape="false" maxlength="50" class="form-control "/>
						<div class="help-block">请填写联系电话</div>
						</td>
					<td class="width-15 active" valign="top"><label class="pull-left">收货地址：</label></td>
					<td class="width-35">
							<form:input path="address" htmlEscape="false" maxlength="500" class="form-control "/>
						<div class="help-block">请填写收货地址</div>
						</td>
					</tr>
				<tr>
					<td class="width-15 active" valign="top"><label class="pull-left">付款方式：</label></td>
					<td class="width-35">
							<form:radiobuttons path="payType" items="${fns:getDictList('PAY_TYPE')}" itemLabel="label" itemValue="value" htmlEscape="false" class="i-checks "/>
							<div class="help-block">请选择付款方式</div>
						</td>
					<td class="width-15 active" valign="top"><label class="pull-left">入园号：</label></td>
					<td class="width-35">
							<form:input path="checkinCode" htmlEscape="false" maxlength="255" class="form-control "/>
						<div class="help-block">请填写入园号</div>
						</td>
					</tr>
				<tr>
					<td class="width-15 active" valign="top"><label class="pull-left">票务系统订单号：</label></td>
					<td class="width-35">
							<form:input path="reserveId" htmlEscape="false" maxlength="30" class="form-control "/>
						<div class="help-block">请填写票务系统订单号</div>
						</td>
					<td></td><td></td></tr><tr>
					<td class="width-15 active" valign="top"><label class="pull-left">订单备注：</label></td>
					<td class="width-35" colspan="3">
							<form:textarea path="remark" htmlEscape="false" rows="4" maxlength="500" class="form-control "/>
							<sys:ckeditor replace="remark" height="400" uploadPath="/ylttrip/tfTicket" />
						</td>
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