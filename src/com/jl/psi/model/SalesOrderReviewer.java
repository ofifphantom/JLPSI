package com.jl.psi.model;
/**
 * 
 * @author 景雅倩
 * @date  2018年5月23日  上午10:47:52
 * @Description  销售订单审批Model
 */
public class SalesOrderReviewer {

    /**
	 * 主键
	 */
    private Integer id;

    /**
	 * 销售订单id
	 */
    private Integer salesOrderId;

    /**
	 * 审批人id
	 */
    private Integer reviewerId;

    /**
	 * 审批类型（1：订单审核，2：作废销售领导审核，3：作废仓库审核，4：销售开单审核，5：申请修改审核，6：折损单审核）
	 */
    private Integer reviewerType;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getSalesOrderId() {
        return salesOrderId;
    }

    public void setSalesOrderId(Integer salesOrderId) {
        this.salesOrderId = salesOrderId;
    }

    public Integer getReviewerId() {
        return reviewerId;
    }

    public void setReviewerId(Integer reviewerId) {
        this.reviewerId = reviewerId;
    }

    public Integer getReviewerType() {
        return reviewerType;
    }

    public void setReviewerType(Integer reviewerType) {
        this.reviewerType = reviewerType;
    }
}