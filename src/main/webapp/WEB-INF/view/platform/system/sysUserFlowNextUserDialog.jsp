<%@page pageEncoding="UTF-8" import="com.cosim.platform.model.system.SysUser"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
<title>选择用户 </title>
	<%@include file="/commons/include/form.jsp" %>
	<link rel="stylesheet" href="${ctx}/js/tree/v35/zTreeStyle.css" type="text/css" />
	<script type="text/javascript" 	src="${ctx}/js/tree/v35/jquery.ztree.core-3.5.min.js"></script>
	<script type="text/javascript">
		var isSingle='${isSingle}';
		$(function(){
			//布局
			$("#defLayout").ligerLayout({
				 leftWidth: 300,
				 rightWidth: 300,
				 bottomHeight :40,
				 height: '100%',
				 allowBottomResize:false,
				 allowLeftCollapse:false,
				 allowRightCollapse:false,
				 minLeftWidth:200,
				 allowLeftResize:false
			});
			
			/**
			var height = $(".l-layout-center").height();
			$("#leftMemu").ligerAccordion({ height: height-28, speed: null });
		    accordion = $("#leftMemu").ligerGetAccordionManager();
		    **/
		    
		    $("#sysUserItem").find("tr").bind('click', function() {
				if(isSingle=='true'){
					var rad=$(this).find('input[name=userData]:radio');
					rad.attr("checked","checked");
				}else{
					var ch=$(this).find(":checkbox[name='userData']");
					window.parent.selectMulti(ch);
				}
			});
		    
		    var args = window.dialogArguments;
		    loadCheckedUserList(args);
		});
		
		/*列表显示出上次已经选中的多选框值
		[{type:'user',id:'',name:''}]
		*/
		function loadCheckedUserList(args){
			if(args==undefined ||  args==null || args.length==0)return;
			for(var i=0;i<args.length;i++){
				var userObj=args[i];
				addSelect(userObj.type,userObj.id,userObj.name)
			}
		}
			
		function setCenterTitle(title){
			$("#centerTitle").empty();
			$("#centerTitle").append(title);
		};
		
		function dellAll() {
			$("#sysUserList").empty();
		};
		function del(obj) {
			var tr = $(obj).parents("tr");
			$(tr).remove();
		};
		
		function addSelect(type,id,name){
			var objId=type +"_" + id;
			var len= $("#" + objId).length;
			if(len>0) return;
			
			var data=type +"#" + id +"#" +name;
			var aryData=['<tr id="'+objId+'">',
							'<td>',
							'<input type="hidden" class="pk" name="userData" value="'+data +'"> ',
							name,
							'</td>',
							'<td><a onclick="javascript:del(this);" class="link del" >删除</a> </td>',
							'</tr>'];
			$("#sysUserList").append(aryData.join(""));
		};
		
		function add(ch) {
			var data = $(ch).val();
			var aryTmp=data.split("#");
			var userId=aryTmp[0];
			var userName=aryTmp[1];
			addSelect("user",userId,userName);
		};
	
		function selectMulti(obj) {
			if ($(obj).attr("checked") == "checked"){
				add(obj);
			}	
		};
	
		function selectAll(obj) {
			var state = $(obj).attr("checked");
			var rtn=state == undefined?false:true;
			checkAll(rtn);
		};
	
		function checkAll(checked) {
			$("#userListFrame").contents().find("input[type='checkbox'][class='pk']").each(function() {
				$(this).attr("checked", checked);
				if (checked) {
					add(this);
				}
			});
		};
		
		function selectUser(){
			var chIds = $("#sysUserList").find(":input[name='userData']");
			var aryType=[];
			var aryId=[];
			var aryName=[];
			
			$.each(chIds,function(i,ch){
				var aryTmp=$(ch).val().split("#");
				aryType.push(aryTmp[0]);
				aryId.push(aryTmp[1]);
				aryName.push(aryTmp[2]);
			});
			var obj={objType:aryType,objIds:aryId,objNames:aryName};
			window.returnValue=obj;
			window.close();
		}
	</script>
<style type="text/css">
.ztree {
	overflow: auto;
}

.label {
	color: #6F8DC6;
	text-align: right;
	padding-right: 6px;
	padding-left: 0px;
	font-weight: bold;
}
html { overflow-x: hidden; }
</style>
</head>
<body>
	<div id="defLayout">
		<div position="left" title="候选人">
			<display:table name="excutors" id="sysUserItem" sort="external" cellpadding="1" cellspacing="1" export="false"  class="table-grid">
				<display:column title="选择" media="html" style="width:30px;">
					<input onchange="window.parent.selectMulti(this);" type="checkbox" class="pk" name="userData" value="${sysUserItem.executeId}#${sysUserItem.executor}">
				</display:column>
				<display:column  property="executor" title="姓名"></display:column>
			</display:table>
		</div>
		
		<div position="right" title="<a onclick='javascript:dellAll();' class='link del'>清空 </a>"
			style="overflow-y: auto;">
			<table width="145" id="sysUserList" class="table-grid table-list" 	id="0" cellpadding="1" cellspacing="1">
			</table>
		</div>
	   
		<div position="bottom"  class="bottom" >
			<a href="#" class="button"  onclick="selectUser()" ><span class="icon ok"></span><span >选择</span></a>
			<a href="#" class="button" style="margin-left:10px;"  onclick="window.close()"><span class="icon cancel"></span><span >取消</span></a>
		</div>
	</div>
</body>
</html>


