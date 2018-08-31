$(function(){
	$("a.link.search.ajax").unbind("click");
});
//处理删除一行
function goPageAjax(obj,n,tableIdCode){
	var url = $("#_nav"+tableIdCode).attr('href');
	url = replacecurrentPage(url,n,tableIdCode);
	//在page.ftl中，$("#oldPageSize"+tableIdCode)的值被设为当前的分页大小
	url = replagePageSize(url,$("#oldPageSize"+tableIdCode).val(),tableIdCode);
	url = replageOldPageSize(url,$("#oldPageSize"+tableIdCode).val(),tableIdCode);
	updateAjax(obj,url);
}

function firstAjax(obj,tableIdCode){
	goPageAjax(obj,1,tableIdCode);
}

function lastAjax(obj,tableIdCode){
	var lastPage=$("#totalPage"+tableIdCode).val();
	goPageAjax(obj,lastPage,tableIdCode);
}

function previousAjax(obj,tableIdCode){
	var currentPage=parseInt($("#currentPage"+tableIdCode).val());
	currentPage-=1;
	if(currentPage<1)currentPage=1;
	goPageAjax(obj,currentPage,tableIdCode);
}

function nextAjax(obj,tableIdCode){
	var currentPage=parseInt($("#currentPage"+tableIdCode).val());
	var totalPage=parseInt($("#totalPage"+tableIdCode).val());
	currentPage+=1;
	if(currentPage>totalPage)currentPage=totalPage;
	goPageAjax(obj,currentPage,tableIdCode);
}

function changePageSizeAjax(obj,tableIdCode){
	var url=$("#_nav"+tableIdCode).attr('href');
	url = replagePageSize(url,obj.value,tableIdCode);
	url = replacecurrentPage(url,$("#currentPage"+tableIdCode).val(),tableIdCode);
	var container = $(obj).closest("div[ajax='ajax']");
	updateAjax(obj,url);
}
/**
 * 跳转至第n页
 */
function jumpToAjax(obj,tableIdCode){
	var currentPage=$("#navNum"+tableIdCode).val();
	var str=/^[1-9]\d*$/;
	if(str.test(currentPage)){
		goPageAjax(obj,currentPage,tableIdCode);
	}else{
		alert("非法的页码!");
		$("#navNum"+tableIdCode).focus();
	}
}


function refreshAjax(obj,url){
	//把锚点标记先移除出来
	var index=url.indexOf("#");
	if(index!=-1){
		url=url.substring(0,index);
	}
	updateAjax(obj,url);
}

//组件中的点击事件
function linkAjax(obj){
	var $obj = $(obj);
	var url=$obj.attr("action");
	updateAjax(obj,url);
}

function handlerSearchAjax(obj){
	var form = $(obj).closest("div.panel-top").find("form[name='searchForm']");
	var href=form.attr("action");
	var params = serializeObject(form);
	updateAjax(obj,href,params);
}


function updateAjax(obj,url,params){
	//自定义显示的最外层Div
	var container = $(obj).closest("div[ajax='ajax']");
	//自定义显示组件的ID
	var displayId=container.attr("displayId");
	//约定Response中的html为返回的Html，用于更新
	if(!params){
		params={};
	}
	params.__displayId=displayId;
	//提交到后台，取得自更新后的Html元素，并替换掉之前的html元素
	$.post(url,params,function(data){
		container.replaceWith(data.html);
	});
}

function serializeObject(form){
	var o = {};
	var a = $(form).serializeArray();
	$.each(a, function() {
	    if (o[this.name]) {
	        if (!o[this.name].push) {
	            o[this.name] = [o[this.name]];
	        }
	        o[this.name].push(this.value || '');
	    } else {
	        o[this.name] = this.value || '';
	    }
	});
	return o;
}

function openLinkDialog(obj,width,height){
	width=width||"800";
	height=height||"600";
	var winArgs="dialogWidth="+width+"px;dialogHeight="+height+"px;help=0;status=0;scroll=0;center=1";
	var url=$(obj).attr("action");
	url=url.getNewUrl();
	window.showModalDialog(url,{},winArgs);
}


function datePicker(obj,type){
	if('yyyy-MM-dd'==type){
		WdatePicker({dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true});
	}else{
		WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true});
	}
	$(obj).blur();
}


function linkSortAjax(obj,tableIdCode){
	var $obj = $(obj);
	var url=$obj.attr("action");
	var sortField=$obj.attr("sort");
	var orderSeq="DESC";
	var curSortField=$("#sortField"+tableIdCode).val();
	var curOrderSeq=$("#orderSeq"+tableIdCode).val();
	
	if(sortField==curSortField){
		if(curOrderSeq=="DESC"){
			orderSeq="ASC";
		}
	}
	
	url = replaceOrderSeq(url,orderSeq,tableIdCode);
	url = replaceSortField(url,sortField,tableIdCode);

	updateAjax(obj,url);
}



/**
 * 替换url中的sortField参数，用于排序显示
 */
function replaceSortField(url,sortField,tableIdCode){
	//把锚点标记先移除出来
	var index=url.indexOf("#");
	if(index!=-1){
		url=url.substring(0,index);
	}
	var sortFieldParam=tableIdCode+'s';
	//查询的页码需要替换
	var reg=new RegExp(sortFieldParam + '=\\w*');
	if(reg.test(url)){
		url=url.replace(reg,sortFieldParam+'='+sortField);
	}else if(url.indexOf('?')!=-1){
		url+='&'+sortFieldParam+'='+sortField;
	}else{
		url+='?'+sortFieldParam+'='+sortField;
	}
	return url;
}

/**
 * 替换url中的orderSeq参数，用于排序显示
 */
function replaceOrderSeq(url,orderSeq,tableIdCode){
	//把锚点标记先移除出来
	var index=url.indexOf("#");
	if(index!=-1){
		url=url.substring(0,index);
	}
	var orderSeqParam=tableIdCode+'o';
	//查询的页码需要替换
	var reg=new RegExp(orderSeqParam + '=\\w*');
	if(reg.test(url)){
		url=url.replace(reg,orderSeqParam+'='+orderSeq);
	}else if(url.indexOf('?')!=-1){
		url+='&'+orderSeqParam+'='+orderSeq;
	}else{
		url+='?'+orderSeqParam+'='+orderSeq;
	}
	return url;
}
