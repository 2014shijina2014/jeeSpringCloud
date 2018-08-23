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
<body  class="gray-bg">
		<form:form id="inputForm" modelAttribute="tfTicket" action="${ctx}/ylttrip/tfTicket/save" method="post" class="form-horizontal content-background">
			<div class="content">
				<form:hidden path="id"/>
				<sys:message content="${message}"/>
					<div class="form-group">
						<label class="col-sm-2 pull-left">订单编号<font color="red">*</font></label>
						<div class="col-sm-9 col-lg-10 col-xs-12">
								<form:input placeholder="订单编号" path="ticketNo" htmlEscape="false" maxlength="25" class="form-control required"/>
							<div class="help-block">请填写订单编号</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 pull-left">商品编号</label>
						<div class="col-sm-9 col-lg-10 col-xs-12">
								<form:input placeholder="商品编号" path="goodsNo" htmlEscape="false" maxlength="25" class="form-control "/>
							<div class="help-block">请填写商品编号</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 pull-left">种类编号</label>
						<div class="col-sm-9 col-lg-10 col-xs-12">
								<form:input placeholder="种类编号" path="goodsItemId" htmlEscape="false" maxlength="255" class="form-control "/>
							<div class="help-block">请填写种类编号</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 pull-left">种类名称</label>
						<div class="col-sm-9 col-lg-10 col-xs-12">
								<form:input placeholder="种类名称" path="goodsItemName" htmlEscape="false" maxlength="255" class="form-control "/>
							<div class="help-block">请填写种类名称</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 pull-left">商品数量</label>
						<div class="col-sm-9 col-lg-10 col-xs-12">
								<form:input placeholder="商品数量" path="goodsNum" htmlEscape="false" maxlength="11" class="form-control  digits"/>
							<div class="help-block">请填写商品数量</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 pull-left">商品单价</label>
						<div class="col-sm-9 col-lg-10 col-xs-12">
								<form:input placeholder="商品单价" path="price" htmlEscape="false" class="form-control  number"/>
							<div class="help-block">请填写商品单价</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 pull-left">订单金额</label>
						<div class="col-sm-9 col-lg-10 col-xs-12">
								<form:input placeholder="订单金额" path="salePrice" htmlEscape="false" class="form-control  number"/>
							<div class="help-block">请填写订单金额</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 pull-left">下单人</label>
						<div class="col-sm-9 col-lg-10 col-xs-12">
								<sys:treeselect id="user" name="user.id" value="${tfTicket.user.id}" labelName="user.name" labelValue="${tfTicket.user.name}"
									title="用户" url="/sys/office/treeData?type=3" cssClass="form-control " allowClear="true" notAllowSelectParent="true"/>
								<div class="help-block">请选择下单人</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 pull-left">下单时间</label>
						<div class="col-sm-9 col-lg-10 col-xs-12">
								<input id="orderDate" name="orderDate" type="text" maxlength="20" class="laydate-icon form-control layer-date "
									value="<fmt:formatDate value="${tfTicket.orderDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"/>
								<div class="help-block">请选择下单时间</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 pull-left">订单状态</label>
						<div class="col-sm-9 col-lg-10 col-xs-12">
								<form:radiobuttons path="state" items="${fns:getDictList('STATE')}" itemLabel="label" itemValue="value" htmlEscape="false" class="i-checks "/>
								<div class="help-block">请选择订单状态</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 pull-left">状态时间</label>
						<div class="col-sm-9 col-lg-10 col-xs-12">
								<input id="stateDate" name="stateDate" type="text" maxlength="20" class="laydate-icon form-control layer-date "
									value="<fmt:formatDate value="${tfTicket.stateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"/>
								<div class="help-block">请选择状态时间</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 pull-left">客户姓名</label>
						<div class="col-sm-9 col-lg-10 col-xs-12">
								<form:input placeholder="客户姓名" path="custName" htmlEscape="false" maxlength="50" class="form-control "/>
							<div class="help-block">请填写客户姓名</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 pull-left">联系电话</label>
						<div class="col-sm-9 col-lg-10 col-xs-12">
								<form:input placeholder="联系电话" path="linkPhone" htmlEscape="false" maxlength="50" class="form-control "/>
							<div class="help-block">请填写联系电话</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 pull-left">收货地址</label>
						<div class="col-sm-9 col-lg-10 col-xs-12">
								<form:input placeholder="收货地址" path="address" htmlEscape="false" maxlength="500" class="form-control "/>
							<div class="help-block">请填写收货地址</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 pull-left">付款方式</label>
						<div class="col-sm-9 col-lg-10 col-xs-12">
								<form:radiobuttons path="payType" items="${fns:getDictList('PAY_TYPE')}" itemLabel="label" itemValue="value" htmlEscape="false" class="i-checks "/>
								<div class="help-block">请选择付款方式</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 pull-left">入园号</label>
						<div class="col-sm-9 col-lg-10 col-xs-12">
								<form:input placeholder="入园号" path="checkinCode" htmlEscape="false" maxlength="255" class="form-control "/>
							<div class="help-block">请填写入园号</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 pull-left">票务系统订单号</label>
						<div class="col-sm-9 col-lg-10 col-xs-12">
								<form:input placeholder="票务系统订单号" path="reserveId" htmlEscape="false" maxlength="30" class="form-control "/>
							<div class="help-block">请填写票务系统订单号</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 pull-left">订单备注</label>
						<div class="col-sm-9 col-lg-10 col-xs-12">
								<form:textarea path="remark" htmlEscape="false" rows="4" maxlength="500" class="form-control "/>
								<sys:ckeditor replace="remark" height="400" uploadPath="/ylttrip/tfTicket" />
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