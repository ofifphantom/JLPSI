package com.jl.psi.service;

import com.jl.psi.model.Bills;
import com.jl.psi.model.WriteOff;
import com.jl.psi.utils.DataTables;

public interface WriteOffService extends BaseService<WriteOff>{
	 /**
	  * 分页
	  * @param dataTables
	  * @return
	  */
	public DataTables dataTables(DataTables dataTables,Integer type,String writeoffCode,Integer companyOne,Integer companyTwo,String dateSearch);
	/**
	 * 查询最大编号
	 * @return
	 */
	public String  selectMaxCode();
}
