package com.buba.boot1806a.service.impl;


import com.buba.boot1806a.dao.userMapper;
import com.buba.boot1806a.pojo.*;
import com.buba.boot1806a.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService{

    @Autowired
    private userMapper userMapper;


    /*登录*/
    @Override
    public tbUser login(String username) {
        return userMapper.login(username);
    }

    @Override
    public int upPwd(Integer id, String passWord) {
        return  userMapper.upPwd(id,passWord);
    }

    /*用户管理__删除*/
    @Override
    public int delUser(Integer id) {
        return userMapper.delUser(id);
    }

    /*用户管理__增加*/
    @Override
    public int addUser(tbUser user) {
        return userMapper.addUser(user);
    }

    /*用户管理__修改*/
    @Override
    public int updateUser(tbUser user) {
        return userMapper.updateUser(user);
    }


    /*用户管理__单查*/
    @Override
    public tbUser findUserById(String id) {
        return userMapper.findUserById(id);
    }


}
