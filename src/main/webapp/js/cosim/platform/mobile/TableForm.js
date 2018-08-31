
/**
 * 手机表单
 * by cjj
 */

Ext.define('mobile.TableForm', {
	extend: 'Ext.TabPanel',
    
    name: 'tableForm',

    constructor: function (config) {
		
		config = config || {};

    	var mainHidden = true;
    	var br = Ext.create('Ext.Panel',{
    		html:'<br>'
    	});
    	
    	if(config.extForm==false)
    	{
    		this.mainTable = Ext.create('Ext.form.Panel');	
    	
	    	// 主表字段
	    	var mainFields = config.mainFields;
	    	if(mainFields.length!=0){
	    		mainHidden = false;
		    	for(var idx=0;idx<mainFields.length;idx++){
		    		var field = mainFields[idx];
		    		this.mainTable.add({
		    			xtype:'textfield',
		    			name:field.key,
		    			label:field.label,
		    			value:field.value,
		    			readOnly:true
		    		});
		    	}
	    	}
	    	
	    	this.mainTable.add(br);

	    	// 处理子表字段
	    	var subTables = config.subTables;
	    	for(var tbidx=0;tbidx<subTables.length;tbidx++)
	    	{	
	    		var table = subTables[tbidx];
	    		var fields = table.fields;
	    		var datas = table.dataList;
	    		if(datas.length!=0)
	    		{
	    			mainHidden = false;
	    			var fieldKeys = [];
	    			var flex=Math.floor(100/fields.length);
		    		var html ='<table class="touchgridpanel">'+
		    				'<tr class="x-grid-hd-row">';
		    		for(var idx=0;idx<fields.length;idx++){
		    			var field = fields[idx];
		    			fieldKeys.push(field.fieldKey);
		    			html+='<td width="'+flex+'%" class="x-grid-cell-hd">'+field.fieldVal+'</td>';
		    		}
		    		html+='</tr>';
		    		
		    		for(var idx=0;idx<datas.length;idx++){
		    			var data = datas[idx];
		    			html+='<tr>';
		    			for(var fidx=0;fidx<fieldKeys.length;fidx++){
		    				html+='<td width="'+flex+'%" class="x-grid-cell">'+data[fieldKeys[fidx]]+'</td>';
		    			}
		    			html+='</tr>';
		    		}
		    		
		    		html+='</table><br>';

		    		this.mainTable.add({
		    			xtype:'panel',
		    			html:html
		    		});
	    		}
	    	}
    	}
    	else
    	{
    		mainHidden = false;
    		
    		var detail = config.formDetailUrl;
    		var edit = config.formEditUrl;
    		var view = null;
    		if(detail!=''||edit!='')
    		{
	    		if(edit!='')
	    		{
	    			view = edit;
	    		}
	    		else
	    		{
	    			view = detail;
	    		}
	    		
	    		view = view.substring(5,view.length).replace(new RegExp("/","gm"),".");
	    		this.mainTable = Ext.create(view,{taskId:config.taskId!=null?'0':config.taskId});
			}
    	}
    	
    	if(!config.notApprove)
    	{
    		this.mainTable.add({
                xtype: 'textareafield',
                label: '审批意见',
                maxRows: 4,
                name: 'opinion'
    		});
    	}
    	
    	this.signTask = config.signTask;
    	this.toolbar = Ext.create('Ext.Toolbar',{
			docked: 'top',
			hidden: config.notApprove,
	    	items: [
	            {
                    xtype: 'segmentedbutton',
                    name:'directEnd',
                    allowMultiple: true,
                    items: [
                        { text: '直接结束' }
                    ],
                    hidden:this.signTask
	            },
	            {
	                xtype: 'button',
	                iconCls: 'complete',
	            	iconMask: true,
		            text: '完成',
	                voteAgree:1,
	                handler: this.formSubmit
	            },
	            {
	                xtype: 'button',
		            iconCls: 'refuse',
		            iconMask: true,
		            text: '反对',
	                voteAgree:2,
	                handler: this.formSubmit,
	                hidden:this.signTask
	            },
	            {
	                xtype: 'button',
		            iconCls: 'giveup',
		            iconMask: true,
		            text: '弃权',
	                voteAgree:0,
	                handler: this.formSubmit,
	                hidden:this.signTask
	            }
	    	]
		});

        Ext.apply(config,{
        	title:'表单明细',
            activeItem:mainHidden?1:0,
            items: [
                this.toolbar,
	            {
		            title: '流程表单',
		            layout: 'fit',
	                items:this.mainTable,
	                hidden:mainHidden
	            },
	            {
		            title: '流程图',
	                items:Ext.create('mobile.UserImage',{
		            	type:config.imageType,
		        		id:config.id
		        	})
	            },
	    		Ext.create('mobile.UserInfo',{username:config.username})
            ],
            listeners:{
        		'activeitemchange':function(){

            	}
        	}
        });
    
        this.callParent([config]);
	},
	
	getVoteAgree:function(voteAgree){
		if(!this.signTask && voteAgree!=0){
			var segbtn = this.toolbar.items.getAt(0);
			var endCheck = segbtn.isPressed(segbtn.getAt(0));
			if(endCheck && voteAgree==1){
				voteAgree = 5;
			}else if(endCheck && voteAgree==2){
				voteAgree = 6;
			}
		}
		return voteAgree;
	}

});

