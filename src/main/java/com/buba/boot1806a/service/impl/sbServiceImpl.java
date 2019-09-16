package com.buba.boot1806a.service.impl;

import com.buba.boot1806a.dao.sbMapper;
import com.buba.boot1806a.pojo.Plan;
import com.buba.boot1806a.pojo.tbDept;
import com.buba.boot1806a.service.sbService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class sbServiceImpl implements sbService {

    @Autowired
    private sbMapper sbMapper;

    /*预报数据的提交*/
    @Override
    public int addPlan(Plan p) {
        /*获取id*/
        tbDept findDeptById = sbMapper.findDeptById(p.getDeptId());

        p.setDeptName(findDeptById.getDeptName());

        int i = sbMapper.addPlan(p);

        return i;
    }

    /*分页展示上报数据*/
    @Override
    public PageInfo<Plan> findPlan(Integer deptId,String pageNum, String pageSize) {

        PageHelper.startPage(Integer.parseInt(pageNum),Integer.parseInt(pageSize));

        List<Plan> plans = sbMapper.findPlan(deptId);

        PageInfo<Plan> p = new PageInfo<Plan>(plans);

        return p;
    }


    /*市级用户__审核数据*/
    @Override
    public PageInfo<Plan> findPlanOnAudit(String areaId, String pageNum, String size) {
        PageHelper.startPage(Integer.parseInt(pageNum),Integer.parseInt(size));

        List<Plan> plans = sbMapper.findPlanOnAudit(areaId);

        PageInfo<Plan> p = new PageInfo<Plan>(plans);

        return p;
    }
}
