
/**
 * 手机登录跳转
 * by cjj
 */

Ext.define('mobile.View', {
	extend: 'Ext.NavigationView',

	constructor: function (config) {
	
		config = config || {};
		
		Ext.apply(config,{
			defaultBackButtonText:'返回',
			items:[
		       Ext.create('mobile.Login',{})
			]
		});
		
		this.callParent([config]);
	}

});
