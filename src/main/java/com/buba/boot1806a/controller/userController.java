package com.buba.boot1806a.controller;


import com.buba.boot1806a.pojo.*;
import com.buba.boot1806a.service.UserService;
import com.buba.boot1806a.utils.MD5Utils;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("user")
public class userController {

    @Value("${User.path}")
    private String path;

    @Autowired
    private UserService userService;


    /*用户登录*/
    @ResponseBody
    @RequestMapping("login")
    public Map<String,String> login(HttpServletRequest request, @Param("username")String username, @Param("userpwd") String userpwd) {

        //调用服务层的方法进行查询用户是否存在
        tbUser user = userService.login(username);

        //创建一个map集合
        Map<String,String> map = new HashMap<String,String>();

        //如果返回的user是空，不存在该用户
        if(user==null) {

            map.put("message", "用户不存在");

            return map;
        }
        //登录成功  则放入session域中  反之登录失败 密码不正确
        if(user.getPassword() .equals(userpwd)) {

            // 放入session
            request.getSession().setAttribute("USER_SESSION", user);

            map.put("flag", "true");

            return map;
        }else {
            map.put("message", "密码不正确");

            return map;

        }
    }


    /*退出*/
    @RequestMapping("logout")
    public String logout(HttpSession session) {

        //根据键删除session中的值
        session.removeAttribute("USER_SESSION");

        session.invalidate();

        return "redirect:/jsps/login.jsp";
    }


    /*手机号验证*/
    @RequestMapping("/telyanzheng")
    @ResponseBody
    public boolean phoneText(HttpSession session , tbUser su){

        int code = (int) ((Math.random()*9+1)*1000);

        String pCode =  String.valueOf(code);
        System.out.println(pCode);
        session.setAttribute("phoneCode",pCode);

        //boolean sendMSM = SendSMSUtils.sendMSM(su.getTel(),String.valueOf(code) );

        return true;
    }


    /*检验手机号*/
    @RequestMapping("/yanzheng")
    @ResponseBody
    public boolean yanzheng(HttpSession session , tbUser su){

        String phoneCode= (String) session.getAttribute("phoneCode");

        if(phoneCode.equals(su.getPhoneText())) {
            return true;
        }else {
            return false;
        }
    }


    /*修改密码__验证*/
    @RequestMapping("pwdmodify")
    @ResponseBody
    public boolean pwdmodify(HttpSession session,String oldpassword){

        tbUser user= (tbUser) session.getAttribute("USER_SESSION");

        if(user.getPassword().equals(oldpassword)) {
            return true;
        }else {
            return false;
        }
    }


    /*修改密码*/
    @RequestMapping("upPwd")
    @ResponseBody
    public boolean upPwd(HttpSession session,String passWord){

        tbUser user= (tbUser) session.getAttribute("USER_SESSION");

        int i = userService.upPwd(user.getId(),passWord);

        if(i>0) {
            return true;
        }else {
            return false;
        }
    }


    /*用户信息__删除*/
    @RequestMapping("delUser")
    public boolean delUser(Integer id){
        int i = userService.delUser(id);
        return i>0;
    }

    /*用户管理__增加*/
    @RequestMapping("addUser")
    @ResponseBody
    public boolean addUser(tbUser user){
        String md5 = MD5Utils.md5(user.getPassword());
        user.setPassword(md5);
        int i = userService.addUser(user);
        return i>0;
    }


    /*用户管理__修改*/
    @RequestMapping("updateUser")
    @ResponseBody
    public boolean updateUser(tbUser user){
        String md5 = MD5Utils.md5(user.getPassword());
        user.setPassword(md5);
        int i = userService.updateUser(user);
        return i>0;
    }

    /*用户管理__单查*/
    @RequestMapping("findUserById")
    @ResponseBody
    public tbUser findUserById(String id){

        tbUser user = userService.findUserById(id);

        return user;
    }

}