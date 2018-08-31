
/**
 * 我的待办表单
 * by cjj
 */

Ext.define('mobile.MyTaskForm', {
    extend: 'mobile.TableForm',
    
    name: 'myTaskForm',

    constructor: function (config) {
		
		config = config || {};
    	this.taskId = config.id;
    	this.parentCallback = config.callback;
    	this.extForm = config.extForm;
    
        this.callParent([config]);
	},

	formSubmit:function(){
		var tabpanel = this.up('tabpanel');
		var voteAgree = tabpanel.getVoteAgree(this.config.voteAgree);
		var formpanel = tabpanel.down('formpanel');
		if(tabpanel.extForm)
		{
			formpanel.formSubmit({
				voteAgree: voteAgree,
				formpanel: formpanel
			});
		}
		else
		{
			formpanel.submit({
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
