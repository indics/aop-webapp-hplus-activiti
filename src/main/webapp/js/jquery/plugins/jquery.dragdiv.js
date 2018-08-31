/**可拖拽div插件,可与zTree的拖拽树配合使用**/
;(function($){
	$.fn.dragdiv=$.fn.dragDiv=function(options){		
		options=$.extend({
			errorMsg:'目标对象有误',
			curTarget: null,
			curTmpTarget: null,
			targetTree: null,
			buddy:null,
			noSel: function() {
				try {
					window.getSelection ? window.getSelection().removeAllRanges() : document.selection.empty();
				} catch(e){}
			},
			dragTree2Dom: function(treeId, treeNodes) {
				return !treeNodes[0].isParent;
			},
			prevTree: function(treeId, treeNodes, targetNode) {
				return !targetNode.isParent && targetNode.parentTId == treeNodes[0].parentTId;
			},
			nextTree: function(treeId, treeNodes, targetNode) {
				return !targetNode.isParent && targetNode.parentTId == treeNodes[0].parentTId;
			},
			innerTree: function(treeId, treeNodes, targetNode) {
				return targetNode!=null && targetNode.isParent && targetNode.tId == treeNodes[0].parentTId;
			},
			dropTree2Dom: function(e, treeId, treeNodes, targetNode, moveType) {				
				if (moveType == null && (/item-div/gi.test(e.target.className) || $(e.target).parents(".item-div").length > 0)) {
					var zTree = $.fn.zTree.getZTreeObj(options.buddy);
					zTree.removeNode(treeNodes[0]);

					var newDom = $("span[itemId=" + treeNodes[0].id + "]");
					if (newDom.length > 0) {
						newDom.removeClass("item-span-Disabled");
						newDom.addClass("item-span");
					} else {
						$("#" + itemId).append("<span class='item-span' itemId='" + treeNodes[0].id + "'>" + treeNodes[0].name + "</span>");
					}
					options.updateType();
				} else if ( $(e.target).parents('#'+options.buddy).length > 0) {
					
					var zTree = $.fn.zTree.getZTreeObj(options.buddy),
						html=$(e.target).html(),
				    	node = zTree.getNodeByParam("name",html,null),parentNode;
					
					if (node != null && node.isParent) {
						parentNode = node;
					} else if (node != null && !node.isParent) {
						parentNode = node.getParentNode();
					}
					if (!!parentNode) {						
						var nodes = zTree.addNodes(parentNode, treeNodes[0]);
						zTree.selectNode(nodes[0]);						
						zTree.removeNode(treeNodes[0]);
						options.updateType();
					}
				}
			},
			dom2Tree: function(e, treeId, treeNode) {
				var target = options.curTarget, tmpTarget = options.curTmpTarget;
				if (!target) return;
				var zTree = $.fn.zTree.getZTreeObj(options.buddy), parentNode;
				if (treeNode != null && treeNode.isParent) {
					parentNode = treeNode;
				} else if (treeNode != null && !treeNode.isParent) {
					parentNode = treeNode.getParentNode();
				}

				if (tmpTarget) tmpTarget.remove();
				if (!!parentNode) {
					var nodes = zTree.addNodes(parentNode, {id:target.attr("itemId"), name: target.text()});
					zTree.selectNode(nodes[0]);
				} else {
					target.removeClass("item-span-Disabled");
					target.addClass("item-span");
					alert(options.errorMsg);
				}
				options.updateType();
				options.curTarget = null;
				options.curTmpTarget = null;
			},
			updateType: function() {
				var zTree = $.fn.zTree.getZTreeObj(options.buddy),
				nodes = zTree.getNodes();
				for (var i=0, l=nodes.length; i<l; i++) {
					var num = nodes[i].children ? nodes[i].children.length : 0;
					nodes[i].name = nodes[i].name.replace(/ \(.*\)/gi, "") + " (" + num + ")";
					zTree.updateNode(nodes[i]);
				}
			},
			bindMouseDown: function(e) {
				if(!options.targetTree)options.initTreeEventBind();
				var target = e.target;
				if (target!=null && target.className=="item-span") {
					var doc = $(document), target = $(target),
					docScrollTop = doc.scrollTop(),
					docScrollLeft = doc.scrollLeft();
					target.addClass("item-span-Disabled");
					target.removeClass("item-span");
					curDom = $("<span class='item_tmp item-span'>" + target.text() + "</span>");
					curDom.appendTo("body");

					curDom.css({
						"top": (e.clientY + docScrollTop + 3) + "px",
						"left": (e.clientX + docScrollLeft + 3) + "px"
					});
					options.curTarget = target;
					options.curTmpTarget = curDom;

					doc.bind("mousemove", options.bindMouseMove);
					doc.bind("mouseup", options.bindMouseUp);
				}
				if(e.preventDefault) {
					e.preventDefault();
				}
			},
			bindMouseMove: function(e) {
				options.noSel();
				var doc = $(document), 
				docScrollTop = doc.scrollTop(),
				docScrollLeft = doc.scrollLeft(),
				tmpTarget = options.curTmpTarget;
				if (tmpTarget) {
					tmpTarget.css({
						"top": (e.clientY + docScrollTop + 3) + "px",
						"left": (e.clientX + docScrollLeft + 3) + "px"
					});
				}
				return false;
			},
			//初始化buddy tree的事件绑定
			initTreeEventBind:function(){
				options.targetTree = $.fn.zTree.getZTreeObj(options.buddy);
				if(options.targetTree){
					options.targetTree.setting.edit.drag.prev = options.prevTree;
					options.targetTree.setting.edit.drag.next = options.nextTree;
					options.targetTree.setting.edit.drag.inner = options.innerTree;
					options.targetTree.setting.callback.beforeDrag = options.dragTree2Dom;
					options.targetTree.setting.callback.onDrop = options.dropTree2Dom;
					options.targetTree.setting.callback.onMouseUp = options.dom2Tree;
				}
			},
			bindMouseUp: function(e) {				
				var doc = $(document);
				doc.unbind("mousemove", options.bindMouseMove);
				doc.unbind("mouseup", options.bindMouseUp);

				var target = options.curTarget, tmpTarget = options.curTmpTarget;
				if (tmpTarget) tmpTarget.remove();

				if ($(e.target).parents('#'+options.buddy).length == 0) {
					if (target) {
						target.removeClass("item-span-Disabled");
						target.addClass("item-span");
					}
					options.curTarget = null;
					options.curTmpTarget = null;
				}
			}
		},options||{});
		if(!options.data)return this;		
		var parseItem=function(data){
			var html=[];
			if(!data.items){
				html.push(['<span class="item-span"']);
				if(data.id) html.push(' itemId="'+data.id+'"');
				if(data.desc) html.push(' itemDesc="'+data.desc+'"');
				html.push('>');
				if(data.name) html.push(data.name);
				html.push('</span>');
			}
			else{				
				html.push('<div class="item-div"');
				if(data.id) html.push(' itemId="'+data.id+'"');
				if(data.desc) html.push(' itemDesc="'+data.desc+'"');
				html.push('><div class="title-div">');
				if(data.name) html.push(data.name);
				html.push('</div>');
				for(var i=0,c;c=data.items[i++];){
					html.push(parseItem(c));
				}
				html.push('</div>');
			}
			return html.join('');
		};
		var html=parseItem(options.data);		
		return this.each(function(){
			$(this).html(html);
			if(options.buddy){
				$(this).bind("mousedown",options.bindMouseDown);
				$("#"+options.buddy).bind("mouseover",function(){				
					if(!options.targetTree)options.initTreeEventBind();
				});
			}
		});
	};
})(jQuery);