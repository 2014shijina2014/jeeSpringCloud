<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ include file="/WEB-INF/views/include/echarts.jsp"%>
<meta name="decorator" content="default"/>
<%@ include file="/WEB-INF/views/include/head.jsp"%>
	<script src="/static/views/modules/ylttrip//tfTicketTotal.js" type="text/javascript"></script>
	<link href="/static/views/modules/ylttrip//tfTicketTotal.css" rel="stylesheet" />

	<div class="wrapper wrapper-content content-background">
	<div class="ibox">
    <div class="ibox-content">
		<!--查询条件-->
<div class="row">
<div class="col-sm-12">
	<form:form id="searchForm" modelAttribute="tfTicket" action="${ctx}/ylttrip/tfTicket/total" method="post" class="form-inline">
	<div class="form-group">
		<input id="run" type="checkbox" value="true" name="run" checked/>自动刷新
		<form:select path="totalType"  class="form-control m-b">
			<form:option value="" label=""/>
			<form:options items="${fns:getDictList('total_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
		</form:select>
		<span>订单编号：</span>
		<form:input path="ticketNo" htmlEscape="false" maxlength="25"  class=" form-control input-sm"/>
		<span>商品编号：</span>
		<form:input path="goodsNo" htmlEscape="false" maxlength="25"  class=" form-control input-sm"/>
		<span>种类编号：</span>
		<form:input path="goodsItemId" htmlEscape="false" maxlength="255"  class=" form-control input-sm"/>
		<span>种类名称：</span>
		<form:input path="goodsItemName" htmlEscape="false" maxlength="255"  class=" form-control input-sm"/>
		<span>商品数量：</span>
		<form:input path="goodsNum" htmlEscape="false" maxlength="11"  class=" form-control input-sm"/>
		<span>商品单价：</span>
		<form:input path="price" htmlEscape="false"  class=" form-control input-sm"/>
		<span>订单金额：</span>
		<form:input path="salePrice" htmlEscape="false"  class=" form-control input-sm"/>
		<span>下单人：</span>
	<sys:treeselect id="user" name="user.id" value="${tfTicket.user.id}" labelName="user.name" labelValue="${tfTicket.user.name}"
	title="用户" url="/sys/office/treeData?type=3" cssClass="form-control input-sm" allowClear="true" notAllowSelectParent="true"/>
		<span>下单时间：</span>
	<input id="beginOrderDate" name="beginOrderDate" type="text" maxlength="20" class="laydate-icon form-control layer-date input-sm"
		   value="<fmt:formatDate value="${tfTicket.beginOrderDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"/> -
	<input id="endOrderDate" name="endOrderDate" type="text" maxlength="20" class="laydate-icon form-control layer-date input-sm"
		   value="<fmt:formatDate value="${tfTicket.endOrderDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"/>
		<span>订单状态：</span>
	<form:radiobuttons class="i-checks" path="state" items="${fns:getDictList('STATE')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
		<span>状态时间：</span>
	<input id="beginStateDate" name="beginStateDate" type="text" maxlength="20" class="laydate-icon form-control layer-date input-sm"
		   value="<fmt:formatDate value="${tfTicket.beginStateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"/> -
	<input id="endStateDate" name="endStateDate" type="text" maxlength="20" class="laydate-icon form-control layer-date input-sm"
		   value="<fmt:formatDate value="${tfTicket.endStateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"/>
		<span>客户姓名：</span>
		<form:input path="custName" htmlEscape="false" maxlength="50"  class=" form-control input-sm"/>
		<span>联系电话：</span>
		<form:input path="linkPhone" htmlEscape="false" maxlength="50"  class=" form-control input-sm"/>
		<span>付款方式：</span>
	<form:radiobuttons class="i-checks" path="payType" items="${fns:getDictList('PAY_TYPE')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
		</div>
		</form:form>
<br/>
		</div>
		</div>

			<!-- 工具栏 -->
	<div class="row">
		<div class="col-sm-12">
			<div class="pull-left">
					<button  class="btn btn-success btn-sm " onclick="$('#searchForm').toggle();$('.fa-chevron').toggle();"  title="检索">
						<i class="fa-chevron fa fa-chevron-up"></i><i class="fa-chevron fa fa-chevron-down" style="display:none"></i> 检索
					</button>
					<button  class="btn btn-success btn-sm " onclick="search()" ><i class="fa fa-search"></i> 查询</button>
			</div>
			<div class="pull-right">
				<div class="btn-group" title="其他">
					<button class="btn btn-success btn-sm dropdown-toggle" data-toggle="dropdown" type="button" aria-expanded="false">
						<i class="glyphicon glyphicon-th icon-th"></i>
						<span class="caret"></span>
					</button>
					<ul class="dropdown-menu" role="menu">
						<li data-type="放大"><a href="javascript:void(0)" onclick="$('body').css({zoom:Number($('body').css('zoom'))+0.1});$('body .echartsEval script').each(function(){eval($(this).html())});">放大</a></li>
						<li data-type="缩小"><a href="javascript:void(0)" onclick="$('body').css({zoom:$('body').css('zoom')-0.1});$('body .echartsEval script').each(function(){eval($(this).html())});">缩小</a></li>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<div class="row" style="margin-top: 10px;">
		<div class="col-sm-12 echartsEval">
			<div id="pie"  class="main000"></div>
			<echarts:pie
					id="pie"
					title="订单数量饼图"
					subtitle="订单数量饼图"
					orientData="${orientData}"/>
			<!--div id="pieSumGoodsNum"  class="main000"></div-->
			<!--xxx-echarts:pie
					id="pieSumGoodsNum"
					title="订单商品数量饼图"
					subtitle="订单商品数量饼图"
					orientData="${orientDataSumGoodsNum}"/-->
			<!--div id="pieSumPrice"  class="main000"></div-->
			<!--xxx-echarts:pie
					id="pieSumPrice"
					title="订单商品单价饼图"
					subtitle="订单商品单价饼图"
					orientData="${orientDataSumPrice}"/-->
			<!--div id="pieSumSalePrice"  class="main000"></div-->
			<!--xxx-echarts:pie
					id="pieSumSalePrice"
					title="订单订单金额饼图"
					subtitle="订单订单金额饼图"
					orientData="${orientDataSumSalePrice}"/-->

			<div id="line_normal"  class="main000"></div>
			<echarts:line
			id="line_normal"
			title="订单曲线"
			subtitle="订单曲线"
			xAxisData="${xAxisData}"
			yAxisData="${yAxisData}"
			xAxisName="时间"
			yAxisName="数量" />
		</div>
	</div>
	<!-- 表格 -->
	<table class="table table-striped table-bordered table-hover table-condensed dataTables-example dataTable">
		<thead>
			<tr>
				<th>时间段</th>
				<th>数量</th>
				<th>商品数量</th>
				<th>商品单价</th>
				<th>订单金额</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${list}" var="tfTicket">
		<tr>
			<td>${tfTicket.totalDate}</td>
			<td style="text-align: right;" class="totalCount">${tfTicket.totalCount}</td>
			<td  style="text-align: right;" class="sumGoodsNum">${tfTicket.sumGoodsNum}</td>
			<td  style="text-align: right;" class="sumPrice">${tfTicket.sumPrice}</td>
			<td  style="text-align: right;" class="sumSalePrice">${tfTicket.sumSalePrice}</td>
		</tr>
		</c:forEach>
		</tbody>
		<tfoot>
			<tr id="totalRow">
				<td>合计：</td>
				<td id="totalCount"  style="text-align: right;"><script>sumColumn("totalCount");</script></td>
				<td  id="sumGoodsNum" style="text-align: right;"><script>sumColumn("sumGoodsNum");</script></td>
				<td  id="sumPrice" style="text-align: right;"><script>sumColumn("sumPrice");</script></td>
				<td  id="sumSalePrice" style="text-align: right;"><script>sumColumn("sumSalePrice");</script></td>
			</tr>
		</tfoot>
	</table>
</div>
</div>
</div>