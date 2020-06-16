package com.dao;

import com.domain.User;
import orm.annotation.Delete;
import orm.annotation.Insert;
import orm.annotation.Select;
import orm.annotation.Update;

import java.util.List;
import java.util.Map;

public interface UserDao {
    /**
     *
     * @param params {'uname':?,'upass':?}
     * @return
     */

    @Select("select * from t_user where uname = #{uname} and upass = #{upass}")
    public User findUserByNameAndPass(Map<String,String> params);

    @Select("select * from t_user")
    public List<User> findAllUsers();

    @Insert("insert into t_user values(null,#{uname},#{upass},#{truename},#{age},#{sex},#{phone},null,null)")
    public void userAdd(User user);

    @Delete("delete from t_user where uno = #{uno}")
    public void userDelete(Integer uno);

    @Select("select * from t_user where uno = #{uno}")
    public User userEdit(Integer uno);

    @Update("update t_user set uname = #{uname},truename = #{truename},age = #{age},sex = #{sex},phone = #{phone} where uno = #{uno}")
    public void userEditSave(User user);
}
