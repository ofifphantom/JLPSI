package com.jl.psi.model;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
/**
 * 盘点单model
 * @author 景雅倩
 * @date 2018年6月11日 下午6:45:22
 */

public class TakeStockOrder {
    private Integer id;
	/**
	 * 日期
	 */
    private Date takeStockDate;
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
	 * 财务审批人编号
	 */
    private String financeReviewer;
    /**
	 * 总经理审批人编号
	 */
    private String managerReviewer;
    /**
	 * 摘要
	 */
    private String summary;
    /**
	 * 状态 1:未发送至仓库    2:仓库盘点中   3:待财务审批   4：财务审批驳回   5:待总经理审批   6:总经理审批驳回   7:已完成
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
    private String takeStockDateString;
    
    /**
     * 制单人名称
     */
    private String originatorName;
    
    /**
     * 仓库名称
     */
    private String warehouseName;
    
    /**
     * 盘点商品信息
     */
    private List<TakeStockOrderCommodity> takeStockOrderCommodities;
    
    /**
     * 财务审核人名称
     */
    private String financeReviewerName;
    
    /**
     * 领导审核人名称
     */
    private String managerReviewerName;
    
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

	public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Date getTakeStockDate() {
        return takeStockDate;
    }

    public void setTakeStockDate(Date takeStockDate) {
        this.takeStockDate = takeStockDate;
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

    public String getFinanceReviewer() {
        return financeReviewer;
    }

    public void setFinanceReviewer(String financeReviewer) {
        this.financeReviewer = financeReviewer == null ? null : financeReviewer.trim();
    }

    public String getManagerReviewer() {
        return managerReviewer;
    }

    public void setManagerReviewer(String managerReviewer) {
        this.managerReviewer = managerReviewer == null ? null : managerReviewer.trim();
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

	public List<TakeStockOrderCommodity> getTakeStockOrderCommodities() {
		return takeStockOrderCommodities;
	}

	public void setTakeStockOrderCommodities(List<TakeStockOrderCommodity> takeStockOrderCommodities) {
		this.takeStockOrderCommodities = takeStockOrderCommodities;
	}

	public String getTakeStockDateString() {
		return takeStockDateString;
	}

	public void setTakeStockDateString(String takeStockDateString) {
		this.takeStockDateString = takeStockDateString;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		try {
			this.takeStockDate=sdf.parse(takeStockDateString);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			this.takeStockDate=null;
		}
	}
	public Integer getPrintNum() {
		return printNum;
	}

	public void setPrintNum(Integer printNum) {
		this.printNum = printNum;
	}

	public String getFinanceReviewerName() {
		return financeReviewerName;
	}

	public void setFinanceReviewerName(String financeReviewerName) {
		this.financeReviewerName = financeReviewerName;
	}

	public String getManagerReviewerName() {
		return managerReviewerName;
	}

	public void setManagerReviewerName(String managerReviewerName) {
		this.managerReviewerName = managerReviewerName;
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