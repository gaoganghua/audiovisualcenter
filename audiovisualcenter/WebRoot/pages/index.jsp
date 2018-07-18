<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html lang="en">
	<head>
		<base href="<%=basePath%>">
		
		<meta charset="utf-8" />
		<title>首页 - 器材借用</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />

		<link href="assets/css/bootstrap.min.css" rel="stylesheet" />
		<link rel="stylesheet" href="assets/css/font-awesome.min.css" />
		<link rel="stylesheet" href="assets/css/prettify.css" />
		<link rel="stylesheet" href="assets/css/ace.min.css" />
		<link rel="stylesheet" href="assets/css/ace-rtl.min.css" />
		<link rel="stylesheet" href="assets/css/ace-skins.min.css" />
		
		<script src="assets/js/jquery-2.0.3.min.js"></script>
		<script src="assets/js/bootstrap.min.js"></script>
		<script src="assets/js/ace-extra.min.js"></script>
		
<%-- 		<script src="js/jquery-1.12.4.js"></script> --%>
		<script src="js/jquery.dataTables.min.js"></script>
		<script src="js/mytable.js"></script>
<%-- 		<script src="assets/js/jquery.dataTables.min.js"></script>  --%>
		<script src="assets/js/jquery.dataTables.bootstrap.js"></script>
		<script src="assets/js/bootbox.min.js"></script>
		
		<script type="text/javascript">
			$(function() {
				var tableurl = "indextable!index";
				//添加操作
				var addBasket = function(data, type, row){
					return "<button class='btn btn-success btn-xs' name='" +data +"'>加入到合借筐</button>";
				}
				//显示状态
				var addStatus = function(data, type, row){
					if(data!=0)
                    	return "<span class='label label-sm label-info arrowed arrowed-righ'>可借用</span>";
                    else
                    	return "<span class='label label-sm label-inverse arrowed-in'>已借出</span>";
				}
				var maxselecttotal = function(data, type, row){
					return "<font name='surplus'>" + data+"</font>";
				}
    			//语言设置
				var languages = {
					"processing" : "处理中...",
					"lengthMenu": "显示 _MENU_ 条数据",
					'zeroRecords': '没有相关数据', 
			        'info': "显示第 _START_ 至 _END_ 项结果，共 _TOTAL_ 项",
			        'infoEmpty': '没有符合条件的记录', 
					'search': '查找   :   ', 
		       	};
		       	//列对象
		       var columns = [
	          	 { "data": "id", "searchable":false, "orderable":false,"class":"center"},
	          	 { "data": "name" }, 
	          	 { "data": "surplus","render":maxselecttotal}, //剩余量-----
	          	 { "data": "total","searchable":false,}, 
	          	 { "data": "typeName","orderable":true},
	          	 { "data": "surplus","searchable":false,"class":"hidden-480","render": addStatus}, 
	          	 { "data": "id", "render":addBasket, "searchable":false, "orderable":false},
		       ];
		       //弹窗保存按钮的回掉函数
		       var btnsavecallback = function(){
		       		var c = $("button.btn-form-save");
		       		if($("#bean-form").valid() && !c.hasClass("disabled")){
		       			$.post("addbasket", $("#bean-form").serialize(),function(data){
		       				var data = eval('(' + data +')');
		       				if(data.success==true){
		       					//mainbootboxalert("成功添加到合借框!", null, null);
		       					totalbadge(1);
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
// 		       		return false;
		       }
		      	// 回调函数
				var createdRowCallback = function( row, data, dataIndex ) {
					$(row).attr("id", data.id);//data()添加data属性值为dataIndex
				    $(row).find("button").click(function(){
						var btnNode = this;
						var id = $(btnNode).attr("name");
						var title = "选择器材"
						var surplus = $(row).find("font[name='surplus']").text();
						if(parseInt(surplus)>0){
							$.post("indextableselect",{"equipId":id}, function(a){
								mainbootbox(a, title, null, btnsavecallback);
							}, "html")
						}else{
							mainbootboxalert("该器材已借完");
						}
						
// 						$("#modal-form").modal();
					});
				}
		       //创建列表
	          var oTable = maindatatable($("#datatable"),tableurl, columns,createdRowCallback, languages, true, true);
	          
			})
		</script>
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
				<s:action name="module" namespace="/" executeResult="true">
					<s:param name="pageIndex" value="1"></s:param>
				</s:action>
<%-- 				<s:debug></s:debug> --%>
<!-- 				<div class="sidebar" id="sidebar"> -->
<%-- 					<script type="text/javascript"> --%>
<!-- //  						try{ace.settings.check('sidebar' , 'fixed')}catch(e){}  -->
<%-- 					</script> --%>
<%-- 					<s:action name="module" namespace="/" executeResult="true"></s:action> --%>
<!-- 					<div class="sidebar-collapse" id="sidebar-collapse"> -->
<!-- 						<i class="icon-double-angle-left" data-icon1="icon-double-angle-left" data-icon2="icon-double-angle-right"></i> -->
<!-- 					</div> -->

<%-- 					<script type="text/javascript"> --%>
<!-- //   						try{ace.settings.check('sidebar' , 'collapsed')}catch(e){}  -->
<%-- 					</script> --%>
<!-- 				</div> -->

				<div class="main-content">
					<div class="breadcrumbs" id="breadcrumbs">
						<script type="text/javascript">
							try{ace.settings.check('breadcrumbs' , 'fixed')}catch(e){}
						</script>

						<ul class="breadcrumb">
							<li>
								<i class="icon-home home-icon"></i>
								<a href="pages/index.jsp?pageId=1">首页</a>
							</li>
							<li class="active">器材借用</li>
						</ul>
					</div>

					<div class="page-content">
						<div class="page-header">
							<h1>
								器材借用
								<small>
									<i class="icon-double-angle-right"></i>
									 查看
								</small>
							</h1>
						</div><!-- /.page-header -->
						<div class="col-xs-12">
							<div class="table-header">
								请选择您要借用的器材：
							</div>

							<div class="table-responsive">
								<table id="datatable" class="table table-striped table-bordered table-hover dataTable">
									<thead>
										<tr>
											<th class="center">
												序号
											</th>
											<th>名称</th>
											<th>剩余量</th>
											<th class="hidden-480">总数量</th>
											<th>
												<i class="icon-time bigger-110 hidden-480"></i>
												类别
											</th>
											<th class="hidden-480">状态</th>

											<th>操作</th>
										</tr>
									</thead>
								</table>
							</div>
						</div>
					</div>					

   					<jsp:include page="common/setting.jsp"></jsp:include>
				</div><!-- /.main-container-inner -->
			</div>
			<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
			<i class="icon-double-angle-up icon-only bigger-110"></i>
		</a>
		</div>
	   	<script src="assets/js/chosen.jquery.min.js"></script>
		<script type="text/javascript">
			if("ontouchend" in document) document.write("<script src='assets/js/jquery.mobile.custom.min.js'>"+"<"+"script>");
		</script>

		<script src="assets/js/prettify.js"></script>

		
		<script src="assets/js/bootstrap.min.js"></script>
		<script src="assets/js/typeahead-bs2.min.js"></script>
		<script src="assets/js/jquery.gritter.min.js"></script>
		<script src="assets/js/spin.min.js"></script>
		<script src="assets/js/ace-elements.min.js"></script>
		<script src="assets/js/ace.min.js"></script>
		
		<script src="assets/js/bootstrap.min.js"></script>
		<script src="assets/js/typeahead-bs2.min.js"></script>
	</body>
</html>

