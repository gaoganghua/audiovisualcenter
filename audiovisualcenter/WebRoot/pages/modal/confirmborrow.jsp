<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
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
	<script src="assets/js/chosen.jquery.min.js"></script>
	<script src="assets/js/ace-elements.min.js"></script>
	<script src="assets/js/ace.min.js"></script>
<%-- 	   	<script src="assets/js/bootstrap.min.js"></script> --%>
<%-- 		<script src="assets/js/typeahead-bs2.min.js"></script> --%>

   	<script src="assets/js/jquery.validate.min.js"></script>
<%--    	<script src="js/mytable.js"></script> --%>
  </head>
  
  <body>
   <s:form action="basketUpdate!updateBasketEquip" method="post" name="beanForm" id="bean-form" cssClass="form-horizontal">
   	<div class="row">
		<div class="col-xs-12">
			<form class="form-horizontal" role="form">
				<div class="form-group">
					<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 学号/教师编号</label>

					<div class="col-sm-6">
						<input type="text" name="no" id="form-field-1" placeholder="学号" class="col-xs-12 col-sm-12">
					</div>
				</div>	
 				<div class="form-group">
					<label class="col-sm-3 control-label no-padding-right" for="form-field-2"> 姓名</label>

					<div class="col-sm-6">
						<input type="text" name="name" id="form-field-2" placeholder="姓名" class="col-xs-12 col-sm-12">
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-3 control-label no-padding-right" for="form-field-3"> 手机号</label>

					<div class="col-sm-6">
						<input type="text" name="phone" id="form-field-3" placeholder="手机号" class="col-xs-12 col-sm-12">
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-3 control-label no-padding-right" for="form-field-5">班级</label>

					<div class="col-sm-6">
						<input type="text" name="clsNo" id="form-field-5" placeholder="班级" class="col-xs-12 col-sm-12">
					</div>
				</div>
				<div class="form-group">
					<div>
						<label class="col-sm-3 control-label no-padding-right" for="form-field-6">学院</label>

						<div class="col-xs-6">
							<select class="chosen-select" id="form-field-select-3" data-placeholder="学院">
								<s:iterator value="dataList">
									<option value='<s:property value="id"/>'><s:property value="college"/> </option>
								</s:iterator>
							</select>
						</div>
					</div>
				</div>
				<div class="form-group">
					<div>
						<label class="col-sm-3 control-label no-padding-right" for="form-field-7">专业</label>

						<div class="col-xs-6">
							<select class="chosen-select" id="form-field-select-4" data-placeholder="专业" name="cls">
								<s:iterator value="#request.clsLists">
									<option value='<s:property value="id"/>'><s:property value="college"/> </option>
								</s:iterator>
							</select>
						</div>
					</div>
				</div>
				<div class="form-group">
					<div>
						<label class="col-sm-3 control-label no-padding-right" for="form-field-8">借出用途</label>

						<div class="col-sm-6">
							<textarea class="col-xs-12 col-sm-12" name="purpose" id="form-field-8" placeholder="用途" style="resize:none; padding-left: 3px;"></textarea>
						</div>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-3 control-label no-padding-right" for="form-field-9">经手人</label>
	
					<div class="col-sm-6" id="form-field-9">
						<input type="text" name="managersName" placeholder="经手人1" class="col-xs-12 col-sm-4">
						&nbsp&nbsp
						<input type="text" name="managersName"  placeholder="经手人2" class="col-xs-12 col-sm-4">
					</div>
				</div>
				<div class="form-group">
					<div>
						<label class="col-sm-3 control-label no-padding-right" for="form-field-10">身份</label>
					 	<div class="col-xs-9">
					 		<div class="control-group" id="form-field-10">
								<div class="radio" >
									<label>
										<input name="identity" type="radio" class="ace" value="1" checked="checked"/>
										<span class="lbl">学生</span>
									</label>
									&nbsp;&nbsp;&nbsp;
									<label>
										<input name="identity" type="radio" class="ace" value="0"/>
										<span class="lbl">老师</span>
									</label>
								</div>
							 </div>
					 	</div>
					 </div>
				</div>
				<div class="form-group">
					<div>
						<label class="col-sm-3 control-label no-padding-right" for="form-field-11">借出状况</label>
					 	<div class="col-xs-9">
					 		<div class="control-group">
								<div class="radio col-xs-12" id="form-field-11">
									<label>
										<input type="radio" class="ace"  checked="checked" name="condition"/>
										<span class="lbl">良好</span>
									</label>
									&nbsp;&nbsp;&nbsp;
									<label>
										<input  type="radio" class="ace" name="condition"/>
										<span class="lbl">部分损坏</span>
									</label>
							 </div>
					 		</div>
					 	</div>
					</div>
				</div>
				<div class="form-group">
					<div>
						<label class="col-sm-3 control-label no-padding-right" for="form-field-12">管理员同意</label>
					 	<div class="col-xs-6" style="margin-top: 6px;">
					 		<label>
								<input name="manageragree" class="ace ace-switch ace-switch-6" type="checkbox" id="manageragree" value="off">
								<span class="lbl"></span>
							</label>
					 	</div>
					 </div>
				</div>
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
			//二级联动
			$("select#form-field-select-3").change(function(){
				var collegeId = $(this).val();
				var selectcls = $("select[name='cls']");
				$.post("collegeInfo",{"collegeId":collegeId}, function(data){
					var data = eval('(' + data+ ')');
					changeSelect(selectcls,data.data)
				})
			})
			//填充客户信息
			var fillClientInfo = function(obj){
				for(var property in obj){
					var node = $("input[name='" +  property+"']");
					if(node.length>0){
						$(node).val(obj[property]);
					}
				}
				var selectnode = $("#form-field-select-3");
				reselectSelect(selectnode, obj.collegeParentId);
				
				//更正身份
				if(obj.flag == true){
					$("input[name='identity'][value='1']")[0].checked = true;
				}else if(obj.flag == false){
					$("input[name='identity'][value='0']")[0].checked = true;
				}
				
				var selectcls = $("select[name='cls']");
				$.post("collegeInfo",{"collegeId":obj.collegeParentId}, function(data){
					var data = eval('(' + data+ ')');
					changeSelect(selectcls,data.data, obj.collegeId)
				})
			};
			//初始化信息框
			var clearClientInfo = function(){
				for(var i=2;i<=5;i++){
					var node = $("#form-field-" +i + "");
					if(node.length>0){
						$(node).val("");
					}
				}
				$("input[name='identity'][value='1']")[0].checked = true;
			}
			//根据学号或者教师编号生成信息
			$("#form-field-1").blur(function(){
				var currentNode = $(this);
				if($.trim($(currentNode).val())!=""){
					var reg=/^\d+$/g;
					if (reg.test($(currentNode).val())) {
						$.post("clientInfo", {"clientStuId":$(currentNode).val()}, function(data){
							var data = eval('(' + data+ ')');
// 							alert(data);
							if(data.success){
								fillClientInfo(data.data)
							}else{
								clearClientInfo();
							}
						})
					}
				}
			})
			//管理元同意
			$("#manageragree").click(function(){
				var currentNode = this;
				if(currentNode.checked){
					mainbootboxprompt("请填写管理员密码", function(result){
						if(result!=null){
							$.post("loadpassword", {"password":result}, function(data){
								var data = eval('(' + data+ ')');
								if(data.success){
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
				}
			})
			$('#bean-form').validate({
				onkeyup:false,
				focusCleanup:false,
				errorElement: 'div',
				errorClass: 'validate-block',
				focusInvalid: true,
				rules: {
					no: {
						required: true,
						number:true,
					},
					name: {
						required: true,
					},
					phone: {
						required: true,
						number:true,
						rangelength:[11,11],
					},
					clsNo: {
						required: true,
						number:true,
					},
					managersName: {
						required: true,
					},
					purpose:{
						required: true,
					},
					manageragree:{
						required:true,
					},
				},
				messages: {
					no: {
						required: "请填写学号或教师编号",
						number:"请填写正确的格式",
					},
					name: {
						required: "请填写姓名",
					},
					phone: {
						required: "请填写手机号",
						number:"请填写正确的格式",
						rangelength:"请填写11位的手机号码",
					},
					clsNo: {
						required: "请填写班号",
						number:"请填写正确的班号",
					},
					managersName: {
						required: "至少填写一个经手人",
					},
					purpose:{
						required: "请填写借出用途",
					},
					manageragree:{
						required:"管理员必须同意",
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
					if(element.attr("name")=="manageragree"){
						error.insertAfter(element.parent().parent())
					}else
						error.insertAfter(element.parent());
				}
			});
		});
	</script>
  </body>
</html>
