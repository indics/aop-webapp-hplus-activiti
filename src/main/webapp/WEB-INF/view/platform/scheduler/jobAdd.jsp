<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
	<head>
		<title>添加任务</title>
<script type="text/javascript" src="${ctx}/js/cosim/platform/bpm/showModalDialog.js"  charset="UTF-8"></script>
		<%@include file="/commons/include/form.jsp" %>
		<script type="text/javascript" src="${ctx}/js/lg/plugins/ligerDialog.js"  ></script>
		<script type="text/javascript" src="${ctx }/js/lg/plugins/ligerWindow.js" ></script>
		<script type="text/javascript" src="${ctx }/js/cosim/platform/scheduler/JobDialog.js"></script>
		
		<script type="text/javascript">
		function addjob(){
			addRow();
		}
		$(function() {
			function showRequest(formData, jqForm, options) { 
				return true;
			} 
			valid(showRequest,showResponse,1);
			$("a.save").click(function() {
				var str=setParameterXml();
				$("#parameterJson").val(str);
				$('#jobForm').submit(); 
			});
		});
		function showResponse(responseText, statusText)  { 
			var obj=new com.cosim.form.ResultMessage(responseText);
			if(obj.isSuccess()){//成功
				$.ligerMessageBox.confirm('提示信息',obj.getMessage()+',是否继续操作?',function(rtn){
					if(!rtn){
						var returnUrl=$("a.back").attr("href");
						location.href=returnUrl;
					}
					else{
						valid.resetForm();
					}
				});
				
		    }else{//失败
		    	$.ligerDialog.err('出错信息',"添加任务失败",obj.getMessage());
		    }
		} 
		var valid;
		function valid(showRequest,showResponse){

		var options={};

		if(showRequest )
			options.beforeSubmit=showRequest;

		if(showResponse )
		   options.success=showResponse;
		valid=$("#jobForm").validate({
			rules: {
				name:{required:true,maxlength:100},
				className:{required:true,maxlength:100}
			},
			messages: {
				name:{required:"任务名称必填.",maxlength:"任务名称 最多 100个字符."},
				className:{required:"任务类必填.",maxlength:"任务类 最多 100个字符."
				}
			},
			submitHandler:function(form){
				$(form).ajaxSubmit(options);
		    },
		    success: function(label) {
				label.html("&nbsp;").addClass("checked");
			}
			
			});
		}
		</script>
</head>
<body>
		<div class="panel">
			<div class="panel-top">
				<div class="tbar-title">
					<span class="tbar-label">添加定时任务</span>
				</div>
				<div class="panel-toolbar">
					<div class="toolBar">
						<div class="group"><a class="link save" id="dataFormSave" href="#">保存</a></div>
						<div class="l-bar-separator"></div>
						<div class="group"><a class="link back" href="getJobList.ht">返回</a></div>
					</div>
				</div>
			</div>
			<form id="jobForm" method="post" action="addJob2.ht">
				<div class="panel-detail">
					<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
						<tr>
							<th width="20%">任务名: </th>
							<td><input type="text" id="name" name="name" value=""  class="inputText"/></td>
						</tr>
						<tr>
							<th width="20%">任务类: </th>
							<td>
							<input type="text" id="className" name="className" value=""  size="60" class="inputText"/>
							<input type="button" value="验证"  id="btnCheckClass" onclick="validClass()" title="验证任务类名是否正确" />
						    <input id="parameterJson" name="parameterJson" type="hidden" />
							</td>
						</tr>
						<tr>
							<th width="20%">任务描述：</th>
							<td>
							<textarea id="description" name="description" class="inputText" rows="5" cols="50"></textarea>
							</td>
						</tr>
					</table>
				</div>
				
			</form>
			<div class="panel-detail">
				<div class="tbar-title">
					<span class="tbar-label">任务参数</span>
				</div>
				<div class="panel-toolbar">
					<div class="toolBar">
						<div class="group"><a id="btnAddParameter" onclick="addRow()" class="link add">添加</a></div>
					</div>	
				</div>
			</div>
			<div class="panel-body">
				
					<table cellpadding="1" cellspacing="1"  class="table-grid">
						<tr>
						  <th align="center">参数名</th>
						  <th align="center">参数类型</th>
						  <th align="center">参数值</th>
						  <th align="center">删除</th>
						</tr>
						<tbody id="trContainer">
					    </tbody>
					</table>
				
			</div>
		</div>	
     </body>
</html>
