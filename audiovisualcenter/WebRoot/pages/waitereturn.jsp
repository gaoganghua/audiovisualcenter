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
		<title>借单管理 - 未归还器材</title>
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
<%-- 		<script src="js/jquery.dataTables.min.js"></script> --%>
		<script src="js/mytable.js"></script>
<%-- 		<script src="assets/js/jquery.dataTables.bootstrap.js"></script> --%>
		<script src="assets/js/bootbox.min.js"></script>
		<script src="js/ejs_production.js"></script>
		
		<script type="text/javascript">
		$(function(){
			//生成订单信息的html
			var viewOptions = function(data) {
			    return new EJS({url: "ejs/viewOptions.ejs"}).render({
			    	data:data,
			    });
			}
			//生成警告信息的html
			var alertOptions = function(text) {
			    return new EJS({url: "ejs/alertOptions.ejs"}).render({
			    	style:"alert-danger",
			    	remove:false,
			    	strong:false,
// 			    	icon:false,
			    	text:text,
			    });
			}
			//生成表格的html
			var tableOptions = function(data) {
			    return new EJS({url: "ejs/tableOptions.ejs"}).render({
			    	edit:false,
			    	remove:true,
			    	view:true,
			    	confirm:true,
			    	data:data,
			    });
			}
			//插入数据
			var inserthtml = function(data){
				var data = eval('(' + data+ ')');
				var html=tableOptions(data.data);
				$("div.table-responsive").html(html);
			}
			//查询所有数据
			var createtable = function(){
				$.post("waitreturnInfo",{},function(data){
					var data = eval('(' + data+ ')');
					if(data.success){
						var html=tableOptions(data.data);
						$("div.table-responsive").html(html);
					}else{
						var html = alertOptions(data.msg);
						$("div.table-responsive").html(html);
					}
				},"json")
			}
			//使用append追加的html代码，使用以下方式获取节点
			$("body").on("click","th[name='borrowTime']",function(){
				var currentNode = $(this).find("i#orderBtn");
				var iconCls = $(currentNode).attr("class");
				var orderColumn = $(currentNode).parent("th").attr("name");
				
				if(iconCls.indexOf("icon-chevron-up")!=-1){//倒序排列
					$.post("waitreturnInfo",{"orderColumn":orderColumn,"orderColumnDir":"desc"},function(data){
						inserthtml(data);
						$("#orderBtn").attr("class","icon-chevron-down pull-right");
					},"json")
				}else{//正序排列
					$.post("waitreturnInfo",{"orderColumn":orderColumn,"orderColumnDir":"asc"},function(data){
						inserthtml(data);
						$("#orderBtn").attr("class","icon-chevron-up pull-right")
					},"json")
				}
			});
			//编辑备注的回掉函数
			var editmsgcallback = function(result, params){
				$.post("waitreturnMsg",{"id":params,"borrowMsg":result}, function(data){
					var data = eval('(' + data+ ')');
					if(data.success){
						if(result==""){
							$("tr[id='"+params+"']>td[name='borrowMsgBtn']>button").attr("class", "btn btn-xs");
						}else{
							$("tr[id='"+params+"']>td[name='borrowMsgBtn']>button").attr("class", "btn btn-xs btn-warning");
						}
					}else{
						if(data.msg=="500"){
       						window.location.href="pages/common/error.jsp";
       					}
						mainbootboxalert(data.msg);
					}
				})
			}
			//添加备注
			$("body").on("click","table>tbody>tr>td[name='borrowMsgBtn']>button",function(){
				var bid = $(this).parent("td").parent("tr").attr("id");
				$.post("waitreturnMsg",{"id":bid}, function(data){
					var data = eval('(' + data +')');
					if(data.success){
						advancebootboxprompt("编辑查看备注",editmsgcallback ,data.msg, bid);
					}else{
						if(data.msg=="500"){
       						window.location.href="pages/common/error.jsp";
       					}
						mainbootboxalert(data.msg);
					}
				})
			})
			//查看器材
			$("body").on("click","button[name='viewbtn']",function(){
				var bid = $(this).parent("div").parent("td").parent("tr").attr("id");
				$.post("waitreturnView",{"id":bid},function(data){
					var data = eval('(' + data +')');
					var html = viewOptions(data.data);
					$("div.modal-body").html(html)
					$("#modal-table").modal({
						show:true,
  						backdrop:'static',
					});
				})
			})
			//确认归还和取消借单的回掉函数
			var savecallback = function(params){
				var url = params[2];
				var bid = params[1];
				var currentNode = params[0];
				mainbootboxprompt("请输入管理员密码", function(result){
					if(result===null){
					}else{
						$.post("loadpassword",{"password":result}, function(data){
							var data = eval('(' + data+ ')');
							if(data.success){
								$.post(url,{"id":bid},function(data){
									var data = eval('(' + data +')');
									if(data.success){
										$(currentNode).parent("div").parent("td").parent("tr").remove();
										if($("table").find("tbody tr").length>0){
											changeTableIndex($("table"), $("table tbody tr").length)
										}else{
											var html = alertOptions("没有等待归还的借单!");
											$("div.table-responsive").html(html);
										}
										waitreturnbadge(2)
										window.location.herf="waitreturnPage?pageId=5";
									}else{
										if(data.msg=="500"){
				       						window.location.href="pages/common/error.jsp";
				       					}
										mainbootbox(data.msg);
									}
								})
							}else{
								mainbootboxalert(data.msg);
							}
						})
					}
				});
			}
			//确认归还
			$("body").on("click","button[name='confirmreturnbtn']",function(){
				var currentNode = this;
				var url="waitreturnConfirm";
				var bid = $(this).parent("div").parent("td").parent("tr").attr("id");
				var params = new Array();
				params.push(currentNode);
				params.push(bid);
				params.push(url);
				mainbootboxconfirm("确定该借单已归还","等待归还",savecallback, null,params);
			})
			//删除借单
			$("body").on("click","button[name='removebtn']",function(){
				var currentNode = this;
				var url="waitreturnCancel";
				var bid = $(this).parent("div").parent("td").parent("tr").attr("id");
				var params = new Array();
				params.push(currentNode);
				params.push(bid);
				params.push(url);
				mainbootboxconfirm("确定取消该借单","等待归还",savecallback, null,params);
			})
	        //创建表格
	        createtable();
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
								<a href="waitreturnPage?pageId=5">等待归还</a>
							</li>
							<li class="active">未归还器材</li>
						</ul><!-- .breadcrumb -->
					</div>

					<div class="page-content">
						<div class="page-header">
							<h1>
								未完成借单
								<small>
									<i class="icon-double-angle-right"></i>
									未归还器材
								</small>
							</h1>
						</div><!-- /.page-header -->
						<div class="col-xs-12">
							<div class="table-header">
								未归还器材信息：
							</div>

							<div class="table-responsive">
							</div>
						</div>
					</div><!-- /.page-content -->
				</div><!-- /.main-content -->
				
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
				
				<jsp:include page="common/setting.jsp"></jsp:include>
 				
 				</div>
			</div>
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
