package com.jl.psi.mapper;

import java.util.List;

import com.jl.psi.model.Menu;
/**
 * 菜单mapper
 * @author 景雅倩
 * @date  2017-11-3  下午3:44:40
 * @Description TODO
 */
public interface MenuMapper  extends BaseMapper<Menu>{
	List<Menu>selectByAll();
	Menu	selectByName(String name);
}