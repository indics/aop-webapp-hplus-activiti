package com.casic.demo.dao.course;

import org.springframework.stereotype.Repository;

import com.casic.demo.model.course.Student;
import com.cosim.core.db.BaseDao;
/**
 *<pre>
 * 对象功能:demo_student Dao类
 * 开发公司:tianzhi
 * 开发人员:zouping
 * 创建时间:2016-08-25 15:01:21
 *</pre>
 */
@Repository
public class StudentDao extends BaseDao<Student>
{
	@Override
	public Class<?> getEntityClass()
	{
		return Student.class;
	}

}