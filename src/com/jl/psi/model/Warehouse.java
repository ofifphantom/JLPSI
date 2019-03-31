package com.jl.psi.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * @author 柳亚婷
 * @date  2018年4月9日  下午4:22:49
 * @Description 仓库信息
 *
 */
public class Warehouse {
	/**
	 * 主键
	 */
    private Integer id;
    /**
	 * 仓库名称
	 */
    private String name;
    private String identifier;
    /**
	 * 仓库位置
	 */
    private String position;
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
		this.identifier = identifier;
	}

	public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position == null ? null : position.trim();
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