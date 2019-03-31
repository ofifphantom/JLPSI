package com.jl.psi.model;

import java.util.Date;

public class SettlementType {
	/**
	 * 主键
	 */
    private Integer id;
    /**
	 * 名称
	 */
    private String name;
    /**
	 * 编号
	 */
    private String identifier;
    /**
	 * 操作人编号
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
    private Person person;
    

    

	public Person getPerson() {
		return person;
	}

	public void setPerson(Person person) {
		this.person = person;
	}

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

    public String getIdentifier() {
        return identifier;
    }

    public void setIdentifier(String identifier) {
        this.identifier = identifier == null ? null : identifier.trim();
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

	public Integer getIsDelete() {
		return isDelete;
	}

	public void setIsDelete(Integer isDelete) {
		this.isDelete = isDelete;
	}
    
}