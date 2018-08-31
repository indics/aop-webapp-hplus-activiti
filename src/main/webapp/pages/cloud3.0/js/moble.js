/*
    @Use:index javascript---main
    @Auth:Sinrry
    @Version:v1.0
*/

//首页top下拉菜单
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
}

//导航二级菜单
var navlibtn = document.getElementById('navlibtn');
var navlibtn_li = navlibtn.getElementsByTagName('li');
var navmenucon=document.getElementById('navmenucon');
var nump = 0;

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
			navmenucon.style.height=19+'px';
		}
}


function getByClass(obj, sClass) {
	if (obj.getElementsByClassName) {
		return obj.getElementsByClassName(sClass);
	}
	var result = [];
	var arr = obj.getElementsByTagName('*');
	var re = new RegExp('\\b' + sClass + '\\b');
	for (var i = 0; i < arr.length; i++) {
		if (re.test(arr[i].className)) {
			result.push(arr[i]);
		}
	}
	return result;
}

//headerbg
var headerbg = document.getElementById('headerbg');
var headerbgli = headerbg.getElementsByTagName('li');
var timmer1 = null;
timmer1 = setInterval(nextbg, 3500);
var num = -1;

function nextbg() {
	for (var i = 0; i < headerbgli.length; i++) {
		headerbgli[i].index = i;
		for (var i = 0; i < headerbgli.length; i++) {
			headerbgli[i].style.display = 'none';
		}
		this.index = num;
		num++;
		if (num > 5) {
			num = 0;
		}
		headerbgli[num].style.display = 'block';
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

//底部二维码
var ewm = document.getElementById('ewm');
var ewmimg = ewm.getElementsByTagName('img')[0];
var onOFF = true;
ewm.onclick = function() {
		if (onOFF) {
			ewmimg.style.display = 'block';
			onOFF = false;
		} else {
			ewmimg.style.display = 'none';
			onOFF = true;
		}
	}
	//翻页选择页面效果
var TS = document.getElementById('TS');
var pchoce = document.getElementById('pchoce');
var pchoceli = pchoce.getElementsByTagName('li');
var onoff = true;

TS.onclick = function() {
	if (onoff) {
		pchoce.style.display = 'block';
		onoff = false;
	} else {
		pchoce.style.display = 'none';
		onoff = true;
	}
}
for (var i = 0; i < pchoceli.length; i++) {
	pchoceli[i].index = i;
	pchoceli[i].onmouseover = function() {
		for (var i = 0; i < pchoceli.length; i++) {
			pchoceli[i].className = '';
		}
		pchoceli[this.index].className = 'hover';
	}
}
//添加class
	function addClass(obj, sClass) {
	var rg = new RegExp('\\b' + sClass + '\\b');
	if (!rg.test(obj.className)) {
		var oldName = obj.className;
		obj.className = oldName ? oldName + ' ' + sClass : sClass;
	}
}
	
function borred(obj){
					var obj=document.getElementById(obj);
					obj.onclick=function(){
						this.style.borderColor='#ff991d';
					}
					obj.onmouseout=function(){
						this.style.borderColor='#9bb1c3';
					}
				}