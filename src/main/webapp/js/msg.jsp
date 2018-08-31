<%@page import="com.cosim.core.web.controller.BaseController"%>
<%@page import="com.cosim.core.web.ResultMessage"%>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/lg/plugins/ligerMsg.js"></script>
<%
if(session.getAttribute(BaseController.Message)!=null){
ResultMessage _obj_=(ResultMessage)session.getAttribute(BaseController.Message);
if(_obj_!=null){
	session.removeAttribute(BaseController.Message);
%>
<script type="text/javascript">
$(function(){
	<%
	  if(_obj_.getResult()==ResultMessage.Success){
	%>
		layer.msg('<%=_obj_.getMessage()%>', {
		  icon: 1,
		  time: 2000
		});
		// $.ligerMsg.correct('<p><font color="green"><%=_obj_.getMessage()%></font></p>',false,function(){$.ligerMsg.close();});
	<%}
	  else{
	%>
		layer.msg('<%=_obj_.getMessage()%>', {
			icon: 1,
			time: 2000	  
		});	
		// $.ligerMsg.warn('<p><font color="red"><%=_obj_.getMessage()%></font></p>',false,function(){$.ligerMsg.close();});
	<%}%>
});
</script>
<%
}} %>

