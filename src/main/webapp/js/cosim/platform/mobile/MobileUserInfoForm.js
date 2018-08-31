
/**
* MobileUserInfoForm
*/

Ext.define('mobile.MobileUserInfoForm', {
    extend: 'Ext.form.Panel',
    
    name: 'mobileUserInfoForm',

    constructor: function (config) {
    	
    	config = config || {};
    	
    	this.taskId = config.taskId;
    	
    	Ext.apply(config,{
    		title:'MobileUserInfo',
    		items: [
    			{
	    			xtype: 'fieldset',
		    		items:[
				        {
				            xtype: 'textfield',
				            name: 'username',
				            label: '姓名'
				        },
				        {
				            xtype: 'numberfield',
				            name: 'idcard',
				            label: '身份证'
				        }
		    		]
	    		}
    		]
    	});
    	
    	this.callParent([config]);
    },
    
    formSubmit:function(config){
		var voteAgree = config.voteAgree;
		var formpanel = config.formpanel;
		formpanel.submit({
		    url: 'platform/mobile/mobileUserInfo/save.ht',
	        params: {
				'json':'{voteAgree:'+voteAgree+'}'
	        },
	        method: 'POST',
	        success: function(form,action,response) 
	        {
	        	var obj = Ext.util.JSON.decode(response);
	        },
	        failure: function(form,action,response)
	        {
				var obj = Ext.util.JSON.decode(response);
				Ext.Msg.alert('', obj.msg);
	        }
		});
	}
    
});