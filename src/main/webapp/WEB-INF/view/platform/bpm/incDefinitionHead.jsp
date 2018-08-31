<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<script type="text/javascript">
	function showXmlWindow(obj){
		var url="";
		if($(obj).text().trim()=='BPMN-XML'){
			url="${ctx}/platform/bpm/bpmDefinition/bpmnXml.ht?defId=${bpmDefinition.defId}";
		}else{
			url="${ctx}/platform/bpm/bpmDefinition/designXml.ht?defId=${bpmDefinition.defId}";
		}
		url=url.getNewUrl();
		window.open(url);
	}
</script>
<div class="panel-top">
	<div class="tbar-title">
		<span class="tbar-label">流程定义管理->${bpmDefinition.subject }</span>
	</div>
	<div class="panel-toolbar">
		
		<div class="toolBar">
			<div class="group"><a class="link xml-bpm"  onclick="showXmlWindow(this);">BPMN-XML</a></div>
			<div class="l-bar-separator"></div>
			<div class="group"><a class="link xml-design" onclick="showXmlWindow(this);">DESIGN-XML</a></div>
			<div class="l-bar-separator"></div>
			<div class="group"><a class="link back" href="${ctx}/platform/bpm/bpmDefinition/list.ht">返回</a></div>
		</div>	
	</div>
</div>
