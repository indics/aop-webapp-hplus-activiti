package com.casic.demo.service.course;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.casic.demo.dao.course.CourseDao;
import com.casic.demo.dao.course.CourseItemDao;
import com.casic.demo.model.course.Course;
import com.casic.demo.model.course.CourseItem;
import com.cosim.core.db.IEntityDao;
import com.cosim.core.service.BaseService;
import com.cosim.core.util.BeanUtils;
import com.cosim.core.util.UniqueIdUtil;

/**
 *<pre>
 * 对象功能:cloud_course Service类
 * 开发公司:tianzhi
 * 开发人员:zouping
 * 创建时间:2016-05-20 11:59:20
 *</pre>
 */
@Service
public class CourseService extends BaseService<Course>
{
	@Resource
	private CourseDao dao;
	
	@Resource
	private CourseItemDao courseItemDao;
	
	public CourseService()
	{
	}
	
	@Override
	protected IEntityDao<Course, Long> getEntityDao() 
	{
		return dao;
	}
	
	private void delByPk(Long id){
		courseItemDao.delByMainId(id);
	}
	
	public void delAll(Long[] lAryId) {
		for(Long id:lAryId){	
			delByPk(id);
			dao.delById(id);	
		}	
	}
	
	public void addAll(Course course) throws Exception{
		add(course);
		addSubList(course);
	}
	
	public void updateAll(Course course) throws Exception{
		update(course);
		delByPk(course.getId());
		addSubList(course);
	}
	
	public void addSubList(Course course) throws Exception{
		List<CourseItem> courseItemList=course.getCourseItemList();
		if(BeanUtils.isNotEmpty(courseItemList)){
			for(CourseItem courseItem:courseItemList){
				courseItem.setCourseId(course.getId());
				courseItem.setId(UniqueIdUtil.genId());
				courseItemDao.add(courseItem);
			}
		}
	}
	
	public List<CourseItem> getCourseItemList(Long id) {
		return courseItemDao.getByMainId(id);
	}
}
