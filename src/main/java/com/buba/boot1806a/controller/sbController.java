package com.buba.boot1806a.controller;

import com.buba.boot1806a.pojo.Plan;
import com.buba.boot1806a.pojo.tbUser;
import com.buba.boot1806a.service.sbService;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("sb")
public class sbController {

    @Autowired
    private sbService sbService;

    /*预报数据的提交*/
    @RequestMapping("addPlan")
    @ResponseBody
    public boolean addPlan(HttpSession session, Plan p){
        tbUser user= (tbUser) session.getAttribute("USER_SESSION");

        /*把user的值赋给dept*/
        p.setDeptId(user.getDeptId());
        p.setAreaId(user.getAreaId());
        p.getAreaCode(user.getAreaCode());
        p.setAvailable("1");
        p.setType("xian");

        int i =sbService.addPlan(p);
        return i>0;
    }


    /*分页展示上报数据*/
    private String defaultPageSize = "3";

    @RequestMapping("/findPlan")
    public String findPlan(HttpSession session,String pageNum,String pageSize,Model m) {
        //如果传入的参数 为空 则默认 页面为第一页
        if (pageNum == null) {
            pageNum = "1";
        }
        //如果传入的参数不为空 则将参数赋值给size
        if (pageSize != null) {
            defaultPageSize = pageSize;
        }

        //从session域中获取user的地区编号
        tbUser user = (tbUser) session.getAttribute("USER_SESSION");

        //使用分页插件进行分页
        PageInfo<Plan> p = sbService.findPlan(user.getDeptId(), pageNum, defaultPageSize);

        //将页面需要的信息放入session域中 和 model 中
        session.setAttribute("pageSize", defaultPageSize);
        session.setAttribute("PageInfo", p);
        m.addAttribute("p", p);

        return "manager/usermanagerInfo2";
    }



    /*市级用户__审核数据*/

    private String AuditPageNum = "1";
    private String AuditPageSize = "3";

    @RequestMapping("/findPlanOnAudit")
    public String findPlanOnAudit(HttpSession session,String pageNum,String pageSize,Model m) {
        //如果传入的参数 为空 则默认 页面为第一页
        if(pageNum != null) {
            AuditPageNum = pageNum;
        }
        //如果传入的参数不为空 则将参数赋值给size
        if(pageSize != null) {
            AuditPageSize = pageSize;
        }

        //从session域中获取user的地区编号
        tbUser user= (tbUser) session.getAttribute("USER_SESSION");

        //使用分页插件进行分页
        PageInfo<Plan> p = sbService.findPlanOnAudit(user.getAreaId() ,AuditPageNum, AuditPageSize);

        //将页面需要的信息放入session域中 和 model 中
        session.setAttribute("pageSize", AuditPageSize);
        m.addAttribute("auditPlan", p);

        return "manager/usermanagerInfo5";
    }




}
