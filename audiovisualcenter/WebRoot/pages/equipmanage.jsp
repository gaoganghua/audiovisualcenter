<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html lang="en">
	<head>
		<base href="<%=basePath%>">
	
		<meta charset="utf-8" />
		<title>器材管理 - 器材的增删改查</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />

		<link href="assets/css/bootstrap.min.css" rel="stylesheet" />
		<link rel="stylesheet" href="assets/css/font-awesome.min.css" />

		<link rel="stylesheet" href="assets/css/prettify.css" />
		<link rel="stylesheet" href="assets/css/chosen.css" />
		<link rel="stylesheet" href="assets/css/ui.jqgrid.css" />

		<link rel="stylesheet" href="assets/css/ace.min.css" />
		<link rel="stylesheet" href="assets/css/ace-rtl.min.css" />
		<link rel="stylesheet" href="assets/css/ace-skins.min.css" />
		
		<script src="js/jquery-1.12.4.js"></script>
<%-- 		<script src="../assets/js/jquery-2.0.3.min.js"></script> --%>
		<script src="assets/js/bootbox.min.js"></script>

		<script src="assets/js/ace-extra.min.js"></script>
		<script src="js/mytable.js"></script>
		<script src="assets/js/jquery.gritter.min.js"></script>
	   	<script src="assets/js/jqGrid/jquery.jqGrid.min.js"></script>
		<script src="assets/js/jqGrid/i18n/grid.locale-en.js"></script>
	</head>

	<body>
		<jsp:include page="head.jsp"></jsp:include>
		<div class="main-container" id="main-container">
			<script type="text/javascript">
				try{ace.settings.check('main-container' , 'fixed')}catch(e){}
			</script>

			<div class="main-container-inner">
				<a class="menu-toggler" id="menu-toggler" href="#">
					<span class="menu-text"></span>
				</a>
				<s:action name="module" namespace="/" executeResult="true"></s:action>
		
				<div class="main-content">
					<div class="breadcrumbs" id="breadcrumbs">
						<script type="text/javascript">
							try{ace.settings.check('breadcrumbs' , 'fixed')}catch(e){}
						</script>

						<ul class="breadcrumb">
							<li>
								<i class="icon-home home-icon"></i>
								<a href="equipManager?pageId=3">器材管理</a>
							</li>
							<li class="active">器材操作</li>
						</ul><!-- .breadcrumb -->
					</div>

					<div class="page-content">
						<div class="page-header">
							<h1>
								器材管理
								<small>
									<i class="icon-double-angle-right"></i>
									器材的增删改查
								</small>
							</h1>
						</div><!-- /.page-header -->
						<div class="row">
							<div class="col-xs-12">
								<table id="grid-table"></table>

								<div id="grid-pager"></div>
							</div><!-- /.col -->
						</div><!-- /.row -->					
					</div><!-- /.page-content -->
				</div><!-- /.main-content -->

				<jsp:include page="common/setting.jsp"></jsp:include>
			</div>

			<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
				<i class="icon-double-angle-up icon-only bigger-110"></i>
			</a>
		</div><!-- /.main-container -->

		<script type="text/javascript">
			if("ontouchend" in document) document.write("<script src='assets/js/jquery.mobile.custom.min.js'>"+"<"+"/script>");
		</script>
		<script src="assets/js/jqGrid/jquery.jqGrid.min.js"></script>
		<script src="assets/js/jqGrid/i18n/grid.locale-en.js"></script>
		
		<script src="assets/js/bootstrap.min.js"></script>
		<script src="assets/js/typeahead-bs2.min.js"></script>
<%-- 		<script src="assets/js/jquery-ui-1.10.3.custom.min.js"></script> --%>
<%-- 		<script src="assets/js/jquery.ui.touch-punch.min.js"></script> --%>
		<script src="assets/js/jquery.gritter.min.js"></script>

		<script src="assets/js/ace-elements.min.js"></script>
		<script src="assets/js/ace.min.js"></script>
		<script src="assets/js/jquery.validate.min.js"></script>
		<script type="text/javascript">
		
			var $path_base = "/";
// 			jQuery(function($) {//不要用这个，很坑
			$(function(){
// 				window.location.href="pages/adminconfirm.jsp";
				
				//管理员密码输入成功后的初始化函数
				$("#grid-table").jqGrid({
					jsonReader : {  
						root:"data",
						page: "currentpage",
						total: "totalpages",
						records: "totalrecords",
						repeatitems: false,
					}, 
					url:"equipInfo",
					datatype: "json",
					mtype:"post",
					height: 400,
					colNames:['操作','序号','名称','编号', '总数','类型','状况'],
					colModel:[
						{name:'myac',index:'', width:80, fixed:true, sortable:false, resize:false,
							//formatter:'actions',
							formatter:function(){
								return '<div style="margin-left:8px;"><div style="float:left;cursor:pointer;" class="ui-pg-div ui-inline-edit" id="editbtn"><span class="ui-icon ui-icon-pencil"></span></div><div style="float:left;margin-left:5px;" class="ui-pg-div ui-inline-del" id="delbtn" ><span class="ui-icon ui-icon-trash"></span></div></div>'
							}, 
						},
						{name:'id',index:'id', width:60, sortable:false,editable: false},
						{name:'name',index:'name',width:90, editable:true, sorttype:"date",/*unformat: pickDate*/},
						{name:'no',index:'no', width:90,editable: true,editoptions:{size:"20",maxlength:"30"}},
						{name:'total',index:'total', width:70, editable: true,edittype:"checkbox",editoptions: {value:"Yes:No"}},
						{name:'typeName',index:'typeName', width:90, sortable:true,editable: true,edittype:"select",editoptions:{value:"FE:FedEx;IN:InTime;TN:TNT;AR:ARAMEX"}},
						{name:'con',index:'con', width:150, sortable:false,editable: true,edittype:"textarea", editoptions:{rows:"2",cols:"10"},formatter: statusFormat} 
					],
					viewrecords : true,
					recordtext:"显示第 {0} 至 {1} 项结果,共{2}条结果",
					emptyrecords:"未查询到任何记录",
					rowNum:10,
					rowList:[10,20,30],
					pager : "#grid-pager",
					pgtext:"{0}",
					altRows: true,
					multiselect: true,
			        multiboxonly: true,
// 			        editurl: $path_base+"/dummy.html",//nothing is saved
					caption: "非管理员严禁修改下列信息：",
					autowidth: true,
					//shrinkToFit:false,
					//加载完成后的修改
					loadComplete : function() {
						var table = this;
						styleCheckbox(table);
						updatePagerIcons(table);
					},
				});
				//自定义按钮
				$("#grid-table").navGrid("#grid-pager",{edit:false,add:false,del:false,search:false})      
					.navButtonAdd("#grid-pager",{    
					   caption:"",
					   buttonicon:"icon-plus-sign blue",       
					   onClickButton: function(){
					   		$.post("equipAddPage", {}, function(html){
					   			bootbox.hideAll();
								var title="器材添加";
					   			mainbootbox(html,title, null, savecallback, cancelcallback);
					   		}, "html");
					   },
					   position:"last"
					 })
					 .navButtonAdd("#grid-pager",{    
					   caption:"",
					   buttonicon:"icon-trash red",       
					   onClickButton: function(){
							bootbox.hideAll();
					   		var ids=$("#grid-table").jqGrid('getGridParam','selarrrow');
					   		if(ids.length>0){
					   			mainbootboxconfirm("确定要删除这些器材吗", "器材管理", deletesavecallback, null, ids)
					   		}else{
					   			mainbootboxalert("请选择需要删除的器材", null, null);
					   		}
					   },
					   position:"last"
					 })
					 .navButtonAdd("#grid-pager",{    
					   caption:"",
					   buttonicon:"icon-check green",       
					   onClickButton: function(){
					   		bootbox.hideAll();
					   		var ids=$("#grid-table").jqGrid('getGridParam','selarrrow');
					   		if(ids.length>0){
					   			mainbootboxconfirm("确定设置器材的状态为良好吗", "器材管理", setstatussavecallback, null, ids)
					   		}else{
					   			mainbootboxalert("请选择需要设置状态的器材", null, null);
					   		}
					   },
					   position:"last"
				 })
// 			}
				 //格式化状态
				function statusFormat(cellvalue, options, rowObject)  {
					if(cellvalue==1)
						return "<span class='label label-md label-success arrowed arrowed-righ'>良好</span>";
                    else
                    	return "<span class='label label-danger arrowed-in'>损坏</span>";
				}
				//修改表格的样式
				function styleCheckbox(table) {
// 					//生成序号
					$("table#grid-table > tbody > tr > td[aria-describedby='grid-table_id']").each(function(i, node){
						node.innerHTML = i + 1;
					})
					//添加敲击事件
					$(table).find("tr").each(function(i, node){
						$(node).find("#editbtn").click(function(){
							editbtncallback(this);
						})
						$(node).find("#delbtn").click(function(){
							delbtncallback(this);
						})
					})
				}
				//添加翻页图标(此方法也可修改页脚增删改查的图标的样式)
				function updatePagerIcons(table) {
					var replacement = 
					{
						'ui-icon-seek-first' : 'icon-double-angle-left bigger-140',
						'ui-icon-seek-prev' : 'icon-angle-left bigger-140',
						'ui-icon-seek-next' : 'icon-angle-right bigger-140',
						'ui-icon-seek-end' : 'icon-double-angle-right bigger-140'
					};
					$('.ui-pg-table:not(.navtable) > tbody > tr > .ui-pg-button > .ui-icon').each(function(){
						var icon = $(this);
						var $class = $.trim(icon.attr('class').replace('ui-icon', ''));
						
						if($class in replacement) icon.attr('class', 'ui-icon '+replacement[$class]);
					})
					$("#alertmod_grid-table").remove();//删除多余弹框
				}
				 //弹框的页面刷新
				function cancelcallback(){
					window.location.href="equipManager?pageId=3";
				}
				 //添加按钮的回掉函数 			
				 //弹出添加页面后就不能再使用$("#grid-table").jqGrid( 'setGridParam')了
				function savecallback(){
				 	var c = $("button.btn-form-save");
		       		if($("#beanform").valid() && !c.hasClass("disabled")){
		       			$.post("equipAdd", $("#beanform").serialize(),function(data){
		       				var data = eval('(' + data +')');
		       				if(data.success){
		       					window.location.href="equipManager?pageId=3";
//  		       					$("#grid-table").jqGrid( 'setGridParam', {url :"equipInfo"}).trigger("reloadGrid");
		       				}else{
		       					if(data.msg=="500"){
		       						window.location.href="pages/common/error.jsp";
		       					}
		       					c.removeClass("disabled")
		       					mainbootboxalert(data.msg, null, null);
		       				}
					   },"json")
		       		}else{
		       			return false;
		       		}
				 }
				//删除按钮的回掉函数
				function deletesavecallback(params){
					var ids = ""
					for(var i=0;i<params.length;i++){
						ids = ids+params[i]+",";
					}
					$.post("equipDelete",{"ids":ids}, function(data){
						var data = eval('(' + data +')');
						if(data.success){
							$("#grid-table").jqGrid( 'setGridParam', {url :"equipInfo"}).trigger("reloadGrid");
						}else{
							if(data.msg=="500"){
	       						window.location.href="pages/common/error.jsp";
	       					}
							mainbootboxalert(data.msg);
						}
					})
				}
				//设置状态的良好
				function setstatussavecallback(params){
					var ids = ""
					for(var i=0;i<params.length;i++){
						ids = ids+params[i]+",";
					}
					$.post("equipSetStatus",{"ids":ids},function(data){
		   				var data = eval('(' +data + ')');
		   				if(data.success){
							$("#grid-table").jqGrid( 'setGridParam', {url :"equipInfo"}).trigger("reloadGrid");
						}else{
							if(data.msg=="500"){
	       						window.location.href="pages/common/error.jsp";
	       					}
							mainbootboxalert(data.msg);
						}
		   			})
				}
				//编辑界面的回掉事件
				function editcallback(){
					var c = $("button.btn-form-save");
		       		if($("#beanform").valid() && !c.hasClass("disabled")){
		       			$.post("equipUpdate", $("#beanform").serialize(),function(data){
		       				var data = eval('(' + data +')');
		       				if(data.success){
		       					window.location.href="equipManager?pageId=3";
// 		       					$("#grid-table").jqGrid( 'setGridParam', {url :"equipInfo"}).trigger("reloadGrid");
		       				}else{
		       					if(data.msg=="500"){
		       						window.location.href="pages/common/error.jsp";
		       					}
		       					c.removeClass("disabled")
		       					mainbootboxalert(data.msg, null, null);
		       				}
					   },"json")
		       		}else{
		       			return false;
		       		}
				}
				//编辑的按钮事件
				function editbtncallback(node){
					var trNode = $(node).parent().parent().parent("tr");
					$.post("equipEditPage", {"id":parseInt(trNode.attr("id"))}, function(html){
						bootbox.hideAll();
						var title="器材编辑";
			   			mainbootbox(html,title, null, editcallback,cancelcallback);
					},"html")
				}
				//删除的按钮事件
				function delbtncallback(node) {
					var trNode = $(node).parent().parent().parent("tr");
					var ids = trNode.attr("id");
					var nameNode = trNode.find("td[aria-describedby='grid-table_name']");
					mainbootboxconfirm("确定要删除" + nameNode.text()+ "吗", "器材管理", function(){
						$.post("equipDelete",{"ids":ids}, function(data){
							var data = eval('(' +data + ')');
							if(data.success){
								$("#grid-table").jqGrid( 'setGridParam', {url :"equipInfo"}).trigger("reloadGrid");
							}else{
								if(data.msg=="500"){
		       						window.location.href="pages/common/error.jsp";
		       					}
								mainbootboxalert(data.msg);
							}
						})
					}, null, null);
					
				}
			});
		</script>
	</body>
</html>
