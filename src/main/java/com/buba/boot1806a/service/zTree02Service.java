package com.buba.boot1806a.service;

import com.buba.boot1806a.pojo.tbArea;
import com.buba.boot1806a.pojo.tbDept;

import java.util.List;

public interface zTree02Service {

    /*机构信息__全查1*/
    List<tbArea> findAllArea();

    /*机构信息__全查2*/
    List<tbDept> findAllDept(int id);
}
