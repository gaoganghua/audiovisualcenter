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
						if(data.msg=="500"){
       						window.location.href="pages/common/error.jsp";
       					}
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
	       					if(data.msg=="500"){
	       						window.location.href="pages/common/error.jsp";
	       					}
	       					c.removeClass("disabled")
	       					mainbootboxalert(data.msg);
	       				}
// 	       				window.location.href="pages/basket.jsp?pageId=2";
				   },"json")
	       		}else{
// 	       			window.location.href="pages/basket.jsp?pageId=2";
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
	       					window.location.href="basket?pageId=2";
	       					return true;
	       				}else{
	       					if(data.msg=="500"){
	       						window.location.href="pages/common/error.jsp";
	       					}
	       					c.removeClass("disabled")
	       					mainbootboxalert(data.msg);
	       				}
// 	       				window.location.href="pages/basket.jsp?pageId=2";
				   },"json")
	       		}else{
	       			return false;
	       		}
			}
			//取消按钮的回掉函数
			var cancelcallback = function(){
				window.location.href="basket?pageId=2";
			}
			//清空合借框操作
			$("button#modalbtn").click(function(){
				bootbox.hideAll();
				$.post("confirmborrow", {}, function(html){
					var title="填写借用信息";
					mainbootbox(html,title, null, confirmborrowcallback, cancelcallback);
				}, "html")
// 				$("#modal-form").modal();
			})
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
								<a href="basket?pageId=2">合借筐</a>
							</li>
							<li class="active">确认借单</li>
						</ul>
					</div>

					<div class="page-content">
						<div class="page-header">
							<h1>
								合借筐
								<small>
									<i class="icon-double-angle-right"></i>
									查看
								</small>
							</h1>
						</div><!-- /.page-header -->
						
						<div class="col-xs-12">
							<div class="table-header">
								请确认您要借用的器材：
							</div>
							
							<s:if test="dataList!=null && dataList.size>0">
							<div class="table-responsive">
								<table id="sample-table-2" class="table table-striped table-bordered table-hover" style="border-style: none;">
									<thead>
										<tr>
											<th class="center">序号</th>
											<th>名称</th>
											<th>编号</th>
											<th class="hidden-480">数量</th>

											<th>
												<i class="icon-time bigger-110 hidden-480"></i>
												类别
											</th>
											<th class="hidden-480">借出状态</th>

											<th></th>
										</tr>
									</thead>

									<tbody>
									<s:iterator value="dataList" var="e" step="status" status="index">
										<tr>
											<td class="center">
												<label><s:property value="#index.count"/> </label>
											</td>

											<td  name="equipName">
												<a href="javascript:void(0)"><s:property value="equipName"/></a>
											</td>
											<td name="equipNo"><s:property value="equipNo"/> </td>
											<td class="hidden-480" name="total"><s:property value="total"/> </td>
											<td name="equipCategory"><s:property value="equipCategory"/> </td>

											<td class="hidden-480" name="condition">
												<s:if test='condition==true'>
													<span class="label label-sm label-success">良好</span>
												</s:if>
												<s:else>
													<span class="label label-sm label-inverse arrowed-in">损坏</span>
												</s:else>
											</td>

											<td>
												<div class="visible-md visible-lg hidden-sm hidden-xs action-buttons">
													<a class="green basket-edit" href="javascript:void(0)" name='<s:property value="equipId"/>'>
														<i class="icon-pencil bigger-130"></i>
													</a>

													<a class="red basket-remove" href="javascript:void(0)" name='<s:property value="equipId"/>'>
														<i class="icon-trash bigger-130"></i>
													</a>
												</div>

												<div class="visible-xs visible-sm hidden-md hidden-lg">
													<div class="inline position-relative">
														<button class="btn btn-minier btn-yellow dropdown-toggle" data-toggle="dropdown">
															<i class="icon-caret-down icon-only bigger-120"></i>
														</button>

														<ul class="dropdown-menu dropdown-only-icon dropdown-yellow pull-right dropdown-caret dropdown-close">
															<li>
																<a href="javascript:void(0)" class="tooltip-success basket-edit" data-rel="tooltip" title="Edit" name='<s:property value="equipId"/>'>
																	<span class="green">
																		<i class="icon-edit bigger-120"></i>
																	</span>
																</a>
															</li>

															<li>
																<a href="javascript:void(0)" class="tooltip-error basket-remove" data-rel="tooltip" title="Delete" name='<s:property value="equipId"/>'>
																	<span class="red">
																		<i class="icon-trash bigger-120"></i>
																	</span>
																</a>
															</li>
														</ul>
													</div>
												</div>
											</td>
									</s:iterator>
										
									<tr style="border-style: none;">
										<td colspan="6" style="border-style: none;">
											
										</td>
										<td style="border-style: none;">
											<button class="btn btn-success btn-xs" id="modalbtn" role="button" href="#modal-form1" data-toggle="modal" style="outline: none;">
								    		合借
								    		</button>
										</td>
									</tr>
									</tbody>
								</table>
							</div>
							</s:if>
							<s:else>
								<div class="alert alert-danger">
									<button type="button" class="close" data-dismiss="alert">
										<i class="icon-remove"></i>
									</button>
									合借框里还没有任何东西
									<br />
								</div>
							</s:else>
						</div>
					</div><!-- /.page-content -->
				</div><!-- /.main-content -->
				
				<jsp:include page="common/setting.jsp"></jsp:include>
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
