<%--
	time:2011-11-28 10:17:09
	desc:edit the 用户表
--%>
<%@page language="java" pageEncoding="UTF-8" import="com.cosim.platform.model.system.SysUser"%>
<%@include file="/commons/include/html_doctype.html"%>
<%@include file="/commons/cloud/global.jsp"%>
<html>
<head>
	<title>编辑 用户表</title>
	<%@include file="/commons/include/form.jsp" %>
	<script type="text/javascript" src="${ctx}/js/cosim/CustomValid.js"></script>
	<script type="text/javascript" src="${ctx}/js/cosim/subform.js"></script>
	<script type="text/javascript" src="${ctx}/js/cosim/CustomValid.js"></script>
	<script type="text/javascript" src="${ctx}/js/cosim/formdata.js"></script>
	<script type="text/javascript" src="${ctx}/js/cosim/platform/form/CommonDialog.js"></script>
	<script type="text/javascript" src="${ctx}/js/cosim/subform.js"></script>
	<script type="text/javascript" src="${ctx}/js/cosim/platform/system/IconDialog.js"></script>
	<script type="text/javascript" src="${ctx}/js/cosim/platform/form/AttachMent.js"></script>
	
	<link rel="stylesheet" href="${ctx}/js/tree/v35/zTreeStyle.css" type="text/css" />
	<script type="text/javascript" src="${ctx}/js/tree/v35/jquery.ztree.core-3.5.min.js"></script>
	<script type="text/javascript" src="${ctx}/js/tree/v35/jquery.ztree.excheck-3.5.min.js"></script>
	<script type="text/javascript" src="${ctx}/js/tree/v35/jquery.ztree.exedit-3.5.min.js"></script> 
	<script type="text/javascript" src="${ctx}/js/lg/plugins/ligerTab.js" ></script>
	<script type="text/javascript" src="${ctx}/js/cosim/displaytag.js" ></script>
	<script type="text/javascript" src="${ctx}/js/lg/plugins/ligerWindow.js" ></script>
   <script type="text/javascript"  src="${ctx}/js/cosim/platform/system/SysDialog.js"></script>
   <script type="text/javascript" src="${ctx}/js/cosim/platform/system/FlexUploadDialog.js"></script>
   		
	<!-- 上传图片 -->
	<script type="text/javascript" src="${ctx}/pages/cloud3.0/js/cloud/ajaxfileupload.js"></script>
	<script type="text/javascript" src="${ctx}/pages/cloud3.0/js/cloud/cloudDialogUtil.js"></script>
	<script type="text/javascript" src="${ctx}/pages/cloud3.0/js/cloud/uploadPreview.js"></script>
	<script type="text/javascript" src="${ctx}/js/layer/layer.js"></script>	
	<script type="text/javascript">
	var rolTree;    //角色树
	var h;
	var expandDepth =2; 
	var waiting = null;
	var action="${action}";

    $(function () { 
    	var options={};
		if(showResponse){
			options.success = showResponse;
		}
		
    	h=$('body').height();
    	$("#tabMyInfo").ligerTab({         	
            	//height:h-80
          });
    				
    	/* if('${sysUser.userId==null}'){
			valid(showRequest,showResponse,1);
		}else{
			valid(showRequest,showResponse);
		}  */
    	
    	var frm=$('#sysUserForm').form();
		$("a.save").click(function(){
			var orgdetail = $("#orgItem tbody tr").html();
    		if(!orgdetail){
    			$.ligerMessageBox.error("提示信息","请给用户选择一个组织");
    			return;
    		}
    		var rolItem = $("#rolItem tbody tr").html();
    		if(!rolItem){
    			$.ligerMessageBox.error("提示信息","请给用户选择一个角色");
    			return;
    		}
	        try{ 
	        	if(isRequied()){
	        		if (frm.valid()) {
						waiting = $.ligerDialog.waitting('正在保存中,请稍候...');
				        frm.setData();
				        frm.ajaxForm(options);
						form.submit();
					}else{
						$.ligerMessageBox.error("提示信息","请输入正确信息");
		    			return;
					}
	        	}else{
	        		$.ligerMessageBox.error("提示信息","请将信息填充完整再提交");
	        	}
				
			}catch(e){
				$.ligerMessageBox.error("提示信息","请输入正确信息");
    			return;
			}
		});
		
		$("#rolAdd").click(function(){
			btnAddRow('rolTree');
		});
		$("#rolDel").click(function(){
			btnDelRow();
		});
		// 角色
    	loadrolTree();
    });
    
    function isRequied(){
    	var flag = true;
    	$(".required input").each(function(){
    		var textVal = $(this).val();
    		if(textVal==""||textVal=="必填"){
    			$(this).next().remove();
    			$(this).parent().append("<label class='error'>必填</label>");
    			flag = false;
    		}
    	})
    	return flag;
    }
    
    function showRequest(formData, jqForm, options){ 
		return true;
	} 		
    
	function showResponse(responseText) {
		if(waiting){
			waiting.close();
		}
		
		var obj = new com.cosim.form.ResultMessage(responseText);
		if (obj.isSuccess()) {
			$.ligerMessageBox.confirm("提示信息", obj.getMessage()+",是否继续操作", function(rtn) {
				if(rtn){
					this.close();
				}else{
					window.location.href = "${ctx}/cloud/system/auth/user/list.ht?sysOrgInfoId=${f:getCurrentTenantId()}&returnUserListUrl=${returnUserListUrl}";
				}
			});
		} else {
			$.ligerMessageBox.error("提示信息",obj.getMessage());
		}
	}
    
	
	//生成角色树      		
	function loadrolTree() {
		var setting = {       				    					
			data: {
				key : {
					
					name: "roleName",
					title: "roleName"
				},
			
				simpleData: {
					enable: true,
					idKey: "roleId",
					pIdKey: "systemId",
					rootPId: null
				}
			},
			view: {
				selectedMulti: true
			},
			onRightClick: false,
			onClick:false,
			check: {
				enable: true,
				chkboxType: { "Y": "", "N": "" }
			},
			callback:{onDblClick: rolTreeOnDblClick}
		};
		
		var url="${ctx}/platform/system/sysRole/getTreeByTenant.ht?tenantId=${f:getCurrentTenantId()}&systemId=${f:getCurrentSystemId()}";
		$.post(url,function(result){
			posTree=$.fn.zTree.init($("#rolTree"), setting,result);
			if(expandDepth!=0)
			{
				posTree.expandAll(false);
				var nodes = posTree.getNodesByFilter(function(node){
					return (node.level < expandDepth);
				});
				if(nodes.length>0){
					for(var i=0;i<nodes.length;i++){
						posTree.expandNode(nodes[i],true,false);
					}
				}
			}else posTree.expandAll(true);
		});
	}; 
	
	
	//树按添加按钮
	function btnAddRow(treeName) {
		var treeObj = $.fn.zTree.getZTreeObj(treeName);
        var nodes = treeObj.getCheckedNodes(true);
        if(nodes==null||nodes=="")
        {
        	 $.ligerMessageBox.warn("你还没选择任何节点!");
			 return;
        }
		if(treeName.indexOf("org")!=-1) {
			var orgId="";
			var orgSupId="";
			var orgName="";	
			var userName="";
	        $.each(nodes,function(i,n){	
	        	orgId=n.orgId;
	        	orgSupId=n.orgSupId;
	        	orgName=n.orgName;
	        	if(n.isRoot==0){
	        		orgAddHtml(orgId,orgSupId,orgName);
	        	}
	        	
			});
	    }
	    else if(treeName.indexOf("pos")!=-1){
	    	 var posId="";
			 var posName="";
			 var posDesc="";
			 var parentId="";
		     $.each(nodes,function(i,n){
		    	  posId=n.posId;
				  posName=n.posName;
				  parentId=n.parentId;
			 	  posAddHtml(posId,posName,parentId);
		     });
	    }
	    else if(treeName.indexOf("rol")!=-1){
	    	 $.each(nodes,function(i,n){
				  var roleId=n.roleId;
				  if(roleId>0){
					  roleId=n.roleId;
					  roleName=n.roleName;
					  if (n.subSystem==null ||n.subSysten=="")
					  {
	    		       sysName=" ";
	    		       }
					  else{
					  sysName=n.subSystem.sysName;
					  }
					  systemId=n.systemId;
					  rolAddHtml(roleId,roleName,systemId,sysName);
				  }
	    	 });
	    }
    }
	
	function btnDelRow() {
		var $aryId = $("input[type='checkbox'][class='pk']:checked");
		var len=$aryId.length;
		if(len==0){
			$.ligerMessageBox.warn("你还没选择任何记录!");
		 	return;
		}
		else{			
			$aryId.each(function(i){
				var obj=$(this);
				delrow(obj.val());
			});
		}
	}
	 
	 function delrow(id){//删除行,用于删除暂时选择的行
		 $("#"+id).remove();
	 }
	
	
	//角色树左键双击
	 function rolTreeOnDblClick(event, treeId, treeNode){   
		 var roleId=treeNode.roleId;
		 var roleName=treeNode.roleName;
		 var sysName = " ";
		 if(treeNode.subSystem!=null&&treeNode.subSystem!=""){
			 sysName=treeNode.subSystem.sysName;
		 }
		 var systemId=treeNode.systemId;
		 rolAddHtml(roleId,roleName,systemId,sysName);
	 };
	 
	 function rolAddHtml(roleId,roleName,systemId,sysName){
		// if( systemId==0) return;
		 var obj=$("#" +roleId);
		 if(obj.length>0) return;
		
		 var tr="<tr id='"+roleId+"' style='cursor:pointer'>";
		 tr+="<td style='text-align: center;'>";
		 tr+=""+roleName+"<input type='hidden' name='roleId' value='"+ roleId +"'>";
		 tr+="</td>";
		 tr+="<td style='text-align: center;'>";
		 tr+=""+sysName;
		 tr+="</td>";
		 tr+="<td style='text-align: center;'>";
		 tr+="<a href='#' onclick='delrow(\""+roleId+"\")' class='link del'>移除</a>";
		 tr+="</td>";
		 tr+="</tr>";
	   
		 $("#rolItem").append(tr);
		
	 }	 
	function goBack(){		 
		var postUrl = "${returnUrl}";//提交地址  
		var postData = "${returnUserListUrl}";//第一个数据  
		
		var ExportForm = document.createElement("FORM");  
		document.body.appendChild(ExportForm);  
		ExportForm.method = "POST";  
		var newElement = document.createElement("input");  
		newElement.setAttribute("name", "returnUserListUrl");  
		newElement.setAttribute("type", "hidden");   
		ExportForm.appendChild(newElement);  
		newElement.value = postData;  
		ExportForm.action = postUrl;  
		ExportForm.submit();  		 	
	}
	
	function openImageDialog(){
		$.cloudDialog.imageDialog({contextPath:"${ctx}",isSingle:true});
	}
	
	function imageDialogCallback(data){
		if(data.length > 0){
			_callbackImageUploadSuccess(data[0].filePath);
		}
	}
	
	function _callbackImageUploadSuccess(path){
		$("#picture").val(path);
		$("#personPic").attr("src","${fileCtx}/" + path);
	};
	 
	</script>
<style type="text/css">
html {
	height: 100%
}

body {
	overflow: auto;
}
</style>
</head>

<body>
	<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label"> <c:if
						test="${sysUser.userId==null }">添加用户信息</c:if> <c:if
						test="${sysUser.userId!=null }">用户【${sysUser.fullname}】分配角色信息</c:if>
				</span>
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group">
						<a class="link save" id="dataFormSave" href="#" >保存</a>
					</div>
					<div class="l-bar-separator"></div>
					<div class="group">
						<a class="link back" onclick="goBack()">返回</a>
					</div>
				</div>
			</div>
		</div>
		<form id="sysUserForm" method="post" action="saveByRole.ht?sysOrgInfoId=${sysOrgInfoId}">
			<div id="tabMyInfo" class="panel-nav"
				style="overflow: hidden; padding-top:10px; position: relative; _position: absolute;">
				<div title="基本信息" tabid="userdetail" icon="${ctx}/styles/default/images/resicon/user.gif">
					<div class="panel-tab-div">
						<table class="table-detail" cellpadding="0" cellspacing="0"	border="0">
							<tr>
								<td rowspan="8" align="center" width="25%" style="border-right:1px solid #7babcf;">
									<div style="float:top !important; background: none; height: 24px; text-align:cetner;padding:10px 0px 10px 180px;">
										<a class="link uploadPhoto" href="#" onclick="openImageDialog();">上传照片</a>
									</div>
									<div class="person_pic_div">
										<p><img id="personPic" src="${fileCtx}/${pictureLoad}" onerror="this.src='${ctx}/commons/image/default_image_male.jpg'"  alt="个人相片" /></p>
										<input type="hidden" id="picture" name="picture" value="${sysUser.picture}" />
									</div>
								</td>
									
								<th width="18%">帐 号: <span class="required">*</span></th>
								<c:if test="${empty sysUser.userId}">
									<input type="hidden" id="account" name="account"
										value="${sysUser.shortAccount}" />
								</c:if>
								<td><c:if test="${bySelf==1}">
										<input type="hidden" name="bySelf" value="1">
									</c:if> <input type="text"
									<c:if test="${bySelf==1 or not empty sysUser.userId}">disabled="disabled"</c:if>
									id="shortAccount" name="shortAccount"
									value="${sysUser.shortAccount}"
									onblur="document.getElementById('account').value=this.value;"
									style="width: 240px !important" class="inputText" /></td>
							</tr>
	
							<tr
								style="<c:if test="${not empty sysUser.userId}">display:none</c:if>">
								<th>密 码: <span class="required">*</span></th>
								<td><input type="password" id="password" name="password"
									value="${sysUser.password}" style="width: 240px !important"
									class="inputText" /></td>
							</tr>
	
							<tr>
								<th>用户姓名:</th>
								<td><input type="text" id="fullname" name="fullname"
									value="${sysUser.fullname}" style="width: 240px !important"
									class="inputText" /></td>
							</tr>
							<tr>
								<th>用户性别:</th>
								<td><select name="sex" class="select"
									style="width: 245px !important">
										<option value="1"
											<c:if test="${sysUser.sex==1}">selected</c:if>>男</option>
										<option value="0"
											<c:if test="${sysUser.sex==0}">selected</c:if>>女</option>
								</select></td>
							</tr>
							<tr>
								<th>邮箱地址:</th>
								<td><input type="text" id="email" name="email"
									value="${sysUser.email}" style="width: 240px !important"
									class="inputText" /></td>
							</tr>
	
							<tr>
								<th>手 机:</th>
								<td><input type="text" id="mobile" name="mobile"
									value="${sysUser.mobile}" style="width: 240px !important"
									class="inputText" /></td>
							</tr>
	
							<tr>
								<th>电 话:</th>
								<td><input type="text" id="phone" name="phone"
									value="${sysUser.phone}" style="width: 240px !important"
									class="inputText" /></td>
							</tr>
							<tr>
								<th>身份证:</th>
								<td><input type="text" id="code" name="code"
									value="${sysUser.code}" style="width: 240px !important"
									class="inputText" /></td>
							</tr>
						</table>
						<input type="hidden" name="userId" value="${sysUser.userId}" />
						<input type="hidden" id="picture" name="picture" value="${sysUser.picture}" />
					</div>
				</div>
				
				<div title="所属组织" tabid="orgdetail" icon="${ctx}/styles/default/images/resicon/home.png">
					<div class="panel-tab-div">
						<table id="orgItem" class="table-grid" cellpadding="1"
							cellspacing="1">
							<thead>
								<th style="width: 25%; text-align: center !important;">组织名称</th>
								<th style="width: 25%; text-align: center !important;">是否主组织</th>
								<th style="width: 50%; text-align: center !important;">主要负责人</th>
							</thead>
							<c:forEach items="${orgList}" var="orgItem" varStatus="status">
								<tr class="${status.index%2==0?'odd':'even'}">
									<td style="text-align: center;">${orgItem.orgName}</td>
									<td style="text-align: center;"><c:choose>
											<c:when test="${orgItem.isPrimary==1}">
												是
										   	</c:when>
											<c:otherwise>
										        否   
										   	</c:otherwise>
										</c:choose></td>
									<td style="text-align: center;">${orgItem.chargeName}</td>
	
								</tr>
							</c:forEach>
						</table>
					</div>
				</div>
				
				
				<div  title="角色选择" tabid="roldetail" icon="${ctx}/styles/default/images/resicon/customer.png">
					<div class="panel-tab-div">
				        <table align="center"  cellpadding="0" cellspacing="0" class="table-grid">
						   <tr>
					       <td width="28%" valign="top" style="padding-left:2px !important;">
					        <div class="tbar-title">
								 <span class="tbar-label">所有角色</span>
							</div>	
							<div class="panel-tab-div" style="height:480px;overflow-y:auto;border:1px solid #6F8DC6;">	
					    	    <div id="rolTree" class="ztree" style="width:200px;margin:-2; padding:-2;" >         
					            </div>
					        </div>
							</td>
							
							<td width="3%" valign="middle"	style="line-height:100px; min-height:100px; padding-top:100px;">
								<input type="button" id="rolAdd" value="添加>>" />
							</td>
							
						    <td valign="top" style="padding-left:2px !important;">
						   	<div class="tbar-title">
								 <span class="tbar-label">已选角色</span>
							</div>	
							<div class="panel-tab-div" style="overflow-y: auto; border: 1px solid #6F8DC6;">
						  		<table id="rolItem" class="table-grid"  cellpadding="1" cellspacing="1">
						   		<thead>					   			
						   			<th style="text-align:center !important;">角色名称</th>
						    		<th style="text-align:center !important;">子系统名称</th>
						    		<th style="text-align:center !important;">操作</th>
						    	</thead>
						    	<c:forEach items="${roleList}" var="rolItem">
						    		<tr trName="${rolItem.roleName}" id="${rolItem.roleId}" style="cursor:pointer">
							    		<td style="text-align: center;">
						    				${rolItem.roleName}<input type="hidden" name="roleId" value="${rolItem.roleId}">
						    			</td>
						    			<td style="text-align: center;">
						    			    ${rolItem.systemName}
						    			</td>
						    			<td style="text-align: center;">
						    			 <a href="#" onclick="delrow('${rolItem.roleId}')" class="link del">移除</a>
						    			</td>
						    		</tr>
						    	</c:forEach>
						   	 	</table>
							</div>
				            </td>
				            </tr>
						 </table>
					</div>
				</div>
			</div>
		</form>
	</div>
</body>
</html>
