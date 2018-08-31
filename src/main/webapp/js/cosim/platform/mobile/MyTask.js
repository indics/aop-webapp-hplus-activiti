/**
 * 手机待办
 * by cjj
 * 
 * var data = {
 *    "tasks" : [
 *    	{
            "taskId": "1",
            "taskName": "task1"
        },
        {
            "taskId": "2",
            "taskName": "task2"
        },
        {
            "taskId": "3",
            "taskName": "task3"
        }
 *    ] 
 * }
 * 
 */

Ext.define('mobile.MyTask', {
    extend: 'mobile.List',
    
    name: 'myTask',

    constructor: function (config) {
		
    	config = config || {};

    	this.username = config.username;

    	Ext.apply(config,{
    		title:'我的待办',
    		fields:[
    			{name: 'id',type: 'string'},
				{name: "subject",  type: "string"}
    		],
    		url:'platform/mobile/mobileTask/myTask.ht',
    		root:'tasks',
		    searchCol:'subject',
			username:config.username,
		    itemTpl: "{subject}<input type='image' class='userImage' onClick='userImage(1, {id})' />",
		    listeners: {
    			itemsingletap:this.itemsingletap
    		}
    	});

    	this.callParent([config]);

    },

	itemsingletap:function(obj, index, target, record){
    	if(!isUserImage){
			Ext.Ajax.request({
			    url: 'platform/mobile/mobileTask/getMyTaskForm.ht',
			    params: {
					taskId:record.get('id')
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
			        	Ext.create('mobile.MyTaskForm',{
			        		extForm:form.extForm,
			        		formDetailUrl:form.formDetailUrl,
			        		formEditUrl:form.formEditUrl,
			        		username:obj.username,
			        		mainFields:formfields,
			        		subTables:subTables,
			        		id:result.taskId,
			        		imageType:1,
			        		notApprove:false,
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
