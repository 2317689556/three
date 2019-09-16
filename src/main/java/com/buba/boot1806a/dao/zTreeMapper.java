package com.buba.boot1806a.dao;

import com.buba.boot1806a.pojo.Items;
import com.buba.boot1806a.pojo.tbArea;
import com.buba.boot1806a.pojo.tbDept;
import com.buba.boot1806a.pojo.tbUser;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface zTreeMapper {


    /*根据省市县不同权限查询*/
    /*县的权限*/
    List<Items> findXianItems(@Param("deptId")Integer deptId, @Param("startTime")String startTime, @Param("endTime") String endTime);

    /*市的权限*/
    List<Items> findShiItems(@Param("areaId")String areaId, @Param("startTime")String startTime, @Param("endTime")String endTime);

    /*省的权限*/
    List<Items> findShengItems( @Param("startTime")String startTime, @Param("endTime")String endTime);

    /*用户信息的树*/
    List<tbDept> findAllDept(int id);

    /*用户信息1*/
    List<tbUser> findParentUser(String id);

    /*用户信息2*/
    List<tbUser> findXianUser(String id);

    /*用户信息3*/
    List<tbArea> findAllArea();
}
