package com.jl.psi.model;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
/**
 * 报损单model
 * @author 景雅倩
 * @date 2018年6月14日 下午4:48:37
 */
public class BreakageOrder {
    private Integer id;
	/**
	 * 日期
	 */
    private Date breakageDate;
	/**
	 * 单号
	 */
    private String identifier;
	/**
	 * 仓库id
	 */
    private Integer warehouseId;
	/**
	 * 业务员id
	 */
    private Integer personId;
	/**
	 * 制单人编号
	 */
    private String originator;
	/**
	 * 审批人编号
	 */
    private String reviewer;
	/**
	 * 摘要
	 */
    private String summary;
	/**
	 * 状态(1：未发送至财务   2：未送审   3：待审核   4：已驳回   5：已完成)
	 */
    private Integer state;
	/**
	 * 打印次数
	 */
    private Integer printNum;
    
  //以下是根据需要添加的字段
  	/**
  	 * 日期---String
  	 */
      private String breakageDateString;
      
      /**
       * 制单人名称
       */
      private String originatorName;
      
      /**
       * 仓库名称
       */
      private String warehouseName;
      
      /**
       * 报损商品信息
       */
      private List<BreakageOrderCommodity> breakageOrderCommodities;
      
      /**
       * 审核人名称
       */
      private String reviewerName;
      
      /**
       * 业务员名称
       */
      private String personName;
      
      /**
       * 业务员编号
       */
      private String personIdentifier;
      
      /**
       * 部门名称
       */
      private String departmentName;
      
      /**
       * 部门id
       */
      private String departmentId;
      
      /**
       * 是否已删除(0：未删，1：已删)
       */
  	private Integer isDelete;
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

	public Integer getIsDelete() {
		return isDelete;
	}

	public void setIsDelete(Integer isDelete) {
		this.isDelete = isDelete;
	}

	public Integer getPrintNum() {
		return printNum;
	}

	public void setPrintNum(Integer printNum) {
		this.printNum = printNum;
	}

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Date getBreakageDate() {
        return breakageDate;
    }

    public void setBreakageDate(Date breakageDate) {
        this.breakageDate = breakageDate;
    }

    public String getIdentifier() {
        return identifier;
    }

    public void setIdentifier(String identifier) {
        this.identifier = identifier == null ? null : identifier.trim();
    }

    public Integer getWarehouseId() {
        return warehouseId;
    }

    public void setWarehouseId(Integer warehouseId) {
        this.warehouseId = warehouseId;
    }

    public Integer getPersonId() {
        return personId;
    }

    public void setPersonId(Integer personId) {
        this.personId = personId;
    }

    public String getOriginator() {
        return originator;
    }

    public void setOriginator(String originator) {
        this.originator = originator == null ? null : originator.trim();
    }

    public String getReviewer() {
        return reviewer;
    }

    public void setReviewer(String reviewer) {
        this.reviewer = reviewer == null ? null : reviewer.trim();
    }

    public String getSummary() {
        return summary;
    }

    public void setSummary(String summary) {
        this.summary = summary == null ? null : summary.trim();
    }

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }

	public String getBreakageDateString() {
		return breakageDateString;
	}

	public void setBreakageDateString(String breakageDateString) {
		this.breakageDateString = breakageDateString;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		try {
			this.breakageDate=sdf.parse(breakageDateString);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			this.breakageDate=null;
		}
	}

	public String getOriginatorName() {
		return originatorName;
	}

	public void setOriginatorName(String originatorName) {
		this.originatorName = originatorName;
	}

	public String getWarehouseName() {
		return warehouseName;
	}

	public void setWarehouseName(String warehouseName) {
		this.warehouseName = warehouseName;
	}

	public List<BreakageOrderCommodity> getBreakageOrderCommodities() {
		return breakageOrderCommodities;
	}

	public void setBreakageOrderCommodities(List<BreakageOrderCommodity> breakageOrderCommodities) {
		this.breakageOrderCommodities = breakageOrderCommodities;
	}

	public String getReviewerName() {
		return reviewerName;
	}

	public void setReviewerName(String reviewerName) {
		this.reviewerName = reviewerName;
	}

	public String getPersonName() {
		return personName;
	}

	public void setPersonName(String personName) {
		this.personName = personName;
	}

	public String getPersonIdentifier() {
		return personIdentifier;
	}

	public void setPersonIdentifier(String personIdentifier) {
		this.personIdentifier = personIdentifier;
	}

	public String getDepartmentName() {
		return departmentName;
	}

	public void setDepartmentName(String departmentName) {
		this.departmentName = departmentName;
	}

	public String getDepartmentId() {
		return departmentId;
	}

	public void setDepartmentId(String departmentId) {
		this.departmentId = departmentId;
	}
    
}