
/**
 * 手机登录
 * by cjj
 */

Ext.define('mobile.Login', {
    extend: 'Ext.form.Panel',
    
    name: 'login',

    constructor: function (config) {
    	
    	config = config || {};
    	
    	Ext.apply(config,{
    		title:'bpmx3业务管理系统',
    		items : [
    			{
	    			xtype: 'fieldset',
	    			items:[
				        {
				            xtype: 'textfield',
				            name: 'username',
				            label: '账号'
				        },
				        {
				            xtype: 'passwordfield',
				            name: 'password',
				            label: '密码'
				        }
		//		        {
		//		    		xtype: 'textfield',
		//		    		name: 'validCode',
		//		    		label: '验证码'
		//		        },
		//		        {
		//		    		xtype: 'panel',
		//		    		html:'<img src="servlet/ValidCode" />'
		//		        },
			        ]
		        },
		        {
		            xtype: 'button',
		            name: 'submit',
		            text:'登录',
		            handler:this.formSubmit
		        }
	        ]
    	});

    	this.callParent([config]);
    },
    
    formSubmit:function(){
		var loginForm = this.up('formpanel');
		loginForm.submit({
		    url: 'mobileLogin.ht',
	        params: {
	            username: loginForm.getCmpByName('username').getValue(),
	            password: loginForm.getCmpByName('password').getValue()
//	            validCode: loginForm.getCmpByName('validCode').getValue()
	        },
	        method: 'POST',
	        success: function(form,action,response) {
	        	var obj = Ext.util.JSON.decode(response);
	        	mobileView.push(
	        		Ext.create('mobile.Main',{
	        			username:obj.username
	        		})
	        	);
	        },
	        failure: function(form,action,response){
				var obj = Ext.util.JSON.decode(response);
				Ext.Msg.alert('', obj.msg);
	        }
		});
	}

});

