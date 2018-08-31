/**
 * 已办事务
 * by cjj
 */


Ext.define('mobile.MyAttend', {
    extend: 'mobile.List',
    
    name: 'MyAttend',

    constructor: function (config) {
		
    	config = config || {};
    	
    	this.username = config.username;

    	Ext.apply(config,{
    		title:'已办事务',
			fields:[
				{name: 'runId',type: 'string'},
				{name: "subject",  type: "string"}
			],
			url:'platform/mobile/mobileTask/myAttend.ht',
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
			    url: 'platform/mobile/mobileTask/getMyAttendForm.ht',
			    params: {
			    	runId:record.get('runId')
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
			        	Ext.create('mobile.TableForm',{
			        		extForm:form.extForm,
			        		formDetailUrl:form.formDetailUrl,
			        		formEditUrl:form.formEditUrl,
			        		username:obj.username,
			        		mainFields:formfields,
			        		subTables:subTables,
			        		id:result.runId,
			        		imageType:2,
			        		notApprove:true,
			        		callback:function(){
			        			obj.store.load();
			        		}
			        	})
			        );
			    }
			});
    	}
    	isUserImage=false;
    }

});
