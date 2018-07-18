<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html>
<html>
	<head>
		<title></title>
		<link href="assets/css/bootstrap.min.css" rel="stylesheet" />
		<link rel="stylesheet" href="assets/css/font-awesome.min.css" />
		<link rel="stylesheet" href="assets/css/ace.min.css" />
		<link rel="stylesheet" href="assets/css/ace-rtl.min.css" />
		<link rel="stylesheet" href="assets/css/ace-skins.min.css" />
		<link rel="stylesheet" href="assets/css/chosen.css" />
	   	
	   	<script src="assets/js/jquery-2.0.3.min.js"></script>
		<script src="assets/js/bootstrap.min.js"></script>
<%-- 		<script src="assets/js/ace-extra.min.js"></script> --%>
	   	<script src="assets/js/chosen.jquery.min.js"></script>
	   	<script src="assets/js/fuelux/fuelux.spinner.min.js"></script>

		<script src="assets/js/ace-elements.min.js"></script>
		<script src="assets/js/ace.min.js"></script>
<%-- 	   	<script src="assets/js/bootstrap.min.js"></script> --%>
<%-- 		<script src="assets/js/typeahead-bs2.min.js"></script> --%>

	   	<script src="assets/js/jquery.validate.min.js"></script>
	</head>
	<body> 
	<s:form action="addbasket" method="post" name="beanForm" id="bean-form" cssClass="form-horizontal">
		<s:if test="dataList!=null && dataList.size>0">
			<div class="row">
				<div class="col-xs-12">
					<form class="form-horizontal" role="form">
						<div class="form-group">
							<div>
								<label class="col-sm-3 control-label no-padding-right" for="form-field-6">名称:</label>
 								<div class="col-sm-9">
 									<label class="control-label"><s:property value="#request.equip.name"/> </label>
 								</div>
 							</div>
						</div>
						<div class="form-group">
							<div>
								<label class="col-sm-3 control-label no-padding-right" for="form-field-6">编号:</label>

								<div class="col-xs-6">
									<select class="width-80 chosen-select" name="equipId" id="form-field-select-3" data-placeholder="Choose a Country...">
										<s:iterator value="dataList" var="e" >
											<option value="<s:property value='id'/>">
												<s:property value="name"/>
											</option>
										</s:iterator>
									</select>
								</div>
							</div>
						</div>
					</form>
				</div>
			</div>
		</s:if>
		<s:else>
			<s:hidden id="id" name="equipId" />
			<div class="row">
				<div class="col-xs-12">
					<form class="form-horizontal" role="form">
						<div class="form-group">
							<div>
								<label class="col-sm-3 control-label no-padding-right" for="form-field-6">名称:</label>
	 							<div class="col-sm-9">
	 								<label class="control-label"><s:property value="#request.equip.name"/> </label>
	 							</div>
	 						</div>
						</div>
 						<div class="form-group">
							<div>
								<label class="col-sm-3 control-label no-padding-right" for="form-field-6">数量:</label>
	 							<div class="col-sm-6">
	 								<input type="text" class="input-mini" id="spinner3" name="equipTotal"/>
	 							</div>
	 						</div>
						</div>
					</form>
				</div>
			</div>
		</s:else>
	</s:form>
	<script type="text/javascript">
// 		jQuery(function($) {
		$(function($) {
			var maxtotal = "";
			var equipId = $("input[name='equipId']").val();
// 			if(equipId!=null){
// 				maxtotal = $("tr[id='" +equipId +"']").find("font[name='surplus']").text();
// 			}
			$('#spinner3').ace_spinner({
				value:1,
				min:1,
// 				max:100,
				step:1, 
				on_sides: true, 
				icon_up:'icon-plus smaller-75', 
				icon_down:'icon-minus smaller-75', 
				btn_up_class:'btn-success' , 
				btn_down_class:'btn-danger'
			});
			$("#form-field-select-3").chosen(); 
			$('#bean-form').validate({
					onkeyup:false,
					focusCleanup:false,
					errorElement: 'div',
					errorClass: 'validate-block',
					focusInvalid: true,
					rules: {
						equipId: {
							required: true,
						},
						equipTotal:{
							required: true,
// 							max:maxtotal,
							remote:{
								url:"queryEquipSurplus",
								type:"post",
								async:false,
// 								dataType:"json",
								data:{
									"equipId":function(){
										return equipId;
									},
									"selectTotal":function(){
										return $("input[name='equipTotal']").val();
									}
								},
								dataFilter:function(data, type){
									var data = eval('(' +data +')');
									return data.success;
								},
							}
						}
					},
					messages: {
						equipId: {
							required: "请选择编号",
						},
						equipTotal:{
							required: "请选择数量",
							remote:"剩余量不足",
						}
					},
					highlight: function (e) {
						$(e).closest('.form-group').removeClass('has-info').addClass('has-error red');
					},
					success: function (e) {
						$(e).closest('.form-group').removeClass('has-error');
						$(e).remove();
					},
					errorPlacement: function (error, element) {
						if($(element).attr("name")=="equipTotal"){
							error.insertAfter(element.parent().parent().parent());
						}else{
							error.insertAfter(element.parent());
						}
					}
				});
		})
	</script>
	</body>
</html>
