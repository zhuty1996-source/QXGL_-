<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>用户编辑</title>
    <style type="text/css">
        #userEditBox{
            width: 400px;
            background-color: #ccffcc;
            border: 2px solid #ccc;
            margin: 20px auto;
            padding-bottom: 10px;
        }
        #userEditBox input{
            width: 250px;
            height: 25px;
            margin-left: 4px;
            margin-top: 4px;
        }
        #userEditBox button{
            margin-left: 130px;
            margin-top: 10px;
            width: 60px;
            height: 30px;
        }
        #userEditBox li{
            list-style: none;
        }
    </style>
    <script type="text/javascript">

    </script>
</head>
<body>
    <div id="userEditBox">
        <h2 align="center">用户编辑</h2>
        <form id="userEditForm" action="userEditSave.do?uno=${requestScope.user.uno}" method="post">
            <ul>
                <li>用户昵称:<input name="uname" required="required" value="${requestScope.user.uname}"></li>
                <li>真实姓名:<input type="text" name="truename" required="required" value="${requestScope.user.truename}"></li>
                <li>用户年龄:<input type="number" name="age" required="required" value="${requestScope.user.age}"></li>
                <li>用户性别:<input name="sex" required="required" value="${requestScope.user.sex}"></li>
                <li>电话号码:<input name="phone" required="required" value="${requestScope.user.phone}"></li>
                <li><button>保存</button></li>
            </ul>
        </form>
    </div>
</body>
</html>
