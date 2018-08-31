<%@page pageEncoding="UTF-8" import="com.cosim.platform.model.system.SysUser"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
<title>选择用户 </title>
	<%@include file="/commons/include/form.jsp" %>
	<link rel="stylesheet" href="${ctx}/js/tree/v35/zTreeStyle.css" type="text/css" />
	<script type="text/javascript" 	src="${ctx}/js/tree/v35/jquery.ztree.core-3.5.min.js"></script>
	<script type="text/javascript">
		var isSingle=${isSingle};
		var rol_Tree=null; 
		var org_Tree=null; 
		var pos_Tree=null; 
		var onl_Tree=null; 
		var accordion = null;
		//树展开层数
		var expandDepth = 1; 
		$(function(){
			//布局
			$("#defLayout").ligerLayout({
				 leftWidth: 200,
				 rightWidth: 140,
				 bottomHeight :40,
				 height: '100%',
				 allowBottomResize:false,
				 allowLeftCollapse:false,
				 allowRightCollapse:false,
				 onHeightChanged: heightChanged,
				 minLeftWidth:200,
				 allowLeftResize:false
			});
			
			var height = $(".l-layout-center").height();
			$("#leftMemu").ligerAccordion({ height: height-28, speed: null });
		    accordion = $("#leftMemu").ligerGetAccordionManager();
		    
			//load_Rol_Tree();
		    load_Org_Tree();
		    //load_Pos_Tree();
		    //load_Onl_Tree();
		    
		    heightChanged();
		    
		    handleSelects();
		});
		function heightChanged(options){
			if(options){   
			    if (accordion && options.middleHeight - 28 > 0){
			    	$("#SEARCH_BY_ROL").height(options.middleHeight - 183);
				    $("#SEARCH_BY_ORG").height(options.middleHeight - 163);
				    $("#SEARCH_BY_POS").height(options.middleHeight - 140);
				    $("#SEARCH_BY_ONL").height(options.middleHeight -163);
			        accordion.setHeight(options.middleHeight - 28);
			    }
			}else{
			    var height = $(".l-layout-center").height();
				$("#SEARCH_BY_ROL").height(height - 183);
			    $("#SEARCH_BY_ORG").height(height - 163);
			    $("#SEARCH_BY_POS").height(height - 140);
			    $("#SEARCH_BY_ONL").height(height - 163);
		    }
		}
		
		function setCenterTitle(title){
			
			$("#centerTitle").empty();
			$("#centerTitle").append(title);
			
		};
		
		/**
		function load_Pos_Tree(){
			var setting = {
					data: {
						key : {
							
							name: "posName",
							title: "posName"
						},
					
						simpleData: {
							enable: true,
							idKey: "posId",
							pIdKey: "parentId",
							rootPId: -1
						}
					},
					async: {
						enable: true,
						url:"${ctx}/platform/system/position/getChildTreeData.ht",
						autoParam:["posId","parentId"]
					},
					callback:{
						onClick: function(event, treeId, treeNode){
									var url="${ctx}/cloud/config/enterprise/user/selector.ht";
									var p="?isSingle=${isSingle}&searchBy=<%=SysUser.SEARCH_BY_POS%>&nodePath="+treeNode.nodePath;
									$("#userListFrame").attr("src",url+p);
									setCenterTitle("按岗位查找:"+treeNode.posName);
								},
						onAsyncSuccess: zTreeOnAsyncSuccess
					}
			};
			pos_Tree = $.fn.zTree.init($("#SEARCH_BY_POS"), setting);
		};
		**/
		
		//判断是否为子结点,以改变图标	
		function zTreeOnAsyncSuccess(event, treeId, treeNode, msg) {
			if(treeNode){
		  	 var children=treeNode.children;
			  	 if(children.length==0){
			  		treeNode.isParent=true;
			  		pos_Tree = $.fn.zTree.getZTreeObj("SEARCH_BY_POS");
			  		pos_Tree.updateNode(treeNode);
			  	 }
			}
		};
		
		function load_Org_Tree(){
			var value=$("#dem").val();
			var setting = {
					data: {
						key : {
							
							name: "orgName",
							title: "orgName"
						},
					
						simpleData: {
							enable: true,
							idKey: "orgId",
							pIdKey: "orgSupId",
							rootPId: -1
						}
					},
					async: {
						enable: true,
						url:"${ctx}/cloud/system/auth/org/getTreeDataByCompany.ht?demId="+value,
						autoParam:["orgId","orgSupId"]
					},
					callback:{
						onClick: function(event, treeId, treeNode){
							var url="${ctx}/cloud/system/auth/user/selector.ht";
							var p="?isSingle=${isSingle}&searchBy=<%=SysUser.SEARCH_BY_ORG%>&path="+treeNode.path;
							$("#userListFrame").attr("src",url+p);
							setCenterTitle("按组织查找:"+treeNode.orgName);
						},
						onAsyncSuccess: orgTreeOnAsyncSuccess
					}
					
				};
				org_Tree=$.fn.zTree.init($("#SEARCH_BY_ORG"), setting);
		};
		//判断是否为子结点,以改变图标	
		function orgTreeOnAsyncSuccess(event, treeId, treeNode, msg) {
			if(treeNode){
		  	 	var children=treeNode.children;
			  	 if(children.length==0){
			  		treeNode.isParent=true;
			  		org_Tree = $.fn.zTree.getZTreeObj("SEARCH_BY_ORG");
			  		org_Tree.updateNode(treeNode);
			  	 }
			}
		};
		function load_Rol_Tree(){
			var systemId=$("#systemId").val();
			var roleName=$("#Q_roleName_SL").val();
			var setting = {
		    		data: {
						key : {
							name: "roleName",
							title: "roleName"
						},
						simpleData: {
							enable: true,
							idKey: "roleId",
							rootPId: -1
						}
					},
		    		callback: {
						onClick: function(event, treeId, treeNode){
						var url="${ctx}/cloud/system/auth/user/selector.ht";
						var p="?isSingle=${isSingle}&searchBy=<%=SysUser.SEARCH_BY_ROL%>&roleId=" + treeNode.roleId;
							$("#userListFrame").attr("src", url + p);
							setCenterTitle("按角色查找:" + treeNode.roleName);
						}
					}
				};
				var url="${ctx}/platform/system/sysRole/getAll.ht";
				var para= {systemId : systemId,Q_roleName_SL : roleName};
				$.post(url,para,function(result){
					rol_Tree = $.fn.zTree.init($("#SEARCH_BY_ROL"), setting,result);
					if(expandDepth!=0)
					{
						rol_Tree.expandAll(false);
						var nodes = rol_Tree.getNodesByFilter(function(node){
							return (node.level < expandDepth);
						});
						if(nodes.length>0){
							for(var i=0;i<nodes.length;i++){
								rol_Tree.expandNode(nodes[i],true,false);
							}
						}
					}else rol_Tree.expandAll(true);
				});
			};

			
			function load_Onl_Tree(){
				var value=$("#onl").val();
				var setting = {
			    		data: {
							key : {
								name: "orgName",
								title: "orgName"
							},
							simpleData: {
								enable: true,
								idKey: "orgId",
								pIdKey : "orgSupId",
								rootPId: -1
							}
						},
			    		callback: {
							onClick: function(event, treeId, treeNode){
								var url="${ctx}/platform/system/sysUser/selector.ht";
								var p="?isSingle=${isSingle}&searchBy=<%=SysUser.SEARCH_BY_ONL%>&path="+treeNode.path;
								$("#userListFrame").attr("src",url+p);
								setCenterTitle("按组织查找:"+treeNode.orgName);
							}
						}
			    };
				
				var url= "${ctx}/cloud/system/auth/org/getTreeOnlineData.ht";
				var para="demId=" + value;
				$.post(url,para,function(result){
					org_Tree = $.fn.zTree.init($("#SEARCH_BY_ONL"), setting,result);
					if(expandDepth!=0)
					{
						org_Tree.expandAll(false);
						var nodes = org_Tree.getNodesByFilter(function(node){
							return (node.level < expandDepth);
						});
						if(nodes.length>0){
							for(var i=0;i<nodes.length;i++){
								org_Tree.expandNode(nodes[i],true,false);
							}
						}
					}else org_Tree.expandAll(true);
				});
				
			};
				
				
			function dellAll() {
				$("#sysUserList").empty();
			};
			function del(obj) {
				var tr = $(obj).parents("tr");
				$(tr).remove();
			};
			
			function add(data) {
				
				var aryTmp=data.split("#");
				var userId=aryTmp[0];
				var len= $("#user_" + userId).length;
				if(len>0) return;
				var aryData=['<tr id="user_'+userId+'">',
					'<td>',
					'<input type="hidden" class="pk" name="userData" value="'+data +'"> ',
					aryTmp[1],
					'</td>',
					'<td><a onclick="javascript:del(this);" class="link del" >删除</a> </td>',
					'</tr>'];
				$("#sysUserList").append(aryData.join(""));
			};
		
			function selectMulti(obj) {
				if ($(obj).attr("checked") == "checked"){
					var data = $(obj).val();
					add(data);
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
						var data = $(this).val();
						add(data);
					}
				});
			};
			
			function selectUser(){
				var chIds;
				if(isSingle==true){
					chIds = $('#userListFrame').contents().find(":input[name='userData'][checked]");
				}else{
					chIds = $("#sysUserList").find(":input[name='userData']");
				}
				var aryuserIds=new Array();
				var aryfullnames=new Array();
				var aryemails=new Array();
				var arymobiles=new Array();
				
				$.each(chIds,function(i,ch){
					var aryTmp=$(ch).val().split("#");
					aryuserIds.push(aryTmp[0]);
					aryfullnames.push(aryTmp[1]);
					aryemails.push(aryTmp[2]);
					arymobiles.push(aryTmp[3]);
					
				});
				if(aryuserIds == ''){
					alert('请选择!');
					return;
				}
				
				var obj={userIds:aryuserIds.join(","),fullnames:aryfullnames.join(","),
						emails:aryemails.join(","),mobiles:arymobiles.join(",")};
				window.returnValue=obj;
				//window.parent.addUser(obj);
				window.close();
			}
			
			var handleSelects=function(){
				var selectUsers = window.dialogArguments ;
				if(selectUsers.selectUserIds && selectUsers.selectUserNames){
					var ids=selectUsers.selectUserIds.split(","); 
					var names=selectUsers.selectUserNames.split(","); 
					for(var i=0;i<ids.length;i++){
						add(ids[i]+"#"+names[i]+"##");
					}
				}
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
		<div id="leftMemu" position="left" title="查询条件" style="overflow: auto; float: left;width: 100%;">
			<div title="按组织查找" style="overflow: hidden;">
				<input type="hidden" id="dem" name="dem" value="1">
				<!-- 
				<table border="0" width="100%" class="table-detail">
					<tr >
						<td width="30%" nowrap="nowrap"><span class="label">维度:</span>
						</td>
						<td style="width:70%;">
							<select id="dem" name="dem" onchange="load_Org_Tree()">
								<c:forEach var="demen" items="${demensionList}">
									<option  value="${demen.demId}" <c:if test="${demen.demId==1}">selected</c:if>>${ demen.demName}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
				</table>
				 -->
				<div id="SEARCH_BY_ORG" class='ztree'></div>
			</div>
		 	
			<!-- 
			<div title="按岗位查找" style="overflow: hidden;">
				<div id="SEARCH_BY_POS" class='ztree'></div>
			</div>

			<div title="按角色查找" style="overflow: hidden;">
				<div class="tree-title" style="width: 100%;">
					<div class="panel-detail">
						<table border="0" width="100%" class="table-detail">
							<tr>
								<td width="30%" nowrap="nowrap">
									<span class="label">系统:</span>
								</td>
								<td colspan="2">
									<select id="systemId" name="systemId" onchange="load_Rol_Tree()">
										<c:forEach var="sys" items="${subSystemList}">
											<option value="${sys.systemId}">${ sys.sysName}</option>
										</c:forEach>
									</select>
								</td>
							</tr>
							<tr>
								<td>
									<span class="label">角色:</span>
								</td>
								<td>
									<input id="Q_roleName_SL" name="Q_roleName_SL" type="text" size="10">
								</td>
								<td>
									<a class="link detail" href="javascript:load_Rol_Tree();">&ensp;</a>
								</td>
							</tr>
						</table>
					</div>
				</div>
				<div id="SEARCH_BY_ROL" class='ztree'></div>
			</div>

			<div title="在线用户" style="overflow: hidden;">
				
				<table border="0" width="100%" class="table-detail">
					<tr >
						<td width="30%" nowrap="nowrap"><span class="label">维度:</span>
						</td>
						<td style="width:70%;">
							<select id="onl" name="onl" onchange="load_Onl_Tree()">
								<c:forEach var="demen" items="${demensionList}">
									<option  value="${demen.demId}" <c:if test="${demen.demId==1}">selected</c:if>>${ demen.demName}</option>
								</c:forEach>
							</select>								
						</td>							
					</tr>
				</table>
				
				<div id="SEARCH_BY_ONL" class='ztree'></div>
			</div>
 			-->
		</div>
		<div position="center">
			<div id="centerTitle" class="l-layout-header">全部用户</div>
			<iframe id="userListFrame" name="userListFrame" height="90%" width="100%" frameborder="0" src="${ctx}/cloud/system/auth/user/selector.ht?isSingle=${isSingle}"></iframe>
		</div>
		<c:if test="${isSingle==false}">
			<div position="right" title="<a onclick='javascript:dellAll();' class='link del'>清空 </a>"
				style="overflow-y: auto;">
				<table width="145" id="sysUserList" class="table-grid table-list" 	id="0" cellpadding="1" cellspacing="1">
				</table>
			</div>
		</c:if>
		<div position="bottom"  class="bottom" >
			<a href="#" class="button"  onclick="selectUser()" ><span class="icon ok"></span><span >选择</span></a>
			<a href="#" class="button" style="margin-left:10px;"  onclick="window.close()"><span class="icon cancel"></span><span >取消</span></a>
		</div>
	</div>
</body>
</html>