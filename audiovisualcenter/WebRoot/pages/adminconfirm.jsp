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
							<div class="space-8"></div>
							<div class="col-xs-8 center">
								<form action="" method="post" id="login-form" >
									<fieldset>
										<label class="block clearfix col-xs-8">
											<span class="block input-icon input-icon-right">
												<input type="password" name="adminPassword" class="form-control" placeholder="管理员密码" />
												<i class="icon-lock"></i>
											</span>
										</label>

										<div class="space"></div>

										<div class="clearfix col-xs-8">
											<button type="button" id="adminButton" class="width-35 pull-right btn btn-sm btn-primary">
												<i class="icon-key"></i>
												登录
											</button>
										</div>
										<div class="space-4"></div>
									</fieldset>
								</form>
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
		<script src="assets/js/jquery.gritter.min.js"></script>

		<script src="assets/js/ace-elements.min.js"></script>
		<script src="assets/js/ace.min.js"></script>
		<script src="assets/js/jquery.validate.min.js"></script>
		<script type="text/javascript">
		
			var $path_base = "/";
// 			jQuery(function($) {//不要用这个，很坑
			$(function(){
				$('#adminButton').on('click', function() {
					var adminpassword = $('#login-form').find("input[name='adminPassword']").val();
					if(adminpassword!=""){
						if(adminpassword.length>10){
							mainbootboxalert("密码错误");
						}else{
							$.post("loadpassword",{"password":adminpassword}, function(data){
								var data = eval('(' + data+ ')');
								if (data.success){
									window.location.href="equipManager?pageId=3";
								}else{
									mainbootboxalert(data.msg)
								}
							},'json');
						}
					}else{
						mainbootboxalert("请输入密码");
					}
					return false;
				});
				//敲击键盘上的回车键
				$("input[name='adminPassword']").keydown(function(event) {
					if (event.keyCode == "13") {
						$('#adminButton').click();
						return false;//取消提交的默认行为
					}
				});
			});
		</script>
	</body>
</html>
