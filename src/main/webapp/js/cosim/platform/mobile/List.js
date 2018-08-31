
/**
 * 通用list
 * 
 * fields: 定义moodel字段
 * {
 * 	 {name: 'id',type: 'string'},
 *	 {name: "subject",  type: "string"}
 * }
 * url： store访问url
 * root： json数据根目录
 * searchCol： 定义检索的字段
 * username： 用户名称
 * 
 * by cjj
 */

Ext.define('mobile.List', {
    extend: 'Ext.List',
    
    name: 'htList',

    constructor: function (config) {
		
    	config = config || {};
    	
    	this.username = config.username;

		Ext.define('taskItem', {
			extend: 'Ext.data.Model',
			config: {
				fields: config.fields
			}
		});
		
		this.store = Ext.create('Ext.data.Store', {
			model: 'taskItem',
			proxy: {
		        type: "ajax",
		        url : config.url,
	            actionMethods: {
	                create : 'POST',
	                read   : 'POST', 
	                update : 'POST',
	                destroy: 'POST'
	            },
		        reader: {
		            type: "json",
		            rootProperty: config.root
		        }
		    },
		    autoLoad: true
		});
		
		this.searchCol = config.searchCol;

		var toolbar = Ext.create('Ext.Toolbar', {
            docked: 'top',
	        items: [
	            {xtype:'spacer'},
	            {
	                xtype: 'searchfield',
	                placeHolder: ' 搜索...',
	                name:'searchField',
	                flex:3
	            },
	            {
	                xtype: 'button',
		            iconCls: 'search',
		            iconMask: true,
	                scope:this,
	                flex:.5,
	                handler: this.onSearchTask
	            },
	            {
	                xtype: 'button',
		            iconCls: 'refresh',
		            iconMask: true,
	                scope:this,
	                flex:.5,
	                handler: function(){
	                	var searchVal = this.down('toolbar').getCmpByName('searchField');
	                	searchVal.setValue('');
	                	this.store.getProxy().setExtraParam(this.searchCol, ''); 
	                	this.store.load();
	            	}
	            },
	            {xtype:'spacer'}
	        ]
		});

    	Ext.apply(config,{
		    fullscreen: true,
		    store: this.store,
    		loadingText:'请稍候',
            items: [toolbar,
			Ext.create('mobile.UserInfo',{username:config.username})]
    	});

    	this.callParent([config]);

    },
    
    onSearchTask:function(){
		var searchVal = this.down('toolbar').getCmpByName('searchField');
		this.store.getProxy().setExtraParam(this.searchCol, searchVal.getValue()); 
		this.store.load();
    }

});
