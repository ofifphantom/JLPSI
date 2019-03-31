package com.jl.psi.model;
/**
 * 菜单model
 * @author 景雅倩
 * @date  2017-11-3  下午3:50:53
 * @Description TODO
 */
public class Menu {
    private Integer id;
    
    /**
     * 父id
     */
    private Integer parentId;
    
    /**
     * 菜单名称
     */
    private String name;
    
    /**
     * 菜单url
     */
    private String url;
    
    /**
     * 图标
     */
    private String icon;
    
    /**
     * 排序
     */
    private Integer sort;
    
    /**
     * 是否有效
     */
    private Integer isEffective;
    
    /**
     * 是否消息提醒
     */
    private Integer isMessage;
    /**
     * 业务类型(1 客户维护，2 供应商维护，3商品维护，4采购订单，5销售订单 )
     */
    private Integer serviceType;
    /**
     * '是否添加页面（0 否 1是）
     */
    private Integer isAdd;
 
    
    
    
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getParentId() {
        return parentId;
    }

    public void setParentId(Integer parentId) {
        this.parentId = parentId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url == null ? null : url.trim();
    }

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon == null ? null : icon.trim();
    }

   

    public Integer getSort() {
		return sort;
	}

	public void setSort(Integer sort) {
		this.sort = sort;
	}

	public Integer getIsEffective() {
        return isEffective;
    }

    public void setIsEffective(Integer isEffective) {
        this.isEffective = isEffective;
    }

	public Integer getIsMessage() {
		return isMessage;
	}

	public void setIsMessage(Integer isMessage) {
		this.isMessage = isMessage;
	}

	public Integer getServiceType() {
		return serviceType;
	}

	public void setServiceType(Integer serviceType) {
		this.serviceType = serviceType;
	}

	public Integer getIsAdd() {
		return isAdd;
	}

	public void setIsAdd(Integer isAdd) {
		this.isAdd = isAdd;
	}
    
    
}