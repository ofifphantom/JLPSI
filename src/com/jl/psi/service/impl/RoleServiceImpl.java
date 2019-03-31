package com.jl.psi.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jl.psi.mapper.RoleMapper;
import com.jl.psi.model.Role;
import com.jl.psi.service.RoleService;
/**
 * 角色ServiceImpl
 * @author 景雅倩
 * @date  2017-11-3  下午3:45:37
 * @Description TODO
 */
@Service
public class RoleServiceImpl  implements RoleService{

	@Autowired
	private RoleMapper roleMapper;
	
	@Override
	public int deleteByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return roleMapper.deleteByPrimaryKey(id);
	}

	@Override
	public int insert(Role t) throws Exception {
		// TODO Auto-generated method stub
		return roleMapper.insert(t);
	}

	@Override
	public int insertSelective(Role t) throws Exception {
		// TODO Auto-generated method stub
		return roleMapper.insertSelective(t);
	}

	@Override
	public Role selectByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return roleMapper.selectByPrimaryKey(id);
	}

	@Override
	public int updateByPrimaryKeySelective(Role t) throws Exception {
		// TODO Auto-generated method stub
		return roleMapper.updateByPrimaryKeySelective(t);
	}

	@Override
	public int updateByPrimaryKey(Role t) throws Exception {
		// TODO Auto-generated method stub
		return roleMapper.updateByPrimaryKey(t);
	}
   
}