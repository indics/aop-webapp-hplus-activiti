$(function(){
	jQuery.highlightTableRows();

	jQuery.selectTr();

	handlerSearch();

	handlerCheckAll();

	//handlerDelOne
	handlerDelOne();

	//处理更新
	handlerUpd();
	
	// 批量选择处理
	handlerSelect();

	//新加函数
	handlerUpdate();

	handlerDelSelect();

	//导出所有
	exportCheckAll();

	//初始化信息
	handlerInit();
});

/**
 * 导出选择时，更改导出链接url中的导出来全部项的参数.
 * 后台没处理导出全部的处理
 **/
function exportAllCheckChange(obj){
	var spanDiv=document.getElementById("divExportAll");
	if(spanDiv!=null){
		var childs=spanDiv.childNodes;
		for(var i=0;i<childs.length;i++){
			if(childs[i]!=null&&childs[i].tagName=="A"){
				var url=childs[i].href;
				if(obj.checked){
					if(url.indexOf("?")!=-1){
						url+="&";
					}else{
						url+="?";
					}
					childs[i].href=url+"exportAll=1";
				}else{
					childs[i].href=childs[i].href.replace("&exportAll=1","").replace("?exportAll=1").replace("exportAll=1");
				}
			}
		}
	}
}

function exportCheckAll()
{
	$(".expCheckAll").bind("click",function(event){
		
		var checked=event.target.checked;
		$(".expCheckAll ~ a").each(function(){
			var url=$(this).attr('href');
			if(checked){
				if(url.indexOf("?")!=-1){
					url+="&";
				}else{
					url+="?";
				}
				$(this).attr('href',url+"exportAll=1");
			}else{
				url=url.replace("&exportAll=1","").replace("?exportAll=1").replace("exportAll=1");
				$(this).attr('href',url);
			}
		});
	});
	//event.target.tagName
}

function handlerCheckAll(){
	$("#chkall").click(function(){
		var state=$(this).attr("checked");
		if(state==undefined)
			checkAll(false);
		else
			checkAll(true);
	});
}



function checkAll(checked){
	$("input[type='checkbox'][class='pk']").each(function(){
		$(this).attr("checked", checked);
	});
}



//查询
function handlerSearch()
{
	$("a.link.search").click(function(){
		if(!$(this).hasClass('disabled')) {
			$("#searchForm").submit();
		}
	});
}

//处理删除一行
function handlerDelOne()
{
	$("table.table-grid td a.link.del").click(function(){
		if($(this).hasClass('disabled')) return false;
		
		var ele = this;
		$.ligerMessageBox.confirm('提示信息','确认删除吗？',function(rtn) {
			if(rtn) {
				if(ele.click) {
					$(ele).unbind('click');
					ele.click();
				} else {
					location.href=ele.href;
				}
			}
		});
		
		return false;
	});
}

//处理初始化模板
function handlerInit()
{
	$("a.link.init").click(function(){
		var action=$(this).attr("action");
		if($(this).hasClass('disabled')) return false;
		
		$.ligerMessageBox.confirm('提示信息','初始化表单模板将会导致自定义模板信息丢失，确定初始化吗？',function(rtn){
			if(rtn){
				var form=new com.cosim.form.Form();
				form.creatForm('form', action);
				form.submit();
			}
		});
		
	});
}

//更新
function handlerSelect(){
	//单击删除超链接的事件处理
	$("div.group > a.link.select").click(function(){
		if($(this).hasClass('disabled')) return false;
		var action=$(this).attr("action");
		var $aryId = $("input[type='checkbox'][disabled!='disabled'][class='pk']:checked");
		if($aryId.length == 0){
			layer.msg('请至少选择一条记录!',{icon: 6, time:2000});
			return false;
		}
		//提交到后台服务器进行日志删除批处理的日志编号字符串
		var delId="";
		var keyName="";
		var len=$aryId.length;
		$aryId.each(function(i){
			var obj=$(this);
			if(i<len-1){
				delId+=obj.val() +",";
			}
			else{
				keyName=obj.attr("name");
				delId+=obj.val();
			}
		});
		var url=action +"?" +keyName +"=" +delId ;
		// 提交数据
		layer.confirm('确定要提交操作吗？', {
				btn: ['确定','取消'] //按钮
			}, function(index){
				//打酱油
				layer.msg('正在提交数据...', {icon: 4});
				var form=new com.cosim.form.Form();
				form.creatForm("form", action);
				form.addFormEl(keyName, delId);
				form.submit();
			}, function(){
				
			}
		);
		return false;
	});
}


//更新
function handlerUpd(){
	$("div.group > a.link.update").click(function() {
		if($(this).hasClass('disabled')) return false;
		
		var action=$(this).attr("action");
		var aryId = $("input[type='checkbox'][disabled!='disabled'][class='pk']:checked");
		var len=aryId.length;
		if(len==0){
			$.ligerMessageBox.warn("提示信息","还没有选择,请选择一项进行编辑!");
			return false;
		}
		else if(len>1){
			$.ligerMessageBox.warn("提示信息","已经选择了多项,请选择一项进行编辑!");
			return false;
		}
		var name=aryId.attr("name");
		var value=aryId.val();
		var form=new com.cosim.form.Form();
		form.creatForm("form", action);
		form.addFormEl(name, value);
		form.submit();
		
	});
}


//更新
function handlerUpdate(){
	$("div.group > a.link.updateNew").click(function() {
		if($(this).hasClass('disabled')) return false;
		
		var action=$(this).attr("action");
		var $aryId = $("input[type='checkbox'][disabled!='disabled'][class='pk']:checked");
		var len=$aryId.length;
		if(len == 0){
			$.ligerMessageBox.warn("请选择记录！");
			return false;
		}
		var delId="";
		var keyName="";
		$aryId.each(function(i){
			var obj=$(this);
			if(i<len-1){
				delId+=obj.val() +",";
			}
			else{
				keyName=obj.attr("name");
				delId+=obj.val();
			}
		});
		
		var url=action +"?" +keyName +"=" +delId ;
		var form=new com.cosim.form.Form();
		form.creatForm("form", action);
		form.addFormEl(keyName, delId);
		form.submit();
	});
}

function handlerDelSelect()
{
	//单击删除超链接的事件处理
	$("div.group > a.link.del").click(function()
	{	
		if($(this).hasClass('disabled')) return false;
		
		var action=$(this).attr("action");
		var $aryId = $("input[type='checkbox'][disabled!='disabled'][class='pk']:checked");
		
		if($aryId.length == 0){
			$.ligerMessageBox.warn("请选择记录！");
			return false;
		}
		
		//提交到后台服务器进行日志删除批处理的日志编号字符串
		var delId="";
		var keyName="";
		var len=$aryId.length;
		$aryId.each(function(i){
			var obj=$(this);
			if(i<len-1){
				delId+=obj.val() +",";
			}
			else{
				keyName=obj.attr("name");
				delId+=obj.val();
			}
		});
		var url=action +"?" +keyName +"=" +delId ;
		
		$.ligerMessageBox.confirm('提示信息','确认删除吗？',function(rtn) {
			if(rtn) {
				var form=new com.cosim.form.Form();
				form.creatForm("form", action);
				form.addFormEl(keyName, delId);
				form.submit();
			}
		});
		return false;
	
		
	});
	
	//单击删除超链接的事件处理
	$("div.group > a.link.dep").click(function()
	{	
		if($(this).hasClass('disabled')) return false;
		
		var action=$(this).attr("action");
		var $aryId = $("input[type='checkbox'][disabled!='disabled'][class='pk']:checked");
		
		if($aryId.length == 0){
			$.ligerMessageBox.warn("请选择记录！");
			return false;
		}
		
		//提交到后台服务器进行日志删除批处理的日志编号字符串
		var delId="";
		var keyName="";
		var len=$aryId.length;
		$aryId.each(function(i){
			var obj=$(this);
			if(i<len-1){
				delId+=obj.val() +",";
			}
			else{
				keyName=obj.attr("name");
				delId+=obj.val();
			}
		});
		var url=action +"?" +keyName +"=" +delId ;
		
		$.ligerMessageBox.confirm('提示信息','确定执行此操作吗？',function(rtn) {
			if(rtn) {
				var form=new com.cosim.form.Form();
				form.creatForm("form", action);
				form.addFormEl(keyName, delId);
				form.submit();
			}
		});
		return false;
	
		
	});
}

function goPage(n,tableIdCode){
	var url = replacecurrentPage($("#_nav"+tableIdCode).attr('href'),n,tableIdCode);
	url = replagePageSize(url,$("#oldPageSize"+tableIdCode).val(),tableIdCode);
	location.href=replageOldPageSize(url,$("#oldPageSize"+tableIdCode).val(),tableIdCode);
}

function first(tableIdCode){
	goPage(1,tableIdCode);
}

function last(tableIdCode){
	var lastPage=$("#totalPage"+tableIdCode).val();
	goPage(lastPage,tableIdCode);
}

function previous(tableIdCode){
	var currentPage=parseInt($("#currentPage"+tableIdCode).val());
	currentPage-=1;
	if(currentPage<1)currentPage=1;
	goPage(currentPage,tableIdCode);
}

function next(tableIdCode){
	var currentPage=parseInt($("#currentPage"+tableIdCode).val());
	var totalPage=parseInt($("#totalPage"+tableIdCode).val());
	currentPage+=1;
	if(currentPage>totalPage)currentPage=totalPage;
	goPage(currentPage,tableIdCode);
}

function changePageSize(sel,tableIdCode){
	var url = replagePageSize($("#_nav"+tableIdCode).attr('href'),sel.value,tableIdCode);
	url = replacecurrentPage(url,$("#currentPage"+tableIdCode).val(),tableIdCode);
	location.href=replageOldPageSize(url,$("#oldPageSize"+tableIdCode).val(),tableIdCode);
}
/**
 * 跳转至第n页
 */
function jumpTo(tableIdCode){
	var currentPage=$("#navNum"+tableIdCode).val();
	var str=/^[1-9]\d*$/;
	if(str.test(currentPage)){
		goPage(currentPage,tableIdCode);
	}else{
		alert("非法的页码!");
		$("#navNum"+tableIdCode).focus();
	}
}

//http://localhost:8080/eShop/hello.do?age=3&currentPage=5&fullname=mansan;

/**
 * 替换url中的page参数，用于数据分页显示
 */
function replacecurrentPage(url,currentPage,tableIdCode){
	//把锚点标记先移除出来
	var index=url.indexOf("#");
	if(index!=-1){
		url=url.substring(0,index);
	}
	var pageParam=tableIdCode+'p';
	//查询的页码需要替换
	var reg=new RegExp(pageParam + '=\\d*');
	if(reg.test(url)){
		url=url.replace(reg,pageParam+'='+currentPage);
	}else if(url.indexOf('?')!=-1){
		url+='&'+pageParam+'='+currentPage;
	}else{
		url+='?'+pageParam+'='+currentPage;
	}
	return url;
}




function replagePageSize(url,pageSize,tableIdCode){
	var pageParam=tableIdCode+'z';
	var reg=new RegExp(pageParam + '=\\d*');
	if(reg.test(url)){
		url=url.replace(reg,pageParam+'='+pageSize);
	}else if(url.indexOf('?')!=-1){
		url+='&'+pageParam+'='+pageSize;
	}else{
		url+='?'+pageParam+'='+pageSize;
	}
	return url;
}


function replageOldPageSize(url,pageSize,tableIdCode){
	var pageParam=tableIdCode+'oz';
	var reg=new RegExp(pageParam + '=\\d*');
	if(reg.test(url)){
		url=url.replace(reg,pageParam+'='+pageSize);
	}else if(url.indexOf('?')!=-1){
		url+='&'+pageParam+'='+pageSize;
	}else{
		url+='?'+pageParam+'='+pageSize;
	}
	return url;
}