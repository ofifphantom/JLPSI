package com.jl.psi.utils;

public class Constants {

	public static final boolean SUCCESS = true;

	public static final boolean FAILURE = false;

	public static final String OPERATION_SUCCESS_MSG = "操作成功!";
	
	public static final String OPERATION_FAILURE_MSG = "操作失败!";

	public static final String SAVE_FAILURE_MSG = "信息保存失败!";
	
	public static final String SAVE_SUCCESS_MSG = "信息保存成功!";

	public static final String UPDATE_SUCCESS_MSG = "信息修改成功!";

	public static final String UPDATE_FAILURE_MSG = "信息修改失败!";

	public static final String DELE_SUCCESS_MSG = "信息删除成功!";

	public static final String DELE_FAILURE_MSG = "信息删除失败!";
	
	public static final String EFFECT_SUCCESS_MSG = "操作成功，已生效!";

	public static final String EFFECT_FAILURE_MSG = "操作失败，请确认后重新操作!";
	
	public static final String SESSION_TIMEOUT_MSG = "登录已失效,请重新登录!";
	
	public static final String OPERATE_INSERT = "添加";
	
	public static final String OPERATE_UPDATE = "修改";
	
	public static final String OPERATE_DELETE = "删除";
	
	public static final String NO_DATA_EXPORT = "无数据";
	
	
	
	
	//管理员标志
	public static final int ADMIN_FLAG = 0;
	//用户标志
	public static final int USER_FLAG = 1;
	
	
	//用户组_超级管理员
	public static final int USER_GROUP_SUPER_ADMINISTRATOR = 0;
	//用户组_管理员
	public static final int USER_GROUP_ADMINISTRATOR = 1;
	//用户组_操作员
	public static final int USER_GROUP_OPERATOR = 2;
	
	
	
	
//流水号前缀
	
	
	//管理员
	public static final String NO_ADMIN = "ADMIN";
	//商品一级分类
	public static final String NO_GOODSONECLASSIFICATION = "GONECLA";
	//商品二级分类
	public static final String NO_GOODSTWOCLASSIFICATION = "GTWOCLA";
	//商品
	public static final String NO_GOODS = "GOODS";
	//供应商
	public static final String NO_SUPPLIER = "S";
	//客户
	public static final String NO_CUSTOMER = "C";
	//结算方式
	public static final String NO_SETTLEMENT = "SETTYPE";
	//部门
	public static final String NO_DEPARTMENT = "DEPT";
	//仓库
	public static final String NO_WAREHOUSE = "WARE";
	//员工
	public static final String NO_PERSON = "PERSON";
	
	
//Code码
	
	
	//管理员
	public static final int CODE_ADMIN = 5;
	//商品一级分类
	public static final int CODE_GOODSONECLASSIFICATION = 2;
	//商品二级分类
	public static final int CODE_GOODSTWOCLASSIFICATION = 3;
	//商品
	public static final int CODE_GOODS = 7;
	//供应商
	public static final int CODE_SUPPLIER = 4;
	//客户
	public static final int CODE_CUSTOMER = 6;
	//结算方式
	public static final int CODE_SETTLEMENT = 8;
	//部门
	public static final int CODE_DEPARTMENT = 9;
	//仓库
	public static final int CODE_WAREHOUSE = 10;
	//员工
	public static final int CODE_PERSON = 11;
	
	
	
    //客户/供应商状态
		//未送审
	public static final int STATE_SUPCTO_NOTSUBMIT = 1;
	
		//审核中
	public static final int STATE_SUPCTO_CHECKING = 2;
	
		//审核通过
	public static final int STATE_SUPCTO_PASS = 3;
	
		//审核未通过
	public static final int STATE_SUPCTO_REFUSED = 4;
	
		//停用审核中
	public static final int STATE_SUPCTO_DISABLEDCHECKING = 5;
	
		//停用审核驳回
	public static final int STATE_SUPCTO_DISABLEDREFUSED = 6;
	
		//停用审核通过
	public static final int STATE_SUPCTO_DISABLEDPASS = 7;
	
		//已恢复使用
	public static final int STATE_SUPCTO_RECOVERYUSE = 8;
	
	
	//采购订单状态
	//采购订单已送审
	public static final int STATE_PROCURETABLE_IS_REVIEW = 2;
		//采购订单审核通过
	public static final int STATE_PROCURETABLE_REVIEW_PASS = 3;
	
		//采购订单审核未通过
	public static final int STATE_PROCURETABLE_REVIEW_REFUSED = 4;
	
		//已付款
	public static final int STATE_PROCURETABLE_PAID = 6;
	//已撤销
	public static final int STATE_PROCURETABLE_CANCLE = 7;
	//送审终止
	public static final int STATE_PROCURETABLE_END = 8;
		//采购终止审核通过
	public static final int STATE_PROCURETABLE_AUDIT_PASS = 9;
	
		//采购终止审核未通过
	public static final int STATE_PROCURETABLE_AUDIT_REFUSED = 10;
	
    
  //日志操作类型   0：商品配置  1：客户配置  2：供应商配置  3：用户管理  4:审核 5:结算方式配置 6:员工配置 7:部门配置 8:仓库配置 9:运输方式配置 10:采购 11:打印 12:销售
    
    public static final int TYPE_LOG_GOODS = 0;
    
    public static final int TYPE_LOG_CUSTOMER = 1;
    
    public static final int TYPE_LOG_SUPPLIER = 2;
    
    public static final int TYPE_LOG_USERMANAGER = 3;
    
    public static final int TYPE_LOG_CHECK = 4;
    
    public static final int TYPE_LOG_SETTLEMENT = 5;
    
    public static final int TYPE_LOG_PERSON = 6;
    
    public static final int TYPE_LOG_DEPARTMENT = 7;
    
    public static final int TYPE_LOG_WAREHOUSE = 8;
    
    public static final int TYPE_LOG_SHIPPINGMODE = 9;
    
    public static final int TYPE_LOG_PROCURE = 10;
    
    public static final int TYPE_LOG_PRINT = 11;
    
    public static final int TYPE_LOG_SALES = 12;
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
