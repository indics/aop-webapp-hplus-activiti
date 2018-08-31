(function ($) {
	$.extend($.fn, {
		//获取复选框的值。
		getCheckBoxValue:function(objJson,scope){
			$(':checkbox,:radio',scope).each(function(){
				var name=$(this).attr('name');
				objJson[name]='';
			});
		
			$(':checkbox:checked,:radio:checked',scope).each(function(){
					var name=$(this).attr('name');
					if(objJson[name]==''){
						objJson[name]=$(this).val();
					}
					else{
						objJson[name]+="," + $(this).val();
					}
			});
		},
		
		//获取复选框的值,获取整行的值。
		getCheckBoxValues:function(objJson,scope){
			$(':checkbox,:radio',scope).each(function(){
				var name=$(this).attr('name');
				objJson[name]='';
			});
		
			$(':checkbox:checked,:radio:checked',scope).each(function(){
					var name=$(this).attr('name');
					if(objJson[name]==''){
						objJson[name]=$(this).val();
					}
					else{
						objJson[name]+="," + $(this).val();
					}
			});
		},
		
		setData:function(){
			var self=this;
			form=$(this);
			//找到主表
			var mainTable=form.find('[type="main"]');
			var main={};
			mainTable.find('input:text,input:hidden,textarea,select').each(function(){
				var value=$(this).val();
				var name=$(this).attr('name');
				if(value!=null&&value!=''){
					main[name]=value;
				}
			});
			
			form.children('input:hidden').each(function(){
				var value=$(this).val();
				var name=$(this).attr('name');
				if(value!=null&&value!=''){
					main[name]=value;
				}
			});
			//设定checkbox，radio的值。
			this.getCheckBoxValue(main,mainTable);
			
			//找到子表  遍历每一行 得到子表数据
			form.find('[type="sub"]').each(function(){
				 var tableId=this.id;
				 var jsonAry=[];
				 var subTable=$(this);
				 subTable.find('[type="subdata"]').each(function(){
					 var subJson={};
					 $(this).find('input:text,input:hidden,textarea,select').each(function(){
						 var value=$(this).val();
						 var name=$(this).attr('name');
						 if(value!=null&&value!=''){
							 subJson[name]=value;
						 }
					 });
					//设定checkbox，radio的值。
					 self.getCheckBoxValue(subJson, subTable);
				
					 if(subJson!={}){
						 jsonAry.push(subJson);
					 }
				 });
				 main[tableId+"List"]=jsonAry;
			});
			var mainStr=JSON.stringify(main);
			$('textarea[name="json"]',form).remove();
			
			var json="<textarea style='display:none;'  name='json'>"+mainStr+"</textarea>";
			form.append($(json));
			
			return form;
		}
	});
})(jQuery);