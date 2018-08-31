
/**
 * 全局变量和公共方法
 * by cjj
 */
	
/**
 * 是否查看流程图
 */
var isUserImage = false; 
	
/**
 * 取得流程图
 * type: 查看流程图的id类型。1：taskId；2：runId
 * id: 对应流程图的id
 */
var userImage = function(type, id){
	isUserImage = true;

	mobileView.push(
		Ext.create('mobile.UserImage',{
			type:type,
			id:id
		})
	);
	
};