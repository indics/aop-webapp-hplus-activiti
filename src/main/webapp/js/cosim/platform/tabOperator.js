/**
 * 在主框架新建Tab
 * @param conf
 */
function addTabItem(conf)
{
	top.tab.addTabItem(conf);
}
/**
 * 关闭主框架的tab选项
 * @param tabId
 */
function closeTabItem(tabId){
	top.tab.removeTabItem(tabId);
}