package com.jl.psi.model;

import java.util.Date;

public class ShippingMode {
	/**
	 * 主键
	 */
    private Integer id;

    /**
     * 运输方式
     */
    private String name;
    
    /**
     * 操作人
     */
    private String operatorIdentifier;

    /**
     * 操作时间
     */
    private Date operatorTime;
    /**
	 * 是否删除
	 */
	private Integer isDelete;
    
	// 根据结果需要，在model里另添格外的字段
	
	/**
	 * 操作人信息
	 */
	Person person;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
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

	public Person getPerson() {
		return person;
	}

	public void setPerson(Person person) {
		this.person = person;
	}

	public Integer getIsDelete() {
		return isDelete;
	}

	public void setIsDelete(Integer isDelete) {
		this.isDelete = isDelete;
	}

    
    
}