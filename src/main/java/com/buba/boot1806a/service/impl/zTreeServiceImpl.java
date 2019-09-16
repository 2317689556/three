package com.buba.boot1806a.service.impl;

import com.buba.boot1806a.dao.zTreeMapper;
import com.buba.boot1806a.pojo.Items;
import com.buba.boot1806a.pojo.tbArea;
import com.buba.boot1806a.pojo.tbDept;
import com.buba.boot1806a.pojo.tbUser;
import com.buba.boot1806a.service.zTreeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class zTreeServiceImpl implements zTreeService {

    @Autowired
    private zTreeMapper zTreeMapper;


    /*根据省市县不同权限查询*/
    /*县的权限*/
    public PageInfo<Items> findXianItems(Integer deptId, String startTime, String endTime, String itemsPageNum, String pageSize) {
        PageHelper.startPage(Integer.parseInt(itemsPageNum),Integer.parseInt(pageSize));
        List<Items> list = zTreeMapper.findXianItems(deptId,startTime,endTime);
        PageInfo<Items> p = new PageInfo<Items>(list);

        return p;
    }

    /*市的权限*/
    public PageInfo<Items> findShiItems(String areaId, String startTime, String endTime, String itemsPageNum, String pageSize) {
        PageHelper.startPage(Integer.parseInt(itemsPageNum),Integer.parseInt(pageSize));
        List<Items> list = zTreeMapper.findShiItems(areaId,startTime,endTime);
        PageInfo<Items> p = new PageInfo<Items>(list);

        return p;
    }

    /*省的权限*/
    public PageInfo<Items> findShengItems(String startTime, String endTime, String itemsPageNum, String pageSize) {

        PageHelper.startPage(Integer.parseInt(itemsPageNum),Integer.parseInt(pageSize));
        List<Items> list = zTreeMapper.findShengItems(startTime,endTime);
        PageInfo<Items> p = new PageInfo<Items>(list);

        return p;
    }


    @Override
    public List<Items> xianFiline(Integer deptId,String startTime,String endTime) {

        List<Items> list = zTreeMapper.findXianItems(deptId,startTime,endTime);

        return list;
    }

    @Override
    public List<Items> shiFiline(String areaId, String startTime, String endTime) {

        List<Items> list = zTreeMapper.findShiItems(areaId,startTime,endTime);

        return list;
    }

    @Override
    public List<Items> shengFiline(String startTime, String endTime) {

        List<Items> list = zTreeMapper.findShengItems(startTime,endTime);

        return list;
    }

    /*用户信息的树*/
    @Override
    public List<tbDept> findAllDept(int id) {
        return zTreeMapper.findAllDept(id);
    }

    /*用户信息1*/
    @Override
    public List<tbUser> findParentUser(String id) {
        return zTreeMapper.findParentUser(id);
    }

    /*用户信息2*/
    @Override
    public List<tbUser> findXianUser(String id) {
        return zTreeMapper.findXianUser(id);
    }

    @Override
    public List<tbArea> findAllArea() {
        return zTreeMapper.findAllArea();
    }


}
