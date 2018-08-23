function SpringUIForm(obj){
	var options={key:"id",formId:"#inputForm",formUrl:"action",saveUrl:"/../savejson",getJsonUrl:"/../getjson"};
	options=Object.assign(options,obj);
	if(url(options.key)==null){
		   $("[v-model]").removeAttr("v-model");
	}
	springvm = new Vue({
		el:options.formId,
		data:{formData:options.formData},
		methods: {
            ini:function(){
                if(url(options.key)!=null && url(options.key).length>0){
                    $.ajax({
                        url : options.getJsonUrl,type:"POST",data:options.key+"="+url(options.key),
                        success:function(data) {springvm.formData=data;},
                        error:function(data) {alert("读取失败");}
                    });
                }
            },
			save: function () {
				$.ajax({  
				     url : $(options.formId).attr(options.formUrl),  type : "POST", data : $(options.formId).serialize(), async:false,
				     success:function(data) { parent.springvm.search();},
				     error:function(data) {  parent.springvm.search();}
				});
			}
		}
	});
    springvm.ini();
}

function SpringUIList(obj){
	var options={key:"id",formId:"#searchForm",formUrl:"action"};
	options=Object.assign(options,obj);
	var fromUrl=window.loacation.href.replace("List.html","Form.html");
	springvm= new Vue({
		el:'#rrapp',
		data:{page:{}},
		methods: {
			init:function(){
                $.ajax({
                    url : $("#searchForm").attr("action"), type : "POST", data : $("#searchForm").serialize(),
                    success : function(data){springvm.page=data.list;},
                    error : function(data){}
                });
			},
			addForm:function(){openDialog("新增",fromUrl,"800px", "500px","");},
			editFormSelect:function(){openDialog("修改",fromUrl+"?id="+getId(),"800px", "500px","");},
			view:function(id){openDialogView("查看",fromUrl+"?id="+id,"800px","500px")},
			editform:function(id){openDialog("修改",fromUrl+"?id="+id,"800px","500px");},
			search: function(){
				$("#pageNo").val(0);
				$.ajax({  
				     url : $("#searchForm").attr("action"),type:"POST",data:$("#searchForm").serialize(),  
				     success : function(data) {  springvm.page=data.list;},
				     error : function(data) { }
				});
			},
			deletex: function (id) {
				$.ajax({  
				     url:$("#searchForm").attr("action")+"/../deletejson",type:"POST", data : "id="+id,
				     success : function(data) {springvm.search();},
				     error : function(data) {springvm.search();}
				});
			}
		}
	});
    springvm.init();
}

function getId(){
	 var str="";var ids="";
	  var size = $("#contentTable tbody tr td input.i-checks:checked").size();
	  if(size == 0 ){
			top.layer.alert('请至少选择一条数据!', {icon: 0, title:'警告'});
			return;
	  }
	  if(size > 1 ){
			top.layer.alert('只能选择一条数据!', {icon: 0, title:'警告'});
			return;
	   }
	  return $("#contentTable tbody tr td input.i-checks:checkbox:checked").attr("id");
}

function lagugae(){


}