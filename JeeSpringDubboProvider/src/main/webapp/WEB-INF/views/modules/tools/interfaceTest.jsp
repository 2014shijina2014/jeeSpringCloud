<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="decorator" content="default"/>
    <%@ include file="/WEB-INF/views/include/head.jsp" %>
</head>
<body class="gray-bg">
<div class="wrapper wrapper-content">
    <div class="row">
        <div class="col-sm-12">
            <div class="ibox float-e-margins">
                <div class="ibox-content">
                    <form method="get" class="form-horizontal">
                        <div class="form-group">
                            <label class="col-sm-2 control-label">url</label>
                            <div class="col-sm-8">
                                <input type="text" id="serverUrl" placeholder="输入请求地址" title="输入请求地址" value="${testInterface.url }"
                                       class="form-control">
                                <span><font
                                        color="gray">请求地址。要登录或授权调用接口，请先调用登录接口和授权接口。</font></span>
                            </div>
                            <div class="col-sm-2">
                                <a class="btn btn-small btn-success" onclick="sendSever();">请求</a>
                                <a class="btn btn-small btn-info" onclick="gReload();">重置</a>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">类型</label>
                            <div class="col-sm-10">
                                <input type="hidden" name="S_TYPE" id="S_TYPE"
                                       value="${testInterface.type eq 'post'?'POST':'GET'}"/>
                                <input name="form-field-radio" class="form-control i-checks" type="radio" value="POST"
                                       <c:if test="${testInterface.type eq 'post'}">checked="checked"</c:if> >POST
                                <input name="form-field-radio" class="form-control i-checks" type="radio" value="GET"
                                       <c:if test="${testInterface.type eq 'get'}">checked="checked"</c:if> >GET
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">post parm</label>
                            <div class="col-sm-8">
                                <input type="text" id="requestBody"  placeholder="输入请求参数" title="输入请求参数" value="${testInterface.body }"
                                       class="form-control">
                                <span><font color="gray">实例:key1=value1&key2=value2。</font></span>
                            </div>
                            <div class="col-sm-2">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">服务器响应：</label>
                            <div class="col-sm-10">
                                <font color="red" id="stime">-</font>&nbsp;毫秒
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">客户端请求：</label>
                            <div class="col-sm-10">
                                <font color="red" id="ctime">-</font>&nbsp;毫秒
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">返回结果</label>
                            <div class="col-sm-8">
                                <textarea id="json-field" title="返回结果" class="form-control span12"></textarea>
                            </div>
                            <div class="col-sm-2">
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript" src="${ctxStatic }/common/interfaceTest.js"></script>
</body>
</html>

