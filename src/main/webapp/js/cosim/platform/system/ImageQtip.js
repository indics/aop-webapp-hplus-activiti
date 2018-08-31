if(typeof ImageQtip == "undefined"){
	ImageQtip = {};
}

//预加载图片
ImageQtip.drawImg = function(tag,src,options,callback){
	var image = new Image();
	image.src = src;
	image.alt="未能成功加载图片，可能已被删除...";		
	if (image.complete) {
		ImageQtip.resizeImg(image,options);
		if(callback)
			callback(tag,image,options);
		else
			ImageQtip.initqTip(tag,image,options);
         return; 
    }
	image.onload = function () {
		ImageQtip.resizeImg(image,options);
		if(callback)
			callback(tag,image,options);
		else
			ImageQtip.initqTip(tag,image,options);
    };
};

//等比例调整图像尺寸
ImageQtip.resizeImg = function(image,options){
	if (image.width > 0 && image.height > 0) {
		 if(options.maxWidth>0){
			 if(image.width>options.maxWidth){
				 image.height=options.maxWidth*image.height/image.width;
				 image.width=options.maxWidth;					 
			 }
		 }
		 if(options.maxHeight>0){
			 if(image.height>options.maxHeight){
				 image.width=options.maxHeight*image.width/image.height;
				 image.height=options.maxHeight;
			 }
		 }
	}		
};

//初始化qTip2
ImageQtip.initqTip = function (tag,image,options){	
	var html=image.outerHTML;		
	$(tag).qtip({
		content : {
			text : html,
			title : {
				text : '附件预览'
			}
		},
		position : {
			at : 'center',
			target : 'event',
			viewport : $(window)
		},
		show : {
			effect : function(offset) {
				$(this).slideDown(200);
			}
		},
		hide : {
			event : 'mouseleave',
			fixed : true
		},
		style : {
			classes : 'ui-tooltip-light ui-tooltip-shadow'
		}
	});
};