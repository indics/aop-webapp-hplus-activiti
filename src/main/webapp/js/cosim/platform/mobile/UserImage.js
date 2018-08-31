
/**
 * 查看流程图
 * by cjj
 */

Ext.define('mobile.UserImage', {
    extend: 'Ext.Panel',
    
    name:'userImage',

    constructor:function(config){
	
    	config = config || {};
    	
    	var taskId='',runId='';
		switch(config.type){
			case 1:
				taskId=config.id;
				break;
			case 2:
				runId=config.id;
				break;
		}

		Ext.apply(config,{
			title: '查看流程图',
			hidden: config.hidden,
			html:'<iframe '+
				'frameborder="0" width="100%" height="100%"'+
				'src="platform/bpm/processRun/userImage.ht?'+
				'taskId='+taskId+
				'&runId='+runId+
				'&notShowTopBar=true'+
				'"></iframe>'
		});
		
		this.callParent([config]);
    }

});
    