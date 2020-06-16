<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>Title</title>
        <style type="text/css">
            #userAddBox{
                width: 400px;
                background-color: #ccffcc;
                border: 2px solid #ccc;
                margin: 20px auto;
                padding-bottom: 10px;
            }
            #userAddBox input{
                width: 250px;
                height: 25px;
                margin-left: 4px;
                margin-top: 4px;
            }
            #userAddBox button{
                margin-left: 130px;
                margin-top: 10px;
                width: 60px;
                height: 30px;
            }
            #userAddBox li{
                list-style: none;
            }
        </style>
        <script type="text/javascript">
            //判断输入密码是否一致
            window.onload = function () {
                var form = document.getElementById("userAddForm");
                form.onsubmit = function () {
                    var pass = document.getElementById("pass");
                    var repass = document.getElementById("repass");
                    if (pass.value == repass.value){
                        return true;
                    } else{
                        alert("两次输入密码不一致,请重新输入");
                        return false;
                    }
                }
            }
        </script>
    </head>
    <body>
        <div id="userAddBox">
            <h2 align="center">用户新建</h2>
                <form id="userAddForm" action="userAdd.do" method="post">
                    <ul>
                        <li>用户昵称:<input name="uname" required="required"></li>
                        <li>用户密码:<input id="pass" type="password" name="upass" required="required"></li>
                        <li>确认密码:<input id="repass" type="password" required="required"></li>
                        <li>真实姓名:<input type="text" name="truename" required="required"></li>
                        <li>用户年龄:<input type="number" name="age" required="required"></li>
                        <li>用户性别:<input name="sex" required="required" list="sexList">
                            <datalist id="sexList">
                                <option value="男"></option>
                                <option value="女"></option>
                            </datalist>
                        </li>
                        <li>电话号码:<input name="phone" required="required"></li>
                        <li><button>保存</button></li>
                    </ul>
                </form>
        </div>
    </body>
</html>
