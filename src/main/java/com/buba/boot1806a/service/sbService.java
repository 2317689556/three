package com.buba.boot1806a.service;

import com.buba.boot1806a.pojo.Plan;
import com.github.pagehelper.PageInfo;

public interface sbService {
    /*预报数据的提交*/
    int addPlan(Plan p);

    /*分页展示上报数据*/
    PageInfo<Plan> findPlan(Integer deptId, String pageNum, String defaultPageSize);

    /*市级用户__审核数据*/
    PageInfo<Plan> findPlanOnAudit(String areaId, String auditPageNum, String auditPageSize);
}
