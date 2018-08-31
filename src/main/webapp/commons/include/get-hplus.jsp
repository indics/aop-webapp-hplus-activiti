<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="f" uri="http://www.jee-soft.cn/functions" %>
<%@ taglib prefix="display" uri="http://displaytag.sf.net" %>
<%@ taglib prefix="cosim" uri="http://www.jee-soft.cn/paging" %>
<%@ taglib prefix="ap" uri="/appleTag"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8" />

<!-- HPlus -->
<script src="${ctx}/js/hplus/js/jquery.min.js?v=2.1.4"></script>
<script src="${ctx}/js/hplus/js/bootstrap.min.js?v=3.3.6"></script>
<script src="${ctx}/js/hplus/js/plugins/peity/jquery.peity.min.js"></script>
<script src="${ctx}/js/hplus/js/content.min.js?v=1.0.0"></script>
<link href="${ctx}/js/hplus/css/bootstrap.min14ed.css?v=3.3.6" rel="stylesheet">
<link href="${ctx}/js/hplus/css/font-awesome.min93e3.css?v=4.4.0" rel="stylesheet">
<link href="${ctx}/js/hplus/css/animate.min.css" rel="stylesheet">
<link href="${ctx}/js/hplus/css/style.min862f.css?v=4.1.0" rel="stylesheet">
<!-- JQGrid -->
<script src="${ctx}/js/hplus/js/plugins/jqgrid/i18n/grid.locale-cnffe4.js?0820"></script>
<script src="${ctx}/js/hplus/js/plugins/jqgrid/jquery.jqGrid.minffe4.js?0820"></script>
<link href="${ctx}/js/hplus/css/plugins/jqgrid/ui.jqgridffe4.css?0820" rel="stylesheet">
<!-- Lay Date  -->
<script src="${ctx}/js/hplus/js/plugins/layer/laydate/laydate.js"></script>
<!-- Sweet Alert  -->
<script src="${ctx}/js/hplus/js/plugins/sweetalert/sweetalert.min.js"></script>
<link href="${ctx}/js/hplus/css/plugins/sweetalert/sweetalert.css" rel="stylesheet">
<!-- HT -->
<script type="text/javascript" src="${ctx}/js/dynamic.jsp"></script>
<script src="${ctx}/js/util/util.js"></script>