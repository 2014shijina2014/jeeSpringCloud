<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>用户管理</title>
    <meta name="decorator" content="default"/>
    <%@ include file="/WEB-INF/views/include/head.jsp" %>
    <%@include file="/WEB-INF/views/include/treeview.jsp" %>
</head>
<body class="gray-bg">
<div class="row">
    <div class="col-sm-2">
        <div class="ibox ibox-full">
            <div class="ibox-title">
                <i class="fa fa-th-list"></i>
                部门
                <a onclick="refresh()" class="pull-right">
                    <i class="fa fa-refresh"></i>
                </a>
            </div>
            <div id="ztree" class="ztree ibox-content"></div>
        </div>
    </div>
    <div class="col-sm-10">
        <div class="wrapper wrapper-content content-background">
            <div class="ibox">
                <div class="ibox-content content">
                    <sys:message content="${message}"/>
                    <!-- 查询条件 -->
                    <div class="row">
                        <div class="col-sm-12">
                            <form:form id="searchForm" modelAttribute="user" action="${ctx}/sys/user/list" method="post"
                                       class="form-inline">
                                <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
                                <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
                                <table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}"
                                                  callback="sortOrRefresh();"/><!-- 支持排序 -->
                                <div class="form-group">
                                    <span>归属公司：</span>
                                    <sys:treeselect id="company" name="company.id" value="${user.company.id}"
                                                    labelName="company.name" labelValue="${user.company.name}"
                                                    title="公司" url="/sys/office/treeData?type=1"
                                                    cssClass=" form-control input-sm" allowClear="true"/>
                                    <span>登录名：</span>
                                    <form:input path="loginName" htmlEscape="false" maxlength="50"
                                                class=" form-control input-sm"/>
                                    <span>归属部门：</span>
                                    <sys:treeselect id="office" name="office.id" value="${user.office.id}"
                                                    labelName="office.name" labelValue="${user.office.name}"
                                                    title="部门" url="/sys/office/treeData?type=2"
                                                    cssClass=" form-control input-sm" allowClear="true"
                                                    notAllowSelectParent="true"/>
                                    <span>姓&nbsp;&nbsp;&nbsp;名：</span>
                                    <form:input path="name" htmlEscape="false" maxlength="50"
                                                class=" form-control input-sm"/>

                                </div>
                            </form:form>
                            <br/>
                        </div>
                    </div>

                    <!-- 工具栏 -->
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="pull-left">
                                <button class="btn btn-success btn-sm " onclick="search()"><i class="fa fa-search"></i>
                                    查询
                                </button>
                                <button class="btn btn-success btn-sm "
                                        onclick="$('#searchForm').toggle();$('.fa-chevron').toggle();" title="检索">
                                    <i class="fa-chevron fa fa-chevron-up"></i><i class="fa-chevron fa fa-chevron-down"
                                                                                  style="display:none"></i> 检索
                                </button>
                                <shiro:hasPermission name="sys:user:add">
                                    <table:addRow url="${ctx}/sys/user/form" title="用户" width="800px" height="620px"
                                                  target="officeContent"></table:addRow><!-- 增加按钮 -->
                                </shiro:hasPermission>
                                <shiro:hasPermission name="sys:user:edit">
                                    <table:editRow url="${ctx}/sys/user/form" id="contentTable" title="用户" width="800px"
                                                   height="680px" target="officeContent"></table:editRow><!-- 编辑按钮 -->
                                </shiro:hasPermission>
                                <shiro:hasPermission name="sys:user:del">
                                    <table:delRow url="${ctx}/sys/user/deleteAll"
                                                  id="contentTable"></table:delRow><!-- 删除按钮 -->
                                </shiro:hasPermission>
                                <shiro:hasPermission name="sys:user:import">
                                    <table:importExcel url="${ctx}/sys/user/import"></table:importExcel><!-- 导入按钮 -->
                                </shiro:hasPermission>
                                <shiro:hasPermission name="sys:user:export">
                                    <table:exportExcel url="${ctx}/sys/user/export"></table:exportExcel><!-- 导出按钮 -->
                                </shiro:hasPermission>
                                <button class="btn btn-white btn-sm " data-toggle="tooltip" data-placement="left"
                                        onclick="sortOrRefresh()" title="刷新"><i class="glyphicon glyphicon-repeat"></i>
                                    刷新
                                </button>
                                <button class="btn btn-white btn-sm " onclick="reset()"><i class="fa fa-refresh"></i> 重置
                                </button>
                            </div>
                            <!-- <div class="pull-right">
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
                            </div> -->
                        </div>
                    </div>

                    <table id="contentTable" class="table table-hover table-condensed dataTables-example dataTable">
                        <thead>
                        <tr>
                            <th><input type="checkbox" class="i-checks"></th>
                            <th class="sort-column login_name">登录名</th>
                            <th class="sort-column name">姓名</th>
                            <th class="sort-column phone">电话</th>
                            <th class="sort-column mobile">手机</th>
                            <th class="sort-column c.name">归属公司</th>
                            <th class="sort-column o.name">归属部门</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${page.list}" var="user">
                            <tr>
                                <td><input type="checkbox" id="${user.id}" class="i-checks"></td>
                                <td><a href="#"
                                       onclick="openDialogView('查看用户', '${ctx}/sys/user/form?id=${user.id}','800px', '680px')">${user.loginName}</a>
                                </td>
                                <td>${user.name}</td>
                                <td>${user.phone}</td>
                                <td>${user.mobile}</td>
                                <td>${user.company.name}</td>
                                <td>${user.office.name}</td>
                                <td>
                                    <shiro:hasPermission name="sys:user:view">
                                        <a href="#"
                                           onclick="openDialogView('查看用户', '${ctx}/sys/user/form?id=${user.id}&action=view','800px', '680px')"
                                           class="btn btn-success btn-sm"><i class="fa fa-search-plus"></i> 查看</a>
                                    </shiro:hasPermission>
                                    <shiro:hasPermission name="sys:user:edit">
                                        <a href="#"
                                           onclick="openDialog('修改用户', '${ctx}/sys/user/form?id=${user.id}','800px', '700px', 'officeContent')"
                                           class="btn btn-white btn-sm"><i class="fa fa-edit"></i> 修改</a>
                                    </shiro:hasPermission>
                                    <shiro:hasPermission name="sys:user:del">
                                        <a href="${ctx}/sys/user/delete?id=${user.id}"
                                           onclick="return confirmx('确认要删除该用户吗？', this.href)"
                                           class="btn btn-white btn-sm"><i
                                                class="fa fa-trash"></i> 删除</a>
                                    </shiro:hasPermission>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    <table:page page="${page}"></table:page>
                    <br/>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    function refresh() {//刷新
        window.location= "${ctx}/sys/user/list";
    }
    var setting = {
        data: {simpleData: {enable: true, idKey: "id", pIdKey: "pId", rootPId: '0'}},
        callback: {
            onClick: function (event, treeId, treeNode) {
                var id = treeNode.id == '0' ? '' : treeNode.id;
                 window.location="${ctx}/sys/user/list?office.id=" + id + "&office.name=" + encodeURI(treeNode.name);
            }
        }
    };
    function refreshTree() {
        $.getJSON("${ctx}/sys/office/treeData", function (data) {
            $.fn.zTree.init($("#ztree"), setting, data).expandAll(true);
        });
    }
    refreshTree();
</script>
</body>
</html>