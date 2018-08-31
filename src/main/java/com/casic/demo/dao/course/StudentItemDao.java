package com.casic.demo.dao.course;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.casic.demo.model.course.StudentItem;
import com.cosim.core.db.BaseDao;
/**
 *<pre>
 * 对象功能:demo_student_item Dao类
 * 开发公司:tianzhi
 * 开发人员:zouping
 * 创建时间:2016-08-25 15:01:21
 *</pre>
 */
@Repository
public class StudentItemDao extends BaseDao<StudentItem>
{
	@Override
	public Class<?> getEntityClass()
	{
		return StudentItem.class;
	}

	public List<StudentItem> getByMainId(Long studentId) {
		return this.getBySqlKey("getStudentItemList", studentId);
	}
	
	public void delByMainId(Long studentId) {
		this.delBySqlKey("delByMainId", studentId);
	}
}