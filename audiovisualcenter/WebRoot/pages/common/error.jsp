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
		<title>合借筐 - 确认借单</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />

		<link href="assets/css/bootstrap.min.css" rel="stylesheet" />
		<link rel="stylesheet" href="assets/css/font-awesome.min.css" />

		<link rel="stylesheet" href="assets/css/prettify.css" />
		<link rel="stylesheet" href="assets/css/chosen.css" />

		<link rel="stylesheet" href="assets/css/ace.min.css" />
		<link rel="stylesheet" href="assets/css/ace-rtl.min.css" />
		<link rel="stylesheet" href="assets/css/ace-skins.min.css" />
		
		<script src="assets/js/jquery-2.0.3.min.js"></script>
		<script src="assets/js/bootbox.min.js"></script>

		<script src="assets/js/ace-extra.min.js"></script>
		<script src="js/mytable.js"></script>
		<script type="text/javascript">
		$(function(){
			//检查表格中是否还有元素
			var checktable = function(){
				var tableNode = $("table#sample-table-2");
				if(tableNode.find("tbody tr").length<=1){
					var alertNode = $("<button type='button' class='close' data-dismiss='alert'><i class='icon-remove'></i></button>");
					var alertDivNode = $("<div class='alert alert-danger'></div>");
					var alertTextNode = "合借框里还没有任何东西";
					alertDivNode.append(alertNode);
					alertDivNode.text(alertTextNode);
					alertDivNode.appendTo($(tableNode).parent("div.table-responsive").parent("div"));
					$(tableNode).parent("div.table-responsive").remove();
				}
			}
			//确认删除的回掉函数
			var confirmdelete = function(arguments){
				var currentNode = arguments[0];
				var equipId = arguments[1];
				var slength = $("table#sample-table-2").find("tbody tr").length-1;
				$.post("basketDelete!deleteBasketEquip", {"equipId":equipId}, function(data){
					var data = eval('(' +data + ')');
					if(data.success){
						mainbootboxalert("删除成功");
						$(currentNode).parent("div").parent("td").parent("tr").remove();
						$(currentNode).parent("li").parent("ul").parent("div").parent("div").parent("td").parent("tr").remove();
						checktable();
						changeTableIndex($("table#sample-table-2"),slength);
						totalbadge(2);
					}else{
						mainbootboxalert(data.msg)
					}
				})
			}
			//删除操作
			$("#sample-table-2 td a.basket-remove,#sample-table-2 li a.basket-remove").click(function(){
				var currentNode = $(this);
				var equipId = $(this).attr("name");
				var equipNameNode = $(this).parent("div").parent("td").parent("tr").find("td[name='equipName']");
				var equipName = $(equipNameNode).find("a").text();
				
				bootbox.hideAll();
				var msg = "确认要删除"+equipName+"?";
				var params = new Array();
				params.push(currentNode);
				params.push(equipId);
				mainbootboxconfirm(msg, null, confirmdelete, null, params);
				
				return false;
			})
			//编辑器材保存按钮的回掉函数
			var editsavecallback = function(params){
				var c = $("button.btn-form-save");
	       		if($("#bean-form").valid() && !c.hasClass("disabled")){
	       			$.post("basketUpdate!updateBasketEquip", $("#bean-form").serialize(),function(data){
	       				var data = eval('(' + data +')');
	       				if(data.success==true){
	       					mainbootboxalert("修改成功");
	       					editbasketequip(data.data, data.index);
	       					return true;
	       				}else{
	       					c.removeClass("disabled")
	       					mainbootboxalert(data.msg);
	       				}
				   },"json")
	       		}else{
	       			return false;
	       		}
			}
			//编辑操作
			/* $("#sample-table-2 td a.basket-edit").click(function(){
				var equipId = $(this).attr("name");
				var index = $(this).parent("div").parent("td").parent("tr").find("td:first label").text();
				var title  = "器材编辑";
				bootbox.hideAll();
				$.post("basketEdit!editBasketEquip", {"equipId":equipId, "index":parseInt(index)}, function(html){
					mainbootbox(html,title, null, editsavecallback);
				}, "html");
			}); */
			$("#sample-table-2 td a.basket-edit,#sample-table-2 li a.basket-edit").click(function(){
				var flag;
				var className = $(this).attr('class');
				var equipId = $(this).attr("name");
				var index = $(this).parent("div").parent("td").parent("tr").find("td:first label").text();
				var index1 = $(this).parent("li").parent("ul").parent("div").parent("div").parent("td").parent("tr").find("td:first label").text();
				var title  = "器材编辑";
				bootbox.hideAll();
				if (className == "green basket-edit") {
					$.post("basketEdit!editBasketEquip", {"equipId":equipId, "index":parseInt(index)}, function(html){
						mainbootbox(html,title, null, editsavecallback);
					}, "html");
				} else if (className == "tooltip-success basket-edit") {
					$.post("basketEdit!editBasketEquip", {"equipId":equipId, "index":parseInt(index1)}, function(html){
						mainbootbox(html,title, null, editsavecallback);
					}, "html");
				}
			});
			//清空合借框的回掉函数
			var confirmborrowcallback = function(){
				var c = $("button.btn-form-save");
	       		if($("#bean-form").valid() && !c.hasClass("disabled")){
	       			$.post("emptyBasket", $("#bean-form").serialize(),function(data){
	       				var data = eval('(' + data +')');
	       				if(data.success==true){
	       					mainbootboxalert("借用成功");
	       					$("table#sample-table-2").find("tbody").empty();
	       					checktable();
	       					totalbadge(0);
	       					return true;
	       				}else{
	       					c.removeClass("disabled")
	       					mainbootboxalert(data.msg);
	       				}
				   },"json")
	       		}else{
	       			return false;
	       		}
			}
			//清空合借框操作
			$("button#modalbtn").click(function(){
				bootbox.hideAll();
				$.post("confirmborrow", {}, function(html){
					var title="填写借用信息";
					mainbootbox(html,title, null, confirmborrowcallback);
				}, "html")
// 				$("#modal-form").modal();
			})
		})
		</script>
	</head>

	<body>
		<jsp:include page="../head.jsp"></jsp:include>
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
								<a href="javascript:void(0)">错误页面</a>
							</li>
							<li class="active">服务器发生错误</li>
						</ul>
					</div>

					<div class="page-content">
						<div class="col-xs-12">
							<div class="error-container">
								<div class="well">
									<h2 class="grey lighter smaller">
										<span class="blue bigger-110">
											<i class="ace-icon fa fa-random"></i>
											500
										</span>
										服务器处理错误
									</h2>
									<hr />
									<h4 class="lighter smaller">
										哎呀，程序出错了！
										<i class="ace-icon fa fa-wrench icon-animated-wrench bigger-120"></i>
									</h4>
									<div class="space"></div>
									<div>
										<h5 class="lighter smaller">请尝试以下操作:</h5>
										<ul class="list-unstyled spaced inline bigger-110 margin-15">
											<li>
												<i class="ace-icon fa fa-hand-o-right blue"></i>
												（1）检查数据库服务和tomcat服务是否开启！
											</li>
											<li>
												<i class="ace-icon fa fa-hand-o-right blue"></i>
												（2）联系管理员，叙述发生此特定错误的详细信息！
											</li>
<!-- 											<li> -->
<!-- 												<i class="ace-icon fa fa-hand-o-right blue"></i> -->
<!-- 												（3）请联系实验室吴兴超同学 -->
<!-- 											</li> -->
										</ul>
									</div>
									<hr />
									<div class="space"></div>
									<div class="center">
										<a href="index" class="btn btn-grey">
											<i class="ace-icon fa fa-arrow-left"></i>
											回到首页
										</a>
										
										<a href="javascript:history.back()" class="btn btn-grey">
											<i class="ace-icon fa fa-arrow-left"></i>
											返回
										</a>
									</div>
								</div>
							</div>
						</div>
					</div><!-- /.page-content -->
				</div><!-- /.main-content -->
				
				<jsp:include page="../common/setting.jsp"></jsp:include>
			</div><!-- /.main-container-inner -->
			<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
				<i class="icon-double-angle-up icon-only bigger-110"></i>
			</a>
		</div><!-- /.main-container -->

   		<script src="assets/js/chosen.jquery.min.js"></script>

		<script type="text/javascript">
			if("ontouchend" in document) document.write("<script src='assets/js/jquery.mobile.custom.min.js'>"+"<"+"/script>");
		</script>
		<script src="assets/js/bootstrap.min.js"></script>
		<script src="assets/js/typeahead-bs2.min.js"></script>

		<script src="assets/js/prettify.js"></script>

		<script src="assets/js/jquery-ui-1.10.3.custom.min.js"></script>
		<script src="assets/js/jquery.ui.touch-punch.min.js"></script>
		<script src="assets/js/bootbox.min.js"></script>
<%-- 		<script src="assets/js/jquery.easy-pie-chart.min.js"></script> --%>
		<script src="assets/js/jquery.gritter.min.js"></script>
		<script src="assets/js/spin.min.js"></script>

		<script src="assets/js/ace-elements.min.js"></script>
		<script src="assets/js/ace.min.js"></script>
	</body>
</html>
