/**
 * 我收到的任务
 * by cjj
 */


Ext.define('mobile.MyAssignee', {
    extend: 'mobile.List',
    
    name: 'myAssignee',

    constructor: function (config) {
		
    	config = config || {};
    	
    	this.username = config.username;

    	Ext.apply(config,{
    		title:'我收到的任务',
			fields:[
			 	{name: 'runId',type: 'string'},
			 	{name: 'taskId',type: 'string'},
			 	{name: "subject",  type: "string"},
			 	{name: "taskStatus",  type: "string"}
			],
			url:'platform/mobile/mobileTask/myAssignee.ht',
			root:'tasks',
		    searchCol:'subject',
			username:config.username,
		    itemTpl: "{subject}<input type='image' class='userImage' onClick='userImage(2, {runId})' />",
		    listeners: {
    			itemsingletap:this.itemsingletap
    		}
    	});
    	
    	this.callParent([config]);
    },
	
	itemsingletap:function(obj, index, target, record){
		if(!isUserImage){
			Ext.Ajax.request({
			    url: 'platform/mobile/mobileTask/getMyAssignForm.ht',
			    params: {
					runId:record.get('runId'),
			    	taskId:record.get('taskStatus')!=1?record.get('taskId'):''
			    },
			    success: function(response){
			        var result = Ext.util.JSON.decode(response.responseText);
			        var form = result.form;
			        var formfields = []; 
			        if(form.fields.length!=0){
			        	formfields = Ext.util.JSON.decode(form.fields.replace(new RegExp("'","gm"),"\""));
			        }
			        var subTables = [];
			        if(form.subTableList.length!=0){
			        	subTables = form.subTableList;
			        }
			        mobileView.push(
			        	Ext.create('mobile.MyAssignForm',{
			        		extForm:form.extForm,
			        		formDetailUrl:form.formDetailUrl,
			        		formEditUrl:form.formEditUrl,
			        		username:obj.username,
			        		mainFields:formfields,
			        		subTables:subTables,
			        		imageType:2,
			        		notApprove:record.get('taskStatus')!=1?false:true,
			        		id:result.runId,
			        		taskId:record.get('taskId'),
			        		signTask:form.signTask,
			        		callback:function(){
			        			obj.store.load();
			        		}
			        	})
			        );
			    }
			});
		}
		isUserImage = false;
    }

});
