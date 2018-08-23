<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta name="decorator" content="default"/>
    <%@ include file="/WEB-INF/views/include/head.jsp"%>
      <!-- SUMMERNOTE -->
	 <link href="${ctxStatic}/summernote/summernote.css" rel="stylesheet">
	 <link href="${ctxStatic}/summernote/summernote-bs3.css" rel="stylesheet">
	 <script src="${ctxStatic}/summernote/summernote.min.js"></script>
	 <script src="${ctxStatic}/summernote/summernote-zh-CN.js"></script>

</head>

<body class="gray-bg">

	
    <div class="lock-word animated fadeInDown">
    </div>
    <div class="middle-box text-center lockscreen animated fadeInDown" style="width:400px">
        <div>
            <div class="m-b-md">
                <img alt="image" style="width:150px;"class="img-circle circle-border" src="${ctxStatic}/images/success.jpg">
            </div>
             <sys:message hideType="0" content="${result}"/>
            
            <form class="m-t" role="form" action="index.html">
                <a href="${ctx}/tools/sms" class="btn btn-primary block full-width">返回</a>
            </form>
        </div>
    </div>

</body>

</html>