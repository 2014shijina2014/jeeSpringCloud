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
    <div class="wrapper wrapper-content">
        <div class="row">

            <div class="col-sm-12 animated fadeInRight">
                <div class="mail-box-header">
                    <div class="pull-right tooltip-demo">
                       <button type="button" class="btn btn-white  btn-sm" onclick="sendLetter()"> <i class="fa fa-pencil"></i> 发送邮件</button>
                    </div>
                    <h2>
                    写邮件
                </h2>
                </div>
               
                <div class="mail-box">


                    <div class="mail-body">
					<form:form id="inputForm" modelAttribute="mailBox" action="${ctx}/tools/email/send" method="post" class="form-horizontal">
                            <div class="form-group">
                                <label class="col-sm-2 control-label"><font color="red">*</font>发送到：</label>

                                <div class="col-sm-8">
                                  	  <input type="text" placeholder="输入多个邮件地址请用英文符号;隔开" id="emailAddress" name="emailAddress"  class="form-control" value="">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">主题：</label>

                                <div class="col-sm-8">
                                    <input type="text" id="title" name="title"  class="form-control" value="">
                                </div>
                            </div>
                              <input type="hidden" id="content" name="content"><!-- 内容 -->
 					</form:form>	
                    </div>

                    <div class="mail-text h-200">

                        <div class="summernote">
                           

                        </div>
                        <div class="clearfix"></div>
                    </div>
                    <div class="mail-body text-right tooltip-demo">
                    	
                    	 <button type="button" class="btn btn-primary  btn-sm" onclick="sendLetter()"> <i class="fa fa-reply"></i> 发送</button>
                    </div>
                    <div class="clearfix"></div>



                </div>
            
            </div>
			
        </div>
    </div>



    <script>
        $(document).ready(function () {
            $('.i-checks').iCheck({
                checkboxClass: 'icheckbox_square-green',
                radioClass: 'iradio_square-green',
            });


            $('.summernote').summernote({
                lang: 'zh-CN'
            });

            

        });
        var edit = function () {
            $('.click2edit').summernote({
                focus: true
            });
        };
        var save = function () {
            var aHTML = $('.click2edit').code(); //save HTML If you need(aHTML: array).
            $('.click2edit').destroy();
        };

        function sendLetter(){
            if($("#emailAddress").val()==''){
            	top.layer.alert('收件人不能为空！', {icon: 0});
            	return;
            }
            if($("#title").val()==''){
              	top.layer.alert('标题不能为空！', {icon: 0});
              	return;
              }
			$("#content").val($(".note-editable").html());
			var index = layer.load(1, {
			    shade: [0.3,'#fff'] //0.1透明度的白色背景
			});
			$("#inputForm").submit();
	    }
    </script>

</body>

</html>