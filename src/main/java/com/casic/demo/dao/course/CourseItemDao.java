package com.casic.demo.dao.course;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.casic.demo.model.course.CourseItem;
import com.cosim.core.db.BaseDao;
/**
 *<pre>
 * 对象功能:cloud_course_item Dao类
 * 开发公司:tianzhi
 * 开发人员:zouping
 * 创建时间:2016-05-20 11:59:20
 *</pre>
 */
@Repository
public class CourseItemDao extends BaseDao<CourseItem>
{
	@Override
	public Class<?> getEntityClass()
	{
		return CourseItem.class;
	}

	public List<CourseItem> getByMainId(Long courseId) {
		return this.getBySqlKey("getCourseItemList", courseId);
	}
	
	public void delByMainId(Long courseId) {
		this.delBySqlKey("delByMainId", courseId);
	}
}