package com.jl.psi.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

 import com.jl.psi.model.WriteOff;
import com.jl.psi.model.WriteOffSub;
 

public interface WriteOffSubService extends BaseService<WriteOff>{
	/**
	 * 查询客户核销单子项
	 * @return
	 */
	public List<WriteOffSub> selectBySaleId(  Integer supctoId,  Integer type);
	/**
	 * 查询供应商核销单子项
	 * @return
	 */
	 public List<WriteOffSub> selectByProcureId(  Integer supctoId,  Integer type);

		/**
		 * 根据核销主项id查询销售订单列表
		 * @param map
		 * @return
		 */
		public List<WriteOffSub> selectSalesById(Integer writeoffId);
		
	   	/**
		 * 根据核销主项id查询订单列表
		 * @param map
		 * @return
		 */
		public List<WriteOffSub> selectProcureById( Integer writeoffId);
	/**
	 * 批量插入
	 * @return
	 */
	public Integer insertBatch(List<WriteOffSub> list);
	/**
   	 * 销售开单收款情况一览表
   	 * @param map 查询条件
   	 * @return 
   	 */
   	public List<WriteOffSub> reportSalesOpenReceiveMoney(Map<String, Object> map);
   	
	/**
	 * 查询预收冲应收 子项
	 * @return
	 */
	public List<WriteOffSub> selectAdvanceReceivable( Integer supctoId);
	/**
	 * 查询 预付冲应付 子项
	 * @return
	 */
	public List<WriteOffSub> selectAdvancePayable( Integer supctoId);
}
