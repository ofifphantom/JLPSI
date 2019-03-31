package com.jl.psi.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jl.psi.mapper.MenuMapper;
import com.jl.psi.model.Menu;
import com.jl.psi.service.MenuService;
/**
 * 菜单ServiceImpl
 * @author 景雅倩
 * @date  2017-11-3  下午3:44:40
 * @Description TODO
 */
@Service
public class MenuServiceImpl  implements MenuService{

	@Autowired
	private MenuMapper menuMapper;
	

	@Override
	public int deleteByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return menuMapper.deleteByPrimaryKey(id);
	}

	@Override
	public int insert(Menu t) throws Exception {
		// TODO Auto-generated method stub
		return menuMapper.insert(t);
	}

	@Override
	public int insertSelective(Menu t) throws Exception {
		// TODO Auto-generated method stub
		return menuMapper.insertSelective(t);
	}

	@Override
	public Menu selectByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return menuMapper.selectByPrimaryKey(id);
	}

	@Override
	public int updateByPrimaryKeySelective(Menu t) throws Exception {
		// TODO Auto-generated method stub
		return menuMapper.updateByPrimaryKeySelective(t);
	}

	@Override
	public int updateByPrimaryKey(Menu t) throws Exception {
		// TODO Auto-generated method stub
		return menuMapper.updateByPrimaryKey(t);
	}

	public List<Menu> selectByAll() {
		// TODO Auto-generated method stub
		return menuMapper.selectByAll();
	}
	
    public Menu selectByName(String name) {
    	return menuMapper.selectByName(name);
    }

   
}