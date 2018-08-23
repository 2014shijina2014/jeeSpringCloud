<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>订单管理</title>
	<meta name="decorator" content="default"/>
	<%@ include file="/WEB-INF/views/include/head.jsp"%>
	<%@ include file="/WEB-INF/views/include/echarts.jsp"%>
	<script src="/static/views/modules/ylttrip//tfTicketList.js" type="text/javascript"></script>
	<link href="/static/views/modules/ylttrip//tfTicketList.css" rel="stylesheet" />
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content content-background">
	<div class="ibox">
    <div class="ibox-content content">
	<sys:message content="${message}"/>
	
	<!--查询条件-->
	<div class="row">
	<div class="col-sm-12">
	<form:form id="searchForm" modelAttribute="tfTicket" action="${ctx}/ylttrip/tfTicket/" method="post" class="form-inline">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
		<div class="form-group">
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
			<button  class="btn btn-success btn-sm " onclick="$('#total').toggle();$('.fa-chevron').toggle();"  title="统计">
				<i class="fa-chevron fa fa-chevron-up"></i><i class="fa-chevron fa fa-chevron-down" style="display:none"></i> 统计
			</button>
			<button  class="btn btn-success btn-sm " onclick="search()" title="查询"><i class="fa fa-search"></i> 查询</button>
			<shiro:hasPermission name="ylttrip:tfTicket:add">
				<table:addRow url="${ctx}/ylttrip/tfTicket/form" title="订单"></table:addRow><!-- 增加按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="ylttrip:tfTicket:edit">
			    <table:editRow url="${ctx}/ylttrip/tfTicket/form" title="订单" id="contentTable"></table:editRow><!-- 编辑按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="ylttrip:tfTicket:del">
				<table:delRow url="${ctx}/ylttrip/tfTicket/deleteAll" id="contentTable"></table:delRow><!-- 删除按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="ylttrip:tfTicket:import">
				<table:importExcel url="${ctx}/ylttrip/tfTicket/import"></table:importExcel><!-- 导入按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="ylttrip:tfTicket:export">
	       		<table:exportExcel url="${ctx}/ylttrip/tfTicket/export"></table:exportExcel><!-- 导出按钮 -->
	       	</shiro:hasPermission>
	        <button class="btn btn-white btn-sm " data-toggle="tooltip" data-placement="left" onclick="sortOrRefresh()" title="刷新"><i class="glyphicon glyphicon-repeat"></i> 刷新</button>
	       	<button  class="btn btn-white btn-sm " onclick="reset()"  title="重置"><i class="fa fa-refresh"></i> 重置</button>
		</div>
		<div class="pull-right">
			<button class="btn btn-white btn-sm " data-toggle="tooltip" data-placement="left" onclick="top.openTab('${ctx}/ylttrip/tfTicket/listVue','Vue订单', false)" title="Vue.js"><i class="glyphicon glyphicon-repeat"></i> Vue.js</button>
			<shiro:hasPermission name="ylttrip:tfTicket:total">
			<button class="btn btn-white btn-sm " data-toggle="tooltip" data-placement="left" onclick="top.openTab('${ctx}/ylttrip/tfTicket/total','统计订单', false)" title="统计图表"><i class="glyphicon glyphicon-repeat"></i> 统计图表</button>
			<button class="btn btn-white btn-sm " data-toggle="tooltip" data-placement="left" onclick="top.openTab('${ctx}/ylttrip/tfTicket/totalMap','统计订单', false)" title="统计地图"><i class="glyphicon glyphicon-repeat"></i> 统计地图</button>
			</shiro:hasPermission>
			<button class="btn btn-success " type="button" name="toggle" title="切换" onclick="$('.table').toggle()"><i class="glyphicon glyphicon-list-alt icon-list-alt"></i></button>
			<div class="btn-group" title="其他">
				<button class="btn btn-success btn-sm dropdown-toggle" data-toggle="dropdown" type="button" aria-expanded="false">
					<i class="glyphicon glyphicon-th icon-th"></i>
					<span class="caret"></span>
				</button>
				<ul class="dropdown-menu" role="menu">
					<li data-type="放大"><a href="javascript:void(0)" onclick="$('body').css({zoom:Number($('body').css('zoom'))+0.1})">放大</a></li>
					<li data-type="缩小"><a href="javascript:void(0)" onclick="$('body').css({zoom:$('body').css('zoom')-0.1})">缩小</a></li>
				</ul>
			</div>
		</div>
	</div>
	</div>

	<!-- 表格 -->
	<div class="table" style="display:none">
		<c:forEach items="${page.list}" var="tfTicket">
			<div style="border: 1px solid #e7eaec;padding: 8px;" class="row">
				<div>
				<input type="checkbox" id="${tfTicket.id}"
					ticketNo="${tfTicket.ticketNo}"
					goodsNo="${tfTicket.goodsNo}"
					goodsItemId="${tfTicket.goodsItemId}"
					goodsItemName="${tfTicket.goodsItemName}"
					goodsNum="${tfTicket.goodsNum}"
					price="${tfTicket.price}"
					salePrice="${tfTicket.salePrice}"
					user.id="${tfTicket.user.id}"
					linkPhone="${tfTicket.linkPhone}"
					payType="${tfTicket.payType}"
					checkinCode="${tfTicket.checkinCode}"
					reserveId="${tfTicket.reserveId}"
					remark="${tfTicket.remark}"
				class="i-checks">
				</div>
				<div class="col-xs-6 col-sm-4 col-md-3 col-lg-2">
				订单编号:
				<a  href="#" onclick="openDialogView('查看订单', '${ctx}/ylttrip/tfTicket/form?id=${tfTicket.id}','800px', '500px')">
					${tfTicket.ticketNo}
				</a></span>
						</div>
				<div class="col-xs-6 col-sm-4 col-md-3 col-lg-2">
				商品编号:
				
					${tfTicket.goodsNo}
				</span>
						</div>
				<div class="col-xs-6 col-sm-4 col-md-3 col-lg-2">
				种类编号:
				
					${tfTicket.goodsItemId}
				</span>
						</div>
				<div class="col-xs-6 col-sm-4 col-md-3 col-lg-2">
				种类名称:
				
					${tfTicket.goodsItemName}
				</span>
						</div>
				<div class="col-xs-6 col-sm-4 col-md-3 col-lg-2">
				商品数量:
				
					${tfTicket.goodsNum}
				</span>
						</div>
				<div class="col-xs-6 col-sm-4 col-md-3 col-lg-2">
				商品单价:
				
					${tfTicket.price}
				</span>
						</div>
				<div class="col-xs-6 col-sm-4 col-md-3 col-lg-2">
				订单金额:
				
					${tfTicket.salePrice}
				</span>
						</div>
				<div class="col-xs-6 col-sm-4 col-md-3 col-lg-2">
				下单人:
				
					${tfTicket.user.name}
				</span>
						</div>
				<div class="col-xs-6 col-sm-4 col-md-3 col-lg-2">
				联系电话:
				
					${tfTicket.linkPhone}
				</span>
						</div>
				<div class="col-xs-6 col-sm-4 col-md-3 col-lg-2">
				付款方式:
				
					${fns:getDictLabel(tfTicket.payType, 'PAY_TYPE', '')}
				</span>
						</div>
				<div class="col-xs-6 col-sm-4 col-md-3 col-lg-2">
				入园号:
				
					${tfTicket.checkinCode}
				</span>
						</div>
				<div class="col-xs-6 col-sm-4 col-md-3 col-lg-2">
				票务系统订单号:
				
					${tfTicket.reserveId}
				</span>
						</div>
				<div class="col-xs-6 col-sm-4 col-md-3 col-lg-2">
				订单备注:
				
					${tfTicket.remark}
				</span>
						</div>
				<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
					<shiro:hasPermission name="ylttrip:tfTicket:view">
						<a href="#" onclick="openDialogView('查看订单', '${ctx}/ylttrip/tfTicket/form?id=${tfTicket.id}&action=view','800px', '500px')" class="btn btn-info btn-sm" title="查看"><i class="fa fa-search-plus"></i>查看</a>
					</shiro:hasPermission>
					<shiro:hasPermission name="ylttrip:tfTicket:edit">
    					<a href="#" onclick="openDialog('修改订单', '${ctx}/ylttrip/tfTicket/form?id=${tfTicket.id}','800px', '500px')" class="btn btn-success btn-sm" title="修改"><i class="fa fa-edit"></i>修改</a>
    				</shiro:hasPermission>
					<shiro:hasPermission name="ylttrip:tfTicket:edit">
    					<a href="#" onclick="top.openTab('${ctx}/ylttrip/tfTicket/form?id=${tfTicket.id}','修改订单', false)" title="修改" class="btn btn-success btn-sm" title="修改(页签)"><i class="fa fa-edit"></i>修改(页签)</a>
    				</shiro:hasPermission>
    				<shiro:hasPermission name="ylttrip:tfTicket:edit">
    					<a href="#" onclick="top.openTab('${ctx}/ylttrip/tfTicket/form?id=${tfTicket.id}&ViewFormType=FormTwo','修改订单', false)" title="修改2" class="btn btn-success btn-sm" title="修改(页签)2"><i class="fa fa-edit"></i>修改(页签)2</a>
    				</shiro:hasPermission>
    				<shiro:hasPermission name="ylttrip:tfTicket:del">
						<a href="${ctx}/ylttrip/tfTicket/delete?id=${tfTicket.id}" onclick="return confirmx('确认要删除该订单吗？', this.href)"   class="btn btn-danger btn-sm"  title="删除"><i class="fa fa-trash"></i>删除</a>
					</shiro:hasPermission>
				</div>
			</div>
		</c:forEach>
	</div>

	<!-- 表格 -->
	<table id="contentTable" class="table table-hover table-condensed dataTables-example dataTable">
		<thead>
			<tr>
				<th> <input type="checkbox" class="i-checks"></th>
				<th  class="sort-column ticketNo ">订单编号</th>
				<th  class="sort-column goodsNo ">商品编号</th>
				<th  class="sort-column goodsItemId ">种类编号</th>
				<th  class="sort-column goodsItemName hidden-xs">种类名称</th>
				<th  class="sort-column goodsNum hidden-xs">商品数量</th>
				<th  class="sort-column price hidden-xs">商品单价</th>
				<th  class="sort-column salePrice hidden-xs">订单金额</th>
				<th  class="sort-column user.name hidden-xs">下单人</th>
				<th  class="sort-column linkPhone hidden-xs">联系电话</th>
				<th  class="sort-column payType hidden-xs">付款方式</th>
				<th  class="sort-column checkinCode hidden-xs">入园号</th>
				<th  class="sort-column reserveId hidden-xs">票务系统订单号</th>
				<th  class="sort-column remark hidden-xs">订单备注</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="tfTicket">
			<tr>
				<td>
				<input type="checkbox" id="${tfTicket.id}"
					ticketNo="${tfTicket.ticketNo}"
					goodsNo="${tfTicket.goodsNo}"
					goodsItemId="${tfTicket.goodsItemId}"
					goodsItemName="${tfTicket.goodsItemName}"
					goodsNum="${tfTicket.goodsNum}"
					price="${tfTicket.price}"
					salePrice="${tfTicket.salePrice}"
					user.id="${tfTicket.user.id}"
					linkPhone="${tfTicket.linkPhone}"
					payType="${tfTicket.payType}"
					checkinCode="${tfTicket.checkinCode}"
					reserveId="${tfTicket.reserveId}"
				class="i-checks"></td>
				<td class=""><a  href="#" onclick="openDialogView('查看订单', '${ctx}/ylttrip/tfTicket/form?id=${tfTicket.id}&action=view','800px', '500px')">
					${tfTicket.ticketNo}
				</a></td>
				<td class="">
					${tfTicket.goodsNo}
				</td>
				<td class="">
					${tfTicket.goodsItemId}
				</td>
				<td class="hidden-xs">
					${tfTicket.goodsItemName}
				</td>
				<td class="hidden-xs">
					${tfTicket.goodsNum}
				</td>
				<td class="hidden-xs">
					${tfTicket.price}
				</td>
				<td class="hidden-xs">
					${tfTicket.salePrice}
				</td>
				<td class="hidden-xs">
					${tfTicket.user.name}
				</td>
				<td class="hidden-xs">
					${tfTicket.linkPhone}
				</td>
				<td class="hidden-xs">
					${fns:getDictLabel(tfTicket.payType, 'PAY_TYPE', '')}
				</td>
				<td class="hidden-xs">
					${tfTicket.checkinCode}
				</td>
				<td class="hidden-xs">
					${tfTicket.reserveId}
				</td>
				<td class="hidden-xs">
					${tfTicket.remark}
				</td>
				<td>
					<shiro:hasPermission name="ylttrip:tfTicket:view">
						<a href="#" onclick="openDialogView('查看订单', '${ctx}/ylttrip/tfTicket/form?id=${tfTicket.id}&action=view','800px', '500px')" class="btn btn-info btn-sm" title="查看"><i class="fa fa-search-plus"></i>查看</a>
					</shiro:hasPermission>
					<shiro:hasPermission name="ylttrip:tfTicket:edit">
    					<!--a href="#" onclick="openDialog('修改订单', '${ctx}/ylttrip/tfTicket/form?id=${tfTicket.id}','800px', '500px',null,true)" class="btn btn-success btn-sm" title="修改(弹窗)"><i class="fa fa-edit"></i>修改(弹窗)</a-->
    				</shiro:hasPermission>
    				 <shiro:hasPermission name="ylttrip:tfTicket:edit">
    					<a href="${ctx}/ylttrip/tfTicket/form?id=${tfTicket.id}" title="修改" class="btn btn-success btn-sm" title="修改"><i class="fa fa-edit"></i>修改</a>
    				</shiro:hasPermission>
    				<shiro:hasPermission name="ylttrip:tfTicket:edit">
    					<!--a href="#" onclick="top.openTab('${ctx}/ylttrip/tfTicket/form?id=${tfTicket.id}','修改订单', false)" title="修改" class="btn btn-success btn-sm" title="修改(页签)"><i class="fa fa-edit"></i>修改(页签)</a-->
    				</shiro:hasPermission>
    				<shiro:hasPermission name="ylttrip:tfTicket:edit">
    					<!--a href="#" onclick="top.openTab('${ctx}/ylttrip/tfTicket/form?id=${tfTicket.id}&ViewFormType=FormTwo','修改订单', false)" title="修改2" class="btn btn-success btn-sm" title="修改(页签)2"><i class="fa fa-edit"></i>修改(页签)2</a-->
    				</shiro:hasPermission>
    				<shiro:hasPermission name="ylttrip:tfTicket:del">
						<a href="${ctx}/ylttrip/tfTicket/delete?id=${tfTicket.id}" onclick="return confirmx('确认要删除该订单吗？', this.href)"   class="btn btn-danger btn-sm" title="删除"><i class="fa fa-trash"></i>删除</a>
					</shiro:hasPermission>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
		<!-- 分页代码 -->
	<table:page page="${page}"></table:page>
	<br/>
		<!-- 统计 -->
	<div class="row" id="total" style="margin-top: 10px;">
		<div class="col-sm-12 echartsEval">
			<h4>合计：${sumTotalCount}行;
商品数量：${sumGoodsNum};
商品单价：${sumPrice};
订单金额：${sumSalePrice};
			</h4>
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

	</div>
	</div>
</div>
</body>
</html>