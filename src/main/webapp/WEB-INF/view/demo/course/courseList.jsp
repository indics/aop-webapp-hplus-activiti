<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
<title>cloud_course管理</title>
<%@include file="/commons/include/get-hplus.jsp" %>

<script type="text/javascript">
	$(function() {
		//添加		
		jQuery(".btn-add").click(function(){
			location.href= 'edit.ht';	
		});
		
		//编辑
		jQuery(".btn-edit").click(function(){
			var $ids = jQuery("#table_list_course").jqGrid('getGridParam', 'selarrrow'); 
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
				var keyName = "id";//主键名称
				location.href = 'edit.ht?' + keyName + '=' + $ids;
			}
		});
		
		//删除
		jQuery(".btn-del").click(
			function() { 
				var $ids = jQuery("#table_list_course").jqGrid('getGridParam', 'selarrrow'); 
				if ($ids.length > 0) {
					var delId = "";//主键值
					var keyName = "id";//主键名称
					var url = "del.ht?" + keyName + "=" + $ids ;
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
				    			jQuery("#table_list_course").trigger("reloadGrid");
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
			var postData = $('#table_list_course').jqGrid("getGridParam", "postData");
			var frm = $('#searchForm');
			var data = {};
			frm.find('input:text,input:hidden,textarea,select').each(function(){
				var value=$(this).val();
				var name=$(this).attr('name');
				if(value!=null&&value!=''){
					data[name]=value;
				}else{
					delete postData[name];
				}
			});
            
			$("#table_list_course").jqGrid('setGridParam',{
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
                        <h5>cloud_course管理列表</h5>
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
										<label class="control-label" for="s_year">year:</label><input id="s_year" type="text" name="Q_year_SL"  class="form-control" />
										<label class="control-label">term:</label><input type="text" name="Q_term_SL"  class="form-control" />
										<label class="control-label">create_user:</label><input type="text" name="Q_createUser_SL"  class="form-control" />
										<label class="control-label">create_time 从:</label> <input id="s_begincreateTime" name="Q_begincreateTime_DL" class="form-control layer-date" placeholder="YYYY-MM-DD"/>
										<label class="control-label">至: </label><input id="s_endcreateTime" name="Q_endcreateTime_DG" class="form-control layer-date" placeholder="YYYY-MM-DD"/>
										<label class="control-label">task_id:</label><input type="text" name="Q_taskId_SL"  class="form-control" />
										<label class="control-label">run_id:</label><input type="text" name="Q_runId_SL"  class="form-control" />
										<label class="control-label">run_state:</label><input type="text" name="Q_runState_SL"  class="form-control" />
									</div>
								</div>
							</form>
						</div>
			
                        <div class="jqGrid_wrapper">
                            <table id="table_list_course" class="jqGrid_table_list"></table>
                            <div id="pager_list_course"></div>
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
        	
        	$("#table_list_course").jqGrid({
     				url : 'listData.ht',
     				datatype : "json",
     				height:'100%',
     				autowidth:true,
     				shrinkToFit:true,
     				multiselect:true,
     				rownumbers:true,
     				rowNum:20,
     				rowList:[10,20,30],
     				colNames:["ID","年份","学期","创建者","创建时间"],
     				colModel:[{name:"id",index:"id",key:true,hidden:true,width:0},
     				          {name:"year",index:"year"},
     				          {name:"term",index:"term"},
     				          {name:"createUser",index:"createUser"},
     				          {name:"createTime",index:"create_time",
     				        	  formatter:function(value,options,row){
     				        		  return new Date(value).Format('yyyy-MM-dd');}
     				          }],
     				pager:"#pager_list_course",
     				viewrecords:true,
     				caption:"课程管理列表",
     				hidegrid:false});
        	
        	$("#table_list_course").jqGrid("navGrid","#pager_list_course",
        			{edit:false,add:false,del:false,search:false},
        			{height:200,reloadAfterSubmit:true});
        	
        	$(window).bind("resize",function(){
        			var width=$(".jqGrid_wrapper").width();
        			$("#table_list_course").setGridWidth(width);
        		})
        	});
    </script>
</body>
</html>


