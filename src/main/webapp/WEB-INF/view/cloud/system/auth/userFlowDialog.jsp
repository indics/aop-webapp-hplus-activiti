<%@page pageEncoding="UTF-8" import="com.cosim.platform.model.system.SysUser"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
<title>选择用户 </title>
	<%@include file="/commons/include/form.jsp" %>
	<link rel="stylesheet" href="${ctx}/js/tree/v35/zTreeStyle.css" type="text/css" />
	<script type="text/javascript" 	src="${ctx}/js/tree/v35/jquery.ztree.core-3.5.min.js"></script>
	<script type="text/javascript">
		var rol_Tree=null; 
		var org_Tree=null; 
		var pos_Tree=null; 
		var onl_Tree=null; 
		var accordion = null;
		
		var rolExpandDeth=0;
		var orgExpandDeth=1;
		var posExpandDeth=1;
		var onlExpandDeth=1;
		
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
		    
			load_Rol_Tree();
		    load_Org_Tree();
		    load_Pos_Tree();
		    load_Onl_Tree();
		    
		    heightChanged();
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
			
		function heightChanged(options){
			if(options){   
			    if (accordion && options.middleHeight - 28 > 0){
			    	$("#SEARCH_BY_ROL").height(options.middleHeight - 183);
				    $("#SEARCH_BY_ORG").height(options.middleHeight - 163);
				    $("#SEARCH_BY_POS").height(options.middleHeight - 140);
				    $("#SEARCH_BY_ONL").height(options.middleHeight - 120);
			        accordion.setHeight(options.middleHeight - 28);
			    }
			}else{
			    var height = $(".l-layout-center").height();
				$("#SEARCH_BY_ROL").height(height - 183);
			    $("#SEARCH_BY_ORG").height(height - 163);
			    $("#SEARCH_BY_POS").height(height - 140);
			    $("#SEARCH_BY_ONL").height(height - 120);
		    }
		}
		
		function setCenterTitle(title){
			$("#centerTitle").empty();
			$("#centerTitle").append(title);
		};
		
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
						onClick: handPosClick,
						onAsyncSuccess: posTreeOnAsyncSuccess
					}
			};
			pos_Tree = $.fn.zTree.init($("#SEARCH_BY_POS"), setting);
		};
		//判断是否为子结点,以改变图标	
		function posTreeOnAsyncSuccess(event, treeId, treeNode, msg) {
			if(treeNode){
		  	 	var children=treeNode.children;
			  	 if(children.length==0){
			  		treeNode.isParent=true;
			  		org_Tree = $.fn.zTree.getZTreeObj("SEARCH_BY_ORG");
			  		org_Tree.updateNode(treeNode);
			  	 }
			}
		};	
		function handPosClick(event, treeId, treeNode){
			var rtn=$("#chkPosition").attr("checked")==undefined?false:true;
			if(rtn){
				addSelect("pos",treeNode.posId,treeNode.posName);
			}
			else{
				var url="${ctx}/cloud/config/enterprise/user/selector.ht";
				var p="?isSingle=${isSingle}&searchBy=<%=SysUser.SEARCH_BY_POS%>&nodePath="+treeNode.nodePath;
				$("#userListFrame").attr("src",url+p);
				setCenterTitle("按岗位查找:"+treeNode.posName);
			}
		}
		
		
		
		function handOrgClick(event, treeId, treeNode){
			var rtn=$("#chkOrg").attr("checked")==undefined?false:true;
			if(rtn){
				addSelect("org",treeNode.orgId,treeNode.orgName);
			}
			else{
				var url="${ctx}/cloud/config/enterprise/user/selector.ht";
				var p="?isSingle=${isSingle}&searchBy=<%=SysUser.SEARCH_BY_ORG%>&path="+treeNode.path;
				$("#userListFrame").attr("src",url+p);
				setCenterTitle("按组织查找:"+treeNode.orgName);
			}
		}
		
		function handRoleClick(event, treeId, treeNode){
			var rtn=$("#chkPosition").attr("checked")==undefined?false:true;
			if(rtn){
				addSelect("role",treeNode.roleId,treeNode.roleName);
			}
			else{
				var url="${ctx}/cloud/config/enterprise/user/selector.ht";
				var p="?isSingle=${isSingle}&searchBy=<%=SysUser.SEARCH_BY_ROL%>&roleId=" + treeNode.roleId;
				$("#userListFrame").attr("src", url + p);
				setCenterTitle("按角色查找:" + treeNode.roleName);
			}
			
		}
		
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
					url:"${ctx}/cloud/config/enterprise/org/getTreeData.ht?demId="+value,
					autoParam:["orgId","orgSupId"]
				},
				callback:{
					onClick: handOrgClick,
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
			var roleName=$("#roleName").val();
			var setting = {
		    		data: {
						key : {name: "roleName",title: "roleName"},
						simpleData: {enable: true,idKey: "roleId",rootPId: -1}
					},
		    		callback: {
						onClick: handRoleClick
					}
				};
				var url="${ctx}/platform/system/sysRole/getAll.ht";
				var para= {systemId : systemId,roleName : roleName};
				$.post(url,para,function(result){
					rol_Tree = $.fn.zTree.init($("#SEARCH_BY_ROL"), setting,result);
					
		            if(rolExpandDeth!=0)
		            {
		                var nodes = rol_Tree.getNodesByFilter(function(node){
		                    return (node.level==rolExpandDeth);
		                });
		                
		                if(nodes.length>0){
		                    for(var idx=0;idx<nodes.length;idx++){
		                    	rol_Tree.expandNode(nodes[idx],false,false);
		                    }
		                }
		            }
		            else
		            {
		            	rol_Tree.expandAll(true);
		            }
					
				});
			};

			
			function load_Onl_Tree(){
				var value=$("#onl").val();
				var setting = {
			    		data: {
							key : {name: "orgName",title: "orgName"},
							simpleData: {enable: true,idKey: "orgId",pIdKey : "orgSupId",rootPId: -1}
						},
			    		callback: {
							onClick: function(event, treeId, treeNode){
								var url="${ctx}/cloud/config/enterprise/user/selector.ht";
								var p="?isSingle=${isSingle}&searchBy=<%=SysUser.SEARCH_BY_ONL%>&path="+treeNode.path;
								$("#userListFrame").attr("src",url+p);
								setCenterTitle("按组织查找:"+treeNode.orgName);
							}
						}
			    };
				
				var url= "${ctx}/cloud/config/enterprise/org/getTreeOnlineData.ht";
				var para="demId=" + value;
				$.post(url,para,function(result){
					org_Tree = $.fn.zTree.init($("#SEARCH_BY_ONL"), setting,result);
					
		            if(onlExpandDeth!=0)
		            {
		                var nodes = org_Tree.getNodesByFilter(function(node){
		                    return (node.level==onlExpandDeth);
		                });
		                
		                if(nodes.length>0){
		                    for(var idx=0;idx<nodes.length;idx++){
		                    	org_Tree.expandNode(nodes[idx],true,false);
		                    }
		                }
		            }
		            else
		            {
						org_Tree.expandAll(true);
		            }
					
				});
				
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
								'<td><a onclick="javascript:del(this);" class="link del" ></a> </td>',
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
		<div id="leftMemu" position="left" title="查询条件" style="overflow: auto; float: left;width: 100%;">
			<div title="组织机构<input type='checkbox' id='chkOrg'><label for='chkOrg'>选择</label>" style="overflow: hidden;">
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
				<div id="SEARCH_BY_ORG" class='ztree'></div>
			</div>

			<div title="岗位<input type='checkbox' id='chkPosition'><label for='chkPosition'>选择</label>" style="overflow: hidden;">
				<div id="SEARCH_BY_POS" class='ztree'></div>
			</div>

			<div title="角色<input type='checkbox' id='chkRole'><label for='chkRole'>选择</label>" style="overflow: hidden;">
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
									<input id="roleName" name="roleName" type="text" size="10">
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

		</div>
		<div position="center">
			<div id="centerTitle" class="l-layout-header">全部用户</div>
			<iframe id="userListFrame" name="userListFrame" height="90%" width="100%" frameborder="0" src="${ctx}/cloud/config/enterprise/user/selector.ht?isSingle=${isSingle}"></iframe>
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


