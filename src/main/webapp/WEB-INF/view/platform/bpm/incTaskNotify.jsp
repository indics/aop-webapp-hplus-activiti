<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
<!--
	function saveOpinion(){
		var btn=$("#btnNotify");
		if(btn.hasClass("disabled")){
			return;
		}
		btn.addClass("disabled");
		var url=__ctx +"/platform/bpm/task/saveOpinion.ht";
		var content=$("#voteContent").val();
		var obj={taskId:"${task.id}",opinion:content};
		$.post(url,obj,function(responseText){
			var obj=new com.cosim.form.ResultMessage(responseText);
			if(obj.isSuccess()){
				$.ligerMessageBox.success("提示信息",obj.getMessage(),function(){
					if(window.opener){
						window.opener.location.reload();
						window.close();
					}
				});
				
			}
			else{
				$.ligerMessageBox.warn("提示信息",obj.getMessage());
			}
			btn.removeClass("disabled");
		});
	}
//-->
</script>
<div class="panel-top noprint">
	<div class="panel-toolbar">
		<div class="toolBar">
			<div class="group"><a id="btnNotify" class="link agree" onclick="saveOpinion()">提交意见</a></div>
			<div class="l-bar-separator"></div>
			<div class="group"><a class="link setting" onclick="showTaskUserDlg()">流程执行示意图</a></div>
			<div class="l-bar-separator"></div>
			<div class="group"><a class="link search" onclick="showTaskOpinions()">审批历史</a></div>
			<div class="l-bar-separator"></div>
		</div>	
	</div>
</div>
