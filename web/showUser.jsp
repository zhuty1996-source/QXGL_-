<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>主页面</title>

    <script type="text/javascript">
        window.onload = function () {
            //斑马条纹
            var tbody = document.getElementById("tbody");
            var trs = tbody.getElementsByTagName("tr");
            for (var i=0;i<trs.length;i++){
                if (i%2==0){
                    trs[i].style.background = '#ccffcc';
                }else{
                    trs[i].style.background = '#ffffff';
                }
            }

            //鼠标移动时背景处理
            for (var i=0;i<trs.length;i++){
                trs[i].onmouseover = function () {
                    var oldColor = this.style.background;
                    this.style.background = '#008c8c';
                    this.onmouseout = function () {
                        this.style.background = oldColor;
                    }
                }
                //数据行增加点击勾选功能
                trs[i].onclick = function () {
                    var input = this.getElementsByTagName('input')[0];
                    input.checked = !input.checked;
                }
                //行中的复选框增加点击判断功能
                var input = trs[i].getElementsByTagName('input')[0];
                input.onclick = function (ev) {
                    //阻止冒泡
                    var e = window.event || ev;
                    e.stopPropagation();
                }
            }
            //制作全选框
            var inputs = document.getElementsByTagName('input');
            for (var i=0;i<inputs.length;i++){
                var input = inputs[i];
                if (input.type == 'checkbox'){
                    input.onclick = function () {
                        var f = this.checked;
                        for (var j=0;j<inputs.length;j++){
                            if (inputs[j].type == 'checkbox'){
                                inputs[j].checked = f;
                            }
                        }
                    }
                }
                break;
            }
        }
        //是否确认删除弹框
        function userDelete(uno) {
            var f = confirm("是否确认删除?");
            if (!f) return;
            window.location.href="userDelete.do?uno="+uno;
        }
        //批量删除
        function userDeletes() {
            var tbody = document.getElementById("tbody");
            var inputs = tbody.getElementsByTagName('input');
            var unos = '';
            for (var i=0;i<inputs.length;i++){
                //找出所有被选中的input标签
                if (inputs[i].checked){
                    var uno = inputs[i].parentNode.nextElementSibling.innerHTML;
                    unos += uno + ',';
                }
            }
            if (unos == ''){
                alert('请选择要删除的文件');
            }else{
                var f = confirm('请确认是否删除这些数据?');
                if (!f)return;
                location.href = 'userDeletes.do?unos='+unos;
            }
        }
    </script>
</head>
<body>
    <h2 align="center">用户信息</h2>
    <p align="center">
        <a href="userAdd.jsp">新建用户</a>
        <a href="javascript:userDeletes()">批量删除</a>
        <a href="userImport.jsp">批量导入</a>
    </p>
    <div id="showBox">
        <form action="" method="get">
            <table border="1" width="90%" align="center" cellspacing="0">
                <thead>
                <tr>
                    <th><input type="checkbox" ></th>
                    <th>用户编号</th>
                    <th>用户姓名</th>
                    <th>用户密码</th>
                    <th>真实姓名</th>
                    <th>用户年龄</th>
                    <th>用户性别</th>
                    <th>用户电话</th>
                    <th>操作</th>
                </tr>
                </thead>

                <tbody id="tbody">
                <c:forEach items="${requestScope.userList}" var="user">
                    <tr align="center">
                        <td><input type="checkbox"></td>
                        <td>${user.uno}</td>
                        <td>${user.uname}</td>
                        <td>${user.upass}</td>
                        <td>${user.truename}</td>
                        <td>${user.age}</td>
                        <td>${user.sex}</td>
                        <td>${user.phone}</td>
                        <td>
                            <a href="userEdit.do?uno=${user.uno}">编辑</a> |
                            <a href="javascript:userDelete(${user.uno})">删除</a> |
                            <a href="setRoles.jsp?uno=${user.uno}&truename=${user.truename}">分配角色</a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </form>
    </div>
</body>
</html>
