<%@ page import="com.chaoshi.model.BgManager" %>
<%@ page import="com.chaoshi.util.DateUtil" %>
<%@ page contentType="text/html; charset=gb2312"%>
<%
if(session.getAttribute("currentManager")==null){
out.print("<script language=javascript>alert('您已经与服务器断开连接，请重新登录！');window.location.href='/jsp/bg/bg-land.jsp';</script>");
}else{
  BgManager manager=(BgManager)session.getAttribute("currentManager");
%>
<table width="788" height="45" border="0" align="center" cellpadding="0" cellspacing="0" background="/images/bg_top.jpg">
  <tr>
    <td valign="top"><table width="770" border="0" align="center">
      <tr>
        <td width="413" height="53" valign="bottom"><div align="right"></div></td>
        <td width="347" valign="bottom" align="right"></td>
      </tr>
    </table></td>
  </tr>
</table>
<table width="788" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#696969">
  <tr>
    <td width="15" height="25">&nbsp;</td>
    <td width="529"><font color="#FFFFFF">当前登录：<%=manager.getUserName()%></font></td>
    <td width="244"><font color="#FFFFFF">今天是<%=DateUtil.getCurrentDateStr()%></font></td>
  </tr>
</table>
<%}%>