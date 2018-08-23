
$("#userButton, #userName").click(function(){
	// 是否限制选择，如果限制，设置为disabled
	if ($("#userButton").hasClass("disabled")){
		return true;
	}
	// 正常打开	
	top.layer.open({
	    type: 2, 
	    area: ['300px', '420px'],
	    title:"选择用户",
	    ajaxData:{selectIds: $("#userId").val()},
	    content: "/admin/tag/treeselect?url="+encodeURIComponent("/sys/office/treeData?type=3")+"&module=&checked=&extId=&isAll=" ,
	    btn: ['确定', '关闭']
	       ,yes: function(index, layero){ //或者使用btn1
					var tree = layero.find("iframe")[0].contentWindow.tree;//h.find("iframe").contents();
					var ids = [], names = [], nodes = [];
					if ("" == "true"){
						nodes = tree.getCheckedNodes(true);
					}else{
						nodes = tree.getSelectedNodes();
					}
					for(var i=0; i<nodes.length; i++) {//
						if (nodes[i].isParent){
							//top.$.jBox.tip("不能选择父节点（"+nodes[i].name+"）请重新选择。");
							//layer.msg('有表情地提示');
							top.layer.msg("不能选择父节点（"+nodes[i].name+"）请重新选择。", {icon: 0});
							return false;
						}//
						ids.push(nodes[i].id);
						names.push(nodes[i].name);//
						break; // 如果为非复选框选择，则返回第一个选择  
					}
					$("#userId").val(ids.join(",").replace(/u_/ig,""));
					$("#userName").val(names.join(","));
					$("#userName").focus();
					top.layer.close(index);
			    	       },
	cancel: function(index){ //或者使用btn2
	           //按钮【按钮二】的回调
        top.layer.close(index);
	       }
	}); 

});

$("#officeButton, #officeName").click(function(){
	// 是否限制选择，如果限制，设置为disabled
	if ($("#officeButton").hasClass("disabled")){
		return true;
	}
	// 正常打开	
	top.layer.open({
	    type: 2, 
	    area: ['300px', '420px'],
	    title:"选择部门",
	    ajaxData:{selectIds: $("#officeId").val()},
	    content: "/admin/tag/treeselect?url="+encodeURIComponent("/sys/office/treeData?type=2")+"&module=&checked=&extId=&isAll=" ,
	    btn: ['确定', '关闭']
	       ,yes: function(index, layero){ //或者使用btn1
					var tree = layero.find("iframe")[0].contentWindow.tree;//h.find("iframe").contents();
					var ids = [], names = [], nodes = [];
					if ("" == "true"){
						nodes = tree.getCheckedNodes(true);
					}else{
						nodes = tree.getSelectedNodes();
					}
					for(var i=0; i<nodes.length; i++) {//
						if (nodes[i].isParent){
							//top.$.jBox.tip("不能选择父节点（"+nodes[i].name+"）请重新选择。");
							//layer.msg('有表情地提示');
							top.layer.msg("不能选择父节点（"+nodes[i].name+"）请重新选择。", {icon: 0});
							return false;
						}//
						ids.push(nodes[i].id);
						names.push(nodes[i].name);//
						break; // 如果为非复选框选择，则返回第一个选择  
					}
					$("#officeId").val(ids.join(",").replace(/u_/ig,""));
					$("#officeName").val(names.join(","));
					$("#officeName").focus();
					top.layer.close(index);
			    	       },
	cancel: function(index){ //或者使用btn2
	           //按钮【按钮二】的回调
        top.layer.close(index);
	       }
	}); 

});

$("#areaButton, #areaName").click(function(){
	// 是否限制选择，如果限制，设置为disabled
	if ($("#areaButton").hasClass("disabled")){
		return true;
	}
	// 正常打开	
	top.layer.open({
	    type: 2, 
	    area: ['300px', '420px'],
	    title:"选择区域",
	    ajaxData:{selectIds: $("#areaId").val()},
	    content: "/admin/tag/treeselect?url="+encodeURIComponent("/sys/area/treeData")+"&module=&checked=&extId=&isAll=" ,
	    btn: ['确定', '关闭']
	       ,yes: function(index, layero){ //或者使用btn1
					var tree = layero.find("iframe")[0].contentWindow.tree;//h.find("iframe").contents();
					var ids = [], names = [], nodes = [];
					if ("" == "true"){
						nodes = tree.getCheckedNodes(true);
					}else{
						nodes = tree.getSelectedNodes();
					}
					for(var i=0; i<nodes.length; i++) {//
						if (nodes[i].isParent){
							//top.$.jBox.tip("不能选择父节点（"+nodes[i].name+"）请重新选择。");
							//layer.msg('有表情地提示');
							top.layer.msg("不能选择父节点（"+nodes[i].name+"）请重新选择。", {icon: 0});
							return false;
						}//
						ids.push(nodes[i].id);
						names.push(nodes[i].name);//
						break; // 如果为非复选框选择，则返回第一个选择  
					}
					$("#areaId").val(ids.join(",").replace(/u_/ig,""));
					$("#areaName").val(names.join(","));
					$("#areaName").focus();
					top.layer.close(index);
			    	       },
	cancel: function(index){ //或者使用btn2
	           //按钮【按钮二】的回调
        top.layer.close(index);
	       }
	}); 

});
