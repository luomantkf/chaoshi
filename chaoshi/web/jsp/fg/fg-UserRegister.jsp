<%@ page contentType="text/html; charset=utf-8" %>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>重邮超市</title>
</head>
<script type="text/javascript">
    var code ; //在全局定义验证码
    //产生验证码
    window.onload = function createCode(){
        code = "";
        var codeLength = 4;//验证码的长度
        var checkCode = document.getElementById("code");
        var random = new Array(0,1,2,3,4,5,6,7,8,9,'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R',
                'S','T','U','V','W','X','Y','Z');//随机数
        for(var i = 0; i < codeLength; i++) {//循环操作
            var index = Math.floor(Math.random()*36);//取得随机数的索引（0~35）
            code += random[index];//根据索引取得随机数加到code上
        }
        checkCode.value = code;//把code值赋给验证码
    }
    function createVCode(){
        code = "";
        var codeLength = 4;//验证码的长度
        var checkCode = document.getElementById("code");
        var random = new Array(0,1,2,3,4,5,6,7,8,9,'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R',
                'S','T','U','V','W','X','Y','Z');//随机数
        for(var i = 0; i < codeLength; i++) {//循环操作
            var index = Math.floor(Math.random()*36);//取得随机数的索引（0~35）
            code += random[index];//根据索引取得随机数加到code上
        }
        checkCode.value = code;//把code值赋给验证码
    }
    function beforeSubmit(form){

        if(form.userName.value==''){
            alert('用户名不能为空！');
            form.userName.focus();
            return false;
        }
        if(form.grade.value==''){
            alert('请输入年级！');
            form.grade.focus();
            return false;
        }
        if(form.sushe.value==''){
            alert('请宿舍！');
            form.sushe.focus();
            return false;
        }
        if(form.phone.value==''){
            alert('请手机号码！');
            form.phone.focus();
            return false;
        }
        if(form.password.value==''){
            alert('密码不能为空！');
            form.password.focus();
            return false;
        }
        if(form.passwordOne.value==''){
            alert('密码不能为空！');
            form.passwordOne.focus();
            return false;
        }
        if(form.password.value!=form.passwordOne.value) {
            alert('你两次输入的密码不一致，请重新输入！');
            return false;
        }
        //校验验证码
        var inputCode = document.getElementById("input").value.toUpperCase(); //取得输入的验证码并转化为大写
        if(inputCode.length <= 0) { //若输入的验证码长度为0
            alert("请输入验证码！"); //则弹出请输入验证码
            return false;
        }
        else if(inputCode != code ) { //若输入的验证码与产生的验证码不一致时
            alert("验证码输入错误！"); //则弹出验证码输入错误
            createCode();//刷新验证码
            document.getElementById("input").value = "";//清空文本框
            return false;
        }
        return true;
    }
</script>
<body>
<jsp:include page="fg-top.jsp" flush="true"/>
<table width="766" border="0" align="center" cellpadding="0" cellspacing="0" bordercolor="#000000">
  <>
    <td bgcolor="#F5F5F5" align="center">
        <div id="recommend" width="752" height="39">
            <h2 style="background-color: cadetblue">
                用户注册
            </h2>
        </div>
        <form method="post" name="form" action="/FgUserServlet.do?action=1" onSubmit="return beforeSubmit(this);">
            <input type="hidden" name="id" value="0">
           <table>
            <tr width="270"  border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td width="107" height="35">
                      <div align="right">用户名称：</div></td>
                    <td width="163">
                        <div align="left">
                            <input type="text" name="userName" value="">
                      </div></td></tr>
                  <tr>
                    <td height="30">
                      <div align="right">用户密码：</div></td>
                    <td>
                        <div align="left">
                            <input type="password" name="password" value="">
                      </div></td></tr>
                  <tr>
                    <td height="30">
                      <div align="right">密码确认：</div></td>
                    <td>
                        <div align="left">
                            <input type="password" name="passwordOne" value="">
                      </div></td></tr>
                  <tr>
                    <td height="30">
                      <div align="right">年级：</div></td>
                    <td>
                        <div align="left">
                            <input type="text" name="grade" value="">
                      </div></td></tr>
                  <tr>
                    <td height="30">
                      <div align="right">宿舍：</div></td>
                    <td>
                        <div align="left">
                            <input type="text" name="sushe" value="">
                      </div></td></tr>
                  <tr>
                    <td height="30">
                      <div align="right">手机号码：</div></td>
                    <td>
                        <div align="left">
                            <input type="text" name="phone" value="">
                      </div></td>
                  </tr>
                <tr>
                    <td height="30">
                        <div align="right"> 验证码：</div>
                    </td>
                    <td>
                        <div align="left">
                            <input  type="text" id="input" style="width:100px;" value="">
                            <input type = "button" id="code" onclick="createCode()"/>
                            <a  href="#" onclick="createVCode()">看不清换一张</a>
                        </div>
                    </td>
                </tr>

        </table>
        <br>
        <input type="submit"   value="提交" width="51" height="20">
            &nbsp;&nbsp;&nbsp;&nbsp;
        <a href="#" onClick="javasrcipt:history.go(-1)"><input type="button"   value="返回" width="51" height="20"></a>
        </form>
</body>
</html>
