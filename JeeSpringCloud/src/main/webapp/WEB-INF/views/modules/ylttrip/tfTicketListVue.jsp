<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>订单管理</title>
	<meta name="decorator" content="default"/>
	<%@ include file="/WEB-INF/views/include/head.jsp"%>
	<script src="/static/views/modules/ylttrip//tfTicketList.js" type="text/javascript"></script>
	<link href="/static/views/modules/ylttrip//tfTicketList.css" rel="stylesheet" />
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content"  id="rrapp">
		<div class="ibox">
		<!--div class="ibox-title">
			<h5>订单列表 </h5>
		</div-->

		<div class="ibox-content">
		<sys:message content="${message}"/>

		<!--查询条件-->
		<div class="row">
		<div class="col-sm-12">
		<form:form id="searchForm" modelAttribute="tfTicket" action="${ctx}/../rest/ylttrip/tfTicket/list" method="post" class="form-inline">
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
				<button  class="btn btn-success btn-sm " @click="search()" title="查询"><i class="fa fa-search"></i> 查询</button>
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
				<button class="btn btn-white btn-sm " data-toggle="tooltip" data-placement="left" onclick="top.openTab('${ctx}/ylttrip/tfTicket','订单', false)" title="list"><i class="glyphicon glyphicon-repeat"></i> list</button>
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
				<div style="border: 1px solid #e7eaec;padding: 8px;" class="row" v-for="item in page">
					<div>
					<input type="checkbox" :id="item.id"
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
					<a  href="#" v-on:onclick="openDialogView('查看订单', '${ctx}/ylttrip/tfTicket/form?id='+item.id,'800px', '500px')">
						{{item.ticketNo}}
					</a></span>
							</div>
					<div class="col-xs-6 col-sm-4 col-md-3 col-lg-2">
					商品编号:
					
						{{item.goodsNo}}
					</span>
							</div>
					<div class="col-xs-6 col-sm-4 col-md-3 col-lg-2">
					种类编号:
					
						{{item.goodsItemId}}
					</span>
							</div>
					<div class="col-xs-6 col-sm-4 col-md-3 col-lg-2">
					种类名称:
					
						{{item.goodsItemName}}
					</span>
							</div>
					<div class="col-xs-6 col-sm-4 col-md-3 col-lg-2">
					商品数量:
					
						{{item.goodsNum}}
					</span>
							</div>
					<div class="col-xs-6 col-sm-4 col-md-3 col-lg-2">
					商品单价:
					
						{{item.price}}
					</span>
							</div>
					<div class="col-xs-6 col-sm-4 col-md-3 col-lg-2">
					订单金额:
					
						{{item.salePrice}}
					</span>
							</div>
					<div class="col-xs-6 col-sm-4 col-md-3 col-lg-2">
					下单人:
					
						{{item.user.name}}
					</span>
							</div>
					<div class="col-xs-6 col-sm-4 col-md-3 col-lg-2">
					联系电话:
					
						{{item.linkPhone}}
					</span>
							</div>
					<div class="col-xs-6 col-sm-4 col-md-3 col-lg-2">
					付款方式:
					
						{{item.payTypeLabel}}
					</span>
							</div>
					<div class="col-xs-6 col-sm-4 col-md-3 col-lg-2">
					入园号:
					
						{{item.checkinCode}}
					</span>
							</div>
					<div class="col-xs-6 col-sm-4 col-md-3 col-lg-2">
					票务系统订单号:
					
						{{item.reserveId}}
					</span>
							</div>
					<div class="col-xs-6 col-sm-4 col-md-3 col-lg-2">
					订单备注:
					
						{{item.remark}}
					</span>
							</div>
					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
						<shiro:hasPermission name="ylttrip:tfTicket:view">
							<a href="#" onclick="openDialogView('查看订单', '${ctx}/ylttrip/tfTicket/form?id='+item.id,'800px', '500px')" class="btn btn-info btn-sm" title="查看"><i class="fa fa-search-plus"></i> 查看</a>
						</shiro:hasPermission>
						<shiro:hasPermission name="ylttrip:tfTicket:edit">
							<a href="#" onclick="openDialog('修改订单', '${ctx}/ylttrip/tfTicket/form?id='+item.id,'800px', '500px')" class="btn btn-success btn-sm" title="修改"><i class="fa fa-edit"></i> 修改</a>
						</shiro:hasPermission>
						<shiro:hasPermission name="ylttrip:tfTicket:del">
							<a href="${ctx}/ylttrip/tfTicket/delete?id='+item.id" onclick="return confirmx('确认要删除该订单吗？', this.href)"   class="btn btn-danger btn-sm"  title="删除"><i class="fa fa-trash"></i> 删除</a>
						</shiro:hasPermission>
					</div>
				</div>
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
				<tr  v-for="item in page" >
					<td>
					<input type="checkbox" :id="item.id"
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
					class="i-checks"></td>
					<td  class=""><a  href="#" v-on:click="openDialogView('查看订单', '${ctx}/ylttrip/tfTicket/form?id='+item.id,'800px', '500px')">
					{{item.ticketNo}}
					</a></td>
					<td  class="">
					{{item.goodsNo}}
					</td>
					<td  class="">
					{{item.goodsItemId}}
					</td>
					<td  class="hidden-xs">
					{{item.goodsItemName}}
					</td>
					<td  class="hidden-xs">
					{{item.goodsNum}}
					</td>
					<td  class="hidden-xs">
					{{item.price}}
					</td>
					<td  class="hidden-xs">
					{{item.salePrice}}
					</td>
					<td  class="hidden-xs">
					{{item.user.name}}
					</td>
					<td  class="hidden-xs">
					{{item.linkPhone}}
					</td>
					<td  class="hidden-xs">
					{{item.payTypeLabel}}
					</td>
					<td  class="hidden-xs">
					{{item.checkinCode}}
					</td>
					<td  class="hidden-xs">
					{{item.reserveId}}
					</td>
					<td  class="hidden-xs">
					{{item.remark}}
					</td>
					<td>
						<shiro:hasPermission name="ylttrip:tfTicket:view">
							<a href="#" v-on:click="openDialogView('查看订单', '${ctx}/ylttrip/tfTicket/form?id='+item.id,'800px', '500px')" class="btn btn-info btn-sm" title="查看"><i class="fa fa-search-plus"></i> </a>
						</shiro:hasPermission>
						<shiro:hasPermission name="ylttrip:tfTicket:edit">
							<a href="#" v-on:click="openDialog('修改订单', '${ctx}/ylttrip/tfTicket/form?id='+item.id,'800px', '500px')" class="btn btn-success btn-sm" title="修改"><i class="fa fa-edit"></i> </a>
						</shiro:hasPermission>
						<shiro:hasPermission name="ylttrip:tfTicket:edit">
    						<a href="#" v-on:click="top.openTab('${ctx}/ylttrip/tfTicket/form?id='+item.id,'修改订单', false)" title="修改" class="btn btn-success btn-sm" title=" 修改(页签)"><i class="fa fa-edit"></i></a>
    					</shiro:hasPermission>
						<shiro:hasPermission name="ylttrip:tfTicket:del">
							<a v-bind:href="'${ctx}/ylttrip/tfTicket/delete?id='+item.id" onclick="return confirmx('确认要删除该订单吗？', this.href)"   class="btn btn-danger btn-sm" title="删除"><i class="fa fa-trash"></i> </a>
						</shiro:hasPermission>
					</td>
				</tr>
			</tbody>
		</table>
			<!-- 分页代码 -->
			<div v-html="result.html">
				{{result.html}}
			</div>
		<br/>
		<br/>
		</div>
		</div>
	</div>
	<script src="/static/vue/vue.min.js"></script>
	<script src="/static/common/SpringUI.js"></script>
</body>
</html>