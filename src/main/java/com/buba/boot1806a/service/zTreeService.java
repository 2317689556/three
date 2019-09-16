package com.buba.boot1806a.service;

import com.buba.boot1806a.pojo.Items;
import com.buba.boot1806a.pojo.tbArea;
import com.buba.boot1806a.pojo.tbDept;
import com.buba.boot1806a.pojo.tbUser;
import com.github.pagehelper.PageInfo;

import java.util.List;

public interface zTreeService {


    /*根据省市县不同权限查询*/
    /*县的权限*/
    PageInfo<Items> findXianItems(Integer deptId, String startTime, String endTime, String itemsPageNum, String size);

    /*市的权限*/
    PageInfo<Items> findShiItems(String areaId, String startTime, String endTime, String itemsPageNum, String size);

    /*省的权限*/
    PageInfo<Items> findShengItems(String startTime, String endTime, String pageNum, String pageSize);



    /*省市县的echarts图*/
    /*县的echarts图*/
    List<Items> xianFiline(Integer deptId, String startTime, String endTime);

    /*市的echarts图*/
    List<Items> shiFiline(String areaId, String startTime, String endTime);

    /*省的echarts图*/
    List<Items> shengFiline(String startTime, String endTime);

    /*用户信息的树*/
    List<tbDept> findAllDept(int id);

    /*用户信息1*/
    List<tbUser> findParentUser(String id);

    /*用户信息2*/
    List<tbUser> findXianUser(String id);

    /*用户信息3*/
    List<tbArea> findAllArea();
}
