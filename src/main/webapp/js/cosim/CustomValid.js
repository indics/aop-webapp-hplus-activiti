/**
 * jquery自定义表单验证插件
 * 使用方法：
 * 在需要做验证的输入框，单选框，多选框，下拉框中加入validate属性
 * validate:写法如下：
 * {required:true,email:true,maxLength:50}
 * 	(1)required:true                必输字段
	(2)remote:"check.php"      使用ajax方法调用check.php验证输入值
	(3)email:true                    必须输入正确格式的电子邮件
	(4)url:true                        必须输入正确格式的网址
	(5)date:true                      必须输入正确格式的日期 日期校验ie6出错，慎用
	(6)dateISO:true                必须输入正确格式的日期(ISO)，例如：2009-06-23，1998/01/22 只验证格式，不验证有效性
	(7)number:true                 必须输入合法的数字(负数，小数)
	(8)digits:true                    必须输入整数
	(9)creditcard:                   必须输入合法的信用卡号
	(10)equalTo:"#field"          输入值必须和#field相同
	(11)accept:                       输入拥有合法后缀名的字符串（上传文件的后缀）
	(12)maxlength:5               输入长度最多是5的字符串(汉字算一个字符)
	(13)minlength:10              输入长度最小是10的字符串(汉字算一个字符)
	(14)rangelength:[5,10]      输入长度必须介于 5 和 10 之间的字符串")(汉字算一个字符)
	(15)range:[5,10]               输入值必须介于 5 和 10 之间
	(16)max:5                        输入值不能大于5
	(17)min:10                       输入值不能小于10
 * 如：
 * <input type="text" name="username" value="" validate="{required:true,maxlength:50}"/>
 * 注意一组单选框，或多选框  只需在其中一个input标记中 加入validate 属性
 * 如：
 * <input type="checkbox" name="a" value="1" validate="{required:true}" tipId="errorA"/>
 * <input type="checkbox" name="a" value="2" />
 * <input type="checkbox" name="a" value="3" />
 * 
 * tipId:错误信息显示的容器ID,设置了这个属性后，错误信息会显示到该标签中。
 * <input type="text" name="name" validate="{required:true}" tipId="errorA"/><label id="errorA"></label>
 * 
 * 
 * 调用方式:
 * 
 * $("a.save").click(function(){
 *			var rtn=$("#shipOrderForm").form().valid();
 *			if(rtn){
 *				$("#shipOrderForm").submit();
 *			}
 *	});
 *	同时也可以扩展验证的规则
 *	var rtn=$("#form").form({
 *		//扩展验证规则 追加到已有的规则中
 *		rules:[{
 *			//规则名称
 *			name:"QQ",
 *			//判断方法  返回 true 或false
 *			rule:function(v){
 *			},
 *			//错误的提示信息
 *			msg:""
 *		
 *		}],
 *		//显示的错误信息样式 element 当前验证的元素，msg：错误信息
 *		errorPlacement:function(element,msg){
 *		},
 *		//成功后的样式 element 当前验证的元素
 *		success:function(element){
 *		},
 *		excludes:":hidden"
 *		}).valid()
 *
 *	扩展 ： by  xianggang
 *	1、如果需要弹出错误提示的具体信息  可以这样使用
 *	var rtn=CustomForm.validate({returnErrorMsg:true});
 *		或者 $("form").valid({returnErrorMsg:true});
 *			其中form即为您要验证的表单或者域
 *	if(!rtn.success){
 *		$.ligerDialog.tipDialog($lang.tip.msg,"表单验证错误信息如下",rtn.errorMsg,null,function(){
 *			$.ligerDialog.hide();
 *		});
 *		return;
 *	}
 *	2、如果想要自定义错误提示信息 可以这样使用
 *		<input type="text" name="NAME" lablename="名称" class="inputText" 
 *			validate="{maxlength:100,required:true,英文字母:true}" 
 *			errormsgtips="{maxlength:'不能超过100',required:'必须填写1',英文字母:'请输入英文字母'}"  />
 *		其中的errormsgtips即为自定义错误提示信息的json对象。
 */
(function($) {
	//初始化的时候填写必填项目
	$(function(){		
		$('input[validate]').each(function() {
			if($(this).val()!='')
				return;
			
			var validRule = $(this).attr('validate');
			
			// 获取json。
			var json = eval('(' + validRule + ')');
			var isRequired = json.required;
			
			// 非必填的字段且值为空 那么直接返回成功。
			if ((isRequired == false || isRequired == undefined))
				return;
			
			// 给必填控件加上必填样式
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
	})

	$.extend($.fn, {
		// 表单初始化，可以添加自定义规则，出错处理和成功后的处理。
		form : function(conf) {
			if (conf) {
				if (conf.errorPlacement) {
					this.errorPlacement = conf.errorPlacement;
				};
				if (conf.rules) {
					for (var i = 0, len = conf.rules.length; i < len; i++) {
						this.addRule(conf.rules[i]);
					}
				};
				if (conf.success) {
					this.success = conf.success;
				};
				if (conf.excludes) {
					this.excludes = conf.excludes;
				}
				
			}
			var form = this;
			form.delegate("input[validate],select[validate],textarea[validate]", "blur", function() {
						form.handValidResult(this);
					});
			form.delegate("input[validate],select[validate],textarea[validate]", "focus", function() {
						form.success(this);
					});
					
			//处理验证ckeditor
			$("[validate].ckeditor",form).each(function(){
				var me= $(this),name = me.attr("name");
				setTimeout(function(){//等待ckeditor渲染完成再进行处理
					var editor=  CKEDITOR.instances[name],ck=me.next();
					if(editor){
						editor.on( 'blur', function(){
							form.handValidResult(me);
						});
						editor.on( "focus", function(){
							form.success(me);
						});
					}
				},1000);
				
			})	
		
			return this;
		},
		// 添加验证规则。
		// 扩展规则和现有的规则名称相同，则覆盖，否则添加。
		addRule : function(rule) {
			var len = this.rules.length;
			for (var i = 0; i < len; i++) {
				var r = this.rules[i];
				if (rule.name == r.name) {
					this.rules[i] = rule;
					return;
				}
			}
			this.rules.push(rule);
		},
		/**
		 * 判断元素是否在不需要校验的范围内。
		 */
		isInNotValid : function(obj) {
			//if($(obj).is(":hidden"))return true;//是否判断校验hidden的元素
			if (!this.excludes)
				return false;
			var scope = $(this.excludes, this);
			var aryInput = $(
					"input:text,input:hidden,textarea,select,input:checkbox,input:radio",
					scope);
			for (var i = 0, len = aryInput.length; i < len; i++) {
				var tmp = aryInput.get(i);
				if (obj == tmp) {
					return true;
				}
			}
			return false;
		},
		// 对所有有validate表单控件进行验证。
		valid : function(conf) {
			if(!conf){
				this.ignoreRequired=false;
			}
			else{
				if(conf.ignoreRequired==undefined){
					this.ignoreRequired=false;
				}
				else{
					this.ignoreRequired=conf.ignoreRequired;
				}
			}
			var _v = true, form = this,msgs={};
			$('[validate]', form).each(function() {
						var returnObj = form.handValidResult(this);
						for(var i in returnObj){
							if (i=="success"&&!returnObj.success)
							   _v = false;
							else
								msgs[i]=returnObj[i];
						}
					});
			if(conf&&conf.returnErrorMsg){
				var returnTextObj={};
				if(!_v){
					var errorMsg="<div>";
					var i=1;
					for(var m in msgs){
						errorMsg=errorMsg+(i++)+"、<span style='color:rgb(136, 10, 10);font-weight: bolder;'>"+
							m+"&nbsp&nbsp</span> <span style='color:red;'>"+msgs[m]+"</span></br>";
					}
					errorMsg+="</div>"
				}
				returnTextObj.success=_v;
				returnTextObj.errorMsg=errorMsg;
				return returnTextObj;
			}
			return _v;
		},
		// 显示表单处理结果
		handValidResult : function(obj) {
			// 是否在不需要验证的范围内，在的话就不需要验证。
			var returnObj={};
			if (this.isInNotValid(obj)){
				returnObj.success=true;
				return returnObj;
			}
			var msg = this.validEach(obj);
			if (msg != '') {
				this.errorPlacement(obj, msg);
				returnObj.success=false;
				if($(obj).parents(".formInput")[0]!=undefined){
					returnObj[$(obj).parents(".formInput")[0].previousElementSibling.outerText]=msg;
				}
				return returnObj;
			} else {
				this.success(obj);
				if($(obj).hasClass('validError')){             //引对子表单的
					$(obj).removeClass('validError');
				}
				returnObj.success=true;
				return returnObj;
			}
		},
		// 验证单个控件。
		validEach : function(obj) {
			var element = $(obj), 
				rules = this.rules,
				validRule = element.attr('validate'),
				value = "",
				name = element.attr("name");
			// 处理单选框和多选框
			if (element.is(":checkbox,:radio")) {
				$(":checked[name='" + name + "']").each(function() {
							if (value == "") {
								value = $(this).val();
							} else {
								value += "," + $(this).val();
							}
						});
			}else if (element.is("select")) {// 处理select
				value = element.find("option:selected").val();
                if(typeof(value)==undefined || value==null || $.trim(value) == '' || value.indexOf("请选择")>-1){
                	value = '';
                }
			}else if (element.hasClass("ckeditor") ) {// 处理ckeditor编辑器
				var editor=  CKEDITOR.instances[name];
				if($.isEmpty(editor))//ckeditor没渲染的，则取textarea的值
					value = element.val();
				else
					value = editor.getData();
			}else if(element.hasClass("selectFile")){//处理附件
				value = element.siblings("textarea[controltype='attachment']").val();
			}else {
				value = $(element).data('value') || element.val();
			}
			// 处理值
			value = value == null ? "" : value.trim();

			// 获取json。
			var json = eval('(' + validRule + ')');
			var isRequired = json.required;
			
		
			
			// 非必填的字段且值为空 那么直接返回成功。
			if ((isRequired == false || isRequired == undefined) && value == "")
				return "";
			
			
			
			//忽略必填规则。
			if(this.ignoreRequired==true && value == "") return "";
			
			// 遍历json规则。
			for (var name in json) {
				var validValue = json[name];
				//验证规则
				var msg = this._validRules({
					rules:rules,//规则json
					ruleName:name,// 规则名称
					validValue:validValue,//验证的值
					value:value,//实际的值
					errormsgtips:element.attr("errormsgtips")
				});
				if (msg != '') 
					return msg;
			}
			return "";
		},
		/**
		 * 验证规则
		 **/
		_validRules :function(conf){
			var  _valid = true,
				rules = conf.rules,//规则json
				ruleName = conf.ruleName,// 规则名称
				validValue = conf.validValue,//验证的值
				value =conf.value;//实际的值
			for (var m = 0; m < rules.length; m++) {
				// 取得验证规则。
				var rule = rules[m];
				if (ruleName.toLowerCase() != rule.name.toLowerCase()) continue;
				// 验证规则如下：
				// email:true,url:true.
				//验证规则是boolean类型
				if ($.type(validValue)  === "boolean") 
					_valid = (!rule.rule(value) && validValue == true) ? false:true; 	
				else 
					_valid = rule.rule(value, validValue);
				
				if (!_valid){ //验证不通过返回消息
					var errorMsg=rule.msg;
					if(conf.errormsgtips){
						var errormsgtips=eval("("+conf.errormsgtips.replaceAll("'","\"")+")")
						for(var i in errormsgtips){
							if(i==ruleName){
								errorMsg=errormsgtips[i];
								break;
							}
						}
					}
					return this.format(errorMsg, validValue);
				}
			}
			return "";
		},
		/**
		 * 消息格式化
		 **/
		format:function(msg,args){
			//boolean类型的直接返回
			if ($.type(args)  === "boolean") 
				return  msg;
			if (!$.isArray(args)) //不是数组类型的
				args = [args];
			//数组类型的
			$.each(args,function(d, e) {
				msg = msg.replace(RegExp("\\{" + d + "\\}", "g"), e)
			});
			return msg;		
		},
		// 错误显示位置。
		errorPlacement : function(element, msg) {
			var errorId = $(element).attr("tipId");
			if (errorId) {
				$('#' + errorId).find('label.error').remove();
				$('#' + errorId).append($('<label class="error">' + msg
						+ '</label>'));
				return;
			}
			//default 为默认提示slide， float为浮动提示， dialog为弹框提示
			var tipStyle = "dialog";
			if(tipStyle == "default"){
				//判断parent宽度如果大于element宽度的100，slide tip,如果小于把父元素撑开
				var parent =$(element).parent();
				if($(parent).outerWidth() > $(element).outerWidth() + 100){//slide tip
					parent.find('label.error').remove();
					parent.append($('<label class="error">' + msg + '</label>'));
				}else{
					if($(element).parent().hasClass('tip_errorDiv')){
						parent.find('a.tip_error').remove();
						parent.append($('<a class="tip_error" title="' + msg + '"><label class="error"/></a>'));
					}else{
						$(element).wrap('<div class="tip_errorDiv"></div>');
						var parent = $(element).parent();
						parent.css('float','left').css('overflow','hidden');
						parent.width($(element).outerWidth() + 50);
						parent.find('label.error').remove();
						parent.append($('<a class="tip_error" title="' + msg + '"><label class="error"/></a>'));
					}
				}
			}else if(tipStyle == "float"){
				//pop tip
				parent.find('div.validatebox-tip').remove();
				//获取偏移量,防止浮动层挡住
				var validRule = $(element).attr('validate');
				var json = eval('(' + validRule + ')');
				var rightTip = json.tipOffset || 0;
				var tip = $("<div class=\"validatebox-tip\">"+"<span class=\"validatebox-tip-content\">"+"</span>"+"<span class=\"validatebox-tip-pointer\">"+"</span>"+"</div>").appendTo(parent);
				tip.find(".validatebox-tip-content").html(msg);
				tip.css({display:"block",left:$(element).offset().left+$(element).outerWidth() + rightTip,top:$(element).offset().top});
				//element的focus时候去掉提示
				$(element).focus(function(){
					parent.find('div.validatebox-tip').remove();
				});
			}else if(tipStyle=="dialog"){//jquery.toastr.min.js
				var controllerName = $(element).attr('validateName');
				if(controllerName){
					msg = controllerName + msg;
				}
				var defaults = {
					 t_msg: 'warning',    //info/warning/error/success
					 t_titile: '警告信息',  //default title
					 t_content: msg,   //default msg
					 closeButton: true,    //关闭按钮显示
					 debug: false,   //
					 progressBar: false,  //进度条显示
					 positionClass: "toast-top-center",     //提示信息显示的位置
					 onclick: function () {   //default
					  //console.log('被点击.....') ;
					 },   //点击时间
					 showDuration: 400,   //显示时间
					 hideDuration: 1000,
					 timeOut: 1300,
					 extendedTimeOut: 1000,
					 showEasing: 'swing',    //动画显示  （swing, linear）
					 hideEasing: 'linear',   //隐藏动画（swing, linear）
					 showMethod: 'fadeIn',
					 hideMethod: 'fadeOut'
				};
				var opts = {};
				var options = $.extend({}, defaults, opts);
				toastr.options = options ;
				var $toast = toastr[options.t_msg](options.t_content, options.t_titile);
			}
		},
		// 验证成功时，删除错误提示信息。
		success : function(element) {
			var errorId = $(element).attr("tipId");
			if (errorId) {
				$('#' + errorId).find('label.error').remove();
				return;
			}
			$(element).parent().find('label.error').remove();	
		},

		// 内置的规则。
		// 内置的规则。
		rules : [{
					name : "required",
					rule : function(v) {
						if (v == "" || v.length == 0 || v == "必填")
							return false;
						return true;
					},
					msg : "必填"
				}, {
					name : "number",
					rule : function(v) {
						return /^-?(?:\d+|\d{1,3}(?:,\d{3})+)(?:\.\d+)?$/
								.test(v.trim());
					},
					msg : "请输入一个合法的数字"
				}, {
					name : "variable",
					rule : function(v) {

						return /^[a-z_0-9]*$/gi.test(v.trim());
					},
					msg : "只能是字母和下划线"
				}, {
					name : "minLength",
					rule : function(v, b) {
						return (v.length >= b);
					},
					msg : "长度不少于{0}"
				}, {
					name : "maxLength",
					rule : function(v, b) {
						return (v.trim().length <= b);
					},
					msg : "长度不超过{0}"
				}, {
					name : "rangeLength",
					rule : function(v, args) {

						return (v.trim().length >= args[0] && v.trim().length <= args[1]);
					},
					msg : "长度必须在{0}之{1}间"
				}, {
					name : "email",
					rule : function(v) {
						return /^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$/i
								.test(v.trim());
					},
					msg : "请输入一合法的邮箱地址"
				}, {
					name : "url",
					rule : function(v) {
						return /^(https?|ftp):\/\/(((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:)*@)?(((\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5]))|((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?)(:\d*)?)(\/((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)+(\/(([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)*)*)?)?(\?((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|[\uE000-\uF8FF]|\/|\?)*)?(\#((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|\/|\?)*)?$/i
								.test(v.trim());
					},
					msg : "请输入一合法的网址"
				}, {
					name : "date",
					rule : function(v) {
						var re = /^[\d]{4}-[\d]{1,2}-[\d]{1,2}\s*[\d]{1,2}:[\d]{1,2}:[\d]{1,2}|[\d]{4}-[\d]{1,2}-[\d]{1,2}|[\d]{1,2}:[\d]{1,2}:[\d]{1,2}$/g
								.test(v.trim());
						return re;
					},
					msg : "请输入一合法的日期"
				}, {
					name : "digits",
					rule : function(v) {
						return /^\d+$/.test(v.trim());
					},
					msg : "请输入整数"
				}, {
					name : "equalTo",
					rule : function(v, b) {
						var a = $("#" + b).val();
						return (v.trim() == a.trim());
					},
					msg : "两次输入不等"
				}, {
					name : "range",
					rule : function(v, args) {
						this.msg = String.format(this.msg, args[0], args[1]);
						return v <= args[1] && v >= args[0];
					},
					msg : "请输入在{0}到{1}范围之内数字"
				}, {
					// 判断数字整数位
					name : "maxIntLen",
					rule : function(v, b) {
						this.msg = String.format(this.msg, b);
						return (v + '').split(".")[0].length <= b;
					},
					msg : "整数位最大长度为{0}"
				}, {
					// 判断数字小数位
					name : "maxDecimalLen",
					rule : function(v, b) {
						this.msg = String.format(this.msg, b);
						return (v + '').replace(/^[^.]*[.]*/, '').length <= b;
					},
					msg : "小数位最大长度为{0}"
				}, {
					// 判断日期范围
					name : "dateRangeStart",
					rule : function(v, b) {
						var end = $("#" + b).val();
						return daysBetween(v, end);
					},
					msg : "开始日期必须小于或等于结束日期"
				}, {
					// 判断日期范围
					name : "dateRangeEnd",
					rule : function(v, b) {
						var start = $("#" + b).val();
						return daysBetween(start, v);
					},
					msg : "开始日期必须小于或等于结束日期"
				}]
	});

})(jQuery);
