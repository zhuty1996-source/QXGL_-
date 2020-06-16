<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <style type="text/css">
        #userImportBox{
            width: 400px;
            background-color: #ccffcc;
            border: 2px solid #cccccc;
            border-radius: 10px;
            padding-bottom: 10px;
            margin: 50px auto;
        }
        #userImportBox input{
            width: 200px;
            height: 25px;
        }
        #userImportBox button{
            width: 100px;
            margin-top: 8px;
        }
    </style>
</head>
<body>
    <div id="userImportBox">
        <h2 align="center">用户批量导入</h2>
        <form action="userImport.do" method="post" enctype="multipart/form-data">
            <ul>
                <li><input type="file" name="excel" required="required"></li>
                <li><button>保存</button></li>
            </ul>
        </form>
    </div>
</body>
</html>
