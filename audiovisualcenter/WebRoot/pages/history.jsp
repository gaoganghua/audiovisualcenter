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
		<title>借单管理 - 已归还器材</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />

		<link href="assets/css/bootstrap.min.css" rel="stylesheet" />
		<link rel="stylesheet" href="assets/css/font-awesome.min.css" />

		<link href="assets/css/bootstrap.min.css" rel="stylesheet" />
		<link rel="stylesheet" href="assets/css/font-awesome.min.css"/>
		<link rel="stylesheet" href="assets/css/prettify.css" />
		<link rel="stylesheet" href="assets/css/ace.min.css" />
		<link rel="stylesheet" href="assets/css/ace-rtl.min.css" />
		<link rel="stylesheet" href="assets/css/ace-skins.min.css" />
		
		<script src="js/jquery-1.12.4.js"></script>
<%-- 		<script src="assets/js/jquery-2.0.3.min.js"></script> --%>
		<script src="assets/js/bootstrap.min.js"></script>
		<script src="assets/js/ace-extra.min.js"></script>
		<script src="js/jquery.dataTables.min.js"></script>
		<script src="js/mytable.js"></script>
		<script src="assets/js/jquery.dataTables.bootstrap.js"></script>
		<script src="assets/js/bootbox.min.js"></script>
		<script src="js/ejs_production.js"></script>
		<script type="text/javascript">
		$(function(){
			var tableNode = $("#sample-table-2");
			var url="historyInfo";
			//生成备注信息
			var msgOptions = function(data, type, row){
				if(data=="")
					return "<button class='btn btn-xs' name='borrowMsg'>备注</button>"
				return "<button class='btn btn-xs btn-warning'  name='borrowMsg'>备注</button>";
			}
			//生成警告信息的html
			var alertOptions = function() {
			    return new EJS({url: "ejs/alertOptions.ejs"}).render({
			    	style:"alert-danger",
			    	remove:false,
			    	strong:false,
// 			    	icon:false,
			    	text:"没有等待归还的借单!",
			    });
			}
			//生成操作按钮的html
			var btnOptions = function(data, type, row) {
			    return new EJS({url: "ejs/btnOptions.ejs"}).render({
			    	edit:false,
			    	remove:false,
			    	view:true,
			    	data:data,
			    });
			}
			//生成订单信息的html
			var viewOptions = function(data) {
			    return new EJS({url: "ejs/viewOptions.ejs"}).render({
			    	data:data,
			    });
			}
			//列对象
			var columns = [
	          	 { "data": "id", "searchable":false, "orderable":false,"class":"center"},
	          	 { "data": "clientName","orderable":true}, 
	          	 { "data": "clientPhone", "orderable":true}, 
	          	 { "data": "managerName","orderable":true,}, 
	          	 { "data": "borrowTime","orderable":true,"searchable":false},
	          	 { "data": "returnTime","orderable":true,"searchable":false},
	          	 { "data": "borrowMsg","orderable":true,"searchable":false,"class":"hidden-480","render": msgOptions}, 
	          	 { "data": "id", "render":btnOptions, "searchable":false, "orderable":false},
	       ];
	       //语言设置
			var languages = {
				"processing" : "处理中...",
				"lengthMenu": "显示 _MENU_ 条数据",
				'zeroRecords': '没有相关数据', 
		        'info': "显示第 _START_ 至 _END_ 项结果，共 _TOTAL_ 项",
		        'infoEmpty': '没有符合条件的记录', 
				'search': '查找   :   ', 
	       	};
	       	//表格创建完成的回掉函数
	       	var createRowCallBack = function(row, data, dataIndex ) {
	       		$(row).attr("id", data.id);
	       		//删除事件
	       		$(row).find("td:last").find("div[name='btnoptions']").find("a:eq(0)").click(function(){
	       			var id = $(this).parent("div").parent("td").parent("tr").attr("id");
	       			$.post("historyRemove",{"id":id},function(data){
	       				var data = eval('(' + data+')');
	       				if(data.success){
	       					$($.fn.dataTable.tables(!0)[0]).DataTable().draw(!1);
	       				}else{
	       					if(data.msg=="500"){
	       						window.location.href="pages/common/error.jsp";
	       					}
	       					mainbootboxalert(data.msg);
	       				}
	       			})
	       		})
	       		//查看事件
	       		$(row).find("td:last").find("div[name='btnoptions']").find("a:eq(0)").click(function(){
	       			var id = $(this).parent("div").parent("td").parent("tr").attr("id");
					$.post("historyView",{"id":id},function(data){
						var data = eval('(' + data+')');
						var html = viewOptions(data.data);
						$(".modal-body").html(html);
						$("#modal-table").modal({
							show:true,
   							backdrop:'static'
						});
					})
	       		})
	       		//查看备注
	       		$(row).find("button[name='borrowMsg']").click(function(){
	       			if($(this).hasClass("btn-warning")){
	       				var id = $(this).parent("td").parent("tr").attr("id");
						$.post("historyMsg",{"id":id},function(data){
							var data = eval('(' +data+ ')');
							var alertMsg = "";
							if(data.success){
								mainbootboxalert(data.msg);
							}else{
								if(data.msg=="500"){
									window.location.href="pages/common/error.jsp";
								}
							}
						})
	       			}else{
	       				mainbootboxalert("无备注");
	       			}
				})
	        }
	        //创建表格
			maindatatable(tableNode, url,columns,createRowCallBack,languages,true, true);
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
				<s:action name="module" namespace="/" executeResult="true"></s:action>

				<div class="main-content">
					<div class="breadcrumbs" id="breadcrumbs">
						<script type="text/javascript">
							try{ace.settings.check('breadcrumbs' , 'fixed')}catch(e){}
						</script>

						<ul class="breadcrumb">
							<li>
								<i class="icon-home home-icon"></i>
								<a href="waitreturnPage?pageId=5">借单管理</a>
							</li>

							<li>
								<a href="historyPage?pageId=6">借用完成</a>
							</li>
							<li class="active">已归还器材</li>
						</ul><!-- .breadcrumb -->
					</div>

					<div class="page-content">
						<div class="page-header">
							<h1>
								已完成借单
								<small>
									<i class="icon-double-angle-right"></i>
									已归还器材
								</small>
							</h1>
						</div><!-- /.page-header -->
						<div class="col-xs-12">
							<!-- <h3 class="header smaller lighter blue">器材列表</h3> -->
							<div class="table-header">
								借用器材历史记录：
							</div>

							<div class="table-responsive">

								<table id="sample-table-2" class="table table-striped table-bordered table-hover">
									<thead>
										<tr>
											<th class="center">序号</th>
											<th>借用人</th>
											<th>电话</th>
											<th class="hidden-480">经手人</th>

											<th>
												<i class="icon-time bigger-110 hidden-480"></i>
												借用时间
											</th>
											<th>
												<i class="icon-time bigger-110 hidden-480"></i>
												归还时间
											</th>
											<th class="hidden-480">备注</th>

											<th>操作</th>
										</tr>
									</thead>

									<tbody>
									 </tbody>
								</table>
							</div>
						</div>
					</div><!-- /.page-content -->
				</div><!-- /.main-content -->

<%-- 				<jsp:include page="common/setting.jsp"></jsp:include> --%>
				<div id="modal-table" class="modal fade in" tabindex="-1">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button class="bootbox-close-button close" data-dismiss="modal" aria-hidden="true">×</button>
								<h4 class="modal-title">借用订单信息</h4>
							</div>

							<div class="modal-body">
							</div>

							<div class="modal-footer no-margin-top">
								<button class="btn btn-sm btn-danger pull-right" data-dismiss="modal">
									<i class="icon-remove"></i>
									关闭
								</button>
							</div>
						</div><!-- /.modal-content -->
					</div><!-- /.modal-dialog -->
				</div><!-- modal-table ENDS -->
<!-- 			</div>/.main-container-inner -->
			
			<jsp:include page="common/setting.jsp"></jsp:include>
			</div><!-- /.main-container-inner -->
			<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
				<i class="icon-double-angle-up icon-only bigger-110"></i>
			</a>
		</div><!-- /.main-container -->

		<script type="text/javascript">
			if("ontouchend" in document) document.write("<script src='assets/js/jquery.mobile.custom.min.js'>"+"<"+"/script>");
		</script>
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
