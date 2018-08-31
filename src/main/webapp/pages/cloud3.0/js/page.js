//登录切换
			function Tab(Tabobj, Tabbtn, Tabcon, iffor) {
				var Tabobj = document.getElementById(Tabobj);
				var Tabbtn = Tabobj.getElementsByTagName(Tabbtn);
				var Tabcon = Tabobj.getElementsByTagName(Tabcon);
				var Timer = null;
				var num = 0;
				for (var i = 0; i < Tabbtn.length; i++) {
					Tabbtn[i].index = i;
					Tabbtn[i].onmouseover = function() {
						num = this.index;
						Tabmian();
					};
				}
				if (iffor === 1) {
					setTimeTab();
					Tabobj.onmouseover = function() {
						clearInterval(Timer);
						Tabmian();
					}
					Tabobj.onmouseout = function() {
						setTimeTab();
					}
				} else if (iffor === 0) {
					Tabmian();
				}
				function setTimeTab() {
					Timer = setInterval(function() {
						num++;
						if (num > Tabbtn.length - 1) {
							num = 0;
						} else if (num < -1) {
							num = Tabbtn.length;
						}
						Tabmian();
					}, 3000);
				}
				function Tabmian() {
					for (var i = 0; i < Tabbtn.length; i++) {
						Tabbtn[i].index = i;
						for (var i = 0; i < Tabbtn.length; i++) {
							Tabbtn[i].className = ''
							Tabcon[i].style.display = 'none';
							Tabcon[i].className = ''
						}
						Tabbtn[num].className = 'active';
						Tabcon[num].style.display = 'block';
						Tabcon[num].className = 'active';
					}
				}
			}
			//翻页选择页面效果
var TS = document.getElementById('TS');
var pchoce = document.getElementById('pchoce');
var pchoceli = pchoce.getElementsByTagName('li');
var onoff=true;

TS.onclick = function() {
	if(onoff){
		pchoce.style.display='block';
		onoff=false;
	}else{
		pchoce.style.display='none';
		onoff=true;
	}
}
for (var i = 0; i < pchoceli.length; i++) {
		pchoceli[i].index = i;
		pchoceli[i].onmouseover = function() {
				for(var i=0;i<pchoceli.length;i++){
					pchoceli[i].className='';
				}
				pchoceli[this.index].className='hover';
		}
	}