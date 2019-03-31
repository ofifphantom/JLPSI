package com.jl.psi.model;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
/**
 * 
 * @author 景雅倩
 * @date  2018年6月04日  上午10:21:50
 * @Description  销售计划单Model
 */
public class SalesPlanOrder {
	/**
	 * 主键
	 */
    private Integer id;
    /**
	 * 编号
	 */
    private String identifier;
    /**
	 * 生成日期
	 */
    private Date createTime;
    
    /**
	 * 结束日期
	 */
    private Date endTime;
    /**
	 * 币种（1：人民币）
	 */
    private Integer currency;
    /**
	 * 分支机构
	 */
    private String branch;
    /**
	 * 制单人编号
	 */
    private String originator;
    /**
	 * 摘要
	 */
    private String summary;
    /**
	 * 客户id
	 */
    private Integer supctoId;
    /**
	 * 业务员id
	 */
    private Integer personId;
    /**
	 * 状态（1：未生成销售订单    2：已生成销售订单   3：销售计划失败）
	 */
    private Integer state;
    /**
	 * 是否是APP订单（1：否  2：是）
	 */
    private Integer isAppOrder;
    /**
	 * APP收货人姓名
	 */
    private String appConsigneeName;
    /**
	 * APP收货人电话
	 */
    private String appConsigneePhone;
    /**
	 * APP收货地址
	 */
    private String appConsigneeAddress;
    /**


	/**
   	 * 操作人信息
   	 */
   	Person person;
   	/**
   	 * 客户信息
   	 */
   	Supcto supcto;
   	/**
   	 * 销售商品信息
   	 */
   	List<SalesPlanOrderCommodity> salesPlanOrderCommodities;
   	/**
  	 * 每个销售订单下商品的保存的货品名称统计
  	 */
  	String commoditysName;
  	/**
  	 * 每个销售订单下商品的保存的货品品牌统计
  	 */
  	String commoditysBrandName;
  	/**
  	 * 制单人名称
  	 */
  	String originatorName;
  	/**
  	 * 业务员名称
  	 */
  	String personName;
  	/**
  	 * 业务员部门名称
  	 */
  	String personDepartmentName;
  	
  	/**
	 * (结束)日期-String
	 */
    private String endTimeString;
  	/**
  	 * miss后台传来的订单id
  	 */
    private Integer missOrderId;
    /**
     * 活动id
     */
    private Integer activityId;
    /**
     * 库存信息
     */
    private Inventory inventory;
    
    public Inventory getInventory() {
		return inventory;
	}

	public void setInventory(Inventory inventory) {
		this.inventory = inventory;
	}

	public Integer getActivityId() {
		return activityId;
	}

	public void setActivityId(Integer activityId) {
		this.activityId = activityId;
	}

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
        this.identifier = identifier == null ? null : identifier.trim();
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    public Integer getCurrency() {
        return currency;
    }

    public void setCurrency(Integer currency) {
        this.currency = currency;
    }

    public String getBranch() {
        return branch;
    }

    public void setBranch(String branch) {
        this.branch = branch == null ? null : branch.trim();
    }

    public String getOriginator() {
        return originator;
    }

    public void setOriginator(String originator) {
        this.originator = originator == null ? null : originator.trim();
    }

    public String getSummary() {
        return summary;
    }

    public void setSummary(String summary) {
        this.summary = summary == null ? null : summary.trim();
    }

    public Integer getSupctoId() {
        return supctoId;
    }

    public void setSupctoId(Integer supctoId) {
        this.supctoId = supctoId;
    }

    public Integer getPersonId() {
        return personId;
    }

    public void setPersonId(Integer personId) {
        this.personId = personId;
    }

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }

    public Integer getIsAppOrder() {
        return isAppOrder;
    }

    public void setIsAppOrder(Integer isAppOrder) {
        this.isAppOrder = isAppOrder;
    }

    public String getAppConsigneeName() {
        return appConsigneeName;
    }

    public void setAppConsigneeName(String appConsigneeName) {
        this.appConsigneeName = appConsigneeName == null ? null : appConsigneeName.trim();
    }

    public String getAppConsigneePhone() {
        return appConsigneePhone;
    }

    public void setAppConsigneePhone(String appConsigneePhone) {
        this.appConsigneePhone = appConsigneePhone == null ? null : appConsigneePhone.trim();
    }

    public String getAppConsigneeAddress() {
        return appConsigneeAddress;
    }

    public void setAppConsigneeAddress(String appConsigneeAddress) {
        this.appConsigneeAddress = appConsigneeAddress == null ? null : appConsigneeAddress.trim();
    }

	public Person getPerson() {
		return person;
	}

	public void setPerson(Person person) {
		this.person = person;
	}

	public Supcto getSupcto() {
		return supcto;
	}

	public void setSupcto(Supcto supcto) {
		this.supcto = supcto;
	}

	public List<SalesPlanOrderCommodity> getSalesPlanOrderCommodities() {
		return salesPlanOrderCommodities;
	}

	public void setSalesPlanOrderCommodities(List<SalesPlanOrderCommodity> salesPlanOrderCommodities) {
		this.salesPlanOrderCommodities = salesPlanOrderCommodities;
	}

	public String getCommoditysName() {
		return commoditysName;
	}

	public void setCommoditysName(String commoditysName) {
		this.commoditysName = commoditysName;
	}

	public String getOriginatorName() {
		return originatorName;
	}

	public void setOriginatorName(String originatorName) {
		this.originatorName = originatorName;
	}

	public String getPersonName() {
		return personName;
	}

	public void setPersonName(String personName) {
		this.personName = personName;
	}

	public String getPersonDepartmentName() {
		return personDepartmentName;
	}

	public void setPersonDepartmentName(String personDepartmentName) {
		this.personDepartmentName = personDepartmentName;
	}

	

	public String getCommoditysBrandName() {
		return commoditysBrandName;
	}

	public void setCommoditysBrandName(String commoditysBrandName) {
		this.commoditysBrandName = commoditysBrandName;
	}
	
	public String getEndTimeString() {
		return endTimeString;
	}

	public void setEndTimeString(String endTimeString) {
		this.endTimeString = endTimeString;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		try {
			this.endTime=sdf.parse(endTimeString);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			this.endTime=null;
		}
	}

	public Integer getMissOrderId() {
		return missOrderId;
	}

	public void setMissOrderId(Integer missOrderId) {
		this.missOrderId = missOrderId;
	}
	

}