
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title>系统岗位管理</title>
	<%@include file="/commons/include/get.jsp"%>
	<script type="text/javascript">
		//树列表的收展
		function treeClick(obj) {
			var clazz = $(obj).attr("class");
			var id = $(obj).parents("tr").attr("id");
			if (clazz == "tree-list-minus") {
				toggleChild(id, "hide");
			} else if (clazz == "tree-list-plus") {
				toggleChild(id, "show");
			}
			//置换加减号
			$(obj).toggleClass("tree-list-minus");
			$(obj).toggleClass("tree-list-plus");
		};
		//子结点收展
		function toggleChild(parentId, type) {
			var child = $("tr[parentId='" + parentId + "']");
			$.each(child, function(i, c) {
				if (type == "hide") {
					$(c).hide();
				} else if (type == "show") {
					$(c).find("a[name='tree_a']").removeClass("tree-list-plus");
					$(c).find("a[name='tree_a']").addClass("tree-list-minus");
					$(c).show();
				}
				var id = $(c).attr("id");
				toggleChild(id, type);
			});
		};
	</script>
</head>
<body>
	<div class="panel">
		<div class="panel-body">
			<div class="panel-data">
				<c:set var="checkAll">
					<input type="checkbox" id="chkall" />
				</c:set>
				<table id="sysPosTable" class="table-grid table-list" id="0"
					cellpadding="1" cellspacing="1">
					<thead>
						<th width="30px"><input type="checkbox" id="chkall"></th>
						<th>岗位名称</th>
						<th>岗位描述</th>
					</thead>
					<tbody>
						<c:forEach items="${positionList}" var="positionItem">
							<tr id="${positionItem.posId }" parentId="${positionItem.parentId }"
								class="${status.index%2==0?'odd':'even'}">
								<td>
									<input type="checkbox" class="pk" name="posId" value="${positionItem.posId }">
									<input type="hidden" name="posName" value="${positionItem.posName }">
								</td>

								<td nowrap="nowrap">${f:returnSpace(positionItem.nodePath)}
									<a name="tree_a" class="tree-list-minus" onclick="treeClick(this)">
									<span class="tree-list-span">${positionItem.posName }</span></a>
								</td>

								<td>${positionItem.posDesc }</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</body>
</html>