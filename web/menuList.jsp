<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <style type="text/css">

        ul li{
            list-style: none;
        }
        li{
            cursor: pointer;
            margin-top: 4px;
            margin-left: 4px;
        }
        #mname,#mhref,#mtarget,#pno {
            width: 100px;
            margin-right: 10px;
        }
        #active{
            background-color: #008c8c;
        }
    </style>
    <script src="js/jquery.js"></script>

    <script type="text/javascript">
        $(function () {
           //ajax请求所有的菜单信息
           $.post(
               'menuList.do',//url
               {uname:'dmc',upass:'123'},//参数
               function (data) {//回调函数
                   //在指定的位置显示某一层级的子菜单
                   function showLevelMenu(pno,$position) {
                       var ul = $('<ul>');
                       $position.append(ul);
                       for (var i=0;i<data.length;i++){
                           var menu = data[i];
                           if (menu.pno == pno){
                               var li = $('<li>');
                               ul.append(li);
                               var span = $('<span mno='+menu.mno+'><input type="hidden" value="'+menu.mno+'" />'+menu.mname+'</span>');
                               li.append(span);

                               showLevelMenu(menu.mno,li);
                           }
                       }
                   }
                   showLevelMenu(-1,$('body'));

                   //菜单合并
                   // $('ul span').click(function () {
                   //     //span ul
                   //     $(this).next().slideToggle(1000);//1秒完成上下滑动的展开或合并
                   // });

                   //为菜单添加点击事件
                   $('ul span').click(function () {
                       $('#active').attr('id','');//取消之前选中的颜色
                       $(this).attr('id','active');//增加当前的选中颜色
                   });
                   //为菜单增加双击事件
                   addMenuDblClick($('ul span'));
               },
               'json'
           );
        });
        //新建根菜单
        function createRootMenu() {
            if ($('#mname').length != 0){
                return ;
            }
            var li = $('<li><input id="mname" placeholder="菜单名字" /><input id="mhref" placeholder="菜单指向" /><input id="mtarget" placeholder="显示位置" /><button id="saveBtn">保存</button></li>');
            $('ul:first').append(li);

            $('#saveBtn').click(function () {
                //保存根菜单信息
                saveMenu(-1);
            })
        }
        //保存menu信息入后台
        function saveMenu(pno) {
            var mname = $('#mname').val();
            var mhref = $('#mhref').val();
            var mtarget = $('#mtarget').val();
            if (mname == ''){
                alert("请输入信息");
                return;
            }
            $.ajax({
                url:'saveMenu.do',
                data:{'pno':pno,'mname':mname,'mhref':mhref,'mtarget':mtarget},
                type:'post',
                success:function (mno) {
                    alert("保存成功"+mno);
                    //清空栏内信息 找到mname标签 的父级li  再清空
                    var li = $('#mname').parent();
                    li.empty();
                    li.append('<span mno='+mno+'>'+mname+'</span>')

                    li.children().click(function () {
                        //为菜单添加点击事件
                        $('ul span').click(function () {
                            $('#active').attr('id','');//取消之前选中的颜色
                            $(this).attr('id','active');//增加当前的选中颜色
                        });
                    });

                    addMenuDblClick(li.children());
                },
                error:function () {
                    alert("保存失败");
                }
            })
        }
        //新建子菜单
        function createChildMenu() {
            var ul = $('#active').next();
            var li = $('<li><input id="mname" placeholder="菜单名字" /><input id="mhref" placeholder="菜单指向" /><input id="mtarget" placeholder="显示位置" /><button id="saveBtn">保存</button></li>');
            if ($('#active').length == 0){
                alert('请选择要创建的子菜单');
                return;
            }
            //在选择了的情况点击其他选项没反应
            if ($('#mname').length != 0){
                return ;
            }
            ul.append(li);
            $('#saveBtn').click(function () {
                var pno = $(this).parent().parent().prev().attr('mno');
                //alert(pno);
                saveMenu(pno);
            });
        }

        //为菜单增加点击事件
        function addMenuDblClick($menus) {
            $menus.dblclick(function (menu) {
                if ($('#mname').length != 0){
                    return ;
                }
                var span = $(this);
                //先查询修改信息的原始数据
                var mno = span.attr('mno');

                $.post('menuOne.do',{'mno':mno},function (menu) {
                    var li = span.parent();
                    span.empty();
                    var mhref = '';
                    if (menu.mhref!=''){
                        mhref = menu.mhref;
                    }
                    var mtarget = '';
                    if (menu.mtarget!=''){
                        mtarget = menu.mtarget;
                    }
                    span.append('<input id="mno" type="hidden" value="'+menu.mno+'" />');
                    span.append('<input id="mname" value="'+menu.mname+'" />');
                    span.append('<input id="mhref" value="'+mhref+'" />');
                    span.append('<input id="mtarget" value="'+mtarget+'" />');
                    span.append('<button id="updateBtn">保存</button>');
                    
                    $('#updateBtn').click(function () {
                        var mno = $('#mno').val();
                        var mname = $('#mname').val();
                        var mhref = $('#mhref').val();
                        var mtarget = $('#mtarget').val();
                        $.post(
                            'menuUpdate.do',
                            {mno:mno,mname:mname,mhref:mhref,mtarget:mtarget},
                            function () {
                                alert('修改成功');
                                var span = $('#mno').parent();
                                span.empty();
                                span.append(mname);
                        },"json");
                    });
                }, "json");
            });
        }
        function deleteMenu() {
            var span = $('#active');
            if (span.length == 0){
                alert('请选择要删除的菜单');
                return;
            }
            var mno = span.attr('mno');
            $.post('menuDelete.do',{'mno':mno},function () {
                alert('删除成功');
                span.parent().remove();
            },'json');
        }
    </script>
</head>
<body>
    <div>
        <a href="javascript:createRootMenu()">新建根菜单</a>
        <a href="javascript:createChildMenu()">新建子菜单</a>
        <a href="javascript:deleteMenu()">删除菜单</a>
    </div>
    <%--
    <ul>
        <li>
            <span>权限管理</span>
            <ul>
                <li>
                    <span>用户管理</span>
                    <ul>
                        <li><span>学生用户</span></li>
                        <li><span>学生用户</span></li>
                    </ul>
                </li>
                <li><span>角色管理</span></li>
            </ul>
        </li>
    </ul>
    --%>
</body>
</html>
