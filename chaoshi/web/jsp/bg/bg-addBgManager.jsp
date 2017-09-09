<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/1/29
  Time: 18:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>添加后台管理用户</title>
</head>
<link href="/css/css.css" rel="stylesheet" type="text/css">
<body style="background-image: url(/images/fg_land1.jpg)">
<jsp:include page="bg-up.jsp" flush="true"/>
<table width="788" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#f5f5dc">
  <tr>
    <td width="170"  valign="top" ><jsp:include page="bg-left.jsp" flush="true" /></td>
    <td width="618" align="center" valign="top" bgcolor="#FFFFFF">
      <div>
        <div class="optitle clearfix">
          <em><input type="button" name="button" value="添加管理员" class="input-button" onclick="location.href='/jsp/bg/bg-addBgManager.jsp'" /></em>
          <div class="title" align="left">添加管理员&gt;&gt;</div>
        </div>
      </div>
      <form method="post" action="/BgManagerServlet.do?action=1">
        <div class="content">
          <table class="box">
            <tr>
              <td class="field">用户名：</td>
              <td><input type="text" name="userName" class="text" /></td>
            </tr>
            <tr>
              <td class="field">用户密码：</td>
              <td><input type="password" name="password" class="text" /></td>
            </tr>
            <tr>
              <td class="field">联系方式：</td>
              <td><input type="text" name="phone" class="text" /></td>
            </tr>

          </table>
        </div>
        <div class="buttons">
          <input type="submit" name="submit" value="确认" class="input-button" />
          <input type="button" name="button" value="返回" class="input-button" onclick="history.back();" />
        </div>
      </form>
      <br>
</table>


</body>
</html>
