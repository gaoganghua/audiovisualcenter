/*dataTables表格
 * 
 * tableObj 表格对象
 * url url地址
 * columns 列对象
 * createRowCallBack 创建行回掉函数
 * languages 自定义语言
 * isPageMenu 是否显示分页菜单
 * isPage 是否分页
 */
function maindatatable(tableObj, url, columns,createRowCallBack, languages, isPageMenu,isPage){
	var oTable = $(tableObj).DataTable({
		"lengthChange": isPageMenu,
		"lengthMenu": [[10, 25, 50, -1], ["10","25","50", "All"]],
		"paging":isPage,
		"processing": true, 
		"serverSide": true, 
		"serverData": function(sSource, aoData, fnCallback) {
//				aoData = JSON.stringify(aoData)
//				alert(aoData)
//				aoData = eval('(' +aoData + ')');
			var params = {};
			params.draw = aoData[0].value;
			params.start = aoData[aoData.length-3].value;
			params.length = aoData[aoData.length-2].value;
			params.query = aoData[aoData.length-1].value.value;
			
			var ordercolumnindex = aoData[aoData.length-4].value[0].column;
			params.orderColumn = aoData[1].value[ordercolumnindex].data;
			params.orderColumnDir = aoData[aoData.length-4].value[0].dir;
			
			var searchColumns = new Array();
			var columns = aoData[1].value;
			for(var i=0;i<columns.length;i++){
				if(columns[i].searchable==true){
					searchColumns.push(columns[i].data);
				}
			}
			params.searchColumns = searchColumns;
			
			$.ajax({
				url:url,
				type:"post",
				dataType:"json",
				data :$.param(params, true),
				success:function(data){
					var data = eval('(' +data + ')');
					fnCallback(data)
				},
			})
		},
		"columns":columns,
        "language":languages,
        //绘制表格的函数
        "fnDrawCallback" : function () {//生成序号
            this.api().column(0).nodes().each(function(cell, i) {
                cell.innerHTML = i + 1;
            });
        },
        //创建列表的函数
        "createdRow":createRowCallBack,
	});
	return oTable;
}
/*	页面弹框
 * 
 * html 页面显示内容
 * title 页面标题
 * buttons 按钮组件
 * savecallback 保存按钮的回掉函数
 * cancelcallback 取消按钮的回掉函数
 * params 回掉函数中的参数集合
 */
function mainbootbox(html, title, buttons, savecallback, cancelcallback){
	var btns = buttons;
	var callbackfn = savecallback;
	var cancelcallbackfn = cancelcallback
	if(savecallback==null){
		callbackfn = null;
	}
	if(cancelcallback==null){
		cancelcallbackfn = null;
	}
	if(buttons==null){
		btns = {
			"保存" :
			 {
				"label" : "<i class='icon-ok'></i> 保存!",
				"className" : "btn-sm btn-success",
				"callback": callbackfn,
			},
			"取消" :
			{
				"label" : "<i class='icon-remove'></i> 取消!",
				"className" : "btn-sm btn-danger",
				"callback": cancelcallbackfn,
			}, 
		}
	}
	basicbootbox(html, title, btns);
}
/*
 * alert弹框
 * 
 * msg 信息
 * title 标题
 * callback 按钮的回掉函数
 */
function mainbootboxalert(msg,title, callback){
	bootbox.alert({
		buttons: {  
               ok: {  
                    label: '确定',  
                    className: 'btn-success'  
                }  
        },  
        message: msg,  
        callback: callback,
        title: title,
		
	})
}
/*
 * 确认对话框
 * 
 * title 标题
 * msg 信息
 * savecallback 确认按钮的回调函数
 * cancelcallback 取消按钮的回掉函数
 * params 确认按钮回掉函数中的参数
 */
function mainbootboxconfirm(msg,title, savecallback, cancelcallback, params){
	bootbox.confirm({
		title:title,
		message:msg,
		buttons:{  
             confirm: {  
                label: '确定',  
                className: 'btn-success'  
	         },  
            cancel: {  
                label: '取消',  
                className: 'btn-danager'  
            }
        },  
		callback:function(result) {
			if(result){
				if(savecallback!=null)
					savecallback(params);
			}else{
				if(cancelcallback!=null)
					cancelcallback();
			}
		}
	});
}
/*
 *多功能输入弹框
 *
 * title 标题
 * callback 回调函数
 * value 初始化值
 * params 传递的参数
 * inputType 输入框的类型
 * inputOptions 指定select或checkbox作为输入类型，则必须以下列格式提供有效值的数组
 */
function advancebootboxprompt(title, callback, value, params,inputType,  inputOptions){
	if(inputType==null){
		inputType="text";
	}
	if(value==null){
		value="";
	}
//	if(inputOptio)
	bootbox.prompt({
		"title":title,
		"inputType":inputType,
		"value":value,
		"inputOptions":inputOptions,
		"callback": function(result){
			if(result===null){
				return true;
			}else{
				callback(result, params);
			}
		}
	})
}
/*基础输入弹窗
 * 
 * title 标题
 * callback 回掉函数
 * 
 */
function mainbootboxprompt(title, callback){
	bootbox.prompt({
		"title":title,
		"callback":callback,
	});
}
/*
 *基础弹框 
 */
function basicbootbox(html, title, buttons){
	bootbox.dialog({
		message: html,
		title:title,
		buttons:buttons		
	})
}
/*
 * 合借框种类变动
 * 
 * changeText 改变的类型
 */
function totalbadge(changeText){
	var basketANode = $("ul.module").find("li[id=2] a");
	var badgeNode = $(basketANode).find("span.badge");
	if(changeText == 1){
		if(badgeNode.length>0){
			var badgeText = parseInt(badgeNode.text())+1;
			badgeNode.text(badgeText);
		}else{
			var badgeNode = $("<span class='badge badge-primary'></span>");
			badgeNode.text(1);
			basketANode.append(badgeNode);
		}
	}else if(changeText == 2){
		if(badgeNode.length>0){
			var badgeText = parseInt(badgeNode.text())-1;
			if(badgeText==0){
				$(badgeNode).remove();
			}else{
				badgeNode.text(badgeText);
			}
		}
	}else if(changeText==0){
		if(badgeNode.length>0){
			$(badgeNode).remove();
		}
	}
}
/*
 * 未归还订单的数量变动
 * 
 * changeText 改变的类型(1-增加，2-减少,0-删除)
 */
function waitreturnbadge(changeText){
	var node = $("span[name='waitreturntotal']");
	if(changeText == 1){
		if(node.length>0){
			if(node.text()==""){
				node.text(1);
			}else{
				var badgeText = parseInt(node.text())+1;
				node.text(badgeText);
			}
		}
	}else if(changeText == 2){
		if(node.length>0){
			var badgeText = parseInt(node.text())-1;
			if(badgeText>0){
				node.text(badgeText);
			}else{
				node.text("");
			}
		}
	}else if(changeText==0){
		if(node.length>0){
			$(node).remove();
		}
	}
}
/*
 * 二级联动
 * 
 * node 二级节点
 * data 数据
 * params 被选中的参数要求
 */
function changeSelect(node, data, params){
	$(node).empty();
	for(var i=0;i<data.length;i++){
		if(data[i].id == params)
			var opt = $("<option value='" + data[i].id+"' selected='selected'>" + data[i].college+ "</option>");
		else
			var opt = $("<option value='" + data[i].id+"'>" + data[i].college+ "</option>");
		$(node).append(opt);
	}
	$(node).trigger("chosen:updated");//更新选项
}
/*
 * 重新选择option
 * 
 * node select节点
 * params 参数
 */
function reselectSelect(node, params){
	var options = $(node).find("option");
	for(var i=0;i<options.length;i++){
		if(options[i].selected == true){
			options[i].selected = false;
		}
		if($(options[i]).val()==params){
			options[i].selected = true;
		}
	}
	$(node).trigger("chosen:updated");//更新选项
}
/*
 * 修改表格中指定行的数据
 * 
 * 
 * obj 修改后的数据对象
 * index 指定行的下标
 */
function editbasketequip(obj, index){
	var trNode = $("table#sample-table-2").find("tr:eq(" + index+ ")");
	var childTdNodes = $(trNode).find("td");
	for(var i=1;i<childTdNodes.length-1;i++){
		var propertyName = $(childTdNodes[i]).attr("name");
		var tdNode = $(trNode).find("td[name='" + propertyName+"']");
		obj[propertyName] = obj[propertyName]+"";
		
		if(obj[propertyName]=="true"){
			obj[propertyName] = "良好";
		}else if(obj[propertyName]=="false"){
			obj[propertyName] = "损坏";
		}
		if(tdNode.children().length>0){
			tdNode.children(":first").text(obj[propertyName])
		}else{
			tdNode.text(obj[propertyName])
		}
	} 
	var aNodes = $(childTdNodes[childTdNodes.length-1]).find("div.action-buttons a");
	for(var i=0;i<aNodes.length;i++){
		$(aNodes[i]).attr("name", obj.equipId);
	}
}
/*
 * 更改表格的序号
 * 
 * node 表格节点
 * length 表格中有效tr的长度
 */
function changeTableIndex (node, length){
	if(length>0){
		var trNodes = $(node).find("tbody tr");
		for(var i=0;i<length;i++){
			$(trNodes[i]).find("td:first label").text(i+1);
		}
	}
}