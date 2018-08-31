package com.casic.demo.controller.course;

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
import com.casic.demo.model.course.Student;
import com.casic.demo.model.course.StudentItem;
import com.casic.demo.service.course.StudentService;
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
 * 对象功能:demo_student 控制器类
 * 开发公司:tianzhi
 * 开发人员:zouping
 * 创建时间:2016-08-25 15:01:21
 *</pre>
 */
@Controller
@RequestMapping("/demo/course/student/")
public class StudentController extends BaseController
{
	@Resource
	private StudentService studentService;
	
	
	/**
	 * 添加或更新demo_student。
	 * @param request
	 * @param response
	 * @param student 添加或更新的实体
	 * @param bindResult
	 * @param viewName
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("save")
	@Action(description="添加或更新demo_student")
	public void save(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		String resultMsg=null;		
		Student student=getFormObject(request);
		try{
			if(student.getStudentId()==null||student.getStudentId()==0){
				student.setStudentId(UniqueIdUtil.genId());
				studentService.addAll(student);			
				resultMsg=getText("record.added","demo_student");
			}else{
			    studentService.updateAll(student);
				resultMsg=getText("record.updated","demo_student");
			}
			writeResultMessage(response.getWriter(),resultMsg,ResultMessage.Success);
		}catch(Exception e){
			writeResultMessage(response.getWriter(),resultMsg+","+e.getMessage(),ResultMessage.Fail);
		}
	}
	
	/**
	 * 取得 Student 实体 
	 * @param request
	 * @return
	 * @throws Exception
	 */
    protected Student getFormObject(HttpServletRequest request) throws Exception {
    
    	JSONUtils.getMorpherRegistry().registerMorpher(new DateMorpher((new String[] { "yyyy-MM-dd" })));
    
		String json=RequestUtil.getString(request, "json");
		JSONObject obj = JSONObject.fromObject(json);
		
		Map<String,  Class> map=new HashMap<String,  Class>();
		map.put("studentItemList", StudentItem.class);
		Student student = (Student)JSONObject.toBean(obj, Student.class,map);
		
		return student;
    }
	
	/**
	 * 取得demo_student分页列表
	 * @param request
	 * @param response
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("list")
	@Action(description="查看demo_student分页列表")
	public ModelAndView list(HttpServletRequest request,HttpServletResponse response) throws Exception
	{	
		List<Student> list=studentService.getAll(new JQGridQueryFilter(request));
		ModelAndView mv=this.getAutoView().addObject("studentList",list);
		
		return mv;
	}
	
	/**
	 * 取得demo_student分页列表数据结构
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
		List<Student> list = studentService.getAll(queryFilter);
		Map<String,Object> data = new HashMap<String,Object>();
		data.put("page", queryFilter.getPageBean().getCurrentPage());
		data.put("total", queryFilter.getPageBean().getTotalPage());	
		data.put("records", queryFilter.getPageBean().getTotalCount());
		data.put("rows", list);
		return data;
	}
	
	/**
	 * 删除demo_student
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("del")
	@Action(description="删除demo_student")
	public void del(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		String message=null;
		try{
			Long[] lAryId =RequestUtil.getLongAryByStr(request, "studentId");
			studentService.delAll(lAryId);
			message = "删除demo_student及其从表成功!";
			writeResultMessage(response.getWriter(),message,ResultMessage.Success);;
		}catch(Exception ex){
			message= "删除失败" + ex.getMessage();
			writeResultMessage(response.getWriter(),message,ResultMessage.Fail);
		}
	}
	
	/**
	 * 	编辑demo_student
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("edit")
	@Action(description="编辑demo_student")
	public ModelAndView edit(HttpServletRequest request) throws Exception
	{
		Long studentId=RequestUtil.getLong(request,"studentId");
		String returnUrl=RequestUtil.getPrePage(request);
		Student student=studentService.getById(studentId);
		List<StudentItem> studentItemList=studentService.getStudentItemList(studentId);
		
		return getAutoView().addObject("student",student)
							.addObject("studentItemList",studentItemList)
							.addObject("returnUrl",returnUrl);
	}

	/**
	 * 取得demo_student明细
	 * @param request   
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("get")
	@Action(description="查看demo_student明细")
	public ModelAndView get(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		long studentId=RequestUtil.getLong(request,"studentId");
		Student student = studentService.getById(studentId);	
		List<StudentItem> studentItemList=studentService.getStudentItemList(studentId);
		return getAutoView().addObject("student",student)
							.addObject("studentItemList",studentItemList);
	}
	
}
