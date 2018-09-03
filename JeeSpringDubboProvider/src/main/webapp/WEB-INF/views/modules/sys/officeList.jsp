<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>部门管理</title>
    <meta name="decorator" content="default"/>
    <%@ include file="/WEB-INF/views/include/head.jsp" %>
    <%@include file="/WEB-INF/views/include/treetable.jsp" %>
    <%@include file="/WEB-INF/views/include/treeview.jsp" %>
    <script type="text/javascript">
        $(document).ready(function () {
            var tpl = $("#treeTableTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g, "");
            var data = ${fns:toJson(list)}, rootId = "${not empty office.id ? office.id : '0'}";
            addRow("#treeTableList", tpl, data, rootId, true);
            $("#treeTable").treeTable({expandLevel: 5});
        });

        function addRow(list, tpl, data, pid, root) {
            for (var i = 0; i < data.length; i++) {
                var row = data[i];
                if ((${fns:jsGetVal('row.parentId')}) == pid) {
                    $(list).append(Mustache.render(tpl, {
                        dict: {
                            type: getDictLabel(${fns:toJson(fns:getDictList('sys_office_type'))}, row.type)
                        }, pid: (root ? 0 : pid), row: row
                    }));
                    addRow(list, tpl, data, row.id);
                }
            }
        }

        function refresh() {//刷新或者排序，页码不清零

            window.location = "${ctx}/sys/office/list";
        }
    </script>
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
                        <!-- 工具栏 -->
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="pull-left">
                                    <shiro:hasPermission name="sys:office:add">
                                        <table:addRow url="${ctx}/sys/office/form?parent.id=${office.id}" title="机构"
                                                      width="800px" height="620px"
                                                      target="officeContent"></table:addRow><!-- 增加按钮 -->
                                    </shiro:hasPermission>
                                    <button class="btn btn-white btn-sm " data-toggle="tooltip" data-placement="left"
                                            onclick="refresh()" title="刷新"><i class="glyphicon glyphicon-repeat"></i> 刷新
                                    </button>
                                </div>
                            </div>
                        </div>
                        <table id="treeTable" class="table table-hover table-condensed dataTables-example dataTable">
                            <thead>
                            <tr>
                                <th>部门名称</th>
                                <th>归属区域</th>
                                <th>部门编码</th>
                                <th>部门类型</th>
                                <th>备注</th>
                                <shiro:hasPermission name="sys:office:edit">
                                    <th>操作</th>
                                </shiro:hasPermission></tr>
                            </thead>
                            <tbody id="treeTableList"></tbody>
                        </table>
                    </div>
                </div>
                <script type="text/template" id="treeTableTpl">
                    <tr id="{{row.id}}" pId="{{pid}}">
                        <td><a href="#"
                               onclick="openDialogView('查看部门', '${ctx}/sys/office/form?id={{row.id}}','800px', '620px')">{{row.name}}</a>
                        </td>
                        <td>{{row.area.name}}</td>
                        <td>{{row.code}}</td>
                        <td>{{dict.type}}</td>
                        <td>{{row.remarks}}</td>
                        <td>
                            <shiro:hasPermission name="sys:office:view">
                                <a href="#"
                                   onclick="openDialogView('查看部门', '${ctx}/sys/office/form?id={{row.id}}&action=view','800px', '620px')"
                                   class="btn btn-success btn-sm"><i class="fa fa-search-plus"></i> 查看</a>
                            </shiro:hasPermission>
                            <shiro:hasPermission name="sys:office:edit">
                                <a href="#"
                                   onclick="openDialog('修改部门', '${ctx}/sys/office/form?id={{row.id}}','800px', '620px', 'officeContent')"
                                   class="btn btn-white btn-sm"><i class="fa fa-edit"></i> 修改</a>
                            </shiro:hasPermission>
                            <shiro:hasPermission name="sys:office:del">
                                <a href="${ctx}/sys/office/delete?id={{row.id}}"
                                   onclick="return confirmx('要删除该部门及所有子部门项吗？', this.href)" class="btn btn-white btn-sm"><i
                                        class="fa fa-trash"></i> 删除</a>
                            </shiro:hasPermission>
                            <shiro:hasPermission name="sys:office:add">
                                <a href="#"
                                   onclick="openDialog('添加下级部门', '${ctx}/sys/office/form?parent.id={{row.id}}','800px', '620px', 'officeContent')"
                                   class="btn  btn-white btn-sm"><i class="fa fa-plus"></i> 添加下级部门</a>
                            </shiro:hasPermission>
                        </td>
                    </tr>
                </script>
                <script type="text/javascript">
                    function refresh() {//刷新
                        window.location = "${ctx}/sys/office/list";
                    }

                    var setting = {
                        data: {simpleData: {enable: true, idKey: "id", pIdKey: "pId", rootPId: '0'}},
                        callback: {
                            onClick: function (event, treeId, treeNode) {
                                var id = treeNode.pId == '0' ? '' : treeNode.pId;
                                //$('#officeContent').attr("src","${ctx}/sys/office/list?id="+id+"&parentIds="+treeNode.pIds);
                                window.location = "${ctx}/sys/office/list?id=" + id + "&parentIds=" + treeNode.pIds;
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
            </div>
        </div>
    </div>
</body>
</html>