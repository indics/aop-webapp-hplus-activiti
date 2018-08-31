<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
<title>流程催办</title>
<script type="text/javascript" src="${ctx}/js/cosim/platform/bpm/showModalDialog.js"  charset="UTF-8"></script>
<%@include file="/commons/include/get.jsp"%>
<script type="text/javascript" src="${ctx}/js/cosim/platform/bpm/showModalDialog.js"  charset="UTF-8"></script>
<script type="text/javascript" src="${ctx}/js/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="${ctx}/js/ckeditor/ckeditor_sysTemp.js"></script>
<script type="text/javascript" src="${ctx}/js/cosim/CustomValid.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery/jquery.form.js"></script>

<style type="text/css">
	label{
		cursor:pointer;
	}
</style>
<script type="text/javascript">
	$(function(){
		editor1=ckeditor('inner_msg');
		editor2=ckeditor('mail_msg');
		
		function showResponse(responseText)  { 
			var obj=new com.cosim.form.ResultMessage(responseText);
			if(obj.isSuccess()){//成功
				$.ligerMessageBox.success('提示信息',obj.getMessage(),function(){
					window.close();
				});					
		    }else{//失败
		    	$.ligerDialog.err('出错信息',"流程催办失败",obj.getMessage());
		    }
		};
		
		var options={};
		if(showResponse){
			options.success=showResponse;
		}
		var frm=$('#urgeForm').form();
		$("a.urge").click(function() {
			$(".ckeditor").each(function(){
				$(this).val(CKEDITOR.instances[$(this).attr('name')].getData());
			});
			frm.ajaxForm(options);
		
			frm.submit();
		});

		$("#userProcessSubject").click(function(){
			var val=$("#userProcessSubject").attr("checked"),
				input=$("#subject");
			if(val){
				input.attr("disabled","disabled");
				input.val("");
			}
			else{
				input.removeAttr("disabled");
			}
		});
	});
	
	function type_change(e){
		var id=$(e).attr("id"),
			val=$(e).attr("checked"),
			tr;		
		switch(id){
			case "short":
				tr=$("#short_msg").closest("tr");
				break;
			case "mail":
				tr=$("#mail_msg").closest("tr");
				break;
		}
		if(tr){
			if(val)
				tr.show();
			else
				tr.hide();
		}
	};
</script>
</head>
<body>
	<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">流程催办设置</span>
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group">
						<a class="link urge">催办</a>
					</div>
					<div class="l-bar-separator"></div>
					<div class="group">
						<a class="link del" onclick="window.close()">关闭</a>
					</div>
				</div>
			</div>			
		</div>
		<div class="panel-body">
			<form  id="urgeForm" method="post" action="urgeSubmit.ht" >
				<input type="hidden" name="actInstId" value="${actInstId}" />
				<input type="hidden" name="processSubject" value="${processSubject}">
				<table cellpadding="1" cellspacing="1" class="table-detail">
					<tr>
						<th width="120">催办方式:</th>
						<td>
							<label><input type="checkbox" disabled="disabled" checked="checked" />站内消息</label>
							<label><input type="checkbox" id="short" name="short" value="1" onclick="type_change(this)"/>手机短信</label>
							<label><input type="checkbox" id="mail" name="mail" value="2" onclick="type_change(this)"/>邮件</label>
						</td>
					</tr>
					<tr>
						<th width="120">站内消息和邮件标题:</th>
						<td>
							<label><input type="checkbox" checked="checked" id="userProcessSubject" name="userProcessSubject" value="true"/>使用流程标题</label>&nbsp;&nbsp;
							<input style="width:210px;height:21px;" type="text" id="subject" name="subject" disabled="disabled" />
						</td>
					</tr>
					<tr>
						<th width="120">站内消息内容:</th>
						<td>
							<textarea cols="50" rows="3" id="inner_msg" name="inner_msg">${inner}</textarea>
						</td>
					</tr>
					<tr style="display:none;">
						<th width="120">手机短信内容:</th>
						<td>
							<textarea cols="50" rows="3" id="short_msg" name="short_msg">${shortMsg}</textarea>
						</td>
					</tr>
					<tr style="display:none;">
						<th width="120">邮件内容:</th>
						<td>
							<textarea cols="50" rows="3" id="mail_msg" name="mail_msg">${mail}</textarea>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</body>
</html>


