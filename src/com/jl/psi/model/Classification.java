package com.jl.psi.model;

import java.util.Date;

/**
 * 
 * @author 柳亚婷
 * @date  2018年4月2日  下午4:23:07
 * @Description 分类信息
 *
 */
public class Classification {
	/**
	 * 主键
	 */
	private Integer id;

	/**
	 * 编号
	 */
	private String identifier;

	/**
	 * 名称
	 */
	private String name;

	/**
	 * 父id
	 */
	private Integer parentId;

	/**
	 * 关键词
	 */
	private String keyWord;

	/**
	 * 操作人编号
	 */
	private String operatorIdentifier;

	/**
	 * 操作时间
	 */
	private Date operatorTime;

	/**
	 * 类型 客户：1，供应商：2，商品：3
	 */
	private Integer type;
	
	/**
	 * 是否删除
	 */
	private Integer isDelete;

	// 根据结果需要，在model里另添格外的字段
	
	/**
	 * 操作人信息
	 */
	Person person;
	
	/**
	 * 父节点的信息
	 */
	Classification pClassification;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getIdentifier() {
		return identifier;
	}

	public void setIdentifier(String identifier) {
		this.identifier = identifier;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name == null ? null : name.trim();
	}

	public Integer getParentId() {
		return parentId;
	}

	public void setParentId(Integer parentId) {
		this.parentId = parentId;
	}

	public String getKeyWord() {
		return keyWord;
	}

	public void setKeyWord(String keyWord) {
		this.keyWord = keyWord == null ? null : keyWord.trim();
	}

	public String getOperatorIdentifier() {
		return operatorIdentifier;
	}

	public void setOperatorIdentifier(String operatorIdentifier) {
		this.operatorIdentifier = operatorIdentifier == null ? null : operatorIdentifier.trim();
	}

	public Date getOperatorTime() {
		return operatorTime;
	}

	public void setOperatorTime(Date operatorTime) {
		this.operatorTime = operatorTime;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public Person getPerson() {
		return person;
	}

	public void setPerson(Person person) {
		this.person = person;
	}

	public Classification getpClassification() {
		return pClassification;
	}

	public void setpClassification(Classification pClassification) {
		this.pClassification = pClassification;
	}

	public Integer getIsDelete() {
		return isDelete;
	}

	public void setIsDelete(Integer isDelete) {
		this.isDelete = isDelete;
	}
	

}