var subTree,subHeight;

$(function() {
		// 布局
		$("#layout").ligerLayout({
					leftWidth : 250,
					height : '100%',
					allowLeftResize : false
				});
		subHeight = $('#subTree').height();
		// 流程变量树
		subTree = new SubRightsTree("subTree", {
					url : __ctx + '/platform/form/bpmFormTable/getSubTree.ht',
					params : {
						tableId:tableId,
						onClick: onClick,
						onDbClick: onDbClick	
					}
				});
		subTree.loadTree();
		$("#subTree").height(subHeight - 95);
});	

/**
 * 单击节点
 */
function onClick(treeId,treeNode) {
	
	if(typeof(treeId)=="undefined")
		return ;

	if (treeNode.level == 0) {
		
		$('#subName').text(treeNode.name);
		$('#tableid').val(treeNode.id);
		
		$.ajax({
			type : "POST",
			url : __ctx + "/platform/bpm/BpmSubtableRights/get.ht",
		    data: {actdefid:$('#actdefid').val(), nodeid:$('#nodeid').val(), tableid:treeNode.id},
			success : function(res) {
				var result = eval('('+res+')');
				var id = typeof(result.permissiontype)!="undefined"?result.id:'0';
				$('#rightid').val(id);
				if(typeof(result.permissiontype)!="undefined"){
					$('input:[name=permissiontype]')[result.permissiontype].click(result.permissiontype);
					if(result.permissiontype==2){
						InitMirror.editor.setCode(result.permissionseting.replaceAll('<br>','\n').replaceAll('<032>','\"'));
					}
				}
			},
			error : function(res) {
				
			}
		});
	}
}
	
/**
 * 双击节点
 */
function onDbClick(treeId,treeNode) {
	
	if(typeof(treeId)=="undefined")
		return ;

	if (treeNode.level != 0) 
	{
		if($('#subName').text()==treeNode.getParentNode().name)
		{
			InitMirror.editor.insertCode(treeNode.name);
		}
		else
		{
			$.ligerMessageBox.warn('提示信息','选取的子表字段不属于当前操作子表');
		}
	}
}