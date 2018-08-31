
<%--
	time:2013-04-23 11:20:58
--%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<%@include file="/commons/cloud/global.jsp"%>
<html>
<head>
<title>企业审核信息</title>
<%@include file="/commons/include/getById.jsp"%>
<style type="text/css">
.panel-body tr td{
	word-wrap: break-word;
	word-break: break-all;
}
.list-paddingleft-2 {
  padding-left: 30px;
  list-style:decimal; 
}
 .list-paddingleft-2 ol li {
  list-style:decimal; 
}
ol li {
  list-style:decimal; 
  margin: 0;
  padding: 0;
}
.table-detail .xuqiu td {
  padding: 5px 10px;
  border: 1px solid #ddd;
}
</style>
</head>
<body>
	<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">企业详细信息</span>
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group">
						<div class="group"><a class="link back" href="javascript:history.back(-1);">返回</a></div>
						<div class="l-bar-separator"></div>
					</div>
				</div>
			</div>
		</div>
		<div class="panel-body">
		<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
			<tr>
				<th width="20%">审核状态:</th>
				<td colspan="3" style="color: red;">
					<c:if test="${tenant.state==0}">未审核</c:if>
					<c:if test="${tenant.state==1}">审核未通过</c:if>
					<c:if test="${tenant.state==2}">审核通过</c:if>
				</td>
			</tr>
			
			<tr>
				<th width="20%">企业账号:</th>
				<td width="30%">${tenant.sysOrgInfoId}</td>
				<th width="20%">邮箱:</th>
				<td>${tenant.email}</td>
			</tr>
			<tr>
				<th width="20%">企业名称:</th>
				<td width="30%">${tenant.name}</td>
				<th width="20%">企业类型:</th>
				<td width="30%">${tenant.type}</td>
			</tr>
			<tr>
				<th width="20%">主营行业:</th>
				<td>${tenant.industry} - ${tenant.industry2}</td>
				<th width="20%">主营产品:</th>
				<td>${tenant.product}</td>
			</tr>
			<tr>
				<th width="20%">经营模式:</th>
				<td>
					<c:forTokens items="${tenant.model}" varStatus="status" delims="," var="model"> 
             			<c:if test="${model=='0'}">
							其他类型企业&nbsp;
						</c:if>
						<c:if test="${model=='1'}">
							生产型企业&nbsp;
						</c:if>
						<c:if test="${model=='2'}">
							贸易型企业&nbsp;
						</c:if>
						<c:if test="${model=='3'}">
							服务型&nbsp;
						</c:if>
						<c:if test="${model=='4'}">
							研发型&nbsp;
						</c:if>
					</c:forTokens>
				</td>
				<th width="20%">公司规模:</th>
				<td>${tenant.scale}</td>
			</tr>
			<tr>
				<th width="20%">经营范围:</th>
				<td>${tenant.manageRange}</td>
				<th width="20%">组织机构代码:</th>
				<td>${tenant.code}</td>
			</tr>
			<tr>
				<th width="20%">工商注册证明:</th>
				<td>${tenant.regProve}</td>
				<th width="20%">企业Logo:</th>
				<td>
					<c:if test="${not empty tenant.logo}">
						<img src="${fileCtx}/${tenant.logo}" width="120" height="84" />
					</c:if>
				</td>
			</tr>
			
			<tr>
				<td align="left" colspan="4" height="20px;" width="100%"></td>
			</tr>
 			<tr>
				<th width="20%">联系人:</th>
				<td 30%>${tenant.connecter}</td>
				<th width="20%">手机:</th>
				<td>${tenant.tel}</td>
			</tr>
			<tr>
 				<th width="20%">座机:</th>
				<td>${tenant.homephone}</td>
				<th width="20%">传真:</th>
				<td>${tenant.fax}</td>
			</tr>
 			<tr>
 				<th width="20%">所在国家、省(州)、市(区):</th>
				<td>${tenant.country}-${tenant.province}-${tenant.city}</td>
				<th width="20%">地址:</th>
				<td>${tenant.address}</td>
			</tr>
			<tr>
				<th width="20%">邮编:</th>
				<td>${tenant.postcode}</td>
 				<th width="20%">公司网站:</th>
				<td>${tenant.website}</td>
 			</tr>
			<tr>
				<th width="20%">是否公开:</th>
				<td>
					<c:if test="${tenant.isPublic == '1'}">
					是
					</c:if>
					<c:if test="${tenant.isPublic == '0'}">
					否
					</c:if>
				</td>
				<th width="20%">注册时间:</th>
				<td>
				<fmt:formatDate value="${tenant.registertime}" pattern="yyyy-MM-dd"/>
				</td>
			</tr>
			
 			<tr>
				<td align="left" colspan="4" height="20px;" width="100%"></td>
			</tr>
 			
 			<tr>
				<th width="20%">主要销售区域:</th>
				<td>${tenant.sellArea}</td>
 				<th width="20%">主要客户群体:</th>
				<td>${tenant.clients}</td>
 			</tr>
 			<tr>
				<th width="20%">企业占地面积:</th>
				<td>${tenant.area}</td>
 				<th width="20%">员工人数:</th>
				<td>${tenant.employees}</td>
 			</tr>
 			<tr>
				<th width="20%">企业品牌:</th>
				<td>${tenant.brand}</td>
 				<th width="20%">年营业额:</th>
				<td>${tenant.turnover}</td>
 			</tr>
 			<tr>
				<th width="20%">年出口额:</th>
				<td>${tenant.exportFore}</td>
 				<th width="20%">年进口额:</th>
				<td>${tenant.importFore}</td>
 			</tr>
 			<tr>
				<th width="20%">质量管理体系:</th>
				<td>${tenant.qualityControl}</td>
 				<th width="20%">注册资本:</th>
				<td>${tenant.regCapital}</td>
 			</tr>
 			<tr>
				<th width="20%">注册地点:</th>
				<td>${tenant.regAdd}</td>
 				<th width="20%">法人:</th>
				<td>${tenant.incorporator}</td>
 			</tr>
 			<tr>
				<th width="20%">开户银行:</th>
				<td>${tenant.openBank}</td>
 				<th width="20%">开户账户:</th>
				<td>${tenant.openAccount}</td>
 			</tr>
			<tr>
				<th width="20%">公司简介:</th>
				<td colspan="3" class="xuqiu">${tenant.info}</td>
			</tr>
		</table>
		<div style="height: 20px;"></div>
		<table class="table-grid table-list" cellpadding="1" cellspacing="1">
				<tr>
					<td colspan="6" style="text-align: center; background-color: #f5f5f5;">资质认证信息</td>
				</tr>
				<tr>
					<th>所属企业</th>
					<th>证书类型</th>
					<th>发证机构</th>
					<th>生效日期</th>
					<th>截止日期</th>
					<th>证书扫描件</th>
				</tr>	
				<c:forEach items="${aptitudeList}" var="aptitudeItem" varStatus="status">
					<tr>
							<input type="hidden" id="id" name="id" value="${aptitudeItem.id}"  class="inputText"/>
							<td style="text-align: center">${aptitudeItem.infoId}</td>					
	
				
							<td style="text-align: center">${aptitudeItem.cateType}</td>					
	
				
							<td style="text-align: center">${aptitudeItem.cateOrg}</td>					
	
				
							<td style="text-align: center"><fmt:formatDate value='${aptitudeItem.inureDate}' pattern='yyyy-MM-dd'/></td>							
								
							<td style="text-align: center">${aptitudeItem.endDate}</td>					
				
							<td style="text-align: center">
							 	<c:if test="${ not empty aptitudeItem.catePic}">
							    	<img src="${fileCtx}/${aptitudeItem.catePic} " width="80" height="84" />
							    </c:if>
							</td>						
					</tr>
				</c:forEach>
			</table>
		</div>
	</div>
</body>
</html>

