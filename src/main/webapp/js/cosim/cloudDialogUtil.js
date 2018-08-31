(function($){
	$.cloudDialog={
		imageDialog:function(conf){
			var defaults = {    
				title:"图片上传",
			    type: 2,
			    area: ['500px', '500px'],
			    fix: false, //不固定
			    maxmin: false,
			    isSingle:false,
			    widths:'400',
			    _callback:"",//默认调用父页面的imageDialogCallback(jsonArr)函数
			    content: [conf.contextPath+'/cloud/pub/image/toCloudUpload.ht','no']   
			}; 
			var opts = $.extend(defaults, conf);
			if(opts.isSingle){
				var url = opts.content[0];
				if(url.indexOf("?")>0){
					opts.content[0] = url+"&isSingle=true";
				}else{
					opts.content[0] = url+"?isSingle=true";
				}
			}
			if(opts._callback.length>0){
				var url = opts.content[0];
				if(url.indexOf("?")>0){
					opts.content[0] = url+"&_callback="+opts._callback;
				}else{
					opts.content[0] = url+"?_callback="+opts._callback;
				}
			}
			if(opts.widths.length>0){
				var url = opts.content[0];
				if(url.indexOf("?")>0){
					opts.content[0] = url+"&widths="+opts.widths;
				}else{
					opts.content[0] = url+"?widths="+opts.widths;
				}
			}
			layer.open(opts);
		}	
	}
})(jQuery);