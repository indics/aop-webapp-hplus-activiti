var FE_interact={
	tab:function (titName,contName,ctrlClass) {
		titName.find("li").hover(function () {
			$(this).addClass(ctrlClass).siblings().removeClass(ctrlClass);
			contName.find("li").eq($(this).index()).addClass(ctrlClass).siblings().removeClass(ctrlClass);
		})
	},
	changeColor:function (oEle,aClass) {
		oEle.hover(function () {
			$(this).addClass(aClass);
		},function () {
			$(this).removeClass(aClass);
		})
	},
	focusMove:function (lBtn,rBtn,moveUl) {
		var num = 0;
		var moveDistance = null;
		var moveUlLiLength = moveUl.find("li").length;
		rBtn.click(function () {
			num++;
			moveDistance = moveUl.find("li").outerWidth(true)*(-1)*num;
			if (num>moveUlLiLength-4) {
				num=moveUlLiLength-4;
				return;
			}
			moveUl.stop().animate({left:moveDistance},300);
		})
		lBtn.click(function () {
			num--;
			moveDistance = moveUl.find("li").outerWidth(true)*(-1)*num;
			if (num<0) {
				num=0;
				return;
			}
			moveUl.stop().animate({left:moveDistance},300);
		})
	},
	numsChange:function (reduceBtn,addBtn,oNumEle) {
		reduceBtn.click(function () {
			var aNumEleValue = oNumEle.val();
			--aNumEleValue ;
			if (aNumEleValue<=0) {
				aNumEleValue = 0;
			}
			oNumEle.val(aNumEleValue);
		})
		addBtn.click(function () {
			var aNumEleValue = oNumEle.val();
			++aNumEleValue ;
//			if (aNumEleValue<=0) {
//				aNumEleValue = 0;
//			}
			oNumEle.val(aNumEleValue);
		})
	}
}

