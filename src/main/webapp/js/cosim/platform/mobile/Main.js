
/**
 * 手机功能菜单
 * by cjj
 */

Ext.define('mobile.Main', {
    extend: 'Ext.Panel',
    
    name:'main',

    constructor:function(config){
		
		var username = config.username;
		
		config = config || {};
		
		var selfItem = [];

		var rowPanel = null;
		
		var menuSize = menus.length;
		if(menus.length!=0 && menus.length%4!=0){
			while(menuSize%4!=0){
				menuSize++;
			}
		}

		for(var idx=0;idx<menuSize;idx++){
			
			if(idx==0||idx%4==0){
				rowPanel = Ext.create('Ext.Panel', {
					layout: {
						type: 'hbox',
						align: 'middle'
					}
				});
			}
			
			var itemPanel = Ext.create('Ext.Panel', {
				layout: {
					type: 'vbox',
					align: 'middle'
				},
				style: {
					'padding-top':'15px',
					'padding-bottom':'15px'
				},
				flex:1,
		    	height:100
			});

			if(idx<menus.length)
			{
				var item = menus[idx];
	
				itemPanel.add({
					xtype:'image',
					name:item.view,
					width:50,
					height:50,
					cls:item.cls,
					listeners:{
						tap:function(){
							mobileView.push(
								Ext.create(this.config.name,{
									username:username,
									title:item.title
								})
							);
						}
					}
				});
				
				itemPanel.add({
					xtype:'label',
					style: {
					    'text-align': 'center',
					    'font-size' : '9pt'
					},
					html:item.title
				});
			}

			rowPanel.add(itemPanel);
			
			if(idx==0||idx%4==0){
				selfItem.push(rowPanel);
			}
		}
		
		selfItem.push(Ext.create('mobile.UserInfo',{username:username}));

		Ext.apply(config,{
			title:'功能菜单',
			items:selfItem
		});
		
		this.callParent([config]);
    }

});