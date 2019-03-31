package com.jl.psi.model;

import java.util.Date;

/**
 * 客戶/供应商model
 * @author THINK
 *
 */
public class Supcto {
	/**
	 * 主键
	 */
    private Integer id;
    /**
     * 分类id
     */
    private Integer classificationId;
    /**
	 * 是否停用（1：否   2：是）
	 */
    private Integer useable;
    /**
	 * 单位名称
	 */
    private String name;
    /**
	 * 全称
	 */
    private String fullName;
    /**
	 * 供应商/客户等级(1:一级  2：二级  3：三级)
	 */
    private Integer frade;
    /**
	 * 往来类型(1：账期   2：现金)
	 */
    private Integer fromType;
    /**
	 * 结算方式id
	 */
    private Integer settlementTypeId;
    /**
	 * 联系手机
	 */
    private String phone;
    /**
	 * 联系人
	 */
    private String contactPeople;
    /**
	 * 邮编
	 */
    private String postcode;
    /**
	 * 传真
	 */
    private String fax;
    /**
	 * 银行账号
	 */
    private String bankAccount;
    /**
	 * 开户银行
	 */
    private String bank;
    /**
	 *纳税识别编号 
	 */
    private String ratepaying;
    /**
	 * 邮箱
	 */
    private String mailbox;
    /**
	 * 发票类型(1：增票   2：普票)
	 */
    private Integer invoiceType;
    /**
	 * 供应商地址/送货地址
	 */
    private String deliveryAddress;
    /**
	 * 信用天数
	 */
    private Integer creditDays;
    /**
	 * 信用金额
	 */
    private Double creditMoney;
    /**
	 * 编号
	 */
    private String identifier;
    /**
	 * 基本信息
	 */
    private String information;
    /**
	 * 其他信息
	 */
    private String otherInformation;
    /**
	 * 部门id
	 */
    private Integer departmentId;
    /**
	 * 业务员id
	 */
    private Integer personId;
    /**
	 * 币种（1：人民币）
	 */
    private Integer currency;
    /**
	 * 通讯地址
	 */
    private String communicationAddress;
    /**
	 * 助记码（供应商编码）
	 */
    private String memoryCode;
    /**
	 * 默认税率
	 */
    private Double taxes;
    /**
	 * 会员卡号
	 */
    private String member;
    /**
	 * 运输方式id
	 */
    private Integer shippingModeId;
    /**
	 * 备注
	 */
    private String remark;
    /**
	 * 常用电话
	 */
    private String commonPhone;
    /**
	 * 备用电话
	 */
    private String reservePhone;
    /**
	 * 状态（1：未送审  2：待审核  3：通过  4：拒绝   5：停用待审核  6：停用审核驳回  7：已停用  8：已恢复使用   ）
	 */
    private Integer state;
    /**
	 * 省份	
	 */
    private String province;
    /**
	 * 市
	 */
    private String city;
    /**
	 * 区
	 */
    private String area;
    /**
	 * 省份编码
	 */
    private String provinceCode;
    /**
	 * 市编码
	 */
    private String cityCode;
    /**
	 * 区编码
	 */
    private String areaCode;
    /**
	 * 客户/供应商（1：客户   2：供应商）
	 */
    private Integer customerOrSupplier;
    /**
	 * 操作人编号
	 */
    private String operatorIdentifier;
    /**
	 * 操作时间
	 */
    private Date operatorTime;
    /**
	 * 网站
	 */
    private String website;
    /**
     * 预收/预付 余额
     */
    private Double advanceMoney;
    
    /**
     * 是否显示（1：显示  2：不显示）
     */
    private Integer isShow;
    
    /**
     * 父ID
     */
    private Integer parentId;
    
    // 根据结果需要，在model里另添格外的字段
    private Classification classification;
    private Person user;
    private Department department;
    private Person person;
    private SettlementType settlementType;
    private String goodsObj;
    private ShippingMode shippingMode;
    /**
     * 客户/供应商的结算方式
     */
    private String settlementTypeName;
    /**
     * 客户所属的一级分类名称
     */
    private String classificationOneName;
    /**
     * 客户所属的二级分类名称
     */
    private String classificationTweName;
    
    
    
    public ShippingMode getShippingMode() {
		return shippingMode;
	}

	public void setShippingMode(ShippingMode shippingMode) {
		this.shippingMode = shippingMode;
	}

	public String getGoodsObj() {
		return goodsObj;
	}

	public void setGoodsObj(String goodsObj) {
		this.goodsObj = goodsObj;
	}

	public Classification getClassification() {
		return classification;
	}

	public void setClassification(Classification classification) {
		this.classification = classification;
	}

	public Department getDepartment() {
		return department;
	}

	public void setDepartment(Department department) {
		this.department = department;
	}

	public Person getPerson() {
		return person;
	}

	public void setPerson(Person person) {
		this.person = person;
	}

	public SettlementType getSettlementType() {
		return settlementType;
	}

	public void setSettlementType(SettlementType settlementType) {
		this.settlementType = settlementType;
	}

	
	public Person getUser() {
		return user;
	}

	public void setUser(Person user) {
		this.user = user;
	}

	public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getClassificationId() {
        return classificationId;
    }

    public void setClassificationId(Integer classificationId) {
        this.classificationId = classificationId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName == null ? null : fullName.trim();
    }

    public Integer getFrade() {
        return frade;
    }

    public void setFrade(Integer frade) {
        this.frade = frade;
    }

    public Integer getFromType() {
        return fromType;
    }

    public void setFromType(Integer fromType) {
        this.fromType = fromType;
    }

    public Integer getSettlementTypeId() {
        return settlementTypeId;
    }

    public void setSettlementTypeId(Integer settlementTypeId) {
        this.settlementTypeId = settlementTypeId;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone == null ? null : phone.trim();
    }

    public String getContactPeople() {
        return contactPeople;
    }

    public void setContactPeople(String contactPeople) {
        this.contactPeople = contactPeople == null ? null : contactPeople.trim();
    }

    public String getPostcode() {
        return postcode;
    }

    public void setPostcode(String postcode) {
        this.postcode = postcode == null ? null : postcode.trim();
    }

    public String getFax() {
        return fax;
    }

    public void setFax(String fax) {
        this.fax = fax == null ? null : fax.trim();
    }

    public String getBankAccount() {
        return bankAccount;
    }

    public void setBankAccount(String bankAccount) {
        this.bankAccount = bankAccount == null ? null : bankAccount.trim();
    }

    public String getBank() {
        return bank;
    }

    public void setBank(String bank) {
        this.bank = bank == null ? null : bank.trim();
    }

    public String getRatepaying() {
        return ratepaying;
    }

    public void setRatepaying(String ratepaying) {
        this.ratepaying = ratepaying == null ? null : ratepaying.trim();
    }

    public String getMailbox() {
        return mailbox;
    }

    public void setMailbox(String mailbox) {
        this.mailbox = mailbox == null ? null : mailbox.trim();
    }

    public Integer getInvoiceType() {
        return invoiceType;
    }

    public void setInvoiceType(Integer invoiceType) {
        this.invoiceType = invoiceType;
    }

    public String getDeliveryAddress() {
        return deliveryAddress;
    }

    public void setDeliveryAddress(String deliveryAddress) {
        this.deliveryAddress = deliveryAddress == null ? null : deliveryAddress.trim();
    }

    public Integer getCreditDays() {
        return creditDays;
    }

    public void setCreditDays(Integer creditDays) {
        this.creditDays = creditDays;
    }

    public Double getCreditMoney() {
        return creditMoney;
    }

    public void setCreditMoney(Double creditMoney) {
        this.creditMoney = creditMoney;
    }

    public String getIdentifier() {
        return identifier;
    }

    public void setIdentifier(String identifier) {
        this.identifier = identifier == null ? null : identifier.trim();
    }

    public String getInformation() {
        return information;
    }

    public void setInformation(String information) {
        this.information = information == null ? null : information.trim();
    }

    public String getOtherInformation() {
        return otherInformation;
    }

    public void setOtherInformation(String otherInformation) {
        this.otherInformation = otherInformation == null ? null : otherInformation.trim();
    }

    public Integer getDepartmentId() {
        return departmentId;
    }

    public void setDepartmentId(Integer departmentId) {
        this.departmentId = departmentId;
    }

   
    public String getMemoryCode() {
		return memoryCode;
	}

	public void setMemoryCode(String memoryCode) {
		this.memoryCode = memoryCode;
	}

	public Integer getCurrency() {
        return currency;
    }

    public void setCurrency(Integer currency) {
        this.currency = currency;
    }

    public String getCommunicationAddress() {
        return communicationAddress;
    }

    public void setCommunicationAddress(String communicationAddress) {
        this.communicationAddress = communicationAddress == null ? null : communicationAddress.trim();
    }

	
	

	public Double getTaxes() {
        return taxes;
    }

    public void setTaxes(Double taxes) {
        this.taxes = taxes;
    }

    public String getMember() {
        return member;
    }

    public void setMember(String member) {
        this.member = member == null ? null : member.trim();
    }

    public Integer getShippingModeId() {
        return shippingModeId;
    }

    public void setShippingModeId(Integer shippingModeId) {
        this.shippingModeId = shippingModeId;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark == null ? null : remark.trim();
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

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }

    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province == null ? null : province.trim();
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city == null ? null : city.trim();
    }

    public String getArea() {
        return area;
    }

    public void setArea(String area) {
        this.area = area == null ? null : area.trim();
    }

    public Integer getCustomerOrSupplier() {
        return customerOrSupplier;
    }

    public void setCustomerOrSupplier(Integer customerOrSupplier) {
        this.customerOrSupplier = customerOrSupplier;
    }

	public Integer getPersonId() {
		return personId;
	}

	public void setPersonId(Integer personId) {
		this.personId = personId;
	}

	public String getOperatorIdentifier() {
		return operatorIdentifier;
	}

	public void setOperatorIdentifier(String operatorIdentifier) {
		this.operatorIdentifier = operatorIdentifier;
	}

	public Date getOperatorTime() {
		return operatorTime;
	}

	public void setOperatorTime(Date operatorTime) {
		this.operatorTime = operatorTime;
	}

	public String getProvinceCode() {
		return provinceCode;
	}

	public void setProvinceCode(String provinceCode) {
		this.provinceCode = provinceCode;
	}

	public String getCityCode() {
		return cityCode;
	}

	public void setCityCode(String cityCode) {
		this.cityCode = cityCode;
	}

	public String getAreaCode() {
		return areaCode;
	}

	public void setAreaCode(String areaCode) {
		this.areaCode = areaCode;
	}

	public String getWebsite() {
		return website;
	}

	public void setWebsite(String website) {
		this.website = website;
	}

	public Integer getUseable() {
		return useable;
	}

	public void setUseable(Integer useable) {
		this.useable = useable;
	}

	public Double getAdvanceMoney() {
		return advanceMoney;
	}

	public void setAdvanceMoney(Double advanceMoney) {
		this.advanceMoney = advanceMoney;
	}

	public String getSettlementTypeName() {
		return settlementTypeName;
	}

	public void setSettlementTypeName(String settlementTypeName) {
		this.settlementTypeName = settlementTypeName;
	}

	public Integer getIsShow() {
		return isShow;
	}

	public void setIsShow(Integer isShow) {
		this.isShow = isShow;
	}

	public Integer getParentId() {
		return parentId;
	}

	public void setParentId(Integer parentId) {
		this.parentId = parentId;
	}

	public String getClassificationOneName() {
		return classificationOneName;
	}

	public void setClassificationOneName(String classificationOneName) {
		this.classificationOneName = classificationOneName;
	}

	public String getClassificationTweName() {
		return classificationTweName;
	}

	public void setClassificationTweName(String classificationTweName) {
		this.classificationTweName = classificationTweName;
	}
	
	
}