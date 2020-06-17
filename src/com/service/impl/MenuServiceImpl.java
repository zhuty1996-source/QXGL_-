package com.service.impl;

import com.dao.MenuDao;
import com.domain.Menu;
import com.service.MenuService;
import orm.SqlSession;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class MenuServiceImpl implements MenuService {

    private MenuDao dao = new SqlSession().getMapper(MenuDao.class);

    @Override
    public List<Menu> findAllMenus() {
        return dao.findAllMenus();
    }

    @Override
    public int saveMenu(Menu menu) {
        dao.saveMenu(menu);
        return dao.findIdByMname(menu.getMname());
    }

    @Override
    public Menu findMenuById(int mno) {
        return dao.findMenuById(mno);
    }

    @Override
    public void updateMenu(Menu menu) {
        dao.updateMenu(menu);
    }

    @Override
    public void deleteMenu(int mno) {
        List<Menu> menus = dao.findAllMenus();
        this.removeMenu(mno,menus);
    }

    @Override
    public void setMenus(int rno, String mnos) {
        //业务层先清空之前选中的菜单关系
        dao.deleteRelationship(rno);
        //再新增新的关系
        String[] mnoArray = mnos.split(",");
        for (String mno : mnoArray){
            Map<String,Integer> params = new HashMap<>();
            params.put("rno",rno);
            params.put("mno",Integer.parseInt(mno));
            dao.addRelationship(params);
        }
    }

    @Override
    public List<Integer> findMenuNosByRole(int rno) {
        return dao.findMenuNosByRole(rno);
    }


    private void removeMenu(int mno,List<Menu> menus){
        for (int i = 0;i < menus.size();i++){
            Menu menu = menus.get(i);
            if (menu.getPno() == mno){
                removeMenu(menu.getMno(),menus);
            }
        }
        dao.deleteMenu(mno);
    }

}
