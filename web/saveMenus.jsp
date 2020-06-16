<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <script src="js/jquery.js"></script>
    <script type="text/javascript">
        $(function () {
            $.post('menuList.do',{},function (menus) {
                //按照子父关系显示

                //显示每一层菜单
                //pno 表示父级菜单编号 表示显示pno这个父级菜单的子级菜单列表
                //$代表要用jquery操作
                function showPreLevelMenus(pno,$position) {
                    var ul = $('<ul>');
                    $position.append(ul);

                    for (var i = 0;i<menus.length;i++){
                        var menu = menus[i];
                        if (menu.pno == pno){

                            var li = $('<li>');
                            ul.append(li);
                            li.append('<input type="checkbox"><span>'+menu.mname+'</span>')

                            showPreLevelMenus(menu.mno,li);
                        }
                    }
                }

                showPreLevelMenus(-1,$('#menuBox td'));//显示根菜单列表

                //增加展开合并操作
                $('#menuBox span').click(function () {
                    $(this).next().toggle(1000);
                });
                
                //增加选中父级，自动选中子集的操作
                $('#menuBox input:checkbox').click(function () {
                   var flag = $(this).prop('checked');
                   if (flag){
                       //选中子级
                       function okChildren($p) {
                                        //  span   ul      li        input
                          var inputs = $p.next().next().children().children('input');
                          if (inputs.length == 0)return;
                          inputs.prop('checked',flag);
                          okChildren(inputs);
                       }
                       okChildren($(this));
                       //选中父级

                   }else{
                       //选掉
                   }
                });
            },'json');
        });
    </script>
    <style type="text/css">
        ul li{
            list-style: none;
            margin-top: 0;
            margin-bottom: 0;
            padding-top: 0;
            padding-bottom: 0;
        }
        li{
            margin-top: 6px;
        }
    </style>
</head>
<body>
    <h2 align="center">为【${param.rname}】分配菜单</h2>
    <input type="hidden" id="rno" value="${param.rno}">
    <table id="menuBox" align="center">
        <tr>
            <td>
                
            </td>
        </tr>
    </table>
</body>
</html>
