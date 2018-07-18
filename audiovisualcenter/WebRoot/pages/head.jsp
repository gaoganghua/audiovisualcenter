<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<html>
  <head>
	<script type="text/javascript">
 	$(function(){ 
 		function mofidyLoginPassword(result){
 			if(result===null){
 			}else if(result==""){
 				mainbootboxalert("请输入新的密码");
 				return false;
 			}else{
 				$.post("modifypassword",{"loginPassword":result}, function(data){
 					var data = eval('(' +data +')');
 					mainbootboxalert(data.msg)
 				})
 			}
 		}
 		$("li[name='modifypassword']").click(function(){ 
 			mainbootboxprompt("修改密码",mofidyLoginPassword)
		})
		function waitreturntotalfn(){
			$.post("waitreturnTotal",{}, function(data){
				var data = eval('(' +data +')');
				if(data.success){
					if(parseInt(data.msg)>0){
						var node = $("span[name='waitreturntotal']");
						node.text(data.msg);
					}
				}
			})
		}
		waitreturntotalfn();
		$("a[name='waitreturnbtn']").click(function(){
			window.location.href="waitreturnPage?pageId=5";
		})
 	})
	</script>
  </head>
  
  <body>
    <div class="navbar navbar-default" id="navbar">
			<script type="text/javascript">
				try{ace.settings.check('navbar' , 'fixed')}catch(e){}
			</script>

			<div class="navbar-container" id="navbar-container">
				<div class="navbar-header pull-left">
					<a href="pages/index.jsp?pageId=1" class="navbar-brand" style="cursor: pointer;">
						<small>
							<i class="icon-leaf"></i>
							电教器材管理中心
						</small>
					</a><!-- /.brand -->
				</div><!-- /.navbar-header -->

				<div class="navbar-header pull-right" role="navigation">
					<ul class="nav ace-nav">
						<li class="purple">
							<a data-toggle="dropdown" class="dropdown-toggle" href="#" name="waitreturnbtn">
								<i class="icon-bell-alt icon-animated-bell"></i>
								<span class="badge badge-important" name="waitreturntotal"></span>
							</a>
						</li>

						<li class="light-blue">
							<a data-toggle="dropdown" href="#" class="dropdown-toggle">
								<img class="nav-user-photo" src="assets/avatars/user.jpg" alt="Jason's Photo" />
								<span class="user-info">
									<small>欢迎</small>
									<s:property value="#session.login_user.loginName"/>
								</span>

								<i class="icon-caret-down"></i>
							</a>

							<ul class="user-menu pull-right dropdown-menu dropdown-yellow dropdown-caret dropdown-close">
								<li name="modifypassword">
									<a href="javascript:void(0)" >
										<i class="icon-user"></i>
										修改密码
									</a>
								</li>
								<li>
									<a href="loginout">
										<i class="icon-off"></i>
										退出登录
									</a>
								</li>
							</ul>
						</li>
					</ul><!-- /.ace-nav -->
				</div><!-- /.navbar-header -->
			</div><!-- /.container -->
		</div>
  </body>
</html>
