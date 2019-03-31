package com.jl.psi.model;

import java.util.List;

/**
 * 
 * @author 柳亚婷
 * @Description:商品model
 * @date: 2018年5月9日 下午2:50:58
 */
public class Commodity {
	/**
	 * 主键
	 */
    private Integer id;
    /**
     * 分类id
     */
    private Integer classificationId;
    /**
     * 商品名称
     */
    private String name;
    
    /**
     * 品牌
     */
    private String brand;
    /**
     * 是否允许0库存出货,0不允许，1允许
     */
    private Integer zeroStock;
    /**
     * 简称
     */
    private String shoutName;
    /**
     * 助记码
     */
    private String mnemonicCode;
    /**
     * 基本信息
     */
    private String basicsInformation;
    /**
     * 货品属性
     */
    private String attribute;
    /**
     * 商品编号
     */
    private String identifier;
    /**
     * 客户/供销商id
     */
    private Integer supctoId;
    /**
     * 默认税率
     */
    private Double taxes;
    /**
     * 临时默认税率
     */
    private Double tempTaxes;
    /**
     * 是否是预售
     */
    private Integer isPresell;
    /**
     * 是否是组装商品(1:是，2：不是）
     */
    private Integer isAssemble;
    
 // 根据结果需要，在model里另添格外的字段
    /**
     * 商品规格信息
     */
    private List<CommoditySpecification> commoditySpecifictions;
    /**
 	 * 分类信息
 	 */
    private Classification classification;
 	/**
 	 * 供货商信息
 	 */
    private Supcto supcto;

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
		this.name = name;
	}

	public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand == null ? null : brand.trim();
    }

    public Integer getZeroStock() {
        return zeroStock;
    }

    public void setZeroStock(Integer zeroStock) {
        this.zeroStock = zeroStock;
    }

    public String getShoutName() {
        return shoutName;
    }

    public void setShoutName(String shoutName) {
        this.shoutName = shoutName == null ? null : shoutName.trim();
    }

    public String getMnemonicCode() {
        return mnemonicCode;
    }

    public void setMnemonicCode(String mnemonicCode) {
        this.mnemonicCode = mnemonicCode == null ? null : mnemonicCode.trim();
    }

    public String getBasicsInformation() {
        return basicsInformation;
    }

    public void setBasicsInformation(String basicsInformation) {
        this.basicsInformation = basicsInformation == null ? null : basicsInformation.trim();
    }

    public String getAttribute() {
        return attribute;
    }

    public void setAttribute(String attribute) {
        this.attribute = attribute == null ? null : attribute.trim();
    }

    public String getIdentifier() {
        return identifier;
    }

    public void setIdentifier(String identifier) {
        this.identifier = identifier == null ? null : identifier.trim();
    }

    public Integer getSupctoId() {
        return supctoId;
    }

    public void setSupctoId(Integer supctoId) {
        this.supctoId = supctoId;
    }

    public Double getTaxes() {
        return taxes;
    }

    public void setTaxes(Double taxes) {
        this.taxes = taxes;
    }

	public List<CommoditySpecification> getCommoditySpecifictions() {
		return commoditySpecifictions;
	}

	public void setCommoditySpecifictions(List<CommoditySpecification> commoditySpecifictions) {
		this.commoditySpecifictions = commoditySpecifictions;
	}

	public Classification getClassification() {
		return classification;
	}

	public void setClassification(Classification classification) {
		this.classification = classification;
	}

	public Supcto getSupcto() {
		return supcto;
	}

	public void setSupcto(Supcto supcto) {
		this.supcto = supcto;
	}

	public Integer getIsAssemble() {
		return isAssemble;
	}

	public void setIsAssemble(Integer isAssemble) {
		this.isAssemble = isAssemble;
	}

	public Integer getIsPresell() {
		return isPresell;
	}

	public void setIsPresell(Integer isPresell) {
		this.isPresell = isPresell;
	}

	public Double getTempTaxes() {
		return tempTaxes;
	}

	public void setTempTaxes(Double tempTaxes) {
		this.tempTaxes = tempTaxes;
	}
    
    
}