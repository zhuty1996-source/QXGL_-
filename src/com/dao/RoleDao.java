package com.dao;

import com.domain.Role;

import java.util.List;
import java.util.Map;

public interface RoleDao {

    List<Role> findAllRoles(Map<String,Object> params);

    int total(Map<String,Object> params);

    List<Role> findUnlinkRolesByUser(int uno);

    List<Role> findLinkRolesByUser(int uno);

    void deleteRelationship(int uno);

    void addRelationship(int uno,int rno);
}
