/*
    @Use:index javascript---main
    @Auth:Sinrry
    @Version:v1.0
*/

/*//首页top下拉菜单
xiala('xiala1');
xiala('xiala2');

function xiala(obj) {
	var obj = document.getElementById(obj);
	var obja = obj.getElementsByTagName('a')[0];
	var objxl = obj.getElementsByTagName('dl')[0];
	obja.onmouseover = function() {
		objxl.style.display = 'block';
	}
	objxl.onmouseover = function() {
		objxl.style.display = 'block';
	}
	obja.onmouseout = function() {
		objxl.style.display = 'none';
	}
	objxl.onmouseout = function() {
		objxl.style.display = 'none';
	}
}*/

//导航二级菜单
var navlibtn = document.getElementById('navlibtn');
var navlibtn_li = navlibtn.getElementsByTagName('li');
var navmenucon=document.getElementById('navmenucon');
var nump = 0;
navmenucon.style.height=19+'px';
for (var i = 0; i < navlibtn_li.length; i++) {
	navlibtn_li[i].index = i;
	navlibtn_li[i].onmouseover = showi;
	navlibtn_li[i].onmouseout = hidei;
}

function showi() {

	for (var i = 0; i < navlibtn_li.length; i++) {
			navlibtn_li[i].className = '';
			navmenucon.style.height=19+'px';
	}
	nump++;
	if (nump > navlibtn_li.length - 1) {
		nump = navlibtn_li.length;
	}
	nump = this.index;
	navlibtn_li[nump].className = 'active';
	if (nump === 0) {
			navmenucon.style.height = 19 + 'px';
		} else {
			navmenucon.style.height = 38 + 'px';
		}
}
function hidei() {
		for (var i = 0; i < navlibtn_li.length; i++) {
			navlibtn_li[i].className = '';
			//navlibtn_li[0].className = 'active';
			navmenucon.style.height=19+'px';
		}
}

//焦点图
var divpicbox = document.getElementById('divpicbox');
var picboxul = divpicbox.getElementsByTagName('ul')[0];
var picboxli = divpicbox.getElementsByTagName('li');
var picboxp = divpicbox.getElementsByTagName('p');
var picboxspan = divpicbox.getElementsByTagName('span')[0];
var picboxbtn = picboxspan.getElementsByTagName('em');
var timmer = null;
var num = 0;
var liwidth = picboxli[0].offsetWidth;
//鼠标切换
for (var i = 0; i < picboxbtn.length; i++) {
	picboxbtn[i].index = i;
	picboxbtn[i].onmouseover = function() {
		num = this.index;
		switchTab();
	}
}
//自动播放
timmer = setInterval(nextPic, 3000);
divpicbox.onmouseover = function() {
	clearInterval(timmer);
};
divpicbox.onmouseout = function() {
	timmer = setInterval(nextPic, 3000);
};

//下一张
function nextPic() {
		num++;
		if (num >= picboxbtn.length) {
			num = 0;
		}
		switchTab();
	}
//切换函数
function switchTab() {
		doMove(picboxul, 787, -liwidth * num, 'left');
		for (var i = 0; i < picboxbtn.length; i++) {
			picboxbtn[i].className = '';
		}
		picboxbtn[num].className = 'cur';
	}
//运动封装(让谁动、方向、目标点、上下左右、回调函数)
function doMove(obj, dir, target, attr, endfn) {
	dir = parseInt(getStyle(obj, attr)) < target ? dir : -dir;
	clearInterval(obj.timer);
	obj.timer = setInterval(function() {
		var speedb = parseInt(getStyle(obj, attr)) + dir;
		if (speedb > target && dir > 0 || speedb < target && dir < 0) {
			speedb = target;
		}
		obj.style[attr] = speedb + 'px';
		if (speedb == target) {
			clearInterval(obj.timer);
			endfn && endfn();
		}
	}, 30)
};



//服务鼠标滑过事件
var Fwlist = document.getElementById('Fwlist');
var Fwlistli = Fwlist.getElementsByTagName('li');
for (var i = 0; i < Fwlistli.length; i++) {
	Fwlistli[i].index = i;
	Fwlistli[i].onmouseover = function() {
		for (var i = 0; i < Fwlistli.length; i++) {
			Fwlistli[i].className = '';
		}
		Fwlistli[this.index].className = 'cur'
	}
	Fwlistli[i].onmouseout = function() {
		for (var i = 0; i < Fwlistli.length; i++) {
			Fwlistli[i].className = '';
		}
	}
}



//底部显示隐藏
fdj();

function fdj() {
	var fdj1 = document.getElementById("fdj1");
	var fdj2 = document.getElementById("fdj2");
	var fdj3 = document.getElementById("fdj3");
	var fdj4 = document.getElementById("fdj4");
	var kaiguan = true;
	var kaiguan2 = true;
	fdj1.onclick = function() {
		if (kaiguan == true) {
			fdj2.style.height = "auto";
			fdj1.className = "fjt";
			kaiguan = false;
		} else {
			fdj2.style.height = "";
			fdj1.className = "";
			kaiguan = true;
		}
	}
	fdj3.onclick = function() {
		if (kaiguan2 == true) {
			fdj4.style.height = "auto";
			fdj3.className = "fjt";
			kaiguan2 = false;
		} else {
			fdj4.style.height = "";
			fdj3.className = "";
			kaiguan2 = true;
		}
	}

}


//带缩略图的焦点图
function getStyle(obj, attr) {
	if (obj.currentStyle) {
		return obj.currentStyle[attr];
	} else {
		return getComputedStyle(obj, false)[attr];
	}
}

function addClass(obj, sClass) {
	var rg = new RegExp('\\b' + sClass + '\\b');
	if (!rg.test(obj.className)) {
		var oldName = obj.className;
		obj.className = oldName ? oldName + ' ' + sClass : sClass;
	}
}

function removeClass(obj, sClass) {
	var rg = new RegExp('\\b' + sClass + '\\b');
	if (rg.test(obj.className)) {
		obj.className = obj.className.replace(rg, '').replace(/^\s+|\s+$/, '');
	}
}

function hasClass(obj, sClass) {
	var rg = new RegExp('\\b' + sClass + '\\b');
	if (rg.test(obj.className)) {
		return true;
	} else {
		return false;
	}
}

function movePic(obj, json, speedNum, flowWidth, fn) {
	obj.lastMove = 0;
	var now = new Date().getTime();
	if (now - obj.lastMove >= 30) {
		move();
	}
	clearInterval(obj.timer);
	obj.timer = setInterval(move, 30);

	function move() {
		var t = true;
		for (var name in json) {
			if (name == 'opacity') {
				var cur = Math.round(parseFloat(getStyle(obj, name)) * 100);
				var iTarget = json[name]
			} else {
				var cur = parseInt(getStyle(obj, name));
				var iTarget = flowWidth ? json[name] + flowWidth : json[name];
			}
			if (isNaN(cur)) {
				name == 'opacity' ? cur = 100 : cur = 0;
			}
			var speed = (iTarget - cur) / speedNum;
			speed = speed > 0 ? Math.ceil(speed) : Math.floor(speed);
			if (cur != iTarget) {
				if (name == 'opacity') {
					obj.style.filter = 'alpha(opacity:' + (cur + speed) + ')';
					obj.style.opacity = (cur + speed) / 100;
				} else {
					obj.style[name] = cur + speed + 'px';
				}
				t = false;
			}
		}
		if (t) {
			clearInterval(obj.timer);
			fn && fn();
		}
		var now = new Date().getTime();
		obj.lastMove = now;
	};
}
var photos = document.getElementById('photos');
var oB = document.getElementById('P1'),
	aB = oB.children;
var oM = document.getElementById('miniP1'),
	aM = oM.children;
var oPrev = document.getElementById('prev1');
var oNext = document.getElementById('next1');
var oPrevv = document.getElementById('prev2');
var oNextt = document.getElementById('next2');
var now = 0,
	oTimer = null;
var oW1 = aB[0].offsetWidth,
	oW2 = aM[0].offsetWidth;
for (var i = 0; i < aM.length; i++) {
	(function(index) {
		aM[i].onclick = function() {
			now = index;
			tabi();
		};
	})(i);
}
oTimer = setInterval(next, 4000);
photos.onmouseover = function() {
	clearInterval(oTimer);
};
photos.onmouseout = function() {
	oTimer = setInterval(next, 4000);
};
oNext.onclick = next;
oPrev.onclick = prev;
oNext.onclick = next;
oPrev.onclick = prev;

function prev() {
	now--;
	now < 0 && (now = aB.length - 1);
	now == aB.length - 1 && movePic(oM, {
		left: -oW2 * (now - 6)
	}, 5, null);
	if (now < aB.length - 6) {
		movePic(oM, {
			left: -oW2 * now
		}, 5, null);
	} else {
		movePic(oM, {
			left: -oW2 * (aB.length - 7)
		}, 5, null);
	}
	tabi();
}

function next() {
	now++;
	now >= aB.length && (now = 0);
	if (now < aB.length - 6) {
		movePic(oM, {
			left: -oW2 * now
		}, 5, null);
	} else {
		movePic(oM, {
			left: -oW2 * (aB.length - 7)
		}, 5, null);
	}
	tabi();
}

function tabi() {
	for (var i = 0; i < aM.length; i++) {
		aM[i].className = '';
	}
	aM[now].className = 'cur';
	movePic(oB, {
		left: -oW1 * now
	}, 5, null);
}

