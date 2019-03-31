package com.jl.psi.mapper;

 import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.jl.psi.model.BillsSub;
import com.jl.psi.model.WriteOffSub;

/**
 * 核销单子项持久化
 * @author guole
 *
 */
public interface WriteOffSubMapper extends BaseMapper<WriteOffSub>{
		/**
		 * 查询预收冲应收 子项
		 * @return
		 */
		public List<WriteOffSub> selectAdvanceReceivable(@Param("supctoId") Integer supctoId);
		/**
		 * 查询 预付冲应付 子项
		 * @return
		 */
		public List<WriteOffSub> selectAdvancePayable(@Param("supctoId") Integer supctoId);
		/**
		/**
		 * 查询客户核销单子项
		 * @return
		 */
		public List<WriteOffSub> selectBySaleId(@Param("supctoId") Integer supctoId,@Param("type") Integer type);
		/**
		 * 查询供应商核销单子项
		 * @return
		 */
		 public List<WriteOffSub> selectByProcureId(@Param("supctoId") Integer supctoId,@Param("type") Integer type);
	   	/**
		 * 根据核销主项id查询销售订单列表
		 * @param map
		 * @return
		 */
		public List<WriteOffSub> selectSalesById(@Param("writeoffId") Integer writeoffId);
		
	   	/**
		 * 根据核销主项id查询订单列表
		 * @param map
		 * @return
		 */
		public List<WriteOffSub> selectProcureById(@Param("writeoffId") Integer writeoffId);
	
		/**
		 * 批量添加
		 * @param list
		 * @return
		 */
		public Integer insertBatch(List<WriteOffSub> list);
		/**
	   	 * 销售开单收款情况一览表
	   	 * @param map 查询条件
	   	 * @return 
	   	 */
	   	public List<WriteOffSub> reportSalesOpenReceiveMoney(Map<String, Object> map);

}
