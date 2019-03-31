package com.jl.psi.service.impl;


import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jl.psi.mapper.PermissionMapper;
import com.jl.psi.model.Permission;
import com.jl.psi.service.PermissionService;
/**
 * 权限ServiceImpl
 * @author 景雅倩
 * @date  2017-11-3  下午3:45:26
 * @Description TODO
 */
@Service
public class PermissionServiceImpl  implements PermissionService{

	@Autowired
	private PermissionMapper permissionMapper;
	

	@Override
	public int deleteByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return permissionMapper.deleteByPrimaryKey(id);
	}

	@Override
	public int insert(Permission t) throws Exception {
		// TODO Auto-generated method stub
		return permissionMapper.insert(t);
	}

	@Override
	public int insertSelective(Permission t) throws Exception {
		// TODO Auto-generated method stub
		return permissionMapper.insertSelective(t);
	}

	@Override
	public Permission selectByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return permissionMapper.selectByPrimaryKey(id);
	}

	@Override
	public int updateByPrimaryKeySelective(Permission t) throws Exception {
		// TODO Auto-generated method stub
		return permissionMapper.updateByPrimaryKeySelective(t);
	}

	@Override
	public int updateByPrimaryKey(Permission t) throws Exception {
		// TODO Auto-generated method stub
		return permissionMapper.updateByPrimaryKey(t);
	}

	@Override
	public int insertBatch(String[] permissions, Integer adminId,String userIdentifier,Date date) {
		Permission permissionMsg;
		List<Permission> permissionList=new ArrayList<>();
		//组合成一个个permission类，传入mapper中
		for(String permission:permissions){
			permissionMsg=new Permission();
			permissionMsg.setMenuId(Integer.parseInt(permission));
			permissionMsg.setUserId(adminId);
			permissionMsg.setOperatorIdentifier(userIdentifier);
			permissionMsg.setCreateTime(date);
			permissionList.add(permissionMsg);
		}
		return permissionMapper.insertBatch(permissionList);
	}

	@Override
	public int deleteByUserId(Integer id) {
		// TODO Auto-generated method stub
		return permissionMapper.deleteByUserId(id);
	}

	@Override
	public boolean deletePermissionByUserIds(List<Integer> list) {
		// TODO Auto-generated method stub
		return permissionMapper.deletePermissionByUserIds(list);
	}
    
}