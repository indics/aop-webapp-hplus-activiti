$(function(){
	var subform={
			tables:{},
			//初始化页面
			init:function(){
				var self=this;
				$("[type='sub']").each(function(){
					var table=$(this);
					//保存事件
					$(table).data('subform', self);
					
					var formType=table.attr("formType");
					//添加一行数据
					var row=table.find("[type='append']");
					//子表Id
					var tableId=table.attr('id');
					//弹框模式
					if(formType=="window"){
						isPage=false;
						var id=this.id+"Form",
							form=$("#"+id),
							width=form.attr('width')?form.attr('width'):form.width()+50,
							height=form.attr('height')?form.attr('height'):form.height()+70,
							title=form.attr('title')?form.attr('title'):''; 
						table.data('form', '<form>' + $('<div></div>').append(form.clone()).html() + '</form>');
						table.data("formProperty",{title:title,width:width ,height: height});
						form.remove();
					}
					//页内编辑模式
					if(formType="page"){
						
					}
					table.data('row',$('<div></div>').append(row.clone()).html());
					
					row.css('display', 'none').html('');
					
					//页内编辑模式
					if(formType="page"){
						//如果为新增并且formType="page"，默认添加一行
						if(table.find('tr[type="subdata"]').length == 0){
							self.add(table);
						}
					}
					
					self.tables[tableId]=table;
					self.handButton(table);
					tmp = self;			
					
					//初始化单元格
				});
			},
			//触发click 事件
			handButton:function(table){
				var self=this;
				$(".add",table).click(function(){					
					self.add(table);
				});
				
				table.delegate("#chkall", "click", function(){
					self.chkAll(this, table);
				});
				
				table.delegate(".del", "click", function(){
					self.delRow(this);
				});
				
				table.delegate(".edit", "click", function(){
					self.edit(this,table);
				});
			},
			//自适应页面
			handleAdd : function(){
				var iframe = $('iframe#main', parent.document);
				var height = $(iframe).attr('height');
				height = parseInt(height.replace('px','')) + 30;
				height = height + 'px';
				$(iframe).attr('height', height);
				var parentBody = window.parent.document.body;
				$(parentBody).height($(parentBody).height() + 20);
			},
			//自适应页面
			handleDel : function(){
			},
			//全选/反选
			chkAll : function(obj, table){
				$('#chkall').each(function () {        //全选/取消全选
			        $(":checkbox.pk", table).attr("checked", obj.checked);
			     });
				//当选中某个子复选框时，SelectAll取消选中
				$(":checkbox.pk", table).click(function () {
			         if (!this.checked) {
			             $('#chkall').attr("checked", false);
			         }
			     });
			},
			//添加一行记录  包括 弹框 和 页内两种编辑模式
			add:function(table){				
				var self=this, f=table.data("form");
				//弹框模式
				if(f){
					var form=$(f).clone(),formProperty = table.data("formProperty");
					//增加一行排序码
					var max = 0;
					table.find('td.seqNum').each(function(){
						var i = $(this).text();
						if(i > max)
							max = i;
					});
					form.find('input.seqNum').val(parseInt(max, 10) + 1);
					this.openWin({
						title:'添加'+formProperty.title,
						width:formProperty.width,
						height:formProperty.height, 
						form:form,
						callback:function(){
							var frm=$(form).form();
							if(frm.valid()){
								var data=self.getFormData(form);
								var showData=self.getFormShowData(form);
								self.addRow(data,showData,table);
							}
						}
					});
				//页内编辑模式
				}else{
					self._addRow(table);
				}
			},
			
			// 弹框模式 根据表单数据 增加一行
			addRow:function(data,showData,table){
				var row=table.data('row');
				var tr=$(row).clone();
				tr.attr('type','subdata');
				tr.removeAttr('style');
				for(var name in data){
					tr.find("td,input:hidden").each(function(){
						if($(this).is('td')){
							var tdname=$(this).attr('name');
							//加行号 zouping
							if($('input',this).hasClass('seqNum')){
								$(this).addClass('seqNum');
							}
							if(name==tdname){
								$(this).text(showData[name]);
							}
						}
						if($(this).is('input:hidden')){
							var inputname=$(this).attr('name');
							if(name==inputname){
								$(this).val(data[name]);
							}
						}
					});
				}
				
				table.append(tr);
				//$.ligerDialog.close();
				//$.ligerDialog.hide();
			},
			
			// 弹框模式 触发 编辑点击事件
			edit:function(obj,table){
				var self=this, f=table.data("form");
				//弹框模式
				if(f){
					var self=this, form=self.setFormData(obj,table),formProperty = table.data("formProperty");
					this.openWin({
						title:'编辑'+formProperty.title,
						width:formProperty.width,
						height:formProperty.height, 
						form:form,
						callback:function(){
							var frm=$(form).form();
							if(frm.valid()){
								self.editRow(obj, form);
							}
						}
					});
				}else{
					self._editRow(obj, table);
				}
			},
			
			//页内编辑模式 添加一行
			_editRow:function(obj, table){
				var a = $(obj).parent('tr').find('input[name="' + $(obj).attr('name') + '"]');
			},
			
			//页内编辑模式 添加一行
			_addRow:function (table){
				var self = this;
				var row=table.data('row');
				var tr=$(row).clone();
				
				table.append(tr);
				self.renderRow(tr);
				return tr;
			},
			
			//处理行单元格,想Excel一样操作
			renderRow:function(row){
				var self=this;
				var table = row.closest('table');
				
				//清除样式,增加行类型
				row.attr('type','subdata');
				row.removeAttr('style');
				
				//行号排序
				this.seqRow(table);
				
				
				//改变输入框样式
				row.find('input').removeClass('inputText')
								 .addClass('inputText_append');

				//单元格获取焦点，改变样式
				row.find('input').focus(function(){
					row.find('input').removeClass('inputText_click')
									.removeClass('inputText_focus');
					
					$(this).addClass('inputText_focus');
				});
				
				//单元格鼠标点击的时候,改变样式
				row.find('input').click(function(){
					row.find('input').removeClass('inputText_click')
									.removeClass('inputText_focus');
					
					if($(this).attr('readonly')==undefined){//编辑框
						$(this).addClass('inputText_click');
						//清空,将值保留到别的地方
						if($(this).val()==0){
							$(this).data('value', $(this).val());
							$(this).val('');
						}
					}else{
						$(this).addClass('inputText_focus');
					}
				});
				
				//单元格change时候，自动补齐失效
				row.find('input').change(function(){
					$(this).data('autoFilled',false);
				});
				
				//失去焦点
				row.find('input').blur(function(){
					//清空,将值保留到别的地方
					var v = $(this).data('value');
					if($(this).val()==''){//如果单元格有隐藏值，将值显示
						$(this).val(v);
					}
					
					//单元格有自动补齐功能，手输入的置为空
					var validate = $(this).attr('validate');
					if(validate!=undefined && validate!='' && validate.indexOf('autoFilled')>-1){
						if($(this).data('autoFilled')==false){
							$(this).val('');
						}
					}
				});
				
				//上下左右事件
				row.find('input').keypress(function(event){
					if(event.keyCode==37){//←
						var prevInp = $(this).parent().prev().find('input');
						if($(this).attr('readonly')==undefined){//如果非只读框,当鼠标移到最左边的时候才移动
							var pos = self.getPos(this);
							if(pos==0){
								if(prevInp.attr('readonly')==undefined){
									prevInp.click().focus();
								}else{//获取焦点,不click
									prevInp.focus();
								}
							}
						}else{//只读框
							prevInp.focus();
						}
					}else if(event.keyCode==38){//↑
						//移动到上一行
						var currentTr = $(this).closest('tr');
						var preTr = currentTr.prev();
						var trIndex = table.find('tr').index(preTr);
						if(trIndex > 2){
							currentTr.find('input').removeClass('inputText_click')
													.removeClass('inputText_focus');
							//获取焦点
							var i = currentTr.find('input').index(this);
							$(preTr.find('input').get(i)).click().focus();
						}
					}else if(event.keyCode==39){//→
						var nextInp = $(this).parent().next().find('input');
						if($(this).attr('readonly')==undefined){//如果非只读框,当鼠标移到最右边的时候才移动
							var pos = self.getPos(this);
							//readOnly不会获取焦点
							if($(this).val().length==0 || pos == $(this).val().length){
								if(nextInp.attr('readonly')==undefined){
									nextInp.click().focus();
								}else{//获取焦点,不click
									nextInp.focus();
								}
							}
						}else{
							nextInp.focus();
						}
					}else if(event.keyCode==40){//↓，增加一行
						//移动到下一行，如果没有则新增一行
						var currentTr = $(this).closest('tr');
						var nextTr = currentTr.next();
						if(nextTr.get(0) == undefined){
							nextTr = self._addRow(table);
						}
						currentTr.find('input').removeClass('inputText_click')
												.removeClass('inputText_focus');
						//获取焦点
						var i = currentTr.find('input').index(this);
						$(nextTr.find('input').get(i)).click().focus();
					}else if(event.keyCode==13){
						//判断是否有<a class="link">
						var a = $(this).parent().find('a.link');
						if(a!=undefined){
							a.trigger('click');
						}
						
						//挪到下一个
						var nextInp = $(this).parent().next().find('input');
						if(nextInp.attr('readonly')==undefined){
							nextInp.click().focus();
						}else{//获取焦点,不click
							nextInp.focus();
						}
					}
				});
				
				//校验
				$('input[validate]', row).each(function() {
					var validRule = $(this).attr('validate');
					
					// 获取json。
					var json = eval('(' + validRule + ')');
					var isRequired = json.required;
					
					// 非必填的字段且值为空 那么直接返回成功。
					if ((isRequired == false || isRequired == undefined))
						return;
					
					if(isRequired){
						$(this).val('必填');
						$(this).addClass('cloud-required');
						$(this).focus(function(){
							if($(this).val()=='必填'){
								$(this).val('');
								$(this).removeClass('cloud-required');
							}					
						});
					}
				});
			},
			
			seqRow : function(table){//对表格的行号进行排序
				//从1开始重新排列
				var seq = 1;
				table.find('input.seqNum').each(function(){
					$(this).val(seq++);
				});
			},
			
			getPos : function (ctrl){
		        var CaretPos = 0;    // IE Support
		        if (document.selection) {
		        	ctrl.focus ();
	                var Sel = document.selection.createRange ();
	                Sel.moveStart ('character', -ctrl.value.length);
	                CaretPos = Sel.text.length;
		        }
		        // Firefox support
		        else if (ctrl.selectionStart || ctrl.selectionStart == '0')
		                CaretPos = ctrl.selectionStart;
		        return (CaretPos);
			},
			
			//删除一行
			delRow:function(obj){
				var self = this;
				//第一行不允许删除
				var tr = $(obj).closest('tr[type="append"]');
				if(tr[0]){
					alert('第一行不允许删除!');
					return;
				}
				
				//第一行不允许删除
				var tr = $(obj).closest('tr[type="subdata"]');
				var table = tr.closest('table');
				tr.remove();
				self.seqRow(table);
				self.handleDel();
			},
			
			//删除一行
			delRows:function(obj){
				var self = this;
				$.ligerMessageBox.confirm('提示信息','确认删除吗？',function(rtn) {
					if(rtn) {
						var table = $(obj).closest('table');
						table.find('input[name="cb"]:checked').each(function(){
							var tr = $(this).closest('[type="subdata"]');
							tr.remove();
							self.handleDel();
						})
						self.seqRow(table);
					}
				});
			},
			
			//弹框模式 根据表单数据 编辑对应的行数据
			editRow:function(obj,form){
				var self=this;
				var data=self.getFormData(form);
				var showData = self.getFormShowData(form);
				//alert(JSON.stringify(data));
				var trObj=$(obj).closest('[type="subdata"]');
				for(var name in data){
					trObj.find("td,input:hidden").each(function(){
						if($(this).is('td')){
							var tdname=$(this).attr('name');
							 
							if(name==tdname){
								$(this).text(showData[name]);
							}
						}
						if($(this).is('input:hidden')){
							var inputname=$(this).attr('name');
							if(name==inputname){
								$(this).val(data[name]);
							}
						}
					});
				}
				//$.ligerDialog.close();
				//$.ligerDialog.hide();
			},
			
			/**
			 * 打开操作数据窗口。
			 * @param conf 窗口配置参数
			 * <pre>
			 * 	conf.title {string}(可选)窗口标题 默认‘编辑’ 
			 * 	conf.width  {number}(可选)窗口宽度 默认400
			 * 	conf.height {number}(可选)窗口高度 默认250
			 * 	conf.form	 {Object}当前窗口对象
			 * 	conf.callback {Object}(必须) 回调函数
			 * </pre>
			 */
			openWin:function(conf){
				$.ligerDialog.open({
					width: conf.width?conf.width:400,
					height:conf.height?conf.height:250,
					title: conf.title?conf.title:'编辑', 
					isResize:true,
					target:conf.form,
					buttons: [{ text: '确定', onclick:function(item,dialog){						
						conf.callback(item,dialog);
					}}]
				});
			},
			
			//回填数据至表单
			setFormData:function(obj,table){
				var form=$(table.data('form')).clone();
				var json={};
				//根据当前行 取得数据
				var trObj =$(obj).closest('[type="subdata"]');
				$("input",trObj).each(function(){
						var value=$(this).val();
						var name=$(this).attr('name');
						json[name]=value;
				});
				
				for(var name in json){
					form.find('input:text,textarea,select,input:hidden').each(function() {
						var attrname=$(this).attr('name');
						if(name==attrname){
							if($(this).is('select')){
								$(this).find('option').each(function(){
									if($(this).val()==json[name]){
										$(this).attr('selected','selected');
									}
								});
							}else{
								$(this).val(json[name]);
							}
						}
					});
					form.find('input:checkbox,input:radio').each(function(){
						var attrname=$(this).attr("name");
						var value = '';
						if(name==attrname){
							value=json[name];
						}
						var ary=value.split(',');
						$(this).find('[name='+name+']').each(function(){
							for(var i=0;i<ary.length;i++){
								var v=ary[i];
								if($(this).val()==v){
									$(this).attr("checked","checked");
								}
							}
						});
							
					});
				}
				return form;
			},
			
			/**
			 * 取得表单中的数据
			 */
			getFormData:function(form){
				var data={};
				$(form).find('input:text,textarea,select,input:hidden').each(function() {
					var name=$(this).attr('name');
					var value=$(this).val();
					data[name]=value;
				});
				$(form).find(":checkbox,:radio").each(function(){
					var name=$(this).attr('name');
					var value="";
					$(":checked[name="+name+"]").each(function(){
						if(value==""){
							value=$(this).val();
						}else{
							value+=","+$(this).val();
						}
					});
					data[name]=value;
				});
				return data;
			},
			/**
			 * 取得表单中的展示的数据
			 */
			getFormShowData:function(form){
				var data={};
				$(form).find('input:text,textarea,input:hidden').each(function() {
					var name=$(this).attr('name');
					var value=$(this).val();
					data[name]=value;
				});
				$(form).find('select').each(function() {
						var me = $(this);
						var name= me.attr('name');
						var value= me.find("option:selected").text(); 
						data[name]=value;
				});
				
				$(form).find(":checkbox,:radio").each(function(){
					var name=$(this).attr('name');
					var value="";
					$(":checked[name="+name+"]").each(function(){
						if(value==""){
							value=$(this).val();
						}else{
							value+=","+$(this).val();
						}
					});
					data[name]=value;
				});
				return data;
			}
			
	};
	subform.init();
	tmp = subform;
});
