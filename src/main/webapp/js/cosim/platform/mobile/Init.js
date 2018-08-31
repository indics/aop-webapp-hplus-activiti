/**
 * 手机登录初始化
 * by cjj
 */

Ext.Loader.setConfig({
    enabled: true,
	paths: {  
		'mobile': 'js/hotent/platform/mobile'  
	} 
});

Ext.application({
	
    name: 'mobileLogin',

    launch: function() {
		
    	clientWidth = document.body.clientWidth;
        mobileView = Ext.create('mobile.View', {fullscreen: true});

    }

});