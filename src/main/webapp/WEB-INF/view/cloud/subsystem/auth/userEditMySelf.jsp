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
   <script type="text/javascript" src="${ctx}/js/cloud/system/CloudFlexUploadDialog.js"></script>
     		
	<!-- 上传图片 -->
	<script type="text/javascript" src="${ctx}/pages/cloud3.0/js/cloud/ajaxfileupload.js"></script>
	<script type="text/javascript" src="${ctx}/pages/cloud3.0/js/cloud/cloudDialogUtil.js"></script>
	<script type="text/javascript" src="${ctx}/pages/cloud3.0/js/cloud/uploadPreview.js"></script>
	<script type="text/javascript" src="${ctx}/js/layer/layer.js"></script>	
	<script type="text/javascript">
	var orgTree;    //组织树
	var posTree;    //岗位树
	var rolTree;    //角色树
	var h;
	var expandDepth =2; 
	
	var action="${action}";

    $(function ()
    { 
    	var options={};
		if(showResponse){
			options.success=showResponse;
		}
    	h=$('body').height();
    	$("#tabMyInfo").ligerTab({         	
            	//height:h-80
          });
    	function showRequest(formData, jqForm, options)
    	{ 
			return true;
		} 					
    	/* if(${sysUser.userId==null}){
			valid(showRequest,showResponse,1);
		}else{
			valid(showRequest,showResponse);
		} */
    	var frm=$('#sysUserForm').form();
		$("a.save").click(function(){
            firstClick(frm,options);
        });
        
		$("#orgAdd").click(function(){
			btnAddRow('orgTree');
		});
		$("#orgDel").click(function(){
			btnDelRow();
		});
		$("#posAdd").click(function(){
			btnAddRow('posTree');
		});
		$("#posDel").click(function(){
			btnDelRow();
		});
		$("#rolAdd").click(function(){
			btnAddRow('rolTree');
		});
		$("#rolDel").click(function(){
			btnDelRow();
		});
		$("#demensionId").change(function(){
			loadorgTree();
		});
		$("#treeReFresh").click(function() {
			loadorgTree();
		});

		$("#treeExpand").click(function() {
			orgTree = $.fn.zTree.getZTreeObj("orgTree");
			var treeNodes = orgTree.transformToArray(orgTree.getNodes());
			for(var i=1;i<treeNodes.length;i++){
				if(treeNodes[i].children){
					orgTree.expandNode(treeNodes[i], true, false, false);
				}
			}
		});
		$("#treeCollapse").click(function() {
			orgTree.expandAll(false);
		});
    	if("grade"==action){
    		loadorgGradeTree();
    	}else{
    		loadorgTree();
    	}
    	loadposTree();
    	loadrolTree();
    	
    	
    	function firstClick(frm,options){
	        frm.setData();
	        frm.ajaxForm(options);
	        try{ 
	        	if (frm.valid()) {
					manager = $.ligerDialog.waitting('正在保存中,请稍候...');
			        frm.setData();
			        frm.ajaxForm(options);
					form.submit();
				}else{
					$.ligerMessageBox.error("提示信息","请输入正确信息");
	    			return;
				}
			}catch(e){
				$.ligerMessageBox.error("提示信息","请输入正确信息");
    			return;
			}
		}
    });
    
    function showResponse(responseText) {
		var obj = new com.cosim.form.ResultMessage(responseText);
		manager.close();
		if (obj.isSuccess()) {
			$.ligerMessageBox.success("提示信息", "用户信息修改成功",function(){
				this.close();
				window.location.href = "${ctx}/cloud/config/enterprise/user/getMySelf.ht?canReturn=0";
			});
		} else {
			$.ligerMessageBox.error("提示信息","保存失败");
		}
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
	
	
	//生成组织树      		
	function loadorgTree(){
		var demId=$("#demensionId").val() || 0;
		var setting = {
			data: {
				key : {
					
					name: "orgName",
					title: "orgName"
				},
				simpleData: {
					enable: true,
					idKey: "orgId",
					pIdKey: "orgSupId"
// 					rootPId: -1
				}
			},
			async: {
				enable: true,
				url:__ctx+"/cloud/config/enterprise/org/getTreeData.ht?demId="+demId,
				autoParam:["orgId","orgSupId"]
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
			callback:{
				onDblClick: orgTreeOnDblClick,
				onAsyncSuccess: orgTreeOnAsyncSuccess
			}
		};
		orgTree=$.fn.zTree.init($("#orgTree"), setting);
	};
	//判断是否为子结点,以改变图标	
	function orgTreeOnAsyncSuccess(event, treeId, treeNode, msg) {
		if(treeNode){
	  	 	var children=treeNode.children;
		  	 if(children.length==0){
		  		treeNode.isParent=true;
		  		orgTree = $.fn.zTree.getZTreeObj("orgTree");
		  		orgTree.updateNode(treeNode);
		  	 }
		}
	};	
	
	function loadorgGradeTree(){
		var setting = {
				data: {
					key : {
						name: "orgName",
						title: "orgName"
					}
				},
				view : {
					selectedMulti : false
				},
				onRightClick: false,
				onClick:false,
				check: {
					enable: true,
					chkboxType: { "Y": "", "N": "" }
				},
				callback:{onDblClick: orgTreeOnDblClick}
			};
		
		   var orgUrl=__ctx + "/platform/system/grade/getOrgJsonByUserId.ht";
		   //一次性加载
		   $.post(orgUrl,function(result){
			   var zNodes=eval("(" +result +")");
			   orgTree=$.fn.zTree.init($("#orgTree"), setting,zNodes);
			   if(expandDepth!=0)
				{
					orgTree.expandAll(false);
					var nodes = orgTree.getNodesByFilter(function(node){
						return (node.level < expandDepth);
					});
					if(nodes.length>0){
						for(var i=0;i<nodes.length;i++){
							orgTree.expandNode(nodes[i],true,false);
						}
					}
				}else orgTree.expandAll(true);
		   });		
	};	
    	
	//生成岗位树      		
	  function loadposTree() {
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
						url:__ctx+"/platform/system/position/getChildTreeData.ht",
						autoParam:["posId","parentId"],
						dataFilter: filter
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
					callback:{
						onDblClick: posTreeOnDblClick,
						onAsyncSuccess: zTreeOnAsyncSuccess
					}
			};
		    posTree = $.fn.zTree.init($("#posTree"), setting);
		
	};	
	
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
	
	//过滤节点,默认为父节点,以改变图标	
	function filter(treeId, parentNode, childNodes) {
			if (!childNodes) return null;
			for (var i=0, l=childNodes.length; i<l; i++) {
				if(!childNodes[i].isParent){
					alert(childNodes[i].posName);
					childNodes[i].isParent = true;
				}
			}
			return childNodes;
	};
    
	
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
		   
			var url="${ctx}/platform/system/sysRole/getTreeData.ht";
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
	 
	 function delrow(id)//删除行,用于删除暂时选择的行
	 {
		 $("#"+id).remove();
	 }

	
	
	
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
	 //组织树左键双击
	 function orgTreeOnDblClick(event, treeId, treeNode)
	 {   
		 var orgId=treeNode.orgId;
		 var orgSupId=treeNode.orgSupId;
		 var orgName=treeNode.orgName;
		 if(treeNode.isRoot==0){
			 orgAddHtml(orgId,orgSupId,orgName);
		 }
	 };
	 
	 
	 function orgAddHtml(orgId,orgSupId,orgName){
		
		 if(orgSupId==-1) return;
		 var obj=$("#" +orgId); 
         if(obj.length>0) return;
         
		 var tr="<tr  id='"+orgId+"' style='cursor:pointer'>";
		 tr+="<td style='text-align: center;'>";
		 tr+=""+orgName+"<input  type='hidden' name='orgIds' value='"+orgId+"'>";
		 tr+="</td>";		
		 
		 tr+="<td style='text-align: center;'>";
		 tr+="<input type='radio' name='orgIdPrimary' value='"+orgId+"' />";
		 tr+="</td>";
		 tr+="<td style='text-align: center;'>";
		 tr+="<input type='checkbox' name='chargeOrgId' value='"+orgId+"' />";
		 tr+="</td>";
	
		 
		 tr+="<td style='text-align: center;'>";
		 tr+="<a href='#' onclick='delrow(\""+orgId+"\")' class='link del'>移除</a>";
		 tr+="</td>";
		 
		 tr+="</tr>";
	     
		 $("#orgItem").append(tr);
		 
	 }
	 
	 
	//岗位树左键双击
	 function posTreeOnDblClick(event, treeId, treeNode){   
		 var posId=treeNode.posId;
		 var posName=treeNode.posName;
		 var posDesc=treeNode.posDesc;
		 var parentId=treeNode.parentId;
		 posAddHtml(posId,posName,parentId);
		 
	 };
	 
	 function posAddHtml(posId,posName,parentId){
		 if(parentId==-1) return;
		 var obj=$("#" +posId);
		 if(obj.length>0) return;
		 var tr="<tr  id='"+posId+"' style='cursor:pointer'>";
		 tr+="<td style='text-align: center;'>";
		 tr+=posName +"<input type='hidden' name='posId' value='"+posId+"'>";
		 tr+="</td>";
		 tr+="<td style='text-align: center;'>";
		 tr+="<input type='radio' name='posIdPrimary' value='"+posId+"' />";
		 tr+="</td>";
		 tr+="<td style='text-align: center;'>";
		 tr+="<a href='#' onclick='delrow(\""+posId+"\")' class='link del'>移除</a>";
		 tr+="</td>";
		 tr+="</tr>";
	    
		 $("#posItem").append(tr);
		 
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
	</script>
<style type="text/css">
	html{height:100%}
	body {overflow:auto;}

</style>
</head>
<body>
<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">
				<c:if test="${sysUser.userId==null }">添加用户信息</c:if>
				<c:if test="${sysUser.userId!=null }">编辑【${sysUser.fullname}】用户信息</c:if>  
				</span>
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group"><a class="link save" id="dataFormSave" href="#">保存</a></div>
					<div class="l-bar-separator"></div>
					<div class="group"><a class="link back" href="${returnUrl}">返回</a></div>
				</div>
			</div>
		</div>
	   <form id="sysUserForm" method="post" action="save.ht">
						
            <div  id="tabMyInfo" class="panel-nav" style="overflow:hidden; position:relative;">  
	           <div title="基本信息" tabid="userdetail" icon="${ctx}/styles/default/images/resicon/user.gif">
			         
			           		<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
								<tr>
									<td rowspan="<c:if test="${not empty sysUser.userId}">11</c:if><c:if test="${empty sysUser.userId}">10</c:if>" align="center" width="26%">
									<div style="float:top !important;background: none;height: 24px;padding:0px 6px 0px 112px;">
										<!-- 
										<a class="link uploadPhoto" href="#" onclick="addPic();">上传照片</a>
										 -->
										<a class="link uploadPhoto" href="#" onclick="openImageDialog();">上传照片</a> 
									</div>
									<div class="person_pic_div">
										<p><img id="personPic" src="${fileCtx}/${pictureLoad}" onerror="this.src='${ctx}/commons/image/default_image_male.jpg'" alt="个人相片" width="230px;" height="370px;"/></p>
									</div>
									</td>
									<th width="18%">帐   号: <span class="required">*</span></th>
									<c:if test="${empty sysUser.userId}">
										<input type="hidden" id="account" name="account" value="${sysUser.shortAccount}"/>
									</c:if>
									<td >
										<c:if test="${bySelf==1}"><input type="hidden" name="bySelf" value="1"></c:if>
										<input type="text" <c:if test="${bySelf==1 or not empty sysUser.userId}">disabled="disabled"</c:if> id="shortAccount" name="shortAccount" value="${sysUser.shortAccount}" onblur="document.getElementById('account').value=this.value;" style="width:240px !important" class="inputText"/>
									</td>
								</tr>						
																				
								<tr style="<c:if test="${not empty sysUser.userId}">display:none</c:if>">
									<th>密   码: <span class="required">*</span></th>
									<td><input type="password" id="password" name="password" value="${sysUser.password}" style="width:240px !important" class="inputText"/></td>
								</tr>
								
								<tr>
								    <th>用户姓名: <span class="required">*</span></th>
									<td ><input type="text" id="fullname" name="fullname" value="${sysUser.fullname}" maxlength="20" style="width:240px !important" class="inputText" validate="{required:true}"/></td>
								</tr>
								<tr>
								    <th>编   码: </th>
									<td ><input type="text" id="code" name="code" value="${sysUser.code}" maxlength="20"  style="width:240px !important" class="inputText"/></td>
								</tr>
								
								<tr>
								    <th>参考编码: </th>
									<td ><input type="text" id="refCode" name="refCode" value="${sysUser.refCode}" maxlength="20"  style="width:240px !important" class="inputText"/></td>
								</tr>
								<tr>
									<th>用户性别: </th>
									<td>
									<select name="sex" class="select" style="width:245px !important">
											<option value="1" <c:if test="${sysUser.sex==1}">selected</c:if> >男</option>
											<option value="0" <c:if test="${sysUser.sex==0}">selected</c:if> >女</option>
									</select>						
									</td>
								</tr>						
								<tr>
									<th>是否锁定: </th>
									<td >								
										<select name="isLock" class="select" style="width:245px !important" <c:if test="${bySelf==1}">disabled="disabled"</c:if>>
											<option value="<%=SysUser.UN_LOCKED %>" <c:if test="${sysUser.isLock==0}">selected</c:if> >未锁定</option>
											<option value="<%=SysUser.LOCKED %>" <c:if test="${sysUser.isLock==1}">selected</c:if> >已锁定</option>
										</select>	
									</td>				  
								</tr>
								
								<tr>
								    <th>是否过期: </th>
									<td >
										<select name="isExpired" class="select" style="width:245px !important" <c:if test="${bySelf==1}">disabled="disabled"</c:if>>
											<option value="<%=SysUser.UN_EXPIRED %>" <c:if test="${sysUser.isExpired==0}">selected</c:if> >未过期</option>
											<option value="<%=SysUser.EXPIRED %>" <c:if test="${sysUser.isExpired==1}">selected</c:if> >已过期</option>
										</select>
									</td>
								</tr>
								
								<tr>
								   <th>当前状态: </th>
									<td>
										<select name="status"  class="select" style="width:245px !important" <c:if test="${bySelf==1}">disabled="disabled"</c:if>>
											<option value="<%=SysUser.STATUS_OK %>" <c:if test="${sysUser.status==1}">selected</c:if> >激活</option>
											<option value="<%=SysUser.STATUS_NO %>" <c:if test="${sysUser.status==0}">selected</c:if> >禁用</option>
											<option value="<%=SysUser.STATUS_Del %>" <c:if test="${sysUser.status==-1}">selected</c:if>>删除</option>
										</select>
									</td>								
								</tr>						
								<tr>
								   <th>邮箱地址: <span class="required">*</span></th>
								   <td ><input type="text" id="email" name="email" maxlength="20" value="${sysUser.email}" style="width:240px !important" validate="{required:true,email:true,ajaxEmail:true}" class="inputText"/></td>
								</tr>
								
								<tr>
									<th>手   机: <span class="required">*</span></th>
									<td ><input type="text" id="mobile" name="mobile" value="${sysUser.mobile}" maxlength="20" style="width:240px !important" validate="{required:true,phone:true,ajaxMobile:true}" class="inputText"/></td>						   
								</tr>
								
								<tr>
								    <th>座 机 号: </th>
									<td ><input type="text" id="phone" name="phone" value="${sysUser.phone}" maxlength="20"  style="width:240px !important" class="inputText" validate="{required:false,tel:true}"/></td>
								</tr>
							</table>
							<input type="hidden" name="userId" value="${sysUser.userId}" />
							<input type="hidden" id="picture" name="picture" value="${sysUser.picture}" />
					
	           </div>
	          <div title="所属组织" tabid="orgdetail"
				icon="${ctx}/styles/default/images/resicon/home.png">
				<div
					style="overflow-y: auto; overflow-x: hidden; border: 0px solid #6F8DC6;">
					<div class="panel-data">
						<table id="orgItem" class="table-grid" cellpadding="1"
							cellspacing="1">
							<thead>
								<th style="width: 25%; text-align: center !important;">组织名称</th>
								<th style="width: 25%; text-align: center !important;">是否主组织</th>
								<th style="width: 50%; text-align: center !important;">主要负责人</th>
							</thead>
							<c:forEach items="${orgList}" var="orgItem" varStatus="status">
								<tr class="${status.index%2==0?'odd':'even'}">
									<td style="text-align: center;">${orgItem.orgName}<input type="hidden" name="orgIds" value="${orgItem.orgId}"/></td>
									<td style="text-align: center;"><c:choose>
											<c:when test="${orgItem.isPrimary==1}">
												是<input type="hidden" name="orgIdPrimary" value="${orgItem.isPrimary}"/>
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
		</div>
<%--	        
	        <div title="岗位选择" tabid="posdetail" icon="${ctx}/styles/default/images/nav-sales.png">
	        	
			         <table align="center"  cellpadding="0" cellspacing="0" class="table-grid">
					   <tr>
				       <td width="28%" valign="top" style="padding-left:2px !important;">
				        <div class="tbar-title">
								<span class="tbar-label">所有岗位</span>
						</div>				         
						<div class="panel-body" style="height:520px;overflow-y:auto;border:1px solid #6F8DC6;">	 
							<div id="posTree" class="ztree" style="width:200px;margin:-2; padding:-2;" >         
				            </div>
						</div>
						</td>
						<td width="3%" valign="middle"  style="padding-left:2px !important;">
						<input type="button" id="posAdd" value="添加&gt;&gt;" />
						<br/>
						<br/>
						<br/>
						</td>
					    <td valign="top" style="padding-left:2px !important;">
					   <div class="tbar-title">
							<span class="tbar-label">已选岗位</span>
						</div>	
						<div style="overflow-y:auto;border:1px solid #6F8DC6;">
						<table id="posItem" class="table-grid"  cellpadding="1" cellspacing="1">
						   		<thead>					   			
						   			<th style="text-align:center !important;">岗位名称</th>
						   			<th style="text-align:center !important;">是否主岗位</th>
						    		<th style="text-align:center !important;">操作</th>
						    	</thead>
						    	<c:forEach items="${posList}" var="posItem">
						    		<tr  id="${posItem.posId}" style='cursor:pointer'>						    		
							    		<td style="text-align: center;">
						    				${posItem.posName}<input type="hidden" name="posId" value="${posItem.posId}">
						    			</td>
						    			<td style="text-align: center;">					    			
						    			 <input type="radio" name="posIdPrimary" value="${posItem.posId}" <c:if test='${posItem.isPrimary==1}'>checked</c:if> />
						    			</td>
						    			
						    			<td style="text-align: center;">
						    			 <a href="#" onclick="delrow('${posItem.posId}')" class="link del">移除</a>
						    			</td>
						    		</tr>
						    	</c:forEach>
						   	 </table>
						</div>
			            </td>
			            </tr>
					 </table>
				 
	         </div>
	          --%>
	         <div title="所属角色" tabid="roldetail"
			icon="${ctx}/styles/default/images/resicon/customer.png">
			<div
				style="overflow-y: auto; overflow-x: hidden; border: 0px solid #6F8DC6;">
				<div class="panel-data">
					<table id="rolItem" class="table-grid" cellpadding="1"
						cellspacing="1">
						<thead>
							<th style="width: 25%; text-align: center !important;">角色名称</th>
							<th style="width: 25%; text-align: center !important;">子系统名称</th>

						</thead>
						<c:forEach items="${roleList}" var="rolItem" varStatus="status">
							<input type="hidden" name="roleId" value="${rolItem.roleId}"/>
							<tr class="${status.index%2==0?'odd':'even'}">
								<td style="text-align: center;">${rolItem.roleName}</td>
								<td style="text-align: center;">${rolItem.systemName}</td>
							</tr>
						</c:forEach>
					</table>
				</div>
			</div>
		</div>						
	      </div>      
	  </form>
</div>
</body>
</html>
