<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>接口管理</title>
	<meta name="decorator" content="default"/>
			    <%@ include file="/WEB-INF/views/include/head.jsp"%>
	<script type="text/javascript" src="${ctxStatic}/common/readTwoD.js"></script>
</head>
<body>
	

		
<body class="gray-bg">
	<div class="wrapper wrapper-content">
	<div class="ibox">

    <div class="ibox-content">
       <form class="form-horizontal">
    	<div class="form-group">
             <div class="col-sm-2">二维码内容</div>

             <div class="col-sm-8">
             		<input type="text" id="encoderContent" title="输入内容" value="http://www.jeespring.org" class="form-control">
             		<span  class="help-inline">请输入要生成二维码的字符串</span>
             </div>
             <div class="col-sm-2">
             		<a class="btn btn-small btn-success" onclick="createTwoD();">生成</a>
             </div>
         </div>
         <div class="form-group">
         	<div class="col-sm-2">二维码图像</div>
             <div class="col-sm-8">
             	<img id="encoderImgId" cache="false"  width="265px" height="265px;"  class="block"/>
             	 <span class="help-inline">使用微信扫一扫</span>
            </div>
           
         </div>
       </form>
    </div>
    </div>
    </div>
</body>
</html>