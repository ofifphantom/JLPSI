package com.jl.psi.model;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

public class Person {
	/**
	 * 主键
	 */
    private Integer id;
    /**
     * 员工姓名
     */
    private String name;
    /**
     * 编号
     */
    private String identifier;  
    /**
     * 登录名
     */
    private String loginName;  
    /**
     * 密码
     */
    private String password;
    /**
     * 类型名称
     */
    private String type;
    /**
     * 部门id
     */
    private Integer departmentId;
    /**
     * 入职日期
     */
    private Date entryTime;
    /**
     * 职务
     */
    private String duties;
    /**
     * 学历	
     */
    private String education;
    /**
     * 性别
     */
    private String sex;
    /**
     * 出生日期
     */
    private Date birthTime;
    /**
     * 籍贯
     */
    private String nativePlace;
    /**
     * 联系手机号
     */
    private String phone;
    /**
     * 家庭电话
     */
    private String homePhone;
    /**
     * 常用电话
     */
    private String commonPhone;
    /**
     * 备用电话
     */
    private String reservePhone;
    /**
     * 邮编
     */
    private String postcode;
    /**
     * 住址
     */
    private String homeAddress;
    /**
     * 邮箱
     */
    private String mailbox;
    /**
     * 离职日期
     */
    private Date quitTime;
    /**
     * 是否为业务员，0不是，1是
     */
    private Integer business;
    /**
     * 是否离职0：未离职，1离职
     */
    private Integer quite;
    /**
     * 操作人编号
     */
    private String operatorIdentifier;
    /**
     * 操作时间
     */
    private Date operatorTime;
    /**
     * 备注
     */
    private String remark;
    /**
     * 身份证号
     */
    private String idNumber;
    
    private Integer warehouseId;
    /**
     * 所属地
     */
    private String place;
    /**
	 * 是否删除
	 */
	private Integer isDelete;
    
 // 根据结果需要，在model里另添格外的字段
    private Person user;
    
    private Department department;
    private String entryTimeStr;
    private String birthTimeStr;
    private String quitTimeStr;
    private String warehouseName;
    
    public String getPlace() {
		return place;
	}

	public void setPlace(String place) {
		this.place = place;
	}

	/**
     * 存储管理员的权限信息
     */
    List<Permission> permissions;
   
    private String resIds;
    
    
    
	public String getResIds() {
		return resIds;
	}

	public void setResIds(String resIds) {
		this.resIds = resIds;
	}

	public List<Permission> getPermissions() {
		return permissions;
	}

	public void setPermissions(List<Permission> permissions) {
		this.permissions = permissions;
	}

	public String getEntryTimeStr() {
		return entryTimeStr;
	}

	public void setEntryTimeStr(String entryTimeStr) {
		this.entryTimeStr = entryTimeStr;
	}

	public String getBirthTimeStr() {
		return birthTimeStr;
	}

	public void setBirthTimeStr(String birthTimeStr) {
		this.birthTimeStr = birthTimeStr;
	}

	public String getQuitTimeStr() {
		return quitTimeStr;
	}

	public void setQuitTimeStr(String quitTimeStr) {
		this.quitTimeStr = quitTimeStr;
	}

    public Person getUser() {
		return user;
	}

	public void setUser(Person user) {
		this.user = user;
	}

	public Department getDepartment() {
		return department;
	}

	public void setDepartment(Department department) {
		this.department = department;
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

	public String getLoginName() {
		return loginName;
	}

	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type == null ? null : type.trim();
    }

    public Integer getDepartmentId() {
        return departmentId;
    }

    public void setDepartmentId(Integer departmentId) {
        this.departmentId = departmentId;
    }

    public Date getEntryTime() {
        return entryTime;
    }

    public void setEntryTime(Date entryTime) {
        this.entryTime = entryTime;
    }

    public String getDuties() {
        return duties;
    }

    public void setDuties(String duties) {
        this.duties = duties == null ? null : duties.trim();
    }

    public String getEducation() {
        return education;
    }

    public void setEducation(String education) {
        this.education = education == null ? null : education.trim();
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex == null ? null : sex.trim();
    }

    public Date getBirthTime() {
        return birthTime;
    }

    public void setBirthTime(Date birthTime) {
        this.birthTime = birthTime;
    }

    public String getNativePlace() {
        return nativePlace;
    }

    public void setNativePlace(String nativePlace) {
        this.nativePlace = nativePlace == null ? null : nativePlace.trim();
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone == null ? null : phone.trim();
    }

    public String getHomePhone() {
        return homePhone;
    }

    public void setHomePhone(String homePhone) {
        this.homePhone = homePhone == null ? null : homePhone.trim();
    }

    public String getCommonPhone() {
        return commonPhone;
    }

    public void setCommonPhone(String commonPhone) {
        this.commonPhone = commonPhone == null ? null : commonPhone.trim();
    }

    public String getReservePhone() {
        return reservePhone;
    }

    public void setReservePhone(String reservePhone) {
        this.reservePhone = reservePhone == null ? null : reservePhone.trim();
    }

    public String getPostcode() {
        return postcode;
    }

    public void setPostcode(String postcode) {
        this.postcode = postcode == null ? null : postcode.trim();
    }

    public String getHomeAddress() {
        return homeAddress;
    }

    public void setHomeAddress(String homeAddress) {
        this.homeAddress = homeAddress == null ? null : homeAddress.trim();
    }

    public String getMailbox() {
        return mailbox;
    }

    public void setMailbox(String mailbox) {
        this.mailbox = mailbox == null ? null : mailbox.trim();
    }

    public Date getQuitTime() {
        return quitTime;
    }

    public void setQuitTime(Date quitTime) {
        this.quitTime = quitTime;
    }

    public Integer getBusiness() {
        return business;
    }

    public void setBusiness(Integer business) {
        this.business = business;
    }

    public Integer getQuite() {
        return quite;
    }

    public void setQuite(Integer quite) {
        this.quite = quite;
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

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark == null ? null : remark.trim();
    }

    public String getIdNumber() {
        return idNumber;
    }

    public void setIdNumber(String idNumber) {
        this.idNumber = idNumber == null ? null : idNumber.trim();
    }

	public Integer getWarehouseId() {
		return warehouseId;
	}

	public void setWarehouseId(Integer warehouseId) {
		this.warehouseId = warehouseId;
	}

	public String getWarehouseName() {
		return warehouseName;
	}

	public void setWarehouseName(String warehouseName) {
		this.warehouseName = warehouseName;
	}

	public Integer getIsDelete() {
		return isDelete;
	}

	public void setIsDelete(Integer isDelete) {
		this.isDelete = isDelete;
	}
    
}