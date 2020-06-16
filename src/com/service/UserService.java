package com.service;

import com.domain.User;

import java.util.List;

public interface UserService {
    /**
     *
     * @param uname = '?'
     * @param upass = '?'
     * @return
     */
    public User checkUser(String uname,String upass);

    public List<User> findAllUsers();

    public void userAdd(User user);

    public void userDelete(Integer uno);

    public User userEdit(Integer uno);

    public void userEditSave(User user);

    public void userDeletes(String unos);

}
