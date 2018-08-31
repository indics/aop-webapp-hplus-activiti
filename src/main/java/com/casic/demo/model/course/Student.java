package com.casic.demo.model.course;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;

import com.cosim.core.model.BaseModel;
/**
 * 对象功能:demo_student Model对象
 * 开发公司:tianzhi
 * 开发人员:zouping
 * 创建时间:2016-08-25 15:01:21
 */
public class Student extends BaseModel
{
	// 主键
	protected Long  studentId;
	// 姓名
	protected String  name;
	// 性别
	protected Long  sex;
	// 爱好
	protected String  honor;
	// 创建时间
	protected java.util.Date  createTime;
	// 创建用户
	protected Long  createUser;
	//demo_student_item列表
	protected List<StudentItem> studentItemList=new ArrayList<StudentItem>();
	public void setStudentId(Long studentId) 
	{
		this.studentId = studentId;
	}
	/**
	 * 返回 主键
	 * @return
	 */
	public Long getStudentId() 
	{
		return this.studentId;
	}
	public void setName(String name) 
	{
		this.name = name;
	}
	/**
	 * 返回 姓名
	 * @return
	 */
	public String getName() 
	{
		return this.name;
	}
	public void setSex(Long sex) 
	{
		this.sex = sex;
	}
	/**
	 * 返回 性别
	 * @return
	 */
	public Long getSex() 
	{
		return this.sex;
	}
	public void setHonor(String honor) 
	{
		this.honor = honor;
	}
	/**
	 * 返回 爱好
	 * @return
	 */
	public String getHonor() 
	{
		return this.honor;
	}
	public void setCreateTime(java.util.Date createTime) 
	{
		this.createTime = createTime;
	}
	/**
	 * 返回 创建时间
	 * @return
	 */
	public java.util.Date getCreateTime() 
	{
		return this.createTime;
	}
	public void setCreateUser(Long createUser) 
	{
		this.createUser = createUser;
	}
	/**
	 * 返回 创建用户
	 * @return
	 */
	public Long getCreateUser() 
	{
		return this.createUser;
	}
	public void setStudentItemList(List<StudentItem> studentItemList) 
	{
		this.studentItemList = studentItemList;
	}
	/**
	 * 返回 demo_student_item列表
	 * @return
	 */
	public List<StudentItem> getStudentItemList() 
	{
		return this.studentItemList;
	}


   	/**
	 * @see java.lang.Object#equals(Object)
	 */
	public boolean equals(Object object) 
	{
		if (!(object instanceof Student)) 
		{
			return false;
		}
		Student rhs = (Student) object;
		return new EqualsBuilder()
		.append(this.studentId, rhs.studentId)
		.append(this.name, rhs.name)
		.append(this.sex, rhs.sex)
		.append(this.honor, rhs.honor)
		.append(this.createTime, rhs.createTime)
		.append(this.createUser, rhs.createUser)
		.isEquals();
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() 
	{
		return new HashCodeBuilder(-82280557, -700257973)
		.append(this.studentId) 
		.append(this.name) 
		.append(this.sex) 
		.append(this.honor) 
		.append(this.createTime) 
		.append(this.createUser) 
		.toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	public String toString() 
	{
		return new ToStringBuilder(this)
		.append("studentId", this.studentId) 
		.append("name", this.name) 
		.append("sex", this.sex) 
		.append("honor", this.honor) 
		.append("createTime", this.createTime) 
		.append("createUser", this.createUser) 
		.toString();
	}
   
  

}