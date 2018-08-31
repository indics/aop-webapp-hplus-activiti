package com.casic.demo.model.course;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;

import com.cosim.core.model.BaseModel;
/**
 * 对象功能:cloud_course Model对象
 * 开发公司:tianzhi
 * 开发人员:zouping
 * 创建时间:2016-05-20 11:59:20
 */
public class Course extends BaseModel
{
	// id
	protected Long  id;
	// year
	protected Long  year;
	// term
	protected Long  term;
	// create_user
	protected Long  createUser;
	// create_time
	protected java.util.Date  createTime;
	// task_id
	protected Long  taskId;
	// run_id
	protected Long  runId;
	// run_state
	protected String  runState;
	//cloud_course_item列表
	protected List<CourseItem> courseItemList=new ArrayList<CourseItem>();
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
	public void setYear(Long year) 
	{
		this.year = year;
	}
	/**
	 * 返回 year
	 * @return
	 */
	public Long getYear() 
	{
		return this.year;
	}
	public void setTerm(Long term) 
	{
		this.term = term;
	}
	/**
	 * 返回 term
	 * @return
	 */
	public Long getTerm() 
	{
		return this.term;
	}
	public void setCreateUser(Long createUser) 
	{
		this.createUser = createUser;
	}
	/**
	 * 返回 create_user
	 * @return
	 */
	public Long getCreateUser() 
	{
		return this.createUser;
	}
	public void setCreateTime(java.util.Date createTime) 
	{
		this.createTime = createTime;
	}
	/**
	 * 返回 create_time
	 * @return
	 */
	public java.util.Date getCreateTime() 
	{
		return this.createTime;
	}
	public void setTaskId(Long taskId) 
	{
		this.taskId = taskId;
	}
	/**
	 * 返回 task_id
	 * @return
	 */
	public Long getTaskId() 
	{
		return this.taskId;
	}
	public void setRunId(Long runId) 
	{
		this.runId = runId;
	}
	/**
	 * 返回 run_id
	 * @return
	 */
	public Long getRunId() 
	{
		return this.runId;
	}
	public void setRunState(String runState) 
	{
		this.runState = runState;
	}
	/**
	 * 返回 run_state
	 * @return
	 */
	public String getRunState() 
	{
		return this.runState;
	}
	public void setCourseItemList(List<CourseItem> courseItemList) 
	{
		this.courseItemList = courseItemList;
	}
	/**
	 * 返回 cloud_course_item列表
	 * @return
	 */
	public List<CourseItem> getCourseItemList() 
	{
		return this.courseItemList;
	}

	protected Long runid;
	protected Short runStatus=0;
	protected Long actInstId;
	
	public Long getRunid() {
		return runid;
	}
	public void setRunid(Long runid) {
		this.runid = runid;
	}
	public Short getRunStatus() {
		return runStatus;
	}
	public void setRunStatus(Short runStatus) {
		this.runStatus = runStatus;
	}
	
	public Long getActInstId() {
		return actInstId;
	}
	public void setActInstId(Long actInstId) {
		this.actInstId = actInstId;
	}

   	/**
	 * @see java.lang.Object#equals(Object)
	 */
	public boolean equals(Object object) 
	{
		if (!(object instanceof Course)) 
		{
			return false;
		}
		Course rhs = (Course) object;
		return new EqualsBuilder()
		.append(this.id, rhs.id)
		.append(this.year, rhs.year)
		.append(this.term, rhs.term)
		.append(this.createUser, rhs.createUser)
		.append(this.createTime, rhs.createTime)
		.append(this.taskId, rhs.taskId)
		.append(this.runId, rhs.runId)
		.append(this.runState, rhs.runState)
		.isEquals();
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() 
	{
		return new HashCodeBuilder(-82280557, -700257973)
		.append(this.id) 
		.append(this.year) 
		.append(this.term) 
		.append(this.createUser) 
		.append(this.createTime) 
		.append(this.taskId) 
		.append(this.runId) 
		.append(this.runState) 
		.toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	public String toString() 
	{
		return new ToStringBuilder(this)
		.append("id", this.id) 
		.append("year", this.year) 
		.append("term", this.term) 
		.append("createUser", this.createUser) 
		.append("createTime", this.createTime) 
		.append("taskId", this.taskId) 
		.append("runId", this.runId) 
		.append("runState", this.runState) 
		.toString();
	}
   
  

}