<%--
	time:2016-05-20 11:59:20
	desc:edit the cloud_course
--%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title>编辑 cloud_course</title>
	<%@include file="/commons/include/form-hplus.jsp" %>
	<script type="text/javascript">
		$(function() {
			var options={};
			if(showResponse){
				options.success=showResponse;
			}
			var frm=$('#courseForm').form();
			$("button.btn-save").click(function() {
				frm.setData();
				frm.ajaxForm(options);
				if(frm.valid()){	
					swal("正在保存。。。","请稍等。。。");
					form.submit();
				}
			});
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
							window.location.href = "${ctx}/demo/course/course/list.ht";		
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
				    <c:when test="${course.id != null}">
				        <h5>编辑cloud_course</h5>
				    </c:when>
				    <c:otherwise>
				        <h5>添加cloud_course</h5>
				    </c:otherwise>			   
			    </c:choose>
             </div>
		    
		    <div class="ibox-content" for="table_list_course">
                <p>
                    <button type="button" class="btn btn-primary btn-save"><i class="fa fa-save"></i>保存</button>
                    <button type="button" class="btn btn-info btn-back" onClick="location.href='list.ht'"><i class="fa fa-back"></i>返回</button>
                </p>
                       
				<div class="ibox float-e-margins">
					<form class="form-horizontal m-t" id="courseForm" method="post" action="save.ht">
						 <table class="table-detail" cellpadding="0" cellspacing="0" border="0" type="main">
							<tr>
								<th width="20%">year: </th>
								<td><input type="text" id="year" name="year" value="${course.year}" class="form-control" validate="{required:true,number:true }"  validateName="年度"/></td>
							</tr>
							<tr>
								<th width="20%">term: </th>
								<td><input type="text" id="term" name="term" value="${course.term}" class="form-control" validate="{required:true,number:true }"  validateName="月份"/></td>
							</tr>
						 </table>
						 <table class="table-grid table-list" cellpadding="1" cellspacing="1" id="courseItem" formType="page" type="sub">
							<tr>
								<td colspan="3">
									<div class="group" align="left">
							   			<a id="btnAdd" class="link add">添加</a>
						    		</div>
						    		<div align="center">
										cloud_course_item : cloud_course_item
						    		</div>
					    		</td>
							</tr>
							<tr>
								<th>course_name</th>
								<th>course_teacher</th>
								<th>操作</th>
							</tr>
							<c:forEach items="${courseItemList}" var="courseItemItem" varStatus="status">
							    <tr type="subdata">
								    <td style="text-align: center" name="courseName">${courseItemItem.courseName}</td>
								    <td style="text-align: center" name="courseTeacher">${courseItemItem.courseTeacher}</td>
								    <td style="text-align: center">
								    	<a href="#" class="link del">删除</a>
								    </td>
									<input type="hidden" name="courseName" value="${courseItemItem.courseName}"/>
									<input type="hidden" name="courseTeacher" value="${courseItemItem.courseTeacher}"/>
							    </tr>
							</c:forEach>
							<tr type="append">
						    	<td style="text-align: center" name="courseName"><input class="form-control" type="text" name="courseName" validate="{required:true}" errormsgtips="{required:'课程名称必填'}"></td>
						    	<td style="text-align: center" name="courseTeacher"><input class="form-control" type="text" name="courseTeacher" validate="{required:true}" errormsgtips="{required:'课程老师名称必填'}"></td>
						    	<td style="text-align: center">
						    		<a href="#" class="link del">删除</a>
						    	</td>
					 		</tr>
					    </table>
						<input type="hidden" name="id" value="${course.id}" />
					</form>
				</div>
			</div><!-- end of ibox-content -->
	</div><!-- end of ibox -->
</div>
</body>
</html>
