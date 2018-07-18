<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s" %>

<html>
  <head>
    
    <title>My JSP 'module.jsp' starting page</title>
    
	<script type="text/javascript" src="assets/js/jquery-2.0.3.js"></script>
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script type="text/javascript">
	$(function(){
		var sid = $("input[name='pageId']").val();
		
		if(sid==null || sid=="" || sid=="null"){
			sid = 1;
		}
		var node = $("li[id='" + sid+"']");
		if(node.parent("ul.submenu").length>0){
			node.parent("ul.submenu").parent("li").addClass("active open");
		}
		node.addClass("active");
		
		//查询合借框里面的种类
		$.post("querybasket!queryBasket", {}, function(data){
			var data = eval('(' +data + ')');
			var basketANode = $("ul.module").find("li[id=2] a");
			var badgeNode = $(basketANode).find("span.badge");
			if(parseInt(data.msg)>0){
				if(badgeNode.length>0){
					badgeNode.text(data.msg);
				}else{
					var badgeNode = $("<span class='badge badge-primary'></span>");
					badgeNode.text(data.msg);
					basketANode.append(badgeNode);
				}
			}
		})
		$(".dropdown-toggle").click(function(){
			return true;
		})
	})
	</script>
  </head>
  
  <body>
  <div class="sidebar" id="sidebar">
	<script type="text/javascript">
		try{ace.settings.check('sidebar' , 'fixed')}catch(e){}
	</script>
	
  	<ul class="nav nav-list module">
  		<s:iterator value="dataList" status="st" var="module">
  			<li id="<s:property value="#module.id"/>">
  				<s:if test="#module.children!=null && #module.children.size>0">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown">
						<i class='<s:property value="#module.iconClass"/>'></i>
						<span class="menu-text"><s:property value="#module.name"/> </span>
						<b class="arrow icon-angle-down"></b>
					</a>
					<ul class="submenu">
						<s:iterator value="#module.children" status="st2" var="childModule">
							<li id="<s:property value="#childModule.id"/>">
								<a href="<s:property value="#childModule.url"/>?pageId=<s:property value="#childModule.id"/>">
									<i class='<s:property value="#childModule.iconClass"/>'></i>
									<span class="menu-text"><s:property value="#childModule.name"/> </span>
								</a>
							</li>	
						</s:iterator>
					</ul>
  				</s:if>
  				<s:else>
  					<a href="<s:property value="#module.url"/>?pageId=<s:property value="#module.id"/>">
						<i class='<s:property value="#module.iconClass"/>'></i>
						<span class="menu-text"><s:property value="#module.name"/> </span>
					</a>
  				</s:else>
				
			</li>
  		</s:iterator>
	</ul>
	
	<!-- <div class="sidebar-collapse" id="sidebar-collapse">
		<i class="icon-double-angle-left" data-icon1="icon-double-angle-left" data-icon2="icon-double-angle-right"></i>
	</div> -->

	<script type="text/javascript">
		try{ace.settings.check('sidebar' , 'collapsed')}catch(e){}
	</script>
</div>
	<input type="hidden" name="pageId" value='<s:property value="pageId"/>'>
<!--          <ul class="nav nav-list"> -->
<!-- 			<li id="1"> -->
<!-- 				<a href="pages/index.jsp?id=1"> -->
<!-- 					<i class="icon-facetime-video"></i> -->
<!-- 					<span class="menu-text"> 器材借用 </span> -->
<!-- 				</a> -->
<!-- 			</li> -->
<!-- 			<li class="active" id="2"> -->
<!-- 				<a href="pages/basket.jsp?id=2"> -->
<!-- 					<i class="icon-gift"></i> -->
<!-- 					<span class="menu-text"> 合借筐 </span> -->
<!-- 				</a> -->
<!-- 			</li> -->

<!-- 			<li id="3"> -->
<!-- 				<a href="pages/equipmanage.jsp?id=3"> -->
<!-- 					<i class="icon-desktop"></i> -->
<!-- 					<span class="menu-text"> 器材管理 </span> -->
<!-- 				</a> -->
<!-- 			</li> -->

<!-- 			<li id="4"> -->
<!-- 				<a href="#" class="dropdown-toggle"> -->
<!-- 					<i class="icon-edit"></i> -->
<%-- 					<span class="menu-text"> 借单管理 </span> --%>

<!-- 					<b class="arrow icon-angle-down"></b> -->
<!-- 				</a> -->

<!-- 				<ul class="submenu"> -->
<!-- 					<li id="5"> -->
<!-- 						<a href="pages/waitereturn.jsp?id=5"> -->
<!-- 							<i class="icon-double-angle-right"></i> -->
<!-- 							等待归还 -->
<!-- 						</a> -->
<!-- 					</li> -->

<!-- 					<li id="6"> -->
<!-- 						<a href="pages/history.jsp?id=6"> -->
<!-- 							<i class="icon-double-angle-right"></i> -->
<!-- 							历史记录 -->
<!-- 						</a> -->
<!-- 					</li> -->
<!-- 				</ul> -->
<!-- 			</li> -->
<!-- 		</ul> -->
  </body>
</html>
