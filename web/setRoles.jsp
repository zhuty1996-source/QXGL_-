<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <style type="text/css">

        #box ul{
            float: left;
            padding: 0;
            margin: 0;
        }
        #box li{
            padding: 0;
            margin: 0;
        }
        #btns{
            width: 50px;
        }
        #btns button{
            width: 40px;
            height: 30px;
            margin: 0 5px;
            margin-top: 100px;
        }
        #box{
            width: 600px;
            margin: 0 auto;
        }
        #noList{
            width: 260px;
            height: 400px;
            border: 2px solid #cccccc;
            padding: 0;
        }
        #noList li{
            list-style: none;
            margin: 0;
            border-bottom: 1px dotted #cccccc;
            line-height: 24px;
            padding: 4px;
            cursor: pointer;
        }
        #yesList{
            width: 260px;
            height: 400px;
            border: 2px solid #cccccc;
            padding: 0;
        }
        #yesList li{
            list-style: none;
            margin: 0;
            border-bottom: 1px dotted #cccccc;
            line-height: 24px;
            padding: 4px;
            cursor: pointer;
        }
    </style>
    <script src="js/jquery.js"></script>
    <script type="text/javascript">
        //查询组装未分配的角色
        $(function () {
            $.post('noList.do',{'uno' : $('#uno').val()},function (roles) {
                for (var i=0;i<roles.length;i++){
                    var role = roles[i];
                    $('#noList').append('<li rno="'+role.rno+'">'+role.rname+'</li>');
                }

                addDblClickToRight();
            },'json');
        });
        //查询组装已分配的角色
        $(function () {
            $.post('yesList.do',{'uno' : $('#uno').val()},function (roles) {
                for (var i=0;i<roles.length;i++){
                    var role = roles[i];
                    $('#yesList').append('<li rno="'+role.rno+'">'+role.rname+'</li>');
                }

                addDblClickToLeft();
            },'json');

            //为按钮增加全右事件
            $('#rightBtn').click(function () {
                $('#noList').children().appendTo($('#yesList'));
                addDblClickToLeft();
            });
            $('#leftBtn').click(function () {
                $('#yesList').children().appendTo($('#noList'));
                addDblClickToRight();
            });

            //增加保存事件
            $('#saveBtn').click(function () {
                var uno = $('#uno').val();
                var rnos = '';
                $('#yesList li').each(function (i , e) {
                    rnos += $(e).attr('rno')+',';
                });

                $.post('saveRoles.do',{'uno':uno,'rnos':rnos},function () {
                    alert('保存成功');
                })

            });

        });



        function addDblClickToRight() {
            $('#noList li').off('dblclick').dblclick(function () {
                $(this).appendTo($('#yesList'));
                addDblClickToLeft();
            });
        }
        function addDblClickToLeft() {
            $('#yesList li').off('dblclick').dblclick(function () {
                $(this).appendTo($('#noList'));
                addDblClickToRight();
            });
        }
    </script>
</head>
<body>
    <h2 align="center">为用户【${param.truename}】角色分配</h2>
    <input type="hidden" id="uno" value="${param.uno}">
    <p align="center">
        <button type="button" id="saveBtn">保存</button>
    </p>
    <div id="box">
        <ul id="noList">
            <%--<li>系统管理员</li>--%>
            <%--<li>普通管理员</li>--%>
        </ul>
        <ul id="btns">
            <button id="rightBtn" type="button"> &gt;&gt;</button>
            <button id="leftBtn" type="button"> &lt;&lt; </button>
        </ul>
        <ul id="yesList">
            <%--<li>库管员</li>--%>
        </ul>
    </div>
</body>
</html>
