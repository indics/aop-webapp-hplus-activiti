<%--
	time:2016-08-25 15:01:21
	desc:edit the demo_student
--%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title>编辑 demo_student</title>
	<%@include file="/commons/include/form-hplus.jsp" %>
	<script type="text/javascript">
		$(function() {
			var options={};
			if(showResponse){
				options.success=showResponse;
			}
			var frm=$('#studentForm').form();
			$("button.btn-save").click(function() {
				frm.setData();
				frm.ajaxForm(options);
				if(frm.valid()){
					swal("正在保存。。。","请稍等。。。");
					form.submit();
				}
			});

			
			laydate({elem:"#createTime",event:"focus"});
		});
		
		function showResponse(responseText) {
			var obj = new com.cosim.form.ResultMessage(responseText);
			if (obj.isSuccess()) {
				swal({
					title:"保存成功！",
					text:"您已经成功保存了这条信息。",
					type:"success"},
					function(){
						setTimeout(function(){
							window.location.href = "${ctx}/demo/course/student/list.ht";		
						},100);
					});
			} else {
				swal("保存失败！","服务器或网络异常。","error");
			}
		}		
	</script>
</head>
<body class="gray-bg">
<div class="wrapper wrapper-content  animated fadeInRight">
	<div class="row">
		<div class="col-sm-12">
		<div class="ibox">
             <div class="ibox-title">
               	<c:choose>
				    <c:when test="student.studentId != null}">
				        <h5>编辑demo_student</h5>
				    </c:when>
				    <c:otherwise>
				        <h5>添加demo_student</h5>
				    </c:otherwise>			   
			    </c:choose>
             </div>
		    
		    <div class="ibox-content" for="table_list_course">
                <p>
                    <button type="button" class="btn btn-primary btn-save"><i class="fa fa-save"></i>保存</button>
                    <button type="button" class="btn btn-info btn-back" onClick="location.href='list.ht'"><i class="fa fa-back"></i>返回</button>
                </p>
                
                <div class="ibox float-e-margins">
					<form id="studentForm" class="form-horizontal m-t" method="post" action="save.ht">
						<table cellpadding="0" cellspacing="0" border="0" type="main">
							<tr>
								<th>姓名: </th>
								<td><input type="text" id="name" name="name" value="${student.name}"  class="form-control" validate="{required:false,maxlength:96}"  /></td>
							</tr>
							<tr>
								<th>性别: </th>
								<td><input type="text" id="sex" name="sex" value="${student.sex}"  class="form-control" validate="{required:false,number:true }"  /></td>
							</tr>
							<tr>
								<th>爱好: </th>
								<td><input type="text" id="honor" name="honor" value="${student.honor}"  class="form-control" validate="{required:false,maxlength:96}"  /></td>
							</tr>
							<tr>
								<th>创建时间: </th>
								<td><input type="text" id="createTime" name="createTime" value="<fmt:formatDate value='${student.createTime}' pattern='yyyy-MM-dd'/>" class="form-control date" validate="{date:true}" /></td>
							</tr>
							<tr>
								<th>创建用户: </th>
								<td><input type="text" id="createUser" name="createUser" value="${student.createUser}"  class="form-control" validate="{required:false,number:true }"  /></td>
							</tr>
						</table>
						<table class="table-grid table-list" cellpadding="1" cellspacing="1" id="studentItem" formType="page" type="sub">
							<tr>
								<td colspan="3">
									<div class="group" align="left">
							   			<a id="btnAdd" class="link add">添加</a>
						    		</div>
						    		<div align="center">
									demo_student_item : demo_student_item
						    		</div>
					    		</td>
							</tr>
							<tr>
								<th>课程ID</th>
								<th>说明</th>
								<th>操作</th>
							</tr>
							<c:forEach items="${studentItemList}" var="studentItemItem" varStatus="status">
							    <tr type="subdata">
								    <td style="text-align: center" name="courseId">${studentItemItem.courseId}</td>
								    <td style="text-align: center" name="remark">${studentItemItem.remark}</td>
								    <td style="text-align: center">
								    	<a href="#" class="link del">删除</a>
								    </td>
									<input type="hidden" name="courseId" value="${studentItemItem.courseId}"/>
									<input type="hidden" name="remark" value="${studentItemItem.remark}"/>
							    </tr>
							</c:forEach>
							<tr type="append">
						    	<td style="text-align: center" name="courseId"><input class="form-control" type="text" name="courseId" validate="{required:false,number:true }"></td>
						    	<td style="text-align: center" name="remark"><input class="form-control" type="text" name="remark" validate="{required:false,maxlength:96}"></td>
						    	<td style="text-align: center">
						    		<a href="#" class="link del">删除</a>
						    	</td>
					 		</tr>
					    </table>
						<input type="hidden" name="studentId" value="${student.studentId}" />
					</form>
				</div>
			</div><!-- end of ibox-content -->
	</div><!-- end of ibox -->
		
	<form id="studentItemForm" style="display:none">
		<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
			<tr>
				<th width="20%">课程ID: </th>
				<td><input type="text" name="courseId" value=""  class="inputText" validate="{required:false,number:true }"/></td>
			</tr>
			<tr>
				<th width="20%">说明: </th>
				<td><input type="text" name="remark" value=""  class="inputText" validate="{required:false,maxlength:96}"/></td>
			</tr>
		</table>
	</form>
</div>
</body>
</html>
