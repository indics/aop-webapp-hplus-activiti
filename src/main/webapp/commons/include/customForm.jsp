<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="f" uri="http://www.jee-soft.cn/functions" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="display" uri="http://displaytag.sf.net" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<f:link href="web.css" ></f:link>
<f:link href="Aqua/css/ligerui-all.css" ></f:link>
<link href="${ctx}/js/tree/v35/zTreeStyle.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/styles/default/css/form.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx}/js/dynamic.jsp"></script>
<script type="text/javascript" src="${ctx}/js/jquery/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery/jquery.form.js"></script>
<script type="text/javascript" src="${ctx}/js/util/util.js"></script>
<script type="text/javascript" src="${ctx}/js/util/json2.js"></script>
<script type="text/javascript" src="${ctx}/js/util/form.js"></script>
<script type="text/javascript" src="${ctx}/js/tree/v35/jquery.ztree.core-3.5.min.js"></script>
<script type="text/javascript" src="${ctx}/js/tree/v35/jquery.ztree.excheck-3.5.min.js"></script>
<script type="text/javascript" src="${ctx}/js/lg/base.js"></script>
<script type="text/javascript" src="${ctx}/js/lg/plugins/ligerComboBox.js"></script>
<script type="text/javascript" src="${ctx}/js/lg/plugins/htDicCombo.js"></script>
<script type="text/javascript" src="${ctx}/js/lg/plugins/ligerMenuBar.js" ></script>
<script type="text/javascript" src="${ctx}/js/lg/plugins/ligerMenu.js"></script>
<script type="text/javascript" src="${ctx}/js/lg/plugins/ligerTextBox.js"></script>
<script type="text/javascript" src="${ctx}/js/lg/plugins/ligerTip.js"></script>
<script type="text/javascript" src="${ctx}/js/lg/plugins/ligerTab.js"></script>
<script type="text/javascript" src="${ctx}/js/lg/plugins/ligerMessageBox.js"></script>
<script type="text/javascript" src="${ctx}/js/lg/plugins/ligerMsg.js"></script>
<script type="text/javascript" src="${ctx}/js/lg/plugins/ligerDrag.js" ></script>
<script type="text/javascript" src="${ctx}/js/lg/plugins/ligerDialog.js" ></script>
<script type="text/javascript" src="${ctx}/js/lg/plugins/ligerResizable.js" ></script>
<script type="text/javascript" src="${ctx}/js/calendar/My97DatePicker/WdatePicker.js" ></script>

<script type="text/javascript" src="${ctx}/js/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="${ctx}/js/cosim/platform/system/SysDialog.js"></script>
<script type="text/javascript" src="${ctx}/js/cosim/platform/form/rule.js"></script>

<script type="text/javascript" src="${ctx}/js/cosim/CustomValid.js"></script>
<script type="text/javascript" src="${ctx}/js/cosim/platform/form/CustomForm.js"></script>
<script type="text/javascript" src="${ctx}/js/cosim/platform/system/FlexUploadDialog.js"></script>
<script type="text/javascript" src="${ctx}/js/cosim/platform/form/AttachMent.js"></script>
<script type="text/javascript" src="${ctx}/js/cosim/platform/form/SubtablePermission.js"></script>
<script type="text/javascript" src="${ctx}/js/cosim/platform/form/OfficeControl.js"></script>
<script type="text/javascript" src="${ctx}/js/cosim/platform/form/OfficePlugin.js"></script>
<script type="text/javascript" src="${ctx}/js/cosim/platform/form/CommonDialog.js"></script>
<script type="text/javascript" src="${ctx}/js/cosim/platform/form/FormData.js"></script>
<script type="text/javascript" src="${ctx}/js/cosim/platform/form/FormUtil.js"></script>
<script type="text/javascript" src="${ctx}/js/cosim/platform/system/ImageQtip.js" ></script>
<style type="text/css">
	.validError {border: 1px solid red}
</style>