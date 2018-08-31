package com.casic.demo.service.course;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.casic.demo.dao.course.StudentDao;
import com.casic.demo.dao.course.StudentItemDao;
import com.casic.demo.model.course.Student;
import com.casic.demo.model.course.StudentItem;
import com.cosim.core.db.IEntityDao;
import com.cosim.core.service.BaseService;
import com.cosim.core.util.BeanUtils;
import com.cosim.core.util.UniqueIdUtil;

/**
 *<pre>
 * 对象功能:demo_student Service类
 * 开发公司:tianzhi
 * 开发人员:zouping
 * 创建时间:2016-08-25 15:01:21
 *</pre>
 */
@Service
public class StudentService extends BaseService<Student>
{
	@Resource
	private StudentDao dao;
	
	@Resource
	private StudentItemDao studentItemDao;
	
	
	public StudentService()
	{
	}
	
	@Override
	protected IEntityDao<Student, Long> getEntityDao() 
	{
		return dao;
	}
	
	private void delByPk(Long studentId){
		studentItemDao.delByMainId(studentId);
	}
	
	public void delAll(Long[] lAryId) {
		for(Long id:lAryId){	
			delByPk(id);
			dao.delById(id);	
		}	
	}
	
	public void addAll(Student student) throws Exception{
		add(student);
		addSubList(student);
	}
	
	public void updateAll(Student student) throws Exception{
		update(student);
		delByPk(student.getStudentId());
		addSubList(student);
	}
	
	public void addSubList(Student student) throws Exception{
		List<StudentItem> studentItemList=student.getStudentItemList();
		if(BeanUtils.isNotEmpty(studentItemList)){
			for(StudentItem studentItem:studentItemList){
				studentItem.setStudentId(student.getStudentId());
				studentItem.setItemId(UniqueIdUtil.genId());
				studentItemDao.add(studentItem);
			}
		}
	}
	
	public List<StudentItem> getStudentItemList(Long studentId) {
		return studentItemDao.getByMainId(studentId);
	}
	
	
}
