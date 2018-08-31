/**
 * 功能:选择表话框
 * 
 */
function FormTableDialog(callBack)
{
	var url=__ctx + '/platform/form/bpmFormTable/selector.ht';
	var winArgs="dialogWidth:800px;dialogHeight:500px;help:0;status:1;scroll:1;center:1;resizable:1";
	url=url.getNewUrl();
	var rtn= window.showModalDialog(url,"",winArgs);
	if(rtn!=undefined){
		callBack.call(this,rtn.tableId,rtn.tableName);
	}
}