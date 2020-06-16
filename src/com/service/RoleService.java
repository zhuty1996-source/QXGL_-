package com.service;

import com.domain.Role;

import java.util.List;

public interface RoleService {

    List<Role> findAllRoles(int page,int rows,Integer rno,String rname,String description);

    int total(Integer rno,String rname,String description);

    List<Role> findUnlinkRolesByUser(int uno);

    List<Role> findLinkRolesByUser(int uno);

    void saveRoles(int uno,String rnos);
}
