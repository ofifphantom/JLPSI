package com.jl.psi.model;

/**
 * 单据打印时的头部和底部
 * @author 柳亚婷
 * @Description: TODO
 * @date: 2018年5月24日 下午5:11:33
 */
public class FormHeadAndFooter {

	/**
	 * 字段名
	 */
	String fieldName;
	/**
	 * 字段值
	 */
	String fieldValue;
	
	public String getFieldName() {
		return fieldName;
	}
	public void setFieldName(String fieldName) {
		this.fieldName = fieldName;
	}
	public String getFieldValue() {
		return fieldValue;
	}
	public void setFieldValue(String fieldValue) {
		this.fieldValue = fieldValue;
	}
	
	
}
