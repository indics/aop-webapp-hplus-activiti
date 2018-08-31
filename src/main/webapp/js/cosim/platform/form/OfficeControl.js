/**
 * office控件。
 * 使用方法：
 * var obj=new OfficeControl();
 * obj.renderTo("divContainer",{fileId:123});
 * 	divContainer： 文档容器id
 * 	fileId：附件id，如果指定那么根据该文件id加载word文档。
 *  
 *  saveRemote:保存文档到服务器
 *  
 * @returns {OfficeControl}
 */
OfficeControl=function(){
	{
		this.controlId="";
		this.controlObj=null;
		this.height="100%";
		this.width="100%";
		var _self=this;
		this.isFileOpen=false;
		this.templatetype = 1;// 模板类型
		
		this.params={Caption:"广州宏天软件有限公司",MakerCaption:"广州宏天软件有限公司",
				MakerKey:"CF4960BFDB79D36ADDC5493B116D39D6A4E335D9",
				ProductCaption:"天智网",
				ProductKey:"6FFE41262266E5CEFD207A8321AC0B398A5B772B",
				TitlebarColor:"14402205"
			};
		this.config={doctype:'doc',fileId:"",controlId:"officeObj"};
		
	};
	/**
	 * 处理文件菜单事件。
	 */
	this.itemclick=function(item){
		var txt=item.text;
		switch(txt){
			case "新建":
				_self.newDoc();
				break;
			case "打开":
				_self.controlObj.showDialog(1);
				break;
			case "另存为":
				if(!_self.isFileOpen) return;
				_self.controlObj.showDialog(3);
				break;
			case "关闭":
				if(!_self.isFileOpen) return;
				_self.closeDoc();
				break;
			case "打印设置":
				if(!_self.isFileOpen) return;
				_self.controlObj.showdialog(5);
				break;
			case "打印预览":
				if(!_self.isFileOpen) return;
				_self.controlObj.PrintPreview();
				break;
			case "打印":
				if(!_self.isFileOpen) return;
				_self.controlObj.printout(true);
				break;
		}
		
	},
	/**
	 * 获取文档类型。
	 */
	this.getDocType=function(){
		var docType="Word.Document";
		var type=this.config.doctype;
		switch(type){
			case "doc":
				docType="Word.Document";
				break;
			case "xls":
				docType="Excel.Sheet";
				break;
			case "ppt":
				docType="PowerPoint.Show";
				break;
		}
		return docType;
	},
	//click事件需要事先进行定义。
	this.memuItems= { width: 120, items:
        [{text: '新建', click: this.itemclick },
         {text: '打开', click: this.itemclick },
         {text: '另存为', click: this.itemclick },
         {text: '关闭', click: this.itemclick },
         {line: true },
         {text: '打印设置', click: this.itemclick },
         {text: '打印预览', click: this.itemclick },
         {text: '打印', click: this.itemclick }]
     };
	/**
	 * 处理菜单点击事件。
	 */
	this.buttonClick=function(item){
	
		var txt=item.text;
		switch(txt){
			case "留痕":
				_self.controlObj.ActiveDocument.TrackRevisions=true;
				break;
			case "不留痕":
				_self.controlObj.ActiveDocument.TrackRevisions=false;
				break;
			case "清除痕迹":
				_self.controlObj.ActiveDocument.AcceptAllRevisions();
				break;
			case "模版套红":
				_self.insertContentTemplate();
				break;
			case "选择模版":
				_self.insertTemplate();
				break;
			case "手写签名":
				try{
					_self.controlObj.DoHandSign2(
							"ntko",//手写签名用户名称
							"ntko",//signkey,DoCheckSign(检查印章函数)需要的验证密钥。
							0,//left
							0,//top
							1,//relative,设定签名位置的参照对象.0：表示按照屏幕位置插入，此时，Left,Top属性不起作用。1：光标位置；2：页边距；3：页面距离 4：默认设置栏，段落（为兼容以前版本默认方式）
							100);
				}catch(err){
				}
				break;
			case "盖章":
				_self.signature();
				break;
			case "全屏":
				_self.controlObj.FullScreenMode=true;
				break;
		}
	},
	/**
	 * 获取模版
	 */
	this.getTemplate=function(){
		var url=__ctx +"/platform/system/sysOfficeTemplate/dialog.ht?type="+this.templatetype;
		var winArgs="dialogWidth=600px;dialogHeight=400px;help=0;status=0;scroll=1;center=1";
		url=url.getNewUrl();
		var rtn=window.showModalDialog(url,"",winArgs);
		return rtn;
	},
	/**
	 * 模版套红。
	 */
	this.insertContentTemplate=function(){
		try{
			this.templatetype = 2;
			var rtn=_self.getTemplate();
			this.templatetype = 1;
			if(rtn==undefined || rtn==null ){
				
				return;
			}
			var templateUrl=__ctx +"/" + rtn.path;
			//选择对象当前文档的所有内容
			var curSel = _self.controlObj.ActiveDocument.Application.Selection;
			curSel.WholeStory();
			curSel.Cut();
			//插入模板
			_self.controlObj.AddTemplateFromURL(templateUrl);
			var BookMarkName = "content";
			if(!_self.controlObj.ActiveDocument.BookMarks.Exists(BookMarkName)){
				alert("Word 模板中不存在名称为：\""+BookMarkName+"\"的书签！");
				return;
			}
			var bkmkObj = _self.controlObj.ActiveDocument.BookMarks(BookMarkName);	
			var saverange = bkmkObj.Range;
			saverange.Paste();
			_self.controlObj.ActiveDocument.Bookmarks.Add(BookMarkName,saverange);		
			
		}catch(err){
			$.ligerDialog.error("insertTemplate:" +err.name + ": " + err.message);
		}
	},
	/**
	 * 插入word模版。
	 */
	this.insertTemplate=function(){
		try{
			var rtn=_self.getTemplate();
			if(rtn==undefined || rtn==null ){
				
				return;
			}
			var headFileURL=__ctx +"/" + rtn.path;
			_self.controlObj.ActiveDocument.Application.Selection.HomeKey(6,0);//光标移动到文档开头
			_self.controlObj.OpenFromURL(headFileURL);//在光标位置插入红头文档
		}catch(err){
			$.ligerDialog.error("insertTemplate:" +err.name + ": " + err.message);
		}
	},
		
	/**
	 * 获取控件的html。
	 */
	this.getControlHtml=function(controlId){
			var cabPath=__ctx +"/media/office/OfficeControl.cab#version=5,0,2,1";
			var str='<object  id="'+controlId+'" codeBase="'+cabPath+'" '+
			'height="'+this.height+'" width="'+this.width+'" classid="clsid:A39F1330-3322-4a1d-9BF0-0BA2BB90E970" style="z-index:-1;">';
			for(var key in this.params){
				str+='<param name="'+key+'" value="'+this.params[key]+'">';
			}
            str+="</object>";
            return str;
	},
	/**
	 * 将控件添加到div容器中。
	 * 第一个参数：
	 * div的容器ID
	 * 第二个参数:
	 * conf:
	 * doctype:文挡类型：可以为doc，xls，ppt
	 * fileId:服务器保存的文件ID
	 */
	this.renderTo=function(divContainerId,conf){
		this.config=$.extend({},this.config,conf);
		
		
		this.controlId="office_" + divContainerId;
		var html=this.getControlHtml(this.controlId);
		$("#" +divContainerId).html("");
		$("#" +divContainerId).append('<div name="menuBar"></div>');
		$("#" +divContainerId).append(html);
		
		var obj=document.getElementById(this.controlId);
		
		this.controlObj=obj;
		this.controlObj.MenuBar=false;
		this.controlObj.Titlebar=false;
		this.controlObj.IsShowToolMenu=true;
		this.controlObj.ToolBars=true;
		var jqControlObj=$(this.controlObj);
		//修改控件的高度。
		jqControlObj.height(jqControlObj.parent().height()-26);
		
		var docType=this.config.doctype;
	
		var items=[];
		 items.push({ text: '文件', menu: this.memuItems});
		 if(docType=="doc"){
			 items.push({ text: '留痕',click:this.buttonClick });
			 items.push({ text: '不留痕' ,click:this.buttonClick});
			 items.push( { text: '清除痕迹' ,click:this.buttonClick});
			 items.push( { text: '模版套红' ,click:this.buttonClick});
		 }
		 items.push({ text: '选择模版' ,click:this.buttonClick});
		 items.push({ text: '手写签名' ,click:this.buttonClick});
		 items.push({ text: '盖章' ,click:this.buttonClick});
		 items.push({ text: '全屏' ,click:this.buttonClick});
		 $("#" +divContainerId +" div[name='menuBar']").ligerMenuBar({ items:items});
		 
		 if($.browser.msie){
			 this.initDoc();
		 }
		 else{
			 $.ligerDialog.warn('office控件只支持IE 32位版的浏览器!');
		 }
	
	},
	/**
	 * 控件载入时，载入文档。
	 */
	this.initDoc=function(){
		//指定了文件。
		if(this.config.fileId!="" && this.config.fileId>0){
			var path= __ctx + "/platform/system/sysFile/getFileById.ht?fileId=" + this.config.fileId;
			try{
				
		//		alert(path);
			//	var path="http://60.195.252.24:8080/tianzhi/12.doc";
				this.controlObj.OpenFromURL(path);
				this.isFileOpen=true;
			}
			catch(err){
				this.newDoc();
			}
		}
		//新建文档。
		else{
			this.newDoc();
		}
	},
	/**
	 * 关闭文档。
	 */
	this.closeDoc=function(){
		if($.browser.msie){
			 this.initDoc();
		}
		else{
			 $.ligerDialog.warn('office控件只支持IE 32位版的浏览器!');
		}
		try{
			this.controlObj.close();
			this.isFileOpen=false;
		}catch(err){
			
			$.ligerDialog.error('closeDoc:' +err.name + ": " + err.message);
		}
	},
	/**
	 * 新建文档。
	 */
	this.newDoc=function(){
		try
		{
			var docType=this.getDocType();
			this.controlObj.CreateNew(docType);
			this.isFileOpen=true;
		}
		catch(err){
			$.ligerDialog.error("newDoc:" +err.name + ": " + err.message);
		}
	},
	/**
	 * 保存文件到服务器。
	 * 服务器返回文件id到this.config.fileId，同时返回文件ID。
	 */
	this.saveRemote=function(){
		var path= __ctx + "/platform/system/sysFile/saveFile.ht";
		var params="fileId=" + this.config.fileId;
		try{
			//保存数据到服务器。
			var curDate=new Date();
			var docName=Math.random()*curDate.getMilliseconds()*10000;
			var result=this.controlObj.SaveToURL(path,"EDITFILE",params,docName+"." + this.config.doctype,0);
			this.config.fileId=result;
			return result;
		}
		catch(err){
			alert("saveRemote:" +err.name + ": " + err.message);
			return -1;
		}
	};
	
	/**
	 * 对文档进行签单
	 */
	this.signature=function(){
		
		var url = __ctx + "/platform/system/seal/dialog.ht";
		var winArgs = "dialogWidth=800px;dialogHeight=600px;help=0;status=0;scroll=1;center=0;resizable=1;";
		url = url.getNewUrl();
		var retVal = window.showModalDialog(url, "", winArgs);
		if(typeof(retVal)==undefined){
			return false;
		}
		if(retVal.fileId.isEmpty()){
			return false;
		}
		var sealUrl=__ctx + "/platform/system/sysFile/getFileById.ht?fileId=" + retVal.fileId;
		try{
//			this.controlObj.AddSignFromURL(retVal.userName,sealUrl);
			this.controlObj.AddSecSignFromURL(retVal.userName,//印章的用户名
					sealUrl,//印章所在服务器相对url
					0,//left
					0,//top
					1,//relative
					2,  //print mode 2
					false,//是是否使用证书，true或者false，
					1);
		}catch(err){
			alert("signature:" +err.name + ": " + err.message);
			return -1;
		}
	};


};