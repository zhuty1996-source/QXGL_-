package com.service;

import com.domain.Menu;

import java.util.List;

public interface MenuService {

    List<Menu> findAllMenus();

    int saveMenu(Menu menu);

    Menu findMenuById(int mno);

    void updateMenu(Menu menu);

    void deleteMenu(int mno);

}
