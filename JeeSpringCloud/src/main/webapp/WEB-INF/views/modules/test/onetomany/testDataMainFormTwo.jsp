<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>订票管理</title>
	<meta name="decorator" content="default"/>
	<%@ include file="/WEB-INF/views/include/head.jsp"%>
	<script src="/static/views/modules/test/onetomany/testDataMainForm.js" type="text/javascript"></script>
	<link href="/static/views/modules/test/onetomany/testDataMainForm.css" rel="stylesheet" />
</head>
<body  class="gray-bg">
	<form:form id="inputForm" modelAttribute="testDataMain" action="${ctx}/test/onetomany/testDataMain/save" method="post" class="form-horizontal content-background">
		<div class="content">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>	
		<table class="width-100 table-condensed dataTables-example dataTable no-footer">
		   <tbody>
				<tr>
					<td class="width-15 active" valign="top"><label class="pull-left"><font color="red">*</font>归属用户：</label></td>
					<td class="width-35">
						<sys:treeselect id="user" name="user.id" value="${testDataMain.user.id}" labelName="user.name" labelValue="${testDataMain.user.name}"
							title="用户" url="/sys/office/treeData?type=3" cssClass="form-control required" allowClear="true" notAllowSelectParent="true"/>
						<div class="help-block">请选择归属用户</div>
					</td>
					<td class="width-15 active" valign="top"><label class="pull-left"><font color="red">*</font>归属部门：</label></td>
					<td class="width-35">
						<sys:treeselect id="office" name="office.id" value="${testDataMain.office.id}" labelName="office.name" labelValue="${testDataMain.office.name}"
							title="部门" url="/sys/office/treeData?type=2" cssClass="form-control required" allowClear="true" notAllowSelectParent="true"/>
						<div class="help-block">请选择归属部门</div>
					</td>
				</tr>
				<tr>
					<td class="width-15 active" valign="top"><label class="pull-left"><font color="red">*</font>归属区域：</label></td>
					<td class="width-35">
						<sys:treeselect id="area" name="area.id" value="${testDataMain.area.id}" labelName="area.name" labelValue="${testDataMain.area.name}"
							title="区域" url="/sys/area/treeData" cssClass="form-control required" allowClear="true" notAllowSelectParent="true"/>
						<div class="help-block">请选择归属区域</div>
					</td>
					<td class="width-15 active" valign="top"><label class="pull-left"><font color="red">*</font>名称：</label></td>
					<td class="width-35">
						<form:input path="name" htmlEscape="false" maxlength="100" class="form-control required"/>
					<div class="help-block">请填写名称</div>
					</td>
				</tr>
				<tr>
					<td class="width-15 active" valign="top"><label class="pull-left"><font color="red">*</font>性别：</label></td>
					<td class="width-35">
						<form:radiobuttons path="sex" items="${fns:getDictList('sex')}" itemLabel="label" itemValue="value" htmlEscape="false" class="i-checks required"/>
						<div class="help-block">请选择性别</div>
					</td>
					<td class="width-15 active" valign="top"><label class="pull-left"><font color="red">*</font>加入日期：</label></td>
					<td class="width-35">
						<input id="inDate" name="inDate" type="text" maxlength="20" class="laydate-icon form-control layer-date required"
							value="<fmt:formatDate value="${testDataMain.inDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"/>
						<div class="help-block">请选择加入日期</div>
					</td>
				</tr>
				<tr>
					<td></td></tr><tr>
					<td class="width-15 active" valign="top"><label class="pull-left">备注信息：</label></td>
					<td class="width-35" colspan="3">
						<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="form-control "/>
					</td>
				</tr>
		 	</tbody>
		</table>
		
		<div class="tabs-container">
            <ul class="nav nav-tabs">
				<li class="active"><a data-toggle="tab" href="#tab-1" aria-expanded="true">火车：</a>
                </li>
				<li class=""><a data-toggle="tab" href="#tab-2" aria-expanded="false">飞机：</a>
                </li>
				<li class=""><a data-toggle="tab" href="#tab-3" aria-expanded="false">汽车：</a>
                </li>
            </ul>
            <div class="tab-content">
				<div id="tab-1" class="tab-pane active">
			<a class="btn btn-warning btn-sm" onclick="addRow('#testDataChildList', testDataChildRowIdx, testDataChildTpl);testDataChildRowIdx = testDataChildRowIdx + 1;" title="新增"><i class="fa fa-plus"></i> 新增</a>
			<table id="contentTable" class="table table-striped table-condensed">
				<thead>
					<tr>
						<th class="hide"></th>
						<th>出发地<font color="red">*</font></th>
						<th>目的地<font color="red">*</font></th>
						<th>代理价格<font color="red">*</font></th>
						<th>备注信息</th>
						<th width="10">&nbsp;</th>
					</tr>
				</thead>
				<tbody id="testDataChildList">
				</tbody>
			</table>
			<script type="text/template" id="testDataChildTpl">//<!--
				<tr id="testDataChildList{{idx}}">
					<td class="hide">
						<input id="testDataChildList{{idx}}_id" name="testDataChildList[{{idx}}].id" type="hidden" value="{{row.id}}"/>
						<input id="testDataChildList{{idx}}_delFlag" name="testDataChildList[{{idx}}].delFlag" type="hidden" value="0"/>
					</td>
					<td  class="max-width-250">
						<sys:treeselect id="testDataChildList{{idx}}_start" name="testDataChildList[{{idx}}].start.id" value="{{row.start.id}}" labelName="testDataChildList{{idx}}.start.name" labelValue="{{row.start.name}}"
							title="区域" url="/sys/area/treeData" cssClass="form-control  required" allowClear="true" notAllowSelectParent="true"/>
					</td>
					
					<td  class="max-width-250">
						<sys:treeselect id="testDataChildList{{idx}}_end" name="testDataChildList[{{idx}}].end.id" value="{{row.end.id}}" labelName="testDataChildList{{idx}}.end.name" labelValue="{{row.end.name}}"
							title="区域" url="/sys/area/treeData" cssClass="form-control  required" allowClear="true" notAllowSelectParent="true"/>
					</td>
					
					<td>
						<input id="testDataChildList{{idx}}_price" name="testDataChildList[{{idx}}].price" type="text" value="{{row.price}}" class="form-control required number"/>
					</td>
					
					<td>
						<textarea id="testDataChildList{{idx}}_remarks" name="testDataChildList[{{idx}}].remarks" rows="4" maxlength="255" class="form-control ">{{row.remarks}}</textarea>
					</td>
					
					<td class="text-center" width="10">
						{{#delBtn}}<span class="close" onclick="delRow(this, '#testDataChildList{{idx}}')" title="删除">&times;</span>{{/delBtn}}
					</td>
				</tr>//-->
			</script>

			<script type="text/template" id="testDataChildTpl2">//<!--
				<tr id="testDataChildList{{idx}}">
					<td class="hide">
						<input id="testDataChildList{{idx}}_id" name="testDataChildList[{{idx}}].id" type="hidden" value="{{row.id}}"/>
						<input id="testDataChildList{{idx}}_delFlag" name="testDataChildList[{{idx}}].delFlag" type="hidden" value="0"/>
					</td>
					<td>
					<div>
					<div>
					</div>
					<div>
						出发地<font color="red">*</font><sys:treeselect id="testDataChildList{{idx}}_start" name="testDataChildList[{{idx}}].start.id" value="{{row.start.id}}" labelName="testDataChildList{{idx}}.start.name" labelValue="{{row.start.name}}"
							title="区域" url="/sys/area/treeData" cssClass="form-control  required" allowClear="true" notAllowSelectParent="true"/>
					</div>
					<div>
					</div>
					<div>
						目的地<font color="red">*</font><sys:treeselect id="testDataChildList{{idx}}_end" name="testDataChildList[{{idx}}].end.id" value="{{row.end.id}}" labelName="testDataChildList{{idx}}.end.name" labelValue="{{row.end.name}}"
							title="区域" url="/sys/area/treeData" cssClass="form-control  required" allowClear="true" notAllowSelectParent="true"/>
					</div>
					<div>
					</div>
					<div>
						代理价格<font color="red">*</font><input id="testDataChildList{{idx}}_price" name="testDataChildList[{{idx}}].price" type="text" value="{{row.price}}" class="form-control required number"/>
					</div>
					<div>
					<div>
					<div>
					<div>
					<div>
					<div>
					</div>
					<div>
						备注信息<textarea id="testDataChildList{{idx}}_remarks" name="testDataChildList[{{idx}}].remarks" rows="4" maxlength="255" class="form-control ">{{row.remarks}}</textarea>
					</div>
					<div>
					</td>
					<td class="text-center" width="10">
						{{#delBtn}}<span class="close" onclick="delRow(this, '#testDataChildList{{idx}}')" title="删除">&times;</span>{{/delBtn}}
					</td>
				</tr>//-->
			</script>

			<script type="text/javascript">
				var tpl="${param.Tpl}";
				if(tpl==null || tpl=="") tpl="Tpl";
				if(tpl=="Tpl2"){
					$("#contentTable>thead").remove();
				}
				var testDataChildRowIdx = 0, testDataChildTpl = $("#testDataChild"+tpl).html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
				$(document).ready(function() {
					var data = ${fns:toJson(testDataMain.testDataChildList)};
					for (var i=0; i<data.length; i++){
						addRow('#testDataChildList', testDataChildRowIdx, testDataChildTpl, data[i]);
						testDataChildRowIdx = testDataChildRowIdx + 1;
					}
				});
			</script>
			</div>
				<div id="tab-2" class="tab-pane">
			<a class="btn btn-warning btn-sm" onclick="addRow('#testDataChild2List', testDataChild2RowIdx, testDataChild2Tpl);testDataChild2RowIdx = testDataChild2RowIdx + 1;" title="新增"><i class="fa fa-plus"></i> 新增</a>
			<table id="contentTable" class="table table-striped table-condensed">
				<thead>
					<tr>
						<th class="hide"></th>
						<th>出发地<font color="red">*</font></th>
						<th>目的地<font color="red">*</font></th>
						<th>代理价格</th>
						<th>备注信息</th>
						<th width="10">&nbsp;</th>
					</tr>
				</thead>
				<tbody id="testDataChild2List">
				</tbody>
			</table>
			<script type="text/template" id="testDataChild2Tpl">//<!--
				<tr id="testDataChild2List{{idx}}">
					<td class="hide">
						<input id="testDataChild2List{{idx}}_id" name="testDataChild2List[{{idx}}].id" type="hidden" value="{{row.id}}"/>
						<input id="testDataChild2List{{idx}}_delFlag" name="testDataChild2List[{{idx}}].delFlag" type="hidden" value="0"/>
					</td>
					<td  class="max-width-250">
						<sys:treeselect id="testDataChild2List{{idx}}_start" name="testDataChild2List[{{idx}}].start.id" value="{{row.start.id}}" labelName="testDataChild2List{{idx}}.start.name" labelValue="{{row.start.name}}"
							title="区域" url="/sys/area/treeData" cssClass="form-control  required" allowClear="true" notAllowSelectParent="true"/>
					</td>
					
					<td  class="max-width-250">
						<sys:treeselect id="testDataChild2List{{idx}}_end" name="testDataChild2List[{{idx}}].end.id" value="{{row.end.id}}" labelName="testDataChild2List{{idx}}.end.name" labelValue="{{row.end.name}}"
							title="区域" url="/sys/area/treeData" cssClass="form-control  required" allowClear="true" notAllowSelectParent="true"/>
					</td>
					
					<td>
						<input id="testDataChild2List{{idx}}_price" name="testDataChild2List[{{idx}}].price" type="text" value="{{row.price}}" class="form-control  number"/>
					</td>
					
					<td>
						<textarea id="testDataChild2List{{idx}}_remarks" name="testDataChild2List[{{idx}}].remarks" rows="4" maxlength="255" class="form-control ">{{row.remarks}}</textarea>
					</td>
					
					<td class="text-center" width="10">
						{{#delBtn}}<span class="close" onclick="delRow(this, '#testDataChild2List{{idx}}')" title="删除">&times;</span>{{/delBtn}}
					</td>
				</tr>//-->
			</script>

			<script type="text/template" id="testDataChild2Tpl2">//<!--
				<tr id="testDataChild2List{{idx}}">
					<td class="hide">
						<input id="testDataChild2List{{idx}}_id" name="testDataChild2List[{{idx}}].id" type="hidden" value="{{row.id}}"/>
						<input id="testDataChild2List{{idx}}_delFlag" name="testDataChild2List[{{idx}}].delFlag" type="hidden" value="0"/>
					</td>
					<td>
					<div>
					<div>
					</div>
					<div>
						出发地<font color="red">*</font><sys:treeselect id="testDataChild2List{{idx}}_start" name="testDataChild2List[{{idx}}].start.id" value="{{row.start.id}}" labelName="testDataChild2List{{idx}}.start.name" labelValue="{{row.start.name}}"
							title="区域" url="/sys/area/treeData" cssClass="form-control  required" allowClear="true" notAllowSelectParent="true"/>
					</div>
					<div>
					</div>
					<div>
						目的地<font color="red">*</font><sys:treeselect id="testDataChild2List{{idx}}_end" name="testDataChild2List[{{idx}}].end.id" value="{{row.end.id}}" labelName="testDataChild2List{{idx}}.end.name" labelValue="{{row.end.name}}"
							title="区域" url="/sys/area/treeData" cssClass="form-control  required" allowClear="true" notAllowSelectParent="true"/>
					</div>
					<div>
					</div>
					<div>
						代理价格<input id="testDataChild2List{{idx}}_price" name="testDataChild2List[{{idx}}].price" type="text" value="{{row.price}}" class="form-control  number"/>
					</div>
					<div>
					<div>
					<div>
					<div>
					<div>
					<div>
					</div>
					<div>
						备注信息<textarea id="testDataChild2List{{idx}}_remarks" name="testDataChild2List[{{idx}}].remarks" rows="4" maxlength="255" class="form-control ">{{row.remarks}}</textarea>
					</div>
					<div>
					</td>
					<td class="text-center" width="10">
						{{#delBtn}}<span class="close" onclick="delRow(this, '#testDataChild2List{{idx}}')" title="删除">&times;</span>{{/delBtn}}
					</td>
				</tr>//-->
			</script>

			<script type="text/javascript">
				var tpl="${param.Tpl}";
				if(tpl==null || tpl=="") tpl="Tpl";
				if(tpl=="Tpl2"){
					$("#contentTable>thead").remove();
				}
				var testDataChild2RowIdx = 0, testDataChild2Tpl = $("#testDataChild2"+tpl).html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
				$(document).ready(function() {
					var data = ${fns:toJson(testDataMain.testDataChild2List)};
					for (var i=0; i<data.length; i++){
						addRow('#testDataChild2List', testDataChild2RowIdx, testDataChild2Tpl, data[i]);
						testDataChild2RowIdx = testDataChild2RowIdx + 1;
					}
				});
			</script>
			</div>
				<div id="tab-3" class="tab-pane">
			<a class="btn btn-warning btn-sm" onclick="addRow('#testDataChild3List', testDataChild3RowIdx, testDataChild3Tpl);testDataChild3RowIdx = testDataChild3RowIdx + 1;" title="新增"><i class="fa fa-plus"></i> 新增</a>
			<table id="contentTable" class="table table-striped table-condensed">
				<thead>
					<tr>
						<th class="hide"></th>
						<th>出发地<font color="red">*</font></th>
						<th>目的地<font color="red">*</font></th>
						<th>代理价格</th>
						<th>备注信息</th>
						<th width="10">&nbsp;</th>
					</tr>
				</thead>
				<tbody id="testDataChild3List">
				</tbody>
			</table>
			<script type="text/template" id="testDataChild3Tpl">//<!--
				<tr id="testDataChild3List{{idx}}">
					<td class="hide">
						<input id="testDataChild3List{{idx}}_id" name="testDataChild3List[{{idx}}].id" type="hidden" value="{{row.id}}"/>
						<input id="testDataChild3List{{idx}}_delFlag" name="testDataChild3List[{{idx}}].delFlag" type="hidden" value="0"/>
					</td>
					<td  class="max-width-250">
						<sys:treeselect id="testDataChild3List{{idx}}_start" name="testDataChild3List[{{idx}}].start.id" value="{{row.start.id}}" labelName="testDataChild3List{{idx}}.start.name" labelValue="{{row.start.name}}"
							title="区域" url="/sys/area/treeData" cssClass="form-control  required" allowClear="true" notAllowSelectParent="true"/>
					</td>
					
					<td  class="max-width-250">
						<sys:treeselect id="testDataChild3List{{idx}}_end" name="testDataChild3List[{{idx}}].end.id" value="{{row.end.id}}" labelName="testDataChild3List{{idx}}.end.name" labelValue="{{row.end.name}}"
							title="区域" url="/sys/area/treeData" cssClass="form-control  required" allowClear="true" notAllowSelectParent="true"/>
					</td>
					
					<td>
						<input id="testDataChild3List{{idx}}_price" name="testDataChild3List[{{idx}}].price" type="text" value="{{row.price}}" class="form-control  number"/>
					</td>
					
					<td>
						<textarea id="testDataChild3List{{idx}}_remarks" name="testDataChild3List[{{idx}}].remarks" rows="4" maxlength="255" class="form-control ">{{row.remarks}}</textarea>
					</td>
					
					<td class="text-center" width="10">
						{{#delBtn}}<span class="close" onclick="delRow(this, '#testDataChild3List{{idx}}')" title="删除">&times;</span>{{/delBtn}}
					</td>
				</tr>//-->
			</script>

			<script type="text/template" id="testDataChild3Tpl2">//<!--
				<tr id="testDataChild3List{{idx}}">
					<td class="hide">
						<input id="testDataChild3List{{idx}}_id" name="testDataChild3List[{{idx}}].id" type="hidden" value="{{row.id}}"/>
						<input id="testDataChild3List{{idx}}_delFlag" name="testDataChild3List[{{idx}}].delFlag" type="hidden" value="0"/>
					</td>
					<td>
					<div>
					<div>
					</div>
					<div>
						出发地<font color="red">*</font><sys:treeselect id="testDataChild3List{{idx}}_start" name="testDataChild3List[{{idx}}].start.id" value="{{row.start.id}}" labelName="testDataChild3List{{idx}}.start.name" labelValue="{{row.start.name}}"
							title="区域" url="/sys/area/treeData" cssClass="form-control  required" allowClear="true" notAllowSelectParent="true"/>
					</div>
					<div>
					</div>
					<div>
						目的地<font color="red">*</font><sys:treeselect id="testDataChild3List{{idx}}_end" name="testDataChild3List[{{idx}}].end.id" value="{{row.end.id}}" labelName="testDataChild3List{{idx}}.end.name" labelValue="{{row.end.name}}"
							title="区域" url="/sys/area/treeData" cssClass="form-control  required" allowClear="true" notAllowSelectParent="true"/>
					</div>
					<div>
					</div>
					<div>
						代理价格<input id="testDataChild3List{{idx}}_price" name="testDataChild3List[{{idx}}].price" type="text" value="{{row.price}}" class="form-control  number"/>
					</div>
					<div>
					<div>
					<div>
					<div>
					<div>
					<div>
					</div>
					<div>
						备注信息<textarea id="testDataChild3List{{idx}}_remarks" name="testDataChild3List[{{idx}}].remarks" rows="4" maxlength="255" class="form-control ">{{row.remarks}}</textarea>
					</div>
					<div>
					</td>
					<td class="text-center" width="10">
						{{#delBtn}}<span class="close" onclick="delRow(this, '#testDataChild3List{{idx}}')" title="删除">&times;</span>{{/delBtn}}
					</td>
				</tr>//-->
			</script>

			<script type="text/javascript">
				var tpl="${param.Tpl}";
				if(tpl==null || tpl=="") tpl="Tpl";
				if(tpl=="Tpl2"){
					$("#contentTable>thead").remove();
				}
				var testDataChild3RowIdx = 0, testDataChild3Tpl = $("#testDataChild3"+tpl).html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
				$(document).ready(function() {
					var data = ${fns:toJson(testDataMain.testDataChild3List)};
					for (var i=0; i<data.length; i++){
						addRow('#testDataChild3List', testDataChild3RowIdx, testDataChild3Tpl, data[i]);
						testDataChild3RowIdx = testDataChild3RowIdx + 1;
					}
				});
			</script>
			</div>
		</div>
		</div>
			<div id="iframeSave" class="form-group  ${action}">
				<a class="btn btn-success" onclick="doSubmit();">保存</a>
				<a class="btn btn-primary" onclick="javascript:history.back(-1);">返回</a>
				<!--a class="btn btn-primary" onclick="top.closeSelectTabs()">关闭</a-->
			</div>
		</div>
	</form:form>
</body>
</html>