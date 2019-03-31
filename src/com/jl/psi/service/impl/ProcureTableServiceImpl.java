package com.jl.psi.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.jl.psi.mapper.ProcureTableMapper;
import com.jl.psi.model.ProcureCommodity;
import com.jl.psi.model.ProcureTable;
import com.jl.psi.service.ProcureTableService;
import com.jl.psi.utils.DataTables;

@Service
public class ProcureTableServiceImpl implements ProcureTableService {
	
	@Autowired
	ProcureTableMapper procureTableMapper;

	@Override
	public List<ProcureTable> reportAccountsGetherTwo(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return procureTableMapper.reportAccountsGetherTwo(params);
	}

	@Override
	public List<ProcureTable> reportImportOrderDetailOrGether(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return procureTableMapper.reportImportOrderDetailOrGether(params);
	}

	@Override
	public List<ProcureTable> reportPayMoneyGetherOne(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return procureTableMapper.reportPayMoneyGetherOne(params);
	}

	@Override
	public List<ProcureTable> reportPayMoneyGetherTwo(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return procureTableMapper.reportPayMoneyGetherTwo(params);
	}

	@Override
	public List<ProcureTable> reportAccountsGetherOne(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return procureTableMapper.reportAccountsGetherOne(params);
	}

	@Override
	public List<ProcureTable> reportPayMoneyGetherThree(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return procureTableMapper.reportPayMoneyGetherThree(params);
	}

	@Override
	public List<ProcureTable> reportProcureFinishOrderPayMoneyDetail(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return procureTableMapper.reportProcureFinishOrderPayMoneyDetail(params);
	}

	@Override
	public int deleteByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return procureTableMapper.deleteByPrimaryKey(id);
	}

	@Override
	public List<ProcureTable> reportProcureOrderGether(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return procureTableMapper.reportProcureOrderGether(params);
	}

	@Override
	public List<ProcureTable> reportProcurePlanOrderDetail(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return procureTableMapper.reportProcurePlanOrderDetail(params);
	}

	@Override
	public List<ProcureTable> reportProcureFinishOrderDetailOrGether(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return procureTableMapper.reportProcureFinishOrderDetailOrGether(params);
	}

	@Override
	public List<ProcureTable> reportProcureOrderDetail(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return procureTableMapper.reportProcureOrderDetail(params);
	}

	@Override
	public List<ProcureTable> reportProcurePlanOrderGether(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return procureTableMapper.reportProcurePlanOrderGether(params);
	}

	@Override
	public int insert(ProcureTable t) throws Exception {
		// TODO Auto-generated method stub
		return procureTableMapper.insert(t);
	}

	@Override
	public int insertSelective(ProcureTable t) throws Exception {
		// TODO Auto-generated method stub
		return procureTableMapper.insertSelective(t);
	}

	@Override
	public ProcureTable selectByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return procureTableMapper.selectByPrimaryKey(id);
	}

	@Override
	public int updateByPrimaryKeySelective(ProcureTable t) throws Exception {
		// TODO Auto-generated method stub
		return procureTableMapper.updateByPrimaryKeySelective(t);
	}

	@Override
	public int updateByPrimaryKey(ProcureTable t) throws Exception {
		// TODO Auto-generated method stub
		return procureTableMapper.updateByPrimaryKey(t);
	}

	@Override
	public DataTables getProcureTableMsg(DataTables dataTables, String identifier, String supctoName,
			String commodityName,String generateDate,String originator,Integer planOrOrder, Integer page,String queryTime,String state,String isPlan) {
		String[] columns = { "id", "identifier", "name","cp.id", "key_word","operator_identifier","operate_time"};
		Map<String, Object> params = new HashMap<String, Object>();// 传给Mapper的参数
		params.put("iDisplayStart",
				Integer.parseInt(dataTables.getiDisplayStart()));// 获取开始位置
		params.put("pageDisplayLength",
				Integer.parseInt(dataTables.getPageDisplayLength()));// 获取分页大小
		params.put(dataTables.getsSortDir_0(),
				columns[Integer.parseInt(dataTables.getiSortCol_0())]);// 获取需要的列和对应的排序方式

		
		params.put("identifier", identifier);
		params.put("supctoName", supctoName);
		params.put("commodityName", commodityName);
		params.put("generateDate", generateDate);
		params.put("originator", originator);
		params.put("planOrOrder", planOrOrder);
		params.put("page", page);
		params.put("state", state);
		params.put("isPlan", isPlan);
  		String[] arr=null;
		if (queryTime!=""&&queryTime!=null) {
			  arr=queryTime.split(" ~ ");//分割起止时间
			  params.put("beginTime", arr[0]);
			  params.put("endTime", arr[1]);
		}
		List<Object> procureTableList=new ArrayList<>();
		procureTableList=procureTableMapper.selectForSearch(params);
		//循环列表，把一个订单表下的所买的商品的名称以及数量整合在一起传到前台进行显示。
		for(int i=0;i<procureTableList.size();i++){
			List<ProcureCommodity> procureCommodityList=((ProcureTable)procureTableList.get(i)).getProcureCommoditys();
			String commoditysName="";	//整合货品名称
			String businessUnitPrices="";	//整合货品对应的业务单价
			String orderNums="";	//整合业务数量/订单数量
			String totalTaxPrices="";//价税合计
			for(int h=0;h<procureCommodityList.size();h++){
				
				if(h<procureCommodityList.size()-1){
					//整合每个订单下的商品名称
					commoditysName+=procureCommodityList.get(h).getCommoditySpecification().getCommodity().getName()+"("+procureCommodityList.get(h).getCommoditySpecification().getSpecificationName()+")"+"<br>";				
					//整合每个订单下的商品数量
					businessUnitPrices+=procureCommodityList.get(h).getBusinessUnitPrice()+"<br>";
					//整合每个订单下的商品价格
					orderNums+=procureCommodityList.get(h).getOrderNum()+"<br>";
					if(planOrOrder==1){
						if(procureCommodityList.get(h).getTotalPrice()!=null){
							totalTaxPrices+=procureCommodityList.get(h).getTotalPrice()+"<br>";
						}
						else{
							totalTaxPrices+=0.0+"<br>";	
						}
						
					}
					else{
						if(procureCommodityList.get(h).getTotalTaxPrice()!=null){
							totalTaxPrices+=procureCommodityList.get(h).getTotalTaxPrice()+"<br>";
						}
						else{
							totalTaxPrices+=0.0+"<br>";	
						}
					}
					
				}
				else{
					commoditysName+=procureCommodityList.get(h).getCommoditySpecification().getCommodity().getName()+"("+procureCommodityList.get(h).getCommoditySpecification().getSpecificationName()+")";
					businessUnitPrices+=procureCommodityList.get(h).getBusinessUnitPrice();
					orderNums+=procureCommodityList.get(h).getOrderNum();
					if(planOrOrder==1){
						totalTaxPrices+=procureCommodityList.get(h).getTotalPrice()!=null?procureCommodityList.get(h).getTotalPrice():0.0;	
					}
					else{
						totalTaxPrices+=procureCommodityList.get(h).getTotalTaxPrice()!=null?procureCommodityList.get(h).getTotalTaxPrice():0.0;	
					}
				}
				
			}
			((ProcureTable)procureTableList.get(i)).setCommoditysName(commoditysName);
			((ProcureTable)procureTableList.get(i)).setBusinessUnitPrices(businessUnitPrices);
			((ProcureTable)procureTableList.get(i)).setOrderNums(orderNums);
			((ProcureTable)procureTableList.get(i)).setTotalTaxPrices(totalTaxPrices);
		}
		//不能用limit来进行分页，因为结果集有重复，只能在service中手动进行分页
		List<Object> resultTableList=new ArrayList<>();
		if((procureTableList.size()-Integer.parseInt(dataTables.getiDisplayStart()))>=Integer.parseInt(dataTables.getPageDisplayLength())){
			
			for(int i=Integer.parseInt(dataTables.getiDisplayStart());i<Integer.parseInt(dataTables.getiDisplayStart())+Integer.parseInt(dataTables.getPageDisplayLength());i++){
				resultTableList.add(procureTableList.get(i));
			}
		}
		else{
			
			for(int i=Integer.parseInt(dataTables.getiDisplayStart());i<procureTableList.size();i++){
				resultTableList.add(procureTableList.get(i));
			}
		}
		
		dataTables.setiTotalDisplayRecords(procureTableMapper
				.iTotalDisplayRecords(params));// 搜索结果总行数
		dataTables.setiTotalRecords(procureTableMapper.iTotalRecords(params));// 所有记录总行数
		dataTables.setData(resultTableList);// 返回的结果集
		return dataTables;
	}


	@Override
	public boolean updateStateByIds(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return procureTableMapper.updateStateByIds(map);
	}

	@Override
	public List<ProcureTable> getProcureTableByIds(ArrayList<Integer> list) {
		// TODO Auto-generated method stub
		return procureTableMapper.getProcureTableByIds(list);
	}


	@Override
	public ProcureTable selectMsgToDetail(Integer id) {
		// TODO Auto-generated method stub
		return procureTableMapper.selectMsgToDetail(id);
	}

	@Override
	public Double getOriginalUnitPrice(Integer commodityId) {
		// TODO Auto-generated method stub
		return procureTableMapper.getOriginalUnitPrice(commodityId);
	}

	@Override
	public List<ProcureTable> selectBatchByPrimaryKey(String[] primaryKeys) {
		Map<String,Object> map=new HashMap<>();
		List<Integer> list=new ArrayList<>();
		for(String id:primaryKeys){
			list.add(Integer.parseInt(id));
		}
		map.put("list", list);
		return procureTableMapper.selectBatchByPrimaryKey(map);
	}

	@Override
	public boolean deleteBatchByPrimaryKey(String[] primaryKeys) {
		Map<String,Object> map=new HashMap<>();
		List<Integer> list=new ArrayList<>();
		for(String id:primaryKeys){
			list.add(Integer.parseInt(id));
		}
		map.put("list", list);
		return procureTableMapper.deleteBatchByPrimaryKey(map);
	}

	@Override
	public String selectMaxIdentifier() {
		// TODO Auto-generated method stub
		return procureTableMapper.selectMaxIdentifier();
	}

	@Override
	public List<ProcureTable> selectIsHasGodownEntry(ProcureTable procureTable) {
		// TODO Auto-generated method stub
		return procureTableMapper.selectIsHasGodownEntry(procureTable);
	}

	@Override
	public boolean deleteByParentIdAndPlanOrOrder(ProcureTable procureTable) {
		// TODO Auto-generated method stub
		return procureTableMapper.deleteByParentIdAndPlanOrOrder(procureTable);
	}

	@Override
	public Integer selectExpirationCount() {
		// TODO Auto-generated method stub
		return procureTableMapper.selectExpirationCount();
	}

	@Override
	public List<ProcureTable> getPurchaseTableByState() {
		// TODO Auto-generated method stub
		return procureTableMapper.getPurchaseTableByState();
	}
	
	@Override
	public Integer updateByVerification(Integer id) {
		// TODO Auto-generated method stub
		return procureTableMapper.updateByVerification(id);
	}

	@Override
	public Integer getArrivalNum(Integer commodityId) {
		// TODO Auto-generated method stub
		return procureTableMapper.getArrivalNum(commodityId);
	}

	@Override
	public boolean updateStateByParentIds(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return procureTableMapper.updateStateByParentIds(map);
	}

	@Override
	public String selectMaxIdentifierToOtherReceipts() {
		// TODO Auto-generated method stub
		return procureTableMapper.selectMaxIdentifierToOtherReceipts();
	}

	@Override
	public List<ProcureTable> reportOtherReceiveOrder(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return procureTableMapper.reportOtherReceiveOrder(params);
	}

	@Override
	public String selectMaxIdentifierToPlanAndOrder() {
		// TODO Auto-generated method stub
		return procureTableMapper.selectMaxIdentifierToPlanAndOrder();
	}

	@Override
	public String selectMaxIdentifierToOpeningAndReturn() {
		// TODO Auto-generated method stub
		return procureTableMapper.selectMaxIdentifierToOpeningAndReturn();
	}

	@Override
	public List<ProcureTable> getSaleReturnDetailToReport(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return procureTableMapper.getSaleReturnDetailToReport(params);
	}

	@Override
	public List<ProcureTable> getSaleReturnAllMsgToReport(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return procureTableMapper.getSaleReturnAllMsgToReport(params);
	}

	/*@Override
	public boolean warehouseHalfApplyBilling(Integer parentId) {
		// TODO Auto-generated method stub
		return procureTableMapper.warehouseHalfApplyBilling(parentId);
	}*/
	public int delete(Integer id) {
		return procureTableMapper.delete(id);
	}

	@Override
	public List<ProcureTable> reportProcureReturnOrderDetail(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return procureTableMapper.reportProcureReturnOrderDetail(params);
	}
}
