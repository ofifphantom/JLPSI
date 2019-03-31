package com.jl.psi.mapper;

 
import com.jl.psi.model.Message;
 
public interface MessageMapper  extends BaseMapper<Message>{
	
 	
	public int  delete(Message message);
}
