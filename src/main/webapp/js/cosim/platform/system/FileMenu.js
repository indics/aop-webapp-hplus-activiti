FileMenu=function(){
	{
		this.rootMenu=null;
		this.menuMenu=null;
		this.treeNode=null;
	};
	this.getMenu=function(treeNode,handler){
		this.treeNode=treeNode;
		var isRoot=0;
		if(treeNode.isRoot) isRoot=1;
		
		var items=[];
		if(treeNode.userId==0){
			items.push({ text: '添加分类', click: handler});
		}
		items.push({ text: '添加我的分类', click: handler });
		items.push({ text: '编辑分类', click: handler});
		items.push({ text: '删除分类', click: handler});
		this.menuMenu = $.ligerMenu({top: 100, left: 100, width: 120, items:items});
		
		this.rootMenu=$.ligerMenu({ top: 100, left: 100, width: 120, items:
	        [{ text: '添加分类', click: handler  },
	         { text: '添加我的分类', click: handler  }]});
		if(isRoot==1){
			return this.rootMenu;
		}
		else{
			return this.menuMenu;
		}
	};
};
