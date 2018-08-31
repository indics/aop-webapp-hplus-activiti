package com.casic.demo.model.course;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;

import com.cosim.core.model.BaseModel;
/**
 * 对象功能:demo_student_item Model对象
 * 开发公司:tianzhi
 * 开发人员:zouping
 * 创建时间:2016-08-25 15:01:21
 */
public class StudentItem extends BaseModel
{
	// 主键
	protected Long  itemId;
	// 课程ID
	protected Long  courseId;
	// 学生ID
	protected Long  studentId;
	// 说明
	protected String  remark;
	public void setItemId(Long itemId) 
	{
		this.itemId = itemId;
	}
	/**
	 * 返回 主键
	 * @return
	 */
	public Long getItemId() 
	{
		return this.itemId;
	}
	public void setCourseId(Long courseId) 
	{
		this.courseId = courseId;
	}
	/**
	 * 返回 课程ID
	 * @return
	 */
	public Long getCourseId() 
	{
		return this.courseId;
	}
	public void setStudentId(Long studentId) 
	{
		this.studentId = studentId;
	}
	/**
	 * 返回 学生ID
	 * @return
	 */
	public Long getStudentId() 
	{
		return this.studentId;
	}
	public void setRemark(String remark) 
	{
		this.remark = remark;
	}
	/**
	 * 返回 说明
	 * @return
	 */
	public String getRemark() 
	{
		return this.remark;
	}


   	/**
	 * @see java.lang.Object#equals(Object)
	 */
	public boolean equals(Object object) 
	{
		if (!(object instanceof StudentItem)) 
		{
			return false;
		}
		StudentItem rhs = (StudentItem) object;
		return new EqualsBuilder()
		.append(this.itemId, rhs.itemId)
		.append(this.courseId, rhs.courseId)
		.append(this.studentId, rhs.studentId)
		.append(this.remark, rhs.remark)
		.isEquals();
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() 
	{
		return new HashCodeBuilder(-82280557, -700257973)
		.append(this.itemId) 
		.append(this.courseId) 
		.append(this.studentId) 
		.append(this.remark) 
		.toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	public String toString() 
	{
		return new ToStringBuilder(this)
		.append("itemId", this.itemId) 
		.append("courseId", this.courseId) 
		.append("studentId", this.studentId) 
		.append("remark", this.remark) 
		.toString();
	}
   
  

}