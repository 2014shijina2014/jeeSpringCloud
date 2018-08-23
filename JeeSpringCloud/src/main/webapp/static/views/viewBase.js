$(document).ready(function() {
    $('#contentTable thead tr th input.i-checks').on('ifChecked', function(event){ //ifCreated 事件应该在插件初始化之前绑定
        $('#contentTable tbody tr td input.i-checks').iCheck('check');
    });

    $('#contentTable thead tr th input.i-checks').on('ifUnchecked', function(event){ //ifCreated 事件应该在插件初始化之前绑定
        $('#contentTable tbody tr td input.i-checks').iCheck('uncheck');
    });

});

function add(){
    var title=$(this).attr("title");
    var url=$(this).attr("url");
    var width=$(this).attr("width");
    var height=$(this).attr("height");
    var target=$(this).attr("target");
    openDialog("新增"+title,url,width==null?'800px':width, height==null?'500px':height,target);
}

function edit(){
    var id=$(this).attr("id");
    // var url = $(this).attr('data-url');
    var str="";
    var ids="";
    var size = $("#"+id+" tbody tr td input.i-checks:checked").size();
    if(size == 0 ){
        top.layer.alert('请至少选择一条数据!', {icon: 0, title:'警告'});
        return;
    }

    if(size > 1 ){
        top.layer.alert('只能选择一条数据!', {icon: 0, title:'警告'});
        return;
    }
    id =  $("#"+id+" tbody tr td input.i-checks:checkbox:checked").attr("id");
    var title=$(this).attr("title");
    var url=$(this).attr("url");
    var width=$(this).attr("width");
    var height=$(this).attr("height");
    var target=$(this).attr("target");
    openDialog("修改"+title,url+"?id="+id,width==null?'800px':width, height==null?'500px':height,target);
}

function deleteAll(){
    // var url = $(this).attr('data-url');
    var id=$(this).attr("id");
    var url=$(this).attr("url");
    var str="";
    var ids="";
    $("#"+id+" tbody tr td input.i-checks:checkbox").each(function(){
        if(true == $(this).is(':checked')){
            str+=$(this).attr("id")+",";
        }
    });
    if(str.substr(str.length-1)== ','){
        ids = str.substr(0,str.length-1);
    }
    if(ids == ""){
        top.layer.alert('请至少选择一条数据!', {icon: 0, title:'警告'});
        return;
    }
    top.layer.confirm('确认要彻底删除数据吗?', {icon: 3, title:'系统提示'}, function(index){
        window.location = url+"?ids="+ids;
        //top.layer.close(index);
    });
}

$("#btnExport").click(function(){
    top.layer.confirm('确认要导出Excel吗?', {icon: 3, title:'系统提示'}, function(index){
        //do something
        //导出之前备份
        var url =  $("#searchForm").attr("action");
        var pageNo =  $("#pageNo").val();
        var pageSize = $("#pageSize").val();
        //导出excel
        $("#searchForm").attr("action",url);
        $("#pageNo").val(-1);
        $("#pageSize").val(-1);
        $("#searchForm").submit();

        //导出excel之后还原
        $("#searchForm").attr("action",url);
        $("#pageNo").val(pageNo);
        $("#pageSize").val(pageSize);
        //top.layer.close(index);
    });
});

$("#btnImport").click(function(){
    var url=$(this).attr("url");
    top.layer.open({
        type: 1,
        area: [500, 300],
        title:"导入数据",
        content:$("#importBox").html() ,
        btn: ['下载模板','确定', '关闭'],
        btn1: function(index, layero){
            window.location.href=url+'/template';
        },
        btn2: function(index, layero){
            $("#importForm").submit();
            //top.layer.close(index);
        },

        btn3: function(index){
            //top.layer.close(index);
        }
    });
});