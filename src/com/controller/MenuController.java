package com.controller;

import com.domain.Menu;
import com.service.MenuService;
import com.service.impl.MenuServiceImpl;
import mymvc.ModelAndView;
import mymvc.Param;
import mymvc.RequestMapping;
import mymvc.ResponseBody;

import java.util.List;

public class MenuController {

    private MenuService service = new MenuServiceImpl();

    @RequestMapping("menuList.do")
    @ResponseBody
    public List<Menu> findAllMenus(){
        List<Menu> menuList = service.findAllMenus();
        return menuList;
    }

    @RequestMapping("saveMenu.do")
    @ResponseBody
    public int saveMenu(Menu menu){
        return service.saveMenu(menu);
    }

    @RequestMapping("menuOne.do")
    @ResponseBody
    public Menu findMenuById(@Param("mno")int mno){
        return service.findMenuById(mno);
    }

    @RequestMapping("menuUpdate.do")
    @ResponseBody
    public void updateMenu(Menu menu){
        service.updateMenu(menu);
    }
    @RequestMapping("menuDelete.do")
    public void deleteMenu(@Param("mno") int mno){
        service.deleteMenu(mno);
    }
}
