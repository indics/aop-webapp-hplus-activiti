<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
<title>demo_student管理</title>
<%@include file="/commons/include/get-hplus.jsp" %>
<script type="text/javascript">
	$(function() {
		//添加		
		jQuery(".btn-add").click(function(){
			location.href= 'edit.ht';	
		});
		
		//编辑
		jQuery(".btn-edit").click(function(){
			var $ids = jQuery("#table_list_student").jqGrid('getGridParam', 'selarrrow'); 
			if ($ids.length == 0) {
				swal({
					title:"警告信息",
					type: "warning",
					text:"请选择要编辑的行"					
				});
			}else if($ids.length > 1){
				swal({
					title:"警告信息",
					type: "warning",
					text:"只能选择一条记录"					
				});
			}else{
				location.href = 'edit.ht?studentId=' + $ids;
			}
		});
		
		//删除
		jQuery(".btn-del").click(
			function() { 
				var $ids = jQuery("#table_list_student").jqGrid('getGridParam', 'selarrrow'); 
				if ($ids.length > 0) {
					var delId = "";//主键值
					var url = "del.ht?studentId=" + $ids;
					swal({
				        title: "确认删除吗？",
				        text: "删除后将无法恢复，请谨慎操作！",
				        type: "warning",
				        showCancelButton: true,
				        confirmButtonColor: "#DD6B55",
				        confirmButtonText: "删除",
				        cancelButtonText: "取消",
				        closeOnConfirm: true
				    }, function () {
				    	$.ajax({
				    		url : url,
				    		type : 'post',
				    		success : function(res){
				    			var result = eval('('+res+')');
				    			swal(result.message, "您已经永久删除了这条信息。", "success");
				    			jQuery("#table_list_student").trigger("reloadGrid");
				    		},
							error : function(res) {
								swal(result.message, "服务器或网络出现异常。", "failure");
							}
				    	})	    	       
				    });
				}else{ 
					swal({
						title:"警告信息",
						type: "warning",
						text:"请选择要删除的行"					
					});
				} 
		});
		
		//查询
		jQuery(".btn-search").click(function(){
			var postData = $('#table_list_student').jqGrid("getGridParam", "postData");
			var frm = $('#searchForm');
			var data = {};
			frm.find('input:text,input:hidden,textarea,select').each(function(){
				var value=$(this).val();
				var name=$(this).attr('name');
				if(value!=null&&value!=''){
					data[name]=value;
				}else{
					if(postData!=null)
						delete postData[name];
				}
			});
            
			$("#table_list_student").jqGrid('setGridParam',{
				postData : data
			}).trigger("reloadGrid");
			
		});
	});
</script>

</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content  animated fadeInRight">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox">
                    <div class="ibox-title">
                        <h5>demo_student管理列表</h5>
                    </div>
                    <div class="ibox-content" for="table_list_course">
                        <p>
                            <button type="button" class="btn btn-success btn-search"><i class="fa fa-search"></i>查询</button>
                            <button type="button" class="btn btn-primary btn-add"><i class="fa fa-upload"></i>添加</button>
                            <button type="button" class="btn btn-info btn-edit"><i class="fa fa-paste"></i>编辑</button>
                            <button type="button" class="btn btn-warning btn-del"><i class="fa fa-warning"></i>删除</button>
                        </p>
                        
                        <div class="ibox float-e-margins">
							<form id="searchForm" class="form-inline" method="post">
								<div class="ibox-content">
									<div class="form-group">
										<label class="control-label" for="s_name">姓名:</label><input id="s_name" type="text" name="Q_name_SL"  class="form-control" />
										<label class="control-label" for="s_sex">性别:</label><input id="s_sex" type="text" name="Q_sex_SL"  class="form-control" />
										<label class="control-label" for="s_honor">爱好:</label><input id="s_honor" type="text" name="Q_honor_SL"  class="form-control" />
										<label class="control-label">创建时间 从:</label> <input id="s_begincreateTime" name="Q_begincreateTime_DL" class="form-control layer-date" placeholder="YYYY-MM-DD"/>
										<label class="control-label">至: </label><input id="s_endcreateTime" name="Q_endcreateTime_DG" class="form-control layer-date" placeholder="YYYY-MM-DD"/>
										<label class="control-label" for="s_create_user">创建用户:</label><input id="s_create_user" type="text" name="Q_createUser_SL"  class="form-control" />
								</div>
							</form>
						</div>
						
						<div class="jqGrid_wrapper">
                            <table id="table_list_student" class="jqGrid_table_list"></table>
                            <div id="pager_list_student"></div>
                       	</div>
                	</div><!-- end of content -->
                </div><!-- end of ibox -->
            </div><!-- end of col -->
        </div><!-- end of row -->
    </div><!-- end of wrapper -->
		
	<script>
        $(document).ready(function(){
			laydate({elem:"#s_begincreateTime",event:"focus"});
			laydate({elem:"#s_endcreateTime",event:"focus"});
			
        	$.jgrid.defaults.styleUI="Bootstrap";
        	
        	$("#table_list_student").jqGrid({
     				url : 'listData.ht',
     				datatype : "json",
     				height:'100%',
     				autowidth:true,
     				shrinkToFit:true,
     				multiselect:true,
     				rownumbers:true,
     				rowNum:20,
     				rowList:[10,20,30],
     				colNames:["studentId","姓名","性别","爱好","创建时间","创建用户"],
     				colModel:[
     				          {name:"studentId",index:"studentId",key:true,hidden:true,width:0},
{name:"name",index:"name"},
							{name:"sex",index:"sex"},
							{name:"honor",index:"honor"},
							{name:"createTime",index:"createTime",
								formatter:function(value,options,row){
									return new Date(value).Format('yyyy-MM-dd');}},
							{name:"createUser",index:"createUser"}
							],
     				pager:"#pager_list_student",
     				viewrecords:true,
     				caption:"demo_student列表",
     				hidegrid:false});
        	
        	$("#table_list_student").jqGrid("navGrid","#pager_list_student",
        			{edit:false,add:false,del:false,search:false},
        			{height:200,reloadAfterSubmit:true});
        	
        	$(window).bind("resize",function(){
        			var width=$(".jqGrid_wrapper").width();
        			$("#table_list_student").setGridWidth(width);
        		})
        	});
    </script>
</body>
</html>


