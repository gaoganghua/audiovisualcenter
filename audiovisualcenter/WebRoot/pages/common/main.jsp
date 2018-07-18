<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'main.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body class="no-skin">
		<!-- head -->
		<s:action name="index!head" namespace="/user" executeResult="true"></s:action>
		<div class="main-container" id="main-container">
			<!-- left -->
			<s:action name="index!left" namespace="/user" executeResult="true"></s:action>
			<div class="main-content">
				<div id="breadcrumbs" class="breadcrumbs">
					<ul class="breadcrumb">
						<li><i class="fa fa-home home-icon"></i> <a href="index">首页</a></li>
					</ul>
				</div>
				<div class="page-content">
					<i id="page-spinner" class="ace-icon fa fa-spinner fa-spin orange bigger-200" style="position: absolute;display: none;"></i>
					<div class="row">
						<div id="syspage-content" class="col-xs-12"></div>
					</div>
				</div>
			</div>
			<div class="footer">
				<div class="footer-inner">
					<div class="footer-content">
						<span class="bigger-120"><span class="blue bolder"><a target="_blank" href="${ciSite}">${ciName}</a></span> Application © 2017 <span class="blue">Technical support <a target="_blank" href="http://www.zhisolution.com">Zhisolution</a></span></span>
					</div>
				</div>
			</div>
			<a href="javascript:void(0)" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
				<i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
			</a>
		</div>
  </body>
</html>
