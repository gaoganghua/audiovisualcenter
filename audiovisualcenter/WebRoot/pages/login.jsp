<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html lang="en">
	<head>
		<base href="<%=basePath%>">
		
		<meta charset="utf-8" />
		<title>登录 - 电教器材管理中心</title>

		<link href="assets/css/bootstrap.min.css" rel="stylesheet" />
		<link rel="stylesheet" href="assets/css/font-awesome.min.css" />
<!-- 		<link rel="stylesheet" href="assets/css/prettify.css" /> -->
		<link rel="stylesheet" href="assets/css/ace.min.css" />
		<link rel="stylesheet" href="assets/css/ace-rtl.min.css" />
		<link rel="stylesheet" href="assets/css/ace-skins.min.css" />
		<link rel="stylesheet" href="js/default/layer.css"/>
		
		<script src="assets/js/jquery-2.0.3.min.js"></script>
		<script src="assets/js/bootstrap.min.js"></script>
		<script src="assets/js/ace-extra.min.js"></script>
		
		<script src="js/jquery-1.12.4.js"></script>
		<style type="text/css">
			.row { margin-left: -6px; margin-right: -6px; }
			.help-block { margin-bottom: 0; margin-top: 8px; }
			.jsq { width:34px; height:34px; margin-top: -8px; }
			.modal-dialog{ width:500px; }
		</style>
	  </head>

	<body class="login-layout">
		<div class="main-container" style="margin-top: 100px;">
			<div class="main-content">
				<div class="row">
					<div class="col-sm-10 col-sm-offset-1">
						<div class="login-container">
							<div class="center">
								<h1>
									<i class="icon-leaf green"></i>
									<span class="red">电教</span>
									<span class="white">器材管理</span>
								</h1>
							</div>

							<div class="space-6"></div>

							<div class="position-relative">
								<div id="login-box" class="login-box visible widget-box no-border">
									<div class="widget-body">
										<div class="widget-main">
											<h4 class="header blue lighter bigger">
												<i class="icon-coffee green"></i>
												请登录管理员账户
											</h4>

											<div class="space-6"></div>

											<form action="loginsuccess" method="post" id="login-form">
												<fieldset>
													<label class="block clearfix">
														<span class="block input-icon input-icon-right">
															<input type="text" name="loginName" class="form-control" placeholder="管理员账号" />
															<i class="icon-user"></i>
														</span>
													</label>

													<label class="block clearfix">
														<span class="block input-icon input-icon-right">
															<input type="password" name="loginPassword" class="form-control" placeholder="登陆密码" />
															<i class="icon-lock"></i>
														</span>
													</label>

													<div class="space"></div>

													<div class="clearfix">
														<label class="inline">
															<input type="checkbox" class="ace" id="remember"/>
															<span class="lbl"> 记住我</span>
														</label>
														<button type="button" id="loginButton" class="width-35 pull-right btn btn-sm btn-primary">
															<i class="icon-key"></i>
															登录
														</button>
													</div>

													<div class="space-4"></div>
												</fieldset>
											</form>
										</div><!-- /widget-main -->
									</div><!-- /widget-body -->
								</div><!-- /login-box -->
							</div><!-- /position-relative -->
						</div>
					</div><!-- /.col -->
				</div><!-- /.row -->
			</div>
		</div><!-- /.main-container -->

		<script type="text/javascript">
			if("ontouchend" in document) document.write("<script src='assets/js/jquery.mobile.custom.min.js'>"+"<"+"/script>");
		</script>
		<script src="assets/js/bootstrap.min.js"></script>
		<!-- page specific plugin scripts -->
		<script src="assets/js/jquery.validate.min.js"></script>
		<script src="assets/js/additional-methods.min.js"></script>
		<script src="assets/js/bootbox.min.js"></script>
		<!-- ace scripts -->
		<script src="assets/js/ace-elements.min.js"></script>
		<script src="assets/js/ace.min.js"></script>
		<script src="assets/js/ace.min.js"></script>
		<script src="js/layer.js"></script>
		
		<script type="text/javascript">
		$(function(){
			$('#login-form').validate({
				errorElement: 'div',
				errorClass: 'help-block',
				focusInvalid: false,
				rules: {
					loginName: {
						required: true
					},
					loginPassword: {
						required: true
					}
				},
				messages: {
					loginName: {
						required: "请输入登录账户."
					},
					loginPassword: {
						required: "请输入登录密码."
					}
				},
				highlight: function (e) {
					$(e).closest('.clearfix').removeClass('has-info').addClass('has-error');
				},
				success: function (e) {
					$(e).closest('.clearfix').removeClass('has-error');
					$(e).remove();
				},
				errorPlacement: function (error, element) {
					error.insertAfter(element.parent());
				}
			})
			if(ace.cookie.get("settlement-user-login-name")!=null){
				$('#login-form').find("input[name='loginName']").val(ace.cookie.get("settlement-user-login-name"));
			}else{
				$('#login-form').find("input[name='loginName']").val('');
			}
			$("#remember").attr("checked",ace.cookie.get("settlement-user-remember"));
			//登陆
			$('#loginButton').on('click', function() {
				var loginButton = $('#loginButton');
				if($('#login-form').valid()){
					var remember = $('#login-form').find('#remember');
					$.post("loginCheck", $('#login-form').serialize(),function(data){
						var data = eval('(' + data+ ')');
						if (data.success){
							if(remember.is(':checked')){//存入cookie中时间为
								var loginname = $('#login-form').find("input[name='loginName']").val();
	      						ace.cookie.set("settlement-user-login-name", loginname, 5000);
	      						ace.cookie.set("settlement-user-remember", true, 5000);
							}else{
								ace.cookie.remove("settlement-user-login-name");
								ace.cookie.remove("settlement-user-remember");
							}
							$('#login-form').submit();
						}else{
							layer.msg(data.msg, { time: 1000 });
						}
					},'json');
				}
			});
			//敲击键盘上的回车键
			$("input[name='loginPassword']").keydown(function(event) {
				if (event.keyCode == "13") {
					$('#loginButton').click();
				}
			});
		})
		</script>
	</body>
</html>
