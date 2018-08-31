/**
 * 子表的权限处理
 * @returns {SubtablePermission}
 */
if (typeof SubtablePermission == 'undefined') {
	SubtablePermission = {};
}

SubtablePermission.init=function(){
	$("[type='subtable']").each(function(){
		var subTable=$(this),
			right=subTable.attr("right");
		if(!right)right="r";
		else
			right=right.toLowerCase();
		//非写权限
		if(right!="w"){
			$("a.add,a.link",subTable).remove();			
			$("input:visible,textarea:visible,select:visible",subTable).each(function(){
				var me=$(this),
					val=me.val();
				me.before(val);
				me.remove();
			});
		}
	});	
};