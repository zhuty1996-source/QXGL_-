package com.dao.impl;

import com.dao.RoleDao;
import com.domain.Role;
import orm.SqlSession;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class RoleDaoImpl implements RoleDao {

    @Override
    public List<Role> findAllRoles(Map<String, Object> params) {

        //编写动态sql语句
        SqlSession session = new SqlSession();
        StringBuilder sql = new StringBuilder();
        sql.append("select * from t_role where 1=1");

        Integer rno = (Integer) params.get("rno");
        if (rno!=null){
            sql.append(" and rno = #{rno}");
        }

        String rname = (String) params.get("rname");
        if (rname!=null && !"".equals(rname)){
            sql.append(" and rname like concat('%',concat(#{rname},'%'))");
        }

        String description = (String) params.get("description");
        if (description!=null && !"".equals(description)){
            sql.append(" and description like concat(#{description},'%') ");
        }
        sql.append(" limit #{start},#{length}");
        System.out.println(sql);
        return session.selectList(sql.toString(),params,Role.class);
    }

    @Override
    public int total(Map<String, Object> params) {

        //编写动态sql语句
        SqlSession session = new SqlSession();
        StringBuilder sql = new StringBuilder();
        sql.append("select count(*) from t_role where 1=1");

        Integer rno = (Integer) params.get("rno");
        if (rno!=null){
            sql.append(" and rno = #{rno}");
        }

        String rname = (String) params.get("rname");
        if (rname!=null && !"".equals(rname)){
            sql.append(" and rname like concat('%',concat(#{rname},'%'))");
        }

        String description = (String) params.get("description");
        if (description!=null && !"".equals(description)){
            sql.append(" and description like concat(#{description},'%') ");
        }
        System.out.println(sql);

        return session.selectOne(sql.toString(),params,int.class);
    }

    @Override
    public List<Role> findUnlinkRolesByUser(int uno) {
        SqlSession session = new SqlSession();
        //select rno from t_user_role where uno = #{uno}
        String sql = "select * from t_role where rno not in (select rno from t_user_role where uno = #{uno})";
        return session.selectList(sql,uno,Role.class);
    }

    @Override
    public List<Role> findLinkRolesByUser(int uno) {
        SqlSession session = new SqlSession();
        String sql = "select * from t_role where rno in (select rno from t_user_role where uno = #{uno})";
        return session.selectList(sql,uno,Role.class);
    }

    @Override
    public void deleteRelationship(int uno) {
        SqlSession session = new SqlSession();
        String sql = "delete from t_user_role where uno = #{uno}";
        session.delete(sql,uno);
    }

    @Override
    public void addRelationship(int uno, int rno) {
        SqlSession session = new SqlSession();
        String sql = "insert into t_user_role (uno,rno) values(#{uno},#{rno}) ";
        Map<String,Integer> params = new HashMap<>();
        params.put("uno",uno);
        params.put("rno",rno);
        session.insert(sql,params);
    }
}
