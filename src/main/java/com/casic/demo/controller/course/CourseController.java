package com.casic.demo.controller.course;

import java.io.IOException;
import java.io.InputStreamReader;
import java.io.LineNumberReader;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.casic.core.web.query.JQGridQueryFilter;
import com.casic.demo.model.course.Course;
import com.casic.demo.model.course.CourseItem;
import com.casic.demo.service.course.CourseService;
import com.cosim.core.annotion.Action;
import com.cosim.core.util.UniqueIdUtil;
import com.cosim.core.web.ResultMessage;
import com.cosim.core.web.controller.BaseController;
import com.cosim.core.web.util.RequestUtil;

import net.sf.ezmorph.object.DateMorpher;
import net.sf.json.JSONObject;
import net.sf.json.util.JSONUtils;
/**
 *<pre>
 * 对象功能:cloud_course 控制器类
 * 开发公司:tianzhi
 * 开发人员:zouping
 * 创建时间:2016-05-20 11:59:20
 *</pre>
 */
@Controller
@RequestMapping("/demo/course/course/")
public class CourseController extends BaseController
{
	@Resource
	private CourseService courseService;
	
	/**
	 * 添加或更新cloud_course。
	 * @param request
	 * @param response
	 * @param course 添加或更新的实体
	 * @param bindResult
	 * @param viewName
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("save")
	@Action(description="添加或更新cloud_course")
	public void save(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		String resultMsg=null;
		Course course=getFormObject(request);
//		org.slf4j.spi.LocationAwareLogger
		try{
			if(course.getId()==null||course.getId()==0){
				course.setId(UniqueIdUtil.genId());
				courseService.addAll(course);			
				resultMsg=getText("record.added","cloud_course");
			}else{
			    courseService.updateAll(course);
				resultMsg=getText("record.updated","cloud_course");
			}
			writeResultMessage(response.getWriter(),resultMsg,ResultMessage.Success);
		}catch(Exception e){
			writeResultMessage(response.getWriter(),resultMsg+","+e.getMessage(),ResultMessage.Fail);
		}
	}
	
	/**
	 * 取得 Course 实体 
	 * @param request
	 * @return
	 * @throws Exception
	 */
    protected Course getFormObject(HttpServletRequest request) throws Exception {
    
    	JSONUtils.getMorpherRegistry().registerMorpher(new DateMorpher((new String[] { "yyyy-MM-dd" })));
    
		String json=RequestUtil.getString(request, "json");
		JSONObject obj = JSONObject.fromObject(json);
		
		Map<String,  Class> map=new HashMap<String,  Class>();
		map.put("courseItemList", CourseItem.class);
		Course course = (Course)JSONObject.toBean(obj, Course.class,map);
		
		return course;
    }
	
	/**
	 * 取得cloud_course分页列表
	 * @param request
	 * @param response
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("list")
	@Action(description="查看cloud_course分页列表")
	public ModelAndView list(HttpServletRequest request,HttpServletResponse response) throws Exception
	{	
		//获取客户端的ip和Mac地址
		List<Course> list=courseService.getAll(new JQGridQueryFilter(request));
		ModelAndView mv=this.getAutoView().addObject("courseList",list);
		
		return mv;
	}

	/**
	 * 取得cloud_course分页列表数据结构
	 * {total:xxx,page:yyy,records:zzz,rows:[{name1:”Row01″,name2:”Row 11″,name3:”Row 12″,name4:”Row 13″,name5:”Row 14″}]}
	 * page:当前页
	 * total:总页数
	 * records:记录数
	 * @param request
	 * @param response
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("listData")
	@ResponseBody
	public Map<String,Object> listData(HttpServletRequest request,HttpServletResponse response) throws Exception
	{	
		JQGridQueryFilter queryFilter = new JQGridQueryFilter(request);
		List<Course> list = courseService.getAll(queryFilter);
		Map<String,Object> data = new HashMap<String,Object>();
		data.put("page", queryFilter.getPageBean().getCurrentPage());
		data.put("total", queryFilter.getPageBean().getTotalPage());	
		data.put("records", queryFilter.getPageBean().getTotalCount());
		data.put("rows", list);
		return data;
	}
	
	/**
	 * 删除cloud_course
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("del")
	public void del(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		String message=null;
		try{
			Long[] lAryId =RequestUtil.getLongAryByStr(request, "id");
			courseService.delAll(lAryId);
			message = "删除cloud_course及其从表成功!";
			writeResultMessage(response.getWriter(),message,ResultMessage.Success);
		}catch(Exception ex){
			message= "删除失败" + ex.getMessage();
			writeResultMessage(response.getWriter(),message,ResultMessage.Fail);
		}
	}
	
	/**
	 * 	编辑cloud_course
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("edit")
	@Action(description="编辑cloud_course")
	public ModelAndView edit(HttpServletRequest request) throws Exception
	{
		Long id=RequestUtil.getLong(request,"id");
		String returnUrl=RequestUtil.getPrePage(request);
		Course course=courseService.getById(id);
		List<CourseItem> courseItemList=courseService.getCourseItemList(id);
		
		return getAutoView().addObject("course",course)
							.addObject("courseItemList",courseItemList)
							.addObject("returnUrl",returnUrl)
							.addObject("applyFlag",0);
	}

	/**
	 * 取得cloud_course明细
	 * @param request   
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("get")
	@Action(description="查看cloud_course明细")
	public ModelAndView get(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		long id=RequestUtil.getLong(request,"id");
		Course course = courseService.getById(id);	
		List<CourseItem> courseItemList=courseService.getCourseItemList(id);
		return getAutoView().addObject("course",course)
							.addObject("courseItemList",courseItemList);
	}
}
