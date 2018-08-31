package com.casic.demo.dao.course;

import org.springframework.stereotype.Repository;

import com.casic.demo.model.course.Course;
import com.cosim.core.db.BaseDao;
/**
 *<pre>
 * 对象功能:cloud_course Dao类
 * 开发公司:tianzhi
 * 开发人员:zouping
 * 创建时间:2016-05-20 11:59:20
 *</pre>
 */
@Repository
public class CourseDao extends BaseDao<Course>
{
	@Override
	public Class<?> getEntityClass()
	{
		return Course.class;
	}

}