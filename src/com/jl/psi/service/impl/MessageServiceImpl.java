package com.jl.psi.service.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jl.psi.mapper.MessageMapper;
import com.jl.psi.model.Menu;
import com.jl.psi.model.Message;
import com.jl.psi.model.ProcureTable;
import com.jl.psi.model.SalesOrder;
import com.jl.psi.service.MenuService;
import com.jl.psi.service.MessageService;
import com.jl.psi.utils.DataTables;

@Service
public class MessageServiceImpl implements MessageService{

    
	@Autowired
	private MenuService  menuService;
	@Autowired
	private MessageMapper messageMapper;
	
 
 
	@Override
	public DataTables dataTables(DataTables dataTables,String userId) {
		// TODO Auto-generated method stub
		String[] columns = { "name"};
		Map<String, Object> params = new HashMap<String, Object>();// 传给Mapper的参数
		params.put("iDisplayStart",
				Integer.parseInt(dataTables.getiDisplayStart()));// 获取开始位置
		params.put("pageDisplayLength",
				Integer.parseInt(dataTables.getPageDisplayLength()));// 获取分页大小
		params.put(dataTables.getsSortDir_0(),
				columns[Integer.parseInt(dataTables.getiSortCol_0())]);// 获取需要的列和对应的排序方式
		params.put("userId",userId);
		dataTables.setiTotalDisplayRecords(messageMapper.iTotalDisplayRecords(params));// 搜索结果总行数
		dataTables.setiTotalRecords(messageMapper.iTotalRecords(params));// 所有记录总行数
		dataTables.setData(messageMapper.selectForSearch(params));// 返回的结果集
		
		return dataTables;
	}
	
	
	@Override
	public void addMessage(Integer serviceId,String menuName) throws Exception {
		Menu menu=menuService.selectByName(menuName);
 
 		Message ms=new Message();
		ms.setMenuId(menu.getId());
		ms.setServiceType(menu.getServiceType());
		ms.setMessageTime(new Date());
		ms.setServiceId(serviceId);
		//删除旧的提醒
		messageMapper.delete(ms);
		//增加新提醒
		messageMapper.insert(ms);
	}	
	
	
	@Override
	public void addMessageBath(List<Integer> serviceIds, String menuName) throws Exception{
		//List<Object> serviceList =(List<Object>)services;
		for(int i=0;i<serviceIds.size();i++) {
			addMessage(serviceIds.get(i),menuName);
		}
 
	}
	 @Override
	public void clearMessage(Integer serviceId, Integer serviceType) throws Exception {
		///清空消息提醒
		 Message ms=new Message();
		 ms.setServiceId(serviceId);
		 ms.setServiceType(serviceType);
		 messageMapper.delete(ms);
		
	}
	 @Override
	public void clearMessageBath(List<Integer> serviceIds, Integer serviceType) throws Exception {
			for(int i=0;i<serviceIds.size();i++) {
				clearMessage(serviceIds.get(i),serviceType);
			}
		
	}
	
}
