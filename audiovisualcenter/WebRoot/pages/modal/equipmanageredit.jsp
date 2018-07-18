<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>器材管理</title>
    <link href="assets/css/bootstrap.min.css" rel="stylesheet" />
	<link rel="stylesheet" href="assets/css/font-awesome.min.css" />
	<link rel="stylesheet" href="assets/css/ace.min.css" />
	<link rel="stylesheet" href="assets/css/ace-rtl.min.css" />
	<link rel="stylesheet" href="assets/css/ace-skins.min.css" />
	<link rel="stylesheet" href="assets/css/chosen.css" />
   	
   	<script src="js/jquery-1.12.4.js"></script>
   	<script src="assets/js/jquery-2.0.3.min.js"></script>
	<script src="assets/js/bootstrap.min.js"></script>
<%-- 		<script src="assets/js/ace-extra.min.js"></script> --%>
   	<script src="assets/js/chosen.jquery.min.js"></script>
   	<script src="assets/js/fuelux/fuelux.spinner.min.js"></script>
<%-- 	<script src="assets/js/chosen.jquery.min.js"></script> --%>
	<script src="assets/js/ace-elements.min.js"></script>
	<script src="assets/js/ace.min.js"></script>
   	<script src="assets/js/jquery.validate.min.js"></script>
   	
   	<script src="assets/js/bootstrap.min.js"></script>
	<script src="assets/js/typeahead-bs2.min.js"></script>
   	<script src="assets/js/jquery.gritter.min.js"></script>
   	<script src="assets/js/jqGrid/jquery.jqGrid.min.js"></script>
	<script src="assets/js/jqGrid/i18n/grid.locale-en.js"></script>
	<!--弹出页面也应该导入相应的包，否则会报错 -->
   </head>
  
  <body>
   <s:form action="equipAdd!equipAdd" method="post" name="beanForm" id="beanform" cssClass="form-horizontal">    
     	<input type="hidden" value='<s:property value="flag"/>' name="flag">
     	<input type="hidden" value='<s:property value="equip.id"/>' name="id">
     	<div class="row">
		 <div class="col-xs-12">
			<form class="form-horizontal" role="form">
 				<div class="form-group">
					<label class="col-sm-3 control-label no-padding-right" for="form-field-2"> 名称</label>

					<div class="col-sm-6">
						<input type="text" name="name" id="form-field-2" value='<s:property value="equip.name"/>' placeholder="名称" class="col-xs-12 col-sm-12">
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-3 control-label no-padding-right" for="form-field-3">编号</label>

					<div class="col-sm-6">
						<input type="text" name="no" id="form-field-3" value='<s:property value="equip.no"/>' placeholder="编号(可选)" class="col-xs-12 col-sm-12">
					</div>
				</div>
				<div class="form-group">
					<div>
						<label class="col-sm-3 control-label no-padding-right" for="form-field-6">类别</label>

						<div class="col-xs-6">
							<select class="chosen-select" id="form-field-select-3" data-placeholder="类别" name="typeId">
								<s:iterator value="dataList">
									<s:if test="id==equip.typeId">
										<option value='<s:property value="id"/>' selected="selected"><s:property value="name"/> </option>
									</s:if>
									<s:else>
										<option value='<s:property value="id"/>'><s:property value="name"/> </option>
									</s:else>
								</s:iterator>
							</select>
						</div>
					</div>
				</div>
				<s:if test="flag==0">
					<div class="form-group">
						<div>
							<label class="col-sm-3 control-label no-padding-right" for="form-field-6">数量:</label>
							<div class="col-sm-1">
								<input type="hidden" id="etotal" value='<s:property value="equip.total"/>'>
								<input type="text" class="input-mini" value="<s:property value="equip.total"/>" id="spinner3" name="total"/>
							</div>
	 					</div>
					</div>
				</s:if>
				<s:elseif test="flag==1">
					<div class="form-group">
						<label class="col-sm-3 control-label no-padding-right" for="form-field-7">子编号</label>
	
						<div class="col-sm-6" id="form-field-7">
							<s:iterator value="#request.childs" status="status">
								<div class="col-xs-12 col-sm-12">
									<s:if test="#status.index==0">
										<input type="text" name="childno" value='<s:property value="no"/>' class="col-xs-10 col-sm-10">	
									</s:if>
									<s:else>
										<br>
										<input type="text" name="childno" value='<s:property value="no"/>' class="col-xs-10 col-sm-10">	
										<a class="btn btn-danger btn-minier col-xs-1 pull-right" name="delOption"><i class="icon-minus"></i></a>		
									</s:else>
								</div>
							</s:iterator>
							<br>
							<div class="col-xs-12 col-sm-12" align="center">
								<a class="btn btn-app btn-success btn-xs" name="addOption"><i class="icon-plus-sign bigger-200"></i></a>
							</div>
						</div>
					</div>
				</s:elseif>
				
				<div class="form-group">
					<div>
						<label class="col-sm-3 control-label no-padding-right" for="form-field-11">器材状况</label>
					 	<div class="col-xs-9">
					 		<div class="control-group">
								<div class="radio col-xs-12" id="form-field-11">
									<label>
										<input type="radio" class="ace" <s:if test="equip.con==1">checked</s:if> name="con" value="1"/>
										<span class="lbl">良好</span>
									</label>
									&nbsp;&nbsp;&nbsp;
									<label>
										<input  type="radio" class="ace" <s:if test="equip.con==0">checked</s:if> name="con" value="0"/>
										<span class="lbl">损坏</span>
									</label>
							 </div>
					 		</div>
					 	</div>
					</div>
				</div>
				<%-- <div class="form-group">
					<div>
						<label class="col-sm-3 control-label no-padding-right" for="form-field-12">启用</label>
					 	<div class="col-xs-6" style="margin-top: 6px;">
					 		<label>
								<input name="equipstatus" class="ace ace-switch ace-switch-6" <s:if test="equip.status==true">checked</s:if> type="checkbox" id="status" value='<s:if test="equip.status==true">1</s:if>'>
								<span class="lbl"></span>
							</label>
					 	</div>
					 </div>
				</div> --%>
			</form>
		</div>
	</div>
  </s:form>
    <script type="text/javascript">
		jQuery(function($) {
			$(".chosen-select").chosen(); 
			$('.chosen-container').each(function(){
				$(this).find('a:first-child').css('width' , '252px');
				$(this).find('.chosen-drop').css('width' , '252px');
				$(this).find('.chosen-search input').css('width' , '242px');
			});
			$('#spinner3').ace_spinner({
				value:parseInt($("#etotal").val()),
				min:1,
// 				max:100,
				step:1, 
				on_sides: true, 
				icon_up:'icon-plus smaller-75', 
				icon_down:'icon-minus smaller-75', 
				btn_up_class:'btn-success' , 
				btn_down_class:'btn-danger'
			});
			$("a[name='delOption']").click(function(){
				delOption(this);
			})
			//添加选项
			$("a[name='addOption']").click(function(){
				var divNode = $("<div class='col-xs-12 col-sm-12'></div>");
				var inputNode = $("<input type='text' name='childno' placeholder='编号' class='col-xs-10 col-sm-10'>");
				var aNode = $("<a class='btn btn-danger btn-minier col-xs-1 pull-right'><i class='icon-minus'></i></a>")
				aNode.click(function(){
					delOption(this)
				})
				divNode.append($("<br/>"));
				divNode.append(inputNode);
				divNode.append(aNode);
				$(this).parent("div").prev("br").before(divNode)
			})
			//删除选项
			function delOption(node){
				$(node).parent("div").remove();
			}
			//管理元同意
			$("#status").click(function(){
				var currentNode = this;
				if(currentNode.checked){
					mainbootboxprompt("请填写管理员密码", function(result){
						if(result!=null){
							$.post("loadpassword", {"password":result}, function(data){
								var data = eval('(' + data+ ')');
								if(data.success){
									$(currentNode).val("1");
									return true;
								}
								else{
									mainbootboxalert(data.msg,null, null);
									currentNode.checked  = false;
									return false;
								}
							})
						}else{
							currentNode.checked  = false;
						}
					});
				}else{
					$(currentNode).val("0");
				}
			})
			$('#beanform').validate({
				onkeyup:false,
				focusCleanup:false,
				errorElement: 'div',
				errorClass: 'validate-block',
				focusInvalid: true,
				rules: {
// 					no: {
// 						required: true,
// 					},
					name: {
						required: true,
					},
					typeId: {
						required: true,
					},
					childno:{
						required: true,
					}
				},
				messages: {
// 					no: {
// 						required: "请填写器材编号",
// 					},
					name: {
						required: "请填写器材名称",
					},
					typeId: {
						required: "请填写器材类型",
					},
					childno:{
						required: "请输入器材的子编号",
					}
				},
				highlight: function (e) {
					$(e).closest('.form-group').removeClass('has-info').addClass('has-error red');
				},
				success: function (e) {
					$(e).closest('.form-group').removeClass('has-error red');
					$(e).remove();
				},
				errorPlacement: function (error, element) {
					if(element.attr("name")=="status"){
						error.insertAfter(element.parent().parent())
					}else if(element.attr("name")=="childno"){
						error.insertAfter(element.parent().parent())
					}else
						error.insertAfter(element.parent());
				}
			});
		});
	</script>
  </body>
</html>
