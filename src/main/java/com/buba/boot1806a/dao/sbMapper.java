package com.buba.boot1806a.dao;

import com.buba.boot1806a.pojo.Plan;
import com.buba.boot1806a.pojo.tbDept;

import java.util.List;

public interface sbMapper {


    /*预报数据的提交*/
    int addPlan(Plan p);

    /*根据id单查*/
    tbDept findDeptById(Integer deptId);

    /*分页展示上报数据*/
    List<Plan> findPlan(Integer deptId);

    /*市级用户__审核数据*/
    List<Plan> findPlanOnAudit(String areaId);
}
