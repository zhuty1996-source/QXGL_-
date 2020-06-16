package com.controller;

import com.domain.User;
import com.service.UserService;
import com.service.impl.UserServiceImpl;
import mymvc.*;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.poi.ss.usermodel.*;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

@SessionAttributes("loginUser")//利用session将user对象存入参数中
public class UserController {


    private UserService service = UserServiceImpl.getInstance();

    @RequestMapping("login.do")//web.xml文件会找到这个mapping执行这个类
    public ModelAndView login(@Param("uname") String uname, @Param("upass") String upass){
        User user = service.checkUser(uname,upass);
        if (user == null){//登录失败
            //转发回一开始的界面 同时传递一个失败参数
            ModelAndView mv = new ModelAndView();
            mv.setViewName("index.jsp");
            mv.addAttribute("flag","9");
            return mv;
        }else{//登录成功
            //跳转到main.jsp界面,访问主界面。将登录成功的信息装入session
            ModelAndView mv = new ModelAndView();
            mv.setViewName("main.jsp");
            mv.addAttribute("loginUser",user);
            return mv;
        }
    }
    @RequestMapping("showUser.do")
    public ModelAndView showUsers(){
        ArrayList<User> userList = (ArrayList<User>) service.findAllUsers();
        ModelAndView mv = new ModelAndView();
        mv.setViewName("showUser.jsp");
        mv.addAttribute("userList",userList);
        return mv;
    }
    @RequestMapping("userAdd.do")
    @ResponseBody
    public String userAdd(User user){
        service.userAdd(user);
        return "保存成功";
    }

    @RequestMapping("userDelete.do")
    @ResponseBody
    public String userDelete(@Param("uno") Integer uno){
        service.userDelete(uno);
        return "删除成功";
    }

    @RequestMapping("userEdit.do")
    public ModelAndView userEdit(@Param("uno") Integer uno){
        User user = service.userEdit(uno);
        ModelAndView mv = new ModelAndView();
        mv.setViewName("userEdit.jsp");
        mv.addAttribute("user",user);
        return mv;
    }

    @RequestMapping("userEditSave.do")
    @ResponseBody
    public String userEditSave(@Param("uno")Integer uno,@Param("uname")String uname,@Param("truename")String truename,@Param("age")Integer age,@Param("sex")String sex,@Param("phone")String phone){
        User user = new User(uno,uname,null,truename,age,sex,phone,null,null);
        service.userEditSave(user);
        return "保存成功";
    }

    @RequestMapping("userDeletes.do")
    public String userDeletes(@Param("unos") String unos){
        service.userDeletes(unos);
        return "showUser.do";
    }

    @RequestMapping("userImport.do")
    public String userImport(HttpServletRequest request){
        try {
            DiskFileItemFactory factory = new DiskFileItemFactory();
            ServletFileUpload upload = new ServletFileUpload(factory);
            List<FileItem> fis = upload.parseRequest(request);

            FileItem fi = fis.get(0);//此次业务只传递了一个文件参数
            InputStream is = fi.getInputStream();//获取文件输入流对象

            //通过输入流读取excel文件内容 需要poi

            Workbook book = WorkbookFactory.create(is);//jvm版excel文件
            Sheet sheet = book.getSheetAt(0);//数据表
            for (int i=1;i<=sheet.getLastRowNum();i++){
                Row row = sheet.getRow(i);
                if (row==null)continue;

                Cell c1 = row.getCell(0);
                Cell c2 = row.getCell(1);
                Cell c3 = row.getCell(2);
                Cell c4 = row.getCell(3);
                Cell c5 = row.getCell(4);
                Cell c6 = row.getCell(5);
                Cell c7 = row.getCell(6);
                Cell c8 = row.getCell(7);

                String uname = c1.getStringCellValue();
                String upass = (int)c2.getNumericCellValue()+"";//123.0-->"123"
                String truename = c3.getStringCellValue();
                Integer age = (int)c4.getNumericCellValue();
                String sex = c5.getStringCellValue();
                String phone = (int)c6.getNumericCellValue()+"";
                String yl1 = null;
                String yl2 = null;
                if (c7!=null){
                    yl1 = c7.getStringCellValue();
                }
                if (c8!=null){
                    yl2 = c8.getStringCellValue();
                }

                User user = new User(null,uname,upass,truename,age,sex,phone,yl1,yl2);
                service.userAdd(user);
            }
        } catch (FileUploadException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return "showUser.do";
    }
}
