package com.buba.boot1806a.controller;

import com.buba.boot1806a.pojo.Node;
import com.buba.boot1806a.pojo.tbArea;
import com.buba.boot1806a.pojo.tbDept;
import com.buba.boot1806a.service.zTree02Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.List;

@Controller
public class zTree02Controller {

    @Autowired
    private zTree02Service zTree02Service;

    /*机构信息__全查1*/
    @RequestMapping("findAllUser")
    @ResponseBody
    public List<Node> findAllUser(){

        List<tbArea> areaData = zTree02Service.findAllArea();

        List<Node> data = new ArrayList<Node>();
        for (tbArea s : areaData) {
            data.add(new Node(s.getId(),Integer.parseInt(s.getParentId()),s.getAreaName(),false,true));

        }

        return data;
    }


    /*机构信息__全查2*/
    @RequestMapping("findAllDept")
    @ResponseBody
    public List<Node> findAllDept(String id){

        List<Node> data = new ArrayList<Node>();

        List<tbDept> deptData = zTree02Service.findAllDept(Integer.parseInt(id));

        for (tbDept d : deptData) {

            data.add(new Node(d.getId(),Integer.parseInt(id),d.getDeptName(),false,false));

        }

        return data;
    }


}
