<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<html>
  <head>
    <title>历史记录的订单</title>
	
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
<%-- 	<script src="assets/js/bootstrap.min.js"></script> --%>
<%-- 	<script src="assets/js/ace-extra.min.js"></script> --%>
<%-- 	<script src="js/jquery.dataTables.min.js"></script> --%>
<%-- 	<script src="js/mytable.js"></script> --%>
<%-- 	<script src="assets/js/jquery.dataTables.bootstrap.js"></script> --%>
<%-- 	<script src="assets/js/bootbox.min.js"></script> --%>
<%-- 	<script src="js/ejs_production.js"></script> --%>
	
<%-- 	<script src="assets/js/bootstrap.min.js"></script> --%>
<%-- 	<script src="assets/js/typeahead-bs2.min.js"></script> --%>
<%-- 	<script src="assets/js/jquery.gritter.min.js"></script> --%>
<%-- 	<script src="assets/js/spin.min.js"></script> --%>
<%-- 	<script src="assets/js/ace-elements.min.js"></script> --%>
<%-- 	<script src="assets/js/ace.min.js"></script> --%>
	
<%-- 	<script src="assets/js/bootstrap.min.js"></script> --%>
<%-- 	<script src="assets/js/typeahead-bs2.min.js"></script> --%>
	<script type="text/javascript">
	$(function(){
	})
	</script>
  </head>
  
  <body>
  <s:if test="dataList!=null && dataList.size>0">
	<table class="table table-striped table-bordered table-hover no-margin-bottom no-border-top">
		<thead>
			<tr>
				<th>名称</th>
				<th>编号</th>
				<th>数量</th>

				<th>
					<i class="icon-time bigger-110"></i>
					状态
				</th>
			</tr>
		</thead>

		<tbody>
			<s:iterator value="dataList">
				<tr>
					<td>
						<a href="javascript:void(0)"><s:property value="equipName"/> </a>
					</td>
					<td><s:property value="equipNo"/></td>
					<td><s:property value="total"/></td>
					<td>
						<s:if test="condition==true">良好</s:if>
						<s:else>损坏</s:else>
					</td>
				</tr>
			</s:iterator>
		</tbody>
	</table>
	</s:if>
	<s:else>
		没有任何记录
	</s:else>
  </body>
</html>
