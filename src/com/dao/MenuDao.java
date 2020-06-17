package com.dao;

import com.domain.Menu;
import orm.annotation.Delete;
import orm.annotation.Insert;
import orm.annotation.Select;
import orm.annotation.Update;

import java.util.List;
import java.util.Map;

public interface MenuDao {

    @Select("select * from t_menu")
    List<Menu> findAllMenus();

    @Insert("insert into t_menu values(null,#{mname},#{mhref},#{mtarget},#{pno},#{yl1},#{yl2})")
    void saveMenu(Menu menu);

    @Select("select mno from t_menu where mname = #{mname}")
    int findIdByMname(String mname);

    @Select("select * from t_menu where mno = #{mno}")
    Menu findMenuById(int mno);

    @Update("update t_menu set mname = #{mname},mhref = #{mhref},mtarget = #{mtarget} where mno = #{mno}")
    void updateMenu(Menu menu);

    @Delete("delete from t_menu where mno = #{mno}")
    void deleteMenu(int mno);

    @Delete("delete from t_role_menu where rno = #{rno}")
    void deleteRelationship(int rno);

    @Insert("insert into t_role_menu values(#{rno},#{mno})")
    void addRelationship(Map<String,Integer> params);

    @Select("select mno from t_role_menu where rno = #{rno}")
    List<Integer> findMenuNosByRole(int rno);
}
