
/**
 * 交给我的任务表单
 * by cjj
 */

Ext.define('mobile.MyAssignForm', {
    extend: 'mobile.TableForm',
    
    name: 'myAssignForm',

    constructor: function (config) {
		
		config = config || {};
    	this.taskId = config.taskId;
    	this.parentCallback = config.callback;
    	this.extForm = config.extForm;
    	
        this.callParent([config]);
	},
	
	formSubmit:function(){
		var tabpanel = this.up('tabpanel');
		var voteAgree = tabpanel.getVoteAgree(this.config.voteAgree);
		var tableForm = tabpanel.down('formpanel');
		if(tabpanel.extForm)
		{
			formpanel.formSubmit({
				voteAgree: voteAgree,
				formpanel: formpanel
			});
		}
		else
		{
			tableForm.submit({
				url: 'platform/mobile/mobileTask/submitForm.ht',
		        params: {
		        	'opinion': '{\"opinion\":\"'+tableForm.getCmpByName('opinion').getValue()+'\"}',
		        	'taskId':tabpanel.taskId,
		        	'voteAgree':voteAgree
				},
		        method: 'POST',
		        success: function(form,action,response) {
		        	Ext.Msg.alert('保存成功');
		        	tabpanel.parentCallback.call();
		        	mobileView.pop();
		        },
		        failure: function(form,action,response){
					var obj = Ext.util.JSON.decode(response);
					Ext.Msg.alert('', obj.msg);
		        }
			});
		}
	}

});
