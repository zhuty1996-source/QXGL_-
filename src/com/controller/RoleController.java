package com.controller;

import com.domain.Role;
import com.service.RoleService;
import com.service.impl.RoleServiceImpl;
import mymvc.ModelAndView;
import mymvc.Param;
import mymvc.RequestMapping;
import mymvc.ResponseBody;

import java.util.List;

public class RoleController {

    private RoleService service = new RoleServiceImpl();

    //分析参数 需要分页的页数page 需要每页显示的记录数 rows
    // 还需要每条记录的信息 rno rname description
    @RequestMapping("showRole.do")
    public ModelAndView showRole(@Param("page") Integer page,@Param("rows") Integer rows,@Param("rno")Integer rno,@Param("rname")String rname,@Param("description")String description){
        if (page == null){
            page = 1;
        }
        if (rows == null){
            rows = 3;
        }

        List<Role> roleList = service.findAllRoles(page,rows,rno,rname,description);
        //需要计算总记录数total
        int total = service.total(rno,rname,description);
        int maxPage = total%rows == 0 ? total/rows : (total/rows+1);

        ModelAndView mv = new ModelAndView();
        mv.setViewName("showRole.jsp");
        mv.addAttribute("page",page);
        mv.addAttribute("rows",rows);
        mv.addAttribute("maxPage",maxPage);
        mv.addAttribute("roleList",roleList);
        mv.addAttribute("rno",rno);
        mv.addAttribute("rname",rname);
        mv.addAttribute("description",description);

        return mv;
    }

    @RequestMapping("noList.do")
    @ResponseBody
    public List<Role> findUnlinkRolesByUser(@Param("uno") int uno){
        List<Role> roles = service.findUnlinkRolesByUser(uno);
        return roles;
    }

    @RequestMapping("yesList.do")
    @ResponseBody
    public List<Role> findLinkRolesByUser(@Param("uno") int uno){
        return service.findLinkRolesByUser(uno);
    }

    @RequestMapping("saveRoles.do")
    @ResponseBody
    public void saveRoles(@Param("uno")int uno,@Param("rnos")String rnos){
        service.saveRoles(uno,rnos);
    }
}
