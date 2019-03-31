package com.jl.psi.mapper;

import java.util.List;

import com.jl.psi.model.Activity;

public interface ActivityMapper  extends BaseMapper<Activity> {

	List<Activity> selectAll();
	Activity  selectByActivityId(Integer activityId);
	Integer updateGenerated(Integer id);
}
