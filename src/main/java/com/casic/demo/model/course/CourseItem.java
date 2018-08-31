package com.casic.demo.model.course;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;

import com.cosim.core.model.BaseModel;
/**
 * 对象功能:cloud_course_item Model对象
 * 开发公司:tianzhi
 * 开发人员:zouping
 * 创建时间:2016-05-20 11:59:20
 */
public class CourseItem extends BaseModel
{
	// id
	protected Long  id;
	// course_id
	protected Long  courseId;
	// course_name
	protected String  courseName;
	// course_teacher
	protected String  courseTeacher;
	public void setId(Long id) 
	{
		this.id = id;
	}
	/**
	 * 返回 id
	 * @return
	 */
	public Long getId() 
	{
		return this.id;
	}
	public void setCourseId(Long courseId) 
	{
		this.courseId = courseId;
	}
	/**
	 * 返回 course_id
	 * @return
	 */
	public Long getCourseId() 
	{
		return this.courseId;
	}
	public void setCourseName(String courseName) 
	{
		this.courseName = courseName;
	}
	/**
	 * 返回 course_name
	 * @return
	 */
	public String getCourseName() 
	{
		return this.courseName;
	}
	public void setCourseTeacher(String courseTeacher) 
	{
		this.courseTeacher = courseTeacher;
	}
	/**
	 * 返回 course_teacher
	 * @return
	 */
	public String getCourseTeacher() 
	{
		return this.courseTeacher;
	}


   	/**
	 * @see java.lang.Object#equals(Object)
	 */
	public boolean equals(Object object) 
	{
		if (!(object instanceof CourseItem)) 
		{
			return false;
		}
		CourseItem rhs = (CourseItem) object;
		return new EqualsBuilder()
		.append(this.id, rhs.id)
		.append(this.courseId, rhs.courseId)
		.append(this.courseName, rhs.courseName)
		.append(this.courseTeacher, rhs.courseTeacher)
		.isEquals();
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() 
	{
		return new HashCodeBuilder(-82280557, -700257973)
		.append(this.id) 
		.append(this.courseId) 
		.append(this.courseName) 
		.append(this.courseTeacher) 
		.toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	public String toString() 
	{
		return new ToStringBuilder(this)
		.append("id", this.id) 
		.append("courseId", this.courseId) 
		.append("courseName", this.courseName) 
		.append("courseTeacher", this.courseTeacher) 
		.toString();
	}
   
  

}