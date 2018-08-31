<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.*;"  %>
<%@include file="/commons/include/html_doctype.html"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<%@include file="/commons/include/form.jsp" %>
	<link href="${ctx}/styles/ligerUI/ligerui-all.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="${ctx }/js/lg/plugins/ligerWindow.js" ></script>
    <script type="text/javascript" src="${ctx}/js/cosim/platform/bpm/showModalDialog.js"  charset="UTF-8"></script>
	<script type="text/javascript" src="${ctx }/js/cosim/platform/system/SysDialog.js"></script>
	<script type="text/javascript" src="${ctx }/js/lg/plugins/ligerAccordion.js" ></script>
    <script type="text/javascript" src="${ctx }/js/lg/plugins/htButtons.js" ></script>
</head>

<body>
	<div class="panel-toolbar">
	<div class="toolBar">
		<div class="group"><span class='htbtn' onclick="save()">保存</span></div>
	</div>
	</div>
	
	<div id="content">
		
		<script type="text/javascript">
		    var height = $(".l-layout-center").height();
	        $("#content").ligerAccordion({speed: null });
	        var	accordion = $("#content").ligerGetAccordionManager();
	        
	        //添加节点容器
			function addGridContainer(id){
	      		var ul=$("<ul id='task" +id+ "' style='width:100%;height:100%;'></ul>");
	      		$("#content").append(ul);
	      		return ul;
	        }
	        
	        var bpmNodeSet = new Array();
	        var taskIdx=-1;
	        var tableIdx = -1;
	        var li = new Array();
	        // 添加新的assignUserItem
	        function addAssignUserItem(ulid,idx,uids,userNames,assignType){
	        	tableIdx++;
	        	var tmpHtml="<li style='margin-top:2px;'><table id='table"+tableIdx+"'><tr>";
	        	if(!li[idx]){
	        		tmpHtml+="<td width='8%'>&nbsp;用户类型:</td><td>";
	        	}else{
	        		tmpHtml+="<td width='8%'>&nbsp;</td><td>";
	        	}
	        	tmpHtml+="<select id='cbo"+tableIdx+"_"+ulid+"' value='"+assignType+
	        		"' class='select' style='margin-left:1%'>"+
	        		"<option value='0'>发起人</option><option value='1'>用户</option>"+
	      			"<option value='2'>角色</option><option value='3'>组织</option>"+
	      			"<option value='4'>组织负责人</option><option value='5'>岗位</option>"+
	      			"<option value='6'>上下级</option><option value='7'>用户属性</option>"+
	      			"<option value='8'>组织属性</option><option value='9'>动态计算</option>";
	      		
	      		tmpHtml.replaceAll("<option value='"+assignType+"'>",
	      				"<option value='"+assignType+"' selected='true'>");
	      		
	      		tmpHtml+="</select></td><td>&nbsp;&nbsp;</td><td width='60%'>"+
	      			"<div id='chb"+tableIdx+"_"+
	      			ulid+"' style='height:50px;max-height:50px;overflow:auto;'><table>";
				
	      		if(userNames!=""){
		      		var arrNames = userNames.split(",");
		      		var arrIds = uids.split(",");
		      		tmpHtml+="<tr>";
		      		for(var idxs=0;idxs<arrNames.length;idxs++){
		      			tmpHtml+="<td style='padding-top:5px;'>&nbsp;&nbsp;"
		      				+"<input type='checkbox' id='"+arrIds[idxs]+"' value='"
		      				+arrNames[idxs]+"' checked=true />&nbsp;"+arrNames[idxs]+"</td>";
		      			if(idxs+1!=arrNames.length){tmpHtml+="&nbsp;&nbsp;";}
		      		}
	      			tmpHtml+="</tr>";
	      		}
	      		
	      		tmpHtml+="</table></div></td><td>&nbsp;&nbsp;</td>"+
	      			"<td><span class='htbtn' onclick='userSelect(\"chb"+tableIdx+"_"+ulid+
	      			"\",\"cbo"+tableIdx+"_"+ulid+"\")'>...</span></td>"+
	      			"<td>&nbsp;</td>"+
	      			"<td width='10%'><span class='htbtn'>未选中删除</span></td>"+
	      			"<td>&nbsp;&nbsp;</td>";
	      		
      			if(!li[idx]){
      				tmpHtml+="<td width='10%'><span class='htbtn' "+
      					"onclick='addAssignUserItem(\""+ulid+"\",\""+idx+"\",\"\",\"\",0)'>添加行</span></td>";
      			}else{
      				tmpHtml+="<td width='10%'><span class='htbtn' "+
      					"onclick='delAssignUserItem(\"table"+tableIdx+"\",\""+ulid+"\",\""+idx+"\")'>删除行</span></td>";
      			}
	      		tmpHtml+="</tr></table></li>";
	      			
	      		if(!li[idx]){li[idx]="";}
	      		li[idx]+=tmpHtml;
	      		
	      		document.getElementById(ulid).innerHTML = li[idx];
	      		
	      		var cpoSelect = document.getElementById("cbo"+tableIdx+"_"+ulid)
	      		for(var idxs=0;idxs<cpoSelect.options.length;idxs++){
	      	         if(cpoSelect.options[idxs].value == assignType)  
	      	         {
	      	    		cpoSelect.options[idxs].selected = true;
	      	         	break;  
	      	         }  
	      		}
	      		
	      		$("span.htbtn").htButtons();
	        }
	        
	     	// 删除旧的assignUserItem
	        function delAssignUserItem(tableId,taskId,idx){
	        	var tableObj = document.getElementById(tableId);
	        	tableObj.parentNode.removeChild(tableObj);
	        	li[idx]=document.getElementById(taskId).innerHTML;
	        }
	     	
	     	// 根据用户类型添加用户 checkbox
		 	function userSelect(itemDiv,selId){
	     		var selObj = document.getElementById(selId);
		 		if(selObj.value!=0){
			 		UserDialog({callback:function(userIds,fullnames){
			     		var divObj = document.getElementById(itemDiv);
			     		var arrIds = userIds.split(",");
			     		var arrName = fullnames.split(",");
			     		var chbArr = divObj.innerHTML.replaceAll("<TR>","").replaceAll("</TR>","")
			     			.replaceAll("<TBODY>","").replaceAll("</TBODY>","")
			     			.replaceAll("<TABLE>","").replaceAll("</TABLE>","")
			     			.split("<TD></TD>");
			     		var cheIdx=0;
			     		var curHtml = "";
			     		//alert(chbArr)
			     		for(var idxs=0;idxs<chbArr.length;idxs++){
			     			cheIdx++;
			     			if(idxs!=0){
			     				curHtml+="<TD></TD>";
			     			}
			     			
							curHtml+=chbArr[idxs];
							
							if(cheIdx%5==1&&cheIdx!=1){
								curHtml+="<TD></TD>";
							}
							
							if(idxs+1==chbArr.length && arrName.length>0){
								for(var nIdx=0;nIdx<arrName.length;nIdx++){
					     			if(cheIdx%5==0){
					     				curHtml+="</TR><TR>";
					     			}
					     			
									curHtml+="<TD></TD><td style='padding-top:10px;'>&nbsp;&nbsp;"
					      				+"<input type='checkbox' id='"+arrIds[nIdx]+"' value='"
					      				+arrName[nIdx]+"' checked=true />&nbsp;"+arrName[nIdx]+"</TD>";
					     			cheIdx++;
								}
								break;
							}
			     			if(cheIdx%5==0){
			     				curHtml+="</TR><TR>";
			     			}
			     		}
			     		curHtml+="</TR></TBODY></TABLE>";
			     		divObj.innerHTML = "<TABLE><TBODY><TR>"+curHtml.trim();
			 		}});
		 		}
		 	}
	        

	     	
	     	function save(){
	     		var json = "";
     			var setid;
	     		for(var i=0;i<bpmNodeSet.length;i++){

	     			var bnsArr = bpmNodeSet[i].split("_");
	     			var taskObj = document.getElementById("task"+bnsArr[0]);
	     			var userType = taskObj.getElementsByTagName("li");
	     			for(var j=0;j<userType.length;j++){
	     				var options = userType[j].getElementsByTagName("option");
	     				var assignType;
	     				for(var l=0;l<options.length;l++){
	     					if(options[l].selected){
	     						assignType=options[l].value;
	     					}
	     				}
	     				var chbArr = userType[j].getElementsByTagName("input");
	     				var ids = "";
	     				var names = "";
	     				for(var k=0;k<chbArr.length;k++){
	     					alert(chbArr[k].id)
	     					if(chbArr[k].checked){
	     						ids+=chbArr[k].id+",";
	     						names+=chbArr[k].value+",";
	     					}
	     				}
	     				if(ids.length>0){
	     					ids=ids.substring(0,ids.length-1);
	     					names=names.substring(0,names.length-1);
	     				}
		     			
	     				if(setid!=bnsArr[0]){
	     					json += "{'setId':'"+bnsArr[0]+"','actDeployId':'"+bnsArr[1]
	     						+"','nodeId':'"+bnsArr[2]+"','nodeName':'"+bnsArr[3]
	     						+"','defId':'"+bnsArr[4]+"','isExist':'"+bnsArr[5]
	     						+"',bpmNodeUser:[";
	     				}
	     				json += "{'assignType':'"+assignType
	     					+"','uids':'"+ids+"','userNames':'"+names+"'},";
		     			setid = bnsArr[0];
	     			}
			     	if(json.length>0){
			     		json = json.substring(0,json.length-1);
			     	}
	     			json+="]},";
	     		}
	     		
		     	if(json.length>0){
		     		json = json.substring(0,json.length-1);
		     	}
		     	json = "{'data':["+json+"]}";
				
		    	$.ajax({
		    		type: 'POST',
		    		url: '${ctx}/platform/bpm/bpmDefinition/saveAssign.ht',
		    		data: {json:json},
		    		success: function(result){
		    			$.ligerMessageBox.success('操作成功',result);
		    		}
		    	});
		     	
	     	}
	     	
		</script>
		
		<c:forEach items="${bpmNodeSetList}" var="bpmNodeSetItem">
			<script type="text/javascript">
				taskIdx++;
				bpmNodeSet.push("${bpmNodeSetItem.setId}_${bpmNodeSetItem.actDeployId}_"+
						"${bpmNodeSetItem.nodeId}_${bpmNodeSetItem.nodeName}_"+
						"${bpmNodeSetItem.defId}_${bpmNodeSetItem.isExist}");
				accordion.addPanel("${bpmNodeSetItem.nodeName}","",addGridContainer("${bpmNodeSetItem.setId}"));
			</script>
			
			<c:set var="isExist" value="false"></c:set>
			<c:if test="${bpmNodeUserList!=null}">
			<c:forEach items="${bpmNodeUserList}" var="bpmNodeUserItem">
				<c:if test="${bpmNodeSetItem.setId == bpmNodeUserItem.setId}">
					<c:set var="isExist" value="true"></c:set>
					
					<c:choose>
						<c:when test="${bpmNodeUserItem.assignType==0}">
							<script type="text/javascript">
								addAssignUserItem("task${bpmNodeSetItem.setId}",taskIdx,"def","发起人",
										"${bpmNodeUserItem.assignType}",0);
							</script>
						</c:when>
						<c:otherwise>
						
							<c:forEach items="${bpmUserSetList}" var="bpmUserSetItem">
								<c:if test="${bpmUserSetItem.assignType == bpmNodeUserItem.assignType}">
									<script type="text/javascript">
										addAssignUserItem("task${bpmNodeSetItem.setId}",taskIdx,"${bpmUserSetItem.cmpIds}",
												"${bpmUserSetItem.cmpNames}","${bpmNodeUserItem.assignType}");
									</script>
								</c:if>
							</c:forEach>
							
						</c:otherwise>
					</c:choose>
					
				</c:if>
			</c:forEach>
			</c:if>
			
			<c:if test="${isExist==false}">
				<script type="text/javascript">
					addAssignUserItem("task${bpmNodeSetItem.setId}",taskIdx,"def","发起人",0);
				</script>
				<c:set var="isExist" value="false"></c:set>
			</c:if>
			
		</c:forEach>
		
		<script type="text/javascript">
			accordion.addComplete();
		</script>

	</div>
</body>
</html>
