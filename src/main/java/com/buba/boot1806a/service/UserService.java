package com.buba.boot1806a.service;

import com.buba.boot1806a.pojo.*;

public interface UserService {

    /*登录*/
    tbUser login(String username);

    /*修改密码*/
    int upPwd(Integer id, String passWord);

    /*用户管理__删除*/
    int delUser(Integer id);

    /*用户管理__增加*/
    int addUser(tbUser user);

    /*用户管理__修改*/
    int updateUser(tbUser user);

    /*用户管理__单查*/
    tbUser findUserById(String id);

}
