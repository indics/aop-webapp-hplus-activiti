
/**
 * 手机用户信息
 * by cjj
 */

Ext.define('mobile.UserInfo', {
    extend: 'Ext.Toolbar',
    
    constructor: function (config) {
		
    	config = config || {};
    
		Ext.apply(config,{
		    docked: 'bottom',
    	    items: [
    	        { xtype: 'spacer' },
    	        {
    	            xtype: 'label',
    	            html: config.username
    	        },
    	        { xtype: 'spacer' }
    	    ]
		});
		
		this.callParent([config]);
	}
});