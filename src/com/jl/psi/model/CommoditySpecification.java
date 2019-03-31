package com.jl.psi.model;

import java.util.Date;
import java.util.List;

/**
 * 
 * @author 柳亚婷
 * @Description: 商品规格model
 * @date: 2018年5月9日 下午3:05:53
 */
/**
 * @author 柳亚婷
 * @Description: TODO
 * @date: 2018年6月14日 下午12:03:26
 */
public class CommoditySpecification {
	/**
	 * 主键
	 */
    private Integer id;
    /**
	 * 订单id
	 */
    private Integer soId;
    
    /**
	 * 订单商品数量
	 */
    private Integer num;
    
	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

	/**
     * 规格编号
     */
    private String specificationIdentifier;
    /**
     * 规格名称
     */
    private String specificationName;
    /**
     * 商品Id
     */
    private Integer commodityId;
    /**
     * 保质日期
     */
    private Integer qualityPeriod;
    /**
     * 保质日期单位
     */
    private String qualityPeriodUnit;
    /**
     * 最小订货量
     */
    private Integer miniOrderQuantity;
    /**
     * 临时最小订货量
     */
    private Integer tempMiniOrderQuantity;
    /**
     * 最小订货增量
     */
    private Integer addOrderQuantity;
    /**
     * 临时最小订货增量
     */
    private Integer tempAddOrderQuantity;
    /**
     * 包装尺寸
     */
    private String packagingSize;
    /**
     * 是否停用，0未，1已停用
     */
    private Integer isDelete;
    /**
     * 预警数量
     */
    private Integer warningNumber;
    /**
     * 临时预警数量
     */
    private Integer tempWarningNumber;
    /**
     * 商品重量
     */
    private Double weight;
    /**
     * 操作人编号
     */
    private String operatorIdentifier;
    /**
     * 操作时间
     */
    private Date operatorTime;
    /**
     * 状态（1：未送审  2：待审核  3：通过  4：拒绝  ）
     */
    private Integer state;
    
    /**
	 * 临时仓库id
	 */
	private Integer tempWarehouseId;
	/**
	 * 临时库存
	 */
	private Integer tempInventory;
	/**
	 * 临时库存上限
	 */
	private Integer tempMaxInventory;
	/**
	 * 临时库存下限
	 */
	private Integer tempMiniInventory;
	/**
     * 临时状态（10:采购修改审核中  11：采购修改审核驳回  12:销售修改审核中  13：:销售修改审核驳回   14：采购修改总经理审核中  15：采购修改总经理审核驳回   ）
     */
    private Integer tempState;
 // 根据结果需要，在model里另添格外的字段
    /**
     * 商品信息
     */
    private Commodity commodity;
    /**
 	 * 操作人信息
 	 */
    private Person person;
 	/**
 	 * 单位信息
 	 */
    private List<Unit> units;
 	/**
 	 * 库存信息
 	 */
    private List<Inventory> inventories;
    /**
     * 条形码
     */
    
    private String barCode;
    /**
     * 账面库存发出数量
     */
    private Integer sendNum;
    /**
     * 账面库存收入数量
     */
    private Integer receiveNum;
    /**
     * 一般销售价格
     */
    private Double commentPrice;
    /**
     * 一般销售价格
     */
    private Double miniPrice;
    /**
     * 占用数量
     */
    private Integer occupiedNum;
    
    public Integer getOccupiedNum() {
		return occupiedNum;
	}

	public void setOccupiedNum(Integer occupiedNum) {
		this.occupiedNum = occupiedNum;
	}

	public Integer getSendNum() {
		return sendNum;
	}

	public void setSendNum(Integer sendNum) {
		this.sendNum = sendNum;
	}

	public Integer getReceiveNum() {
		return receiveNum;
	}

	public void setReceiveNum(Integer receiveNum) {
		this.receiveNum = receiveNum;
	}

	public Double getCommentPrice() {
		return commentPrice;
	}

	public void setCommentPrice(Double commentPrice) {
		this.commentPrice = commentPrice;
	}

	public Double getMiniPrice() {
		return miniPrice;
	}

	public void setMiniPrice(Double miniPrice) {
		this.miniPrice = miniPrice;
	}

	public String getWarehouseName() {
		return warehouseName;
	}

	public void setWarehouseName(String warehouseName) {
		this.warehouseName = warehouseName;
	}

	public Integer getOccupiednventory() {
		return occupiednventory;
	}

	public void setOccupiednventory(Integer occupiednventory) {
		this.occupiednventory = occupiednventory;
	}

	/**
     * 仓库名称
     */
    private String warehouseName;
    /**
     * 占用库存
     */
    private Integer occupiednventory;
    public String getBarCode() {
		return barCode;
	}

	public void setBarCode(String barCode) {
		this.barCode = barCode;
	}
	/**
     * 调拨单信息
     */
	private List<AllotOrderCommodity>  allotOrderCommodities;
	
	
    public List<AllotOrderCommodity> getAllotOrderCommodities() {
		return allotOrderCommodities;
	}

	public void setAllotOrderCommodities(List<AllotOrderCommodity> allotOrderCommodities) {
		this.allotOrderCommodities = allotOrderCommodities;
	}

	/**
     * 基本单位的单位名称
     */
    private String baseUnitName;
    
    /**
     * 基本单位下的一般销售价格
     */
    private Double baseCommonlyPrice;
    
 	/**
 	 * 商品规格所在的仓库
 	 */
 	private Integer specWarehouseId;
 	
 	/**
 	 * 商品规格所在仓库名称
 	 */
 	private String specWarehouseName;
 	
 	/**
 	 * 商品的原始单价---上一次的采购价格
 	 */
 	private Double specOriginalUnitPrice;

 	/**
 	 * 账面数量
 	 */
 	private Integer inventoryNum;
 	
 	/**
 	 * 移动平均价
 	 */
    private Double movingAveragePrice;
    
    /**
     * 基本单位下的最低销售价格
     */
    private Double baseMiniPrice;
    /**
     * 商品的条形码
     */
    private String goodsBarCode;
    public Integer getSoId() {
		return soId;
	}

	public void setSoId(Integer soId) {
		this.soId = soId;
	}
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getSpecificationIdentifier() {
        return specificationIdentifier;
    }

    public void setSpecificationIdentifier(String specificationIdentifier) {
        this.specificationIdentifier = specificationIdentifier == null ? null : specificationIdentifier.trim();
    }

    public String getSpecificationName() {
        return specificationName;
    }

    public void setSpecificationName(String specificationName) {
        this.specificationName = specificationName == null ? null : specificationName.trim();
    }

    public Integer getCommodityId() {
        return commodityId;
    }

    public void setCommodityId(Integer commodityId) {
        this.commodityId = commodityId;
    }

    public Integer getQualityPeriod() {
		return qualityPeriod;
	}

	public void setQualityPeriod(Integer qualityPeriod) {
		this.qualityPeriod = qualityPeriod;
	}

	public String getQualityPeriodUnit() {
		return qualityPeriodUnit;
	}

	public void setQualityPeriodUnit(String qualityPeriodUnit) {
		this.qualityPeriodUnit = qualityPeriodUnit;
	}

	public Integer getMiniOrderQuantity() {
        return miniOrderQuantity;
    }

    public void setMiniOrderQuantity(Integer miniOrderQuantity) {
        this.miniOrderQuantity = miniOrderQuantity;
    }

    public Integer getAddOrderQuantity() {
        return addOrderQuantity;
    }

    public void setAddOrderQuantity(Integer addOrderQuantity) {
        this.addOrderQuantity = addOrderQuantity;
    }

    public String getPackagingSize() {
        return packagingSize;
    }

    public void setPackagingSize(String packagingSize) {
        this.packagingSize = packagingSize == null ? null : packagingSize.trim();
    }

    public Integer getIsDelete() {
        return isDelete;
    }

    public void setIsDelete(Integer isDelete) {
        this.isDelete = isDelete;
    }

    public Integer getWarningNumber() {
        return warningNumber;
    }

    public void setWarningNumber(Integer warningNumber) {
        this.warningNumber = warningNumber;
    }

    public Double getWeight() {
        return weight;
    }

    public void setWeight(Double weight) {
        this.weight = weight;
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

	public List<Unit> getUnits() {
		return units;
	}

	public void setUnits(List<Unit> units) {
		this.units = units;
	}

	public List<Inventory> getInventories() {
		return inventories;
	}

	public void setInventories(List<Inventory> inventories) {
		this.inventories = inventories;
	}

	public Commodity getCommodity() {
		return commodity;
	}

	public void setCommodity(Commodity commodity) {
		this.commodity = commodity;
	}

	public Integer getState() {
		return state;
	}

	public void setState(Integer state) {
		this.state = state;
	}

	public String getBaseUnitName() {
		return baseUnitName;
	}

	public void setBaseUnitName(String baseUnitName) {
		this.baseUnitName = baseUnitName;
	}

	public Double getBaseCommonlyPrice() {
		return baseCommonlyPrice;
	}

	public void setBaseCommonlyPrice(Double baseCommonlyPrice) {
		this.baseCommonlyPrice = baseCommonlyPrice;
	}

	public Integer getSpecWarehouseId() {
		return specWarehouseId;
	}

	public void setSpecWarehouseId(Integer specWarehouseId) {
		this.specWarehouseId = specWarehouseId;
	}

	public Double getSpecOriginalUnitPrice() {
		return specOriginalUnitPrice;
	}

	public void setSpecOriginalUnitPrice(Double specOriginalUnitPrice) {
		this.specOriginalUnitPrice = specOriginalUnitPrice;
	}

	public Integer getInventoryNum() {
		return inventoryNum;
	}

	public void setInventoryNum(Integer inventoryNum) {
		this.inventoryNum = inventoryNum;
	}

	public Double getMovingAveragePrice() {
		return movingAveragePrice;
	}

	public void setMovingAveragePrice(Double movingAveragePrice) {
		this.movingAveragePrice = movingAveragePrice;
	}

	public Double getBaseMiniPrice() {
		return baseMiniPrice;
	}

	public void setBaseMiniPrice(Double baseMiniPrice) {
		this.baseMiniPrice = baseMiniPrice;
	}

	public String getSpecWarehouseName() {
		return specWarehouseName;
	}

	public void setSpecWarehouseName(String specWarehouseName) {
		this.specWarehouseName = specWarehouseName;
	}

	public String getGoodsBarCode() {
		return goodsBarCode;
	}

	public void setGoodsBarCode(String goodsBarCode) {
		this.goodsBarCode = goodsBarCode;
	}

	public Integer getTempMiniOrderQuantity() {
		return tempMiniOrderQuantity;
	}

	public void setTempMiniOrderQuantity(Integer tempMiniOrderQuantity) {
		this.tempMiniOrderQuantity = tempMiniOrderQuantity;
	}

	public Integer getTempAddOrderQuantity() {
		return tempAddOrderQuantity;
	}

	public void setTempAddOrderQuantity(Integer tempAddOrderQuantity) {
		this.tempAddOrderQuantity = tempAddOrderQuantity;
	}

	public Integer getTempWarningNumber() {
		return tempWarningNumber;
	}

	public void setTempWarningNumber(Integer tempWarningNumber) {
		this.tempWarningNumber = tempWarningNumber;
	}

	public Integer getTempWarehouseId() {
		return tempWarehouseId;
	}

	public void setTempWarehouseId(Integer tempWarehouseId) {
		this.tempWarehouseId = tempWarehouseId;
	}

	public Integer getTempInventory() {
		return tempInventory;
	}

	public void setTempInventory(Integer tempInventory) {
		this.tempInventory = tempInventory;
	}

	public Integer getTempMaxInventory() {
		return tempMaxInventory;
	}

	public void setTempMaxInventory(Integer tempMaxInventory) {
		this.tempMaxInventory = tempMaxInventory;
	}

	public Integer getTempMiniInventory() {
		return tempMiniInventory;
	}

	public void setTempMiniInventory(Integer tempMiniInventory) {
		this.tempMiniInventory = tempMiniInventory;
	}

	public Integer getTempState() {
		return tempState;
	}

	public void setTempState(Integer tempState) {
		this.tempState = tempState;
	}

	
	
	
}