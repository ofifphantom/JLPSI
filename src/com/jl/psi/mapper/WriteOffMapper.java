package com.jl.psi.mapper;


import com.jl.psi.model.WriteOff;

public interface WriteOffMapper extends BaseMapper<WriteOff>{
	public String selectMaxCode();
	
	
}
