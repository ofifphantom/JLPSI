package com.jl.psi.service;

/**
 * 基础业务类
 * */
public interface BaseService<T> {

	/**
	 *根据主键删除 信息
	 **/
	public int deleteByPrimaryKey(Integer id) ;
    /**
	 *保存全部信息 
	 **/
	public int insert(T t) throws Exception;
    /**
	 *保存所选内容的信息 
	 **/
	public int insertSelective(T t) throws Exception;
    /**
	 *根据主键查询信息
	 **/ 
	public T selectByPrimaryKey(Integer id);
    /**
	 *根据主键更新所选内容 
	 **/
	public int updateByPrimaryKeySelective(T t) throws Exception;
    /**
	 *根据主键更新全部内容  
	 **/
	public int updateByPrimaryKey(T t) throws Exception;

	
}
