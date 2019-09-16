package com.buba.boot1806a.service.impl;

import com.buba.boot1806a.dao.zTree02Mapper;
import com.buba.boot1806a.dao.zTreeMapper;
import com.buba.boot1806a.pojo.tbArea;
import com.buba.boot1806a.pojo.tbDept;
import com.buba.boot1806a.service.zTree02Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class zTree02ServiceImpl implements zTree02Service {

    @Autowired
    private zTree02Mapper zTree02Mapper;

    @Autowired
    private zTreeMapper zTreeMapper;

    /*机构信息__全查1*/
    @Override
    public List<tbArea> findAllArea() {
        return zTreeMapper.findAllArea();
    }

    /*机构信息__全查2*/
    @Override
    public List<tbDept> findAllDept(int id) {
        return zTreeMapper.findAllDept(id);
    }
}
