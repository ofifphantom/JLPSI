package com.jl.psi.model;


import java.util.Date;
import java.util.List;

public class AllotOrder {
	/**
	 * id
	 */
    private Integer id;
    /**
	 * 日期
	 */
    private Date allotDate;
    /**
	 * 编号
	 */
    private String identifier;
    /**
	 * 调出仓库id
	 */
    private Integer exportWarehouseId;
    /**
	 * 调入仓库id
	 */
    private Integer importWarehouseId;
    /**
	 * 运输方式id
	 */
    private Integer shippingModeId;
    /**
	 * 调整科目
	 */
    private String importBranch;
    /**
	 * 调入机构
	 */
    private String adjustSubject;
    /**
	 * 送货地址
	 */
    private String sendGoodsPlace;
    /**
	 * personId
	 */
    private Integer personId;
    /**
	 * 制单人
	 */
    private String originator;
    /**
	 * 摘要
	 */
    private String summary;
    /**
	 * 打印次数
	 */
    private Integer printNum;
    /**
	 * 调拨商品
	 */
    private List<AllotOrderCommodity> allotOrderCommodities;
    /**
	 * 调出仓库名
	 */
    private String exportName;
    /**
	 * 调入仓库名
	 */
    private String importName;
    /**
	 * 运输方式
	 */
    private ShippingMode  shippingMode;
    /**
	 * 
	 */
    private String makePerson;
    /**
	 * person对象
	 */
    private Person person;
    /**
	 * 收货地址
	 *
	 */
    private String importPlace;
    /**
	 * 发货地址
	 */
    private String exportPlace;
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

	public String getImportPlace() {
		return importPlace;
	}

	public void setImportPlace(String importPlace) {
		this.importPlace = importPlace;
	}

	public String getExportPlace() {
		return exportPlace;
	}

	public void setExportPlace(String exportPlace) {
		this.exportPlace = exportPlace;
	}

	public Person getPerson() {
		return person;
	}

	public void setPerson(Person person) {
		this.person = person;
	}

	private Unit unit;
    

	public Unit getUnit() {
		return unit;
	}

	public void setUnit(Unit unit) {
		this.unit = unit;
	}

	public String getMakePerson() {
		return makePerson;
	}

	public void setMakePerson(String makePerson) {
		this.makePerson = makePerson;
	}

	public ShippingMode getShippingMode() {
		return shippingMode;
	}

	public void setShippingMode(ShippingMode shippingMode) {
		this.shippingMode = shippingMode;
	}

	@Override
	public String toString() {
		return "AllotOrder [id=" + id + ", allotDate=" + allotDate + ", identifier=" + identifier
				+ ", exportWarehouseId=" + exportWarehouseId + ", importWarehouseId=" + importWarehouseId
				+ ", shippingModeId=" + shippingModeId + ", importBranch=" + importBranch + ", adjustSubject="
				+ adjustSubject + ", sendGoodsPlace=" + sendGoodsPlace + ", personId=" + personId + ", originator="
				+ originator + ", summary=" + summary + ", printNum=" + printNum + "]";
	}

	public String getExportName() {
		return exportName;
	}

	public void setExportName(String exportName) {
		this.exportName = exportName;
	}

	public String getImportName() {
		return importName;
	}

	public void setImportName(String importName) {
		this.importName = importName;
	}

	

	

	public List<AllotOrderCommodity> getAllotOrderCommodities() {
		return allotOrderCommodities;
	}

	public void setAllotOrderCommodities(List<AllotOrderCommodity> allotOrderCommodities) {
		this.allotOrderCommodities = allotOrderCommodities;
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

    public Date getAllotDate() {
        return allotDate;
    }

    public void setAllotDate(Date allotDate) {
        this.allotDate = allotDate;
    }

    public String getIdentifier() {
        return identifier;
    }

    public void setIdentifier(String identifier) {
        this.identifier = identifier == null ? null : identifier.trim();
    }

    public Integer getExportWarehouseId() {
        return exportWarehouseId;
    }

    public void setExportWarehouseId(Integer exportWarehouseId) {
        this.exportWarehouseId = exportWarehouseId;
    }

    public Integer getImportWarehouseId() {
        return importWarehouseId;
    }

    public void setImportWarehouseId(Integer importWarehouseId) {
        this.importWarehouseId = importWarehouseId;
    }

    public Integer getShippingModeId() {
        return shippingModeId;
    }

    public void setShippingModeId(Integer shippingModeId) {
        this.shippingModeId = shippingModeId;
    }

    public String getImportBranch() {
        return importBranch;
    }

    public void setImportBranch(String importBranch) {
        this.importBranch = importBranch == null ? null : importBranch.trim();
    }

    public String getAdjustSubject() {
        return adjustSubject;
    }

    public void setAdjustSubject(String adjustSubject) {
        this.adjustSubject = adjustSubject == null ? null : adjustSubject.trim();
    }

    public String getSendGoodsPlace() {
        return sendGoodsPlace;
    }

    public void setSendGoodsPlace(String sendGoodsPlace) {
        this.sendGoodsPlace = sendGoodsPlace == null ? null : sendGoodsPlace.trim();
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

    public String getSummary() {
        return summary;
    }

    public void setSummary(String summary) {
        this.summary = summary == null ? null : summary.trim();
    }
}