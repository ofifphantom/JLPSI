package com.jl.psi.mapper;

import com.jl.psi.model.AllotOrderCommodity;

public interface AllotOrderCommodityMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(AllotOrderCommodity record);

    int insertSelective(AllotOrderCommodity record);

    AllotOrderCommodity selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(AllotOrderCommodity record);

    int updateByPrimaryKey(AllotOrderCommodity record);
}