package com.service.impl;

import com.dao.UserDao;
import com.domain.User;
import com.service.UserService;
import orm.SqlSession;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class UserServiceImpl implements UserService {

    private UserServiceImpl(){}
    private static UserServiceImpl service = new UserServiceImpl();
    public static UserServiceImpl getInstance(){
        return service;
    }

    private UserDao dao = new SqlSession().getMapper(UserDao.class);

    @Override
    public User checkUser(String uname, String upass) {
        Map<String,String> keyMap = new HashMap<>();
        keyMap.put("uname",uname);
        keyMap.put("upass",upass);
        return dao.findUserByNameAndPass(keyMap);
    }

    @Override
    public List<User> findAllUsers() {
        return dao.findAllUsers();
    }

    @Override
    public void userAdd(User user) {
        dao.userAdd(user);
    }

    @Override
    public void userDelete(Integer uno) {
        dao.userDelete(uno);
    }

    @Override
    public User userEdit(Integer uno) {
        return dao.userEdit(uno);
    }

    @Override
    public void userEditSave(User user) {
        dao.userEditSave(user);
    }

    @Override
    public void userDeletes(String unos) {
        String[] unoArray = unos.split(",");
        for (int i = 0;i<unoArray.length;i++){
            Integer uno = Integer.parseInt(unoArray[i]);
            dao.userDelete(uno);
        }
    }
}
