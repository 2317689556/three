package com.buba.boot1806a.controller;

import com.buba.boot1806a.pojo.*;
import com.buba.boot1806a.service.zTreeService;
import com.buba.boot1806a.utils.TemplateExcelUtil;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("zTree")
public class zTreeController {

    @Autowired
    private zTreeService zTreeService;


    /*根据省市县不同权限查询*/
    @RequestMapping("/findItems")
    public String findXianItems(HttpSession session,String startTime,String endTime,String pageNum,String pageSize,Model m) {
        Date d = new Date();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy");
        String year = dateFormat.format(d);
        if(startTime==null) {
            startTime = year+ "-01-01";
        }
        if(endTime==null) {
            endTime = year+ "-12-31";
        }
        //从session域中获取user的地区编号
        tbUser user= (tbUser) session.getAttribute("USER_SESSION");

        //如果传入的参数 为空 则默认 页面为第一页
        if(pageNum == null) {
            pageNum = "1";
        }

        //如果传入的参数不为空 则将参数赋值给size
        if(pageSize == null) {
            pageSize = "3";
        }
        PageInfo<Items> p = new PageInfo<Items>();
        /*县的权限*/
        if(user.getLevel().equals("0")) {
            p = zTreeService.findXianItems(user.getDeptId(),startTime,endTime,pageNum,pageSize);
            //将页面需要的信息放入session域中 和 model 中
            m.addAttribute("startTime", startTime);
            m.addAttribute("endTime", endTime);
            m.addAttribute("pageSize", pageSize);
            m.addAttribute("auditItems", p);


            return "manager/usermanagerInfo6";
        }

        /*市的权限*/
        if(user.getLevel().equals("1")) {
            p = zTreeService.findShiItems(user.getAreaId(),startTime,endTime,pageNum,pageSize);
            //将页面需要的信息放入session域中 和 model 中
            m.addAttribute("startTime", startTime);
            m.addAttribute("endTime", endTime);
            m.addAttribute("pageSize", pageSize);
            m.addAttribute("auditItems", p);

            return "manager/usermanagerInfo7";
        }

        /*省的权限*/
        if(user.getLevel().equals("2")||user.getLevel().equals("4")) {
            p = zTreeService.findShengItems(startTime,endTime,pageNum,pageSize);
            //将页面需要的信息放入session域中 和 model 中
            m.addAttribute("startTime", startTime);
            m.addAttribute("endTime", endTime);
            m.addAttribute("pageSize", pageSize);
            m.addAttribute("auditItems", p);

            return "manager/usermanagerInfo7";
        }
        return "error";
    }


    /*省市县的echarts图*/
    @ResponseBody
    @RequestMapping("/Filine")
    public List<Items> xianFiline(HttpSession session, String startTime, String endTime){
        //从session域中得到登录的用户数据

        tbUser user= (tbUser) session.getAttribute("USER_SESSION");

        Date d = new Date();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy");
        String year = dateFormat.format(d);
        if(startTime==null) {
            startTime = year+ "-01-01";
        }
        if(endTime==null) {
            endTime = year+ "-12-31";
        }


        List<Items> list = new ArrayList<Items>();

        if(user.getLevel().equals("0")) {
            /*县的echarts图*/
            list = zTreeService.xianFiline(user.getDeptId(),startTime,endTime);
        }
        else if(user.getLevel().equals("1")) {
            /*市的echarts图*/
            list = zTreeService.shiFiline(user.getAreaId(),startTime,endTime);
        }

        else if(user.getLevel().equals("2")||user.getLevel().equals("4")) {
            /*省的echarts图*/
            list = zTreeService.shengFiline(startTime,endTime);
        }

        return list;
    }

    @RequestMapping("/excelOutData")
    @ResponseBody
    public boolean excelOutData(String startTime,String endTime,HttpSession session) {
        //从session域中得到登录的用户数据

        tbUser user= (tbUser) session.getAttribute("USER_SESSION");
        //查询不同时间段的数据
        Date d = new Date();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy");
        String year = dateFormat.format(d);
        if(startTime==null) {
            startTime = year+ "-01-01";
        }
        if(endTime==null) {
            endTime = year+ "-12-31";
        }

        List<Items> list = new ArrayList<Items>();
        //根据用户的权限查询不同的信息
        if(user.getLevel().equals("0")) {
            list = zTreeService.xianFiline(user.getDeptId(),startTime,endTime);
        }
        else if(user.getLevel().equals("1")) {
            list = zTreeService.shiFiline(user.getAreaId(),startTime,endTime);
        }

        else if(user.getLevel().equals("2")||user.getLevel().equals("4")) {
            list = zTreeService.shengFiline(startTime,endTime);
        }
        //格式化时间
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        //模板
        String temp = "F:\\Poi\\jiuhui.xlsx";
        //导出位置
        String target = "F:\\Poi\\"+user.getUsername()+"_"+simpleDateFormat.format(new Date())+".xlsx";

        String[] params = {startTime,endTime,user.getUsername(),simpleDateFormat.format(new Date())};
        //根据模板的列名给出顺序
        List<String> headersId = new ArrayList<String>();
        headersId.add("deptName");
        headersId.add("createtime");
        headersId.add("deptId");
        headersId.add("numActivities");
        headersId.add("numActual");
        headersId.add("zhixinglv");
        headersId.add("newClient");
        headersId.add("oldClient");
        headersId.add("yxClient");
        headersId.add("money");
        TemplateExcelUtil<Items> exportBeanExcel = new TemplateExcelUtil<Items>();

        boolean exportExcel = exportBeanExcel.exportExcel(temp, target, params, headersId, list);

        return exportExcel;
    }


    /*用户信息的树*/
    @RequestMapping("findAllDept")
    @ResponseBody
    public List<Node> findAllDept(String id){

        List<Node> data = new ArrayList<Node>();

        List<tbDept> deptData = zTreeService.findAllDept(Integer.parseInt(id));

        for (tbDept d : deptData) {

            data.add(new Node(d.getId(),Integer.parseInt(id),d.getDeptName(),false,false));
        }
        return data;
    }

    /*用户信息*/
    @RequestMapping("findUserInfo")
    @ResponseBody
    public List<tbUser> findUserInfo(String id,String isParent){
        List<tbUser> user = null;
        if(isParent.equals("true")) {
            user = zTreeService.findParentUser(id);
        }else {
            user= zTreeService.findXianUser(id);
        }
        return user;
    }

    /*用户信息*/
    @RequestMapping("findAllUser")
    @ResponseBody
    public List<Node> findAllUser(){

        List<tbArea> areaData = zTreeService.findAllArea();

        List<Node> data = new ArrayList<Node>();
        for (tbArea s : areaData) {
            data.add(new Node(s.getId(),Integer.parseInt(s.getParentId()),s.getAreaName(),false,true));

        }

        return data;
    }

}
