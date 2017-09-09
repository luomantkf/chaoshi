<%@ page contentType="text/html; charset=utf-8" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>管理员登录</title>
</head>
 <link href="/css/css.css" rel="stylesheet" type="text/css">
 <script language="javascript">
 function checkEmpty(){
 if(document.form.account.value==""){
  window.alert("请输入管理员账号")
   document.form.account.focus();
   return false;
 }
 if(document.form.password.value==""){
 window.alert("请输入管理员密码")
 document.form.password.focus();
 return false;
 }
 return true;
 } 
 
 </script>
<body style="background-image: url(/images/fg_land1.jpg)">
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td>
	
	
<form name="form" method="post" action="/BgManagerServlet.do?action=4" onSubmit="return checkEmpty()">
<table width="547" height="294" border="0" align="center" cellpadding="0" cellspacing="0" background="/images/bg_land.jpg">
  <tr>
    <td width="125">&nbsp;</td>
    <td width="422" valign="bottom"><table width="411" border="0">
      <tr>
        <td width="75" height="38"><font  color="#9A6634"><strong style="width: 75px">用户名：</strong></font>          </td>
        <td width="104"><input name="managerName" type="text" size="15"></td>
        <td width="100">&nbsp;<font color="#9A6634"><strong>密码：</strong></font>          </td>
        <td width="113"><input name="password" type="password" size="15"></td>
        <td width="51"><div align="right">
          <input name="Submit" type="image" width="51" height="20"  src="/images/1.png" >
        </div></td>
      </tr>
      <tr>
        <td height="30" colspan="5"><div align="right"><a href="/jsp/index.jsp" class="a1">返回</a>&nbsp;&nbsp;</div></td>
      </tr>
    </table></td>
  </tr>
</table>
</form>
    </td>
  </tr>
</table>

~



</body>
</html>
