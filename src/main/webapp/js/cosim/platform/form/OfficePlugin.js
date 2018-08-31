/**
 * Office插件，用于自定义表单。
 * 
 * 1.OfficePlugin.init();
 *  	加载office控件。
 * 
 * 2.OfficePlugin.submit();
 * 		保存office文档。
 */
OfficePlugin={
		//office控件对象
		officeObj:null,
		//附件对象
		fileObj:null,
		//判断当前表单页面是否有office控件。
		hasOfficeField:false,
		//初始化
		//所做的操作如下：
		//1.检查当前表单中是否有office控件。
		//2.如果存在office控件
		// 	获取文件id，将office控件添加到容器中。
		init:function(){
			
			this.fileObj=$("input[controltype='office']");
			if(this.fileObj.length>0){
				
				var name=this.fileObj.attr("name");
				var fileId=this.fileObj.val();
				//容器的ID
				var divId="div_" + name.replaceAll(":","_");
				
				var right=this.fileObj.attr("right");
				//没有权限，删除div容器。
				if(right=="no"){
					$("#" + divId).remove();
				}
				//有读和写的权限，加载控件。
				else{
					$.ligerDialog.waitting('正在加载OFFICE文档,请稍候...');
					 
					//加载控件。
					this.officeObj= new OfficeControl();
					//加载office控件。
					this.officeObj.renderTo(divId,{fileId:fileId});
					
					$.ligerDialog.closeWaitting(); 
					//是否有office控件。
					this.hasOfficeField=true;
				}
			}
		},
		//提交文件保存。
		//如果有office控件。则保存后将返回的附件id放到隐藏域。
		submit:function(){
			if(!this.hasOfficeField) return;
			var right=this.fileObj.attr("right");
			//可写，保存office内容并上传。
			if(right=="w"){
				//保存到服务器。
				var result=this.officeObj.saveRemote();
				//将结果放到隐藏域。
				this.fileObj.val(result);
			}
		}
};
