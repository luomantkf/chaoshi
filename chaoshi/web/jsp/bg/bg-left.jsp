<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="com.chaoshi.model.BgManager" %>
<script Language="JavaScript">
 function quit() {
    window.location.href="/jsp/bg/loginOut.jsp";
  }
 </script>


<%
    if(session.getAttribute("currentManager")==null){
        out.print("<script language=javascript>alert('您已经与服务器断开连接，请重新登录！');window.location.href='/jsp/bg/bg-land.jsp';</script>");
    }else{
        BgManager manager=(BgManager)session.getAttribute("currentManager");
%>
<table width="35" height="22" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td><img src="/images/bg_left01.jpg" width="170" height="45"></td>
      </tr>
    </table>
      <table width="170" height="46" border="0" cellpadding="0" cellspacing="0" background="/images/bg_left02.jpg">
        <tr>
          <td><table width="118" border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
              <td width="118" height="34" align="center" valign="bottom"><div align="left"><a href="/jsp/bg/bg-managerSelect.jsp" >管理员管理</a></div></td>
            </tr>
          </table></td>
        </tr>
      </table>
    <table width="170" height="46" border="0" cellpadding="0" cellspacing="0" background="/images/bg_left02.jpg">
    <tr>
        <td><table width="118" border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
                <td width="118" height="34" align="center" valign="bottom"><div align="left"><a href="/jsp/bg/bg-user.jsp" >前台用户管理</a></div></td>
            </tr>
        </table></td>
    </tr>
    </table>
        <table width="170" height="46" border="0" cellpadding="0" cellspacing="0" background="/images/bg_left02.jpg">
            <tr>
                <td><table width="118" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="118" height="34" align="center" valign="bottom"><div align="left"><a href="/jsp/bg/bg-goods.jsp">商品管理</a></div></td>
                    </tr>
                </table></td>
            </tr>
        </table>
        <table width="170" height="46" border="0" cellpadding="0" cellspacing="0" background="/images/bg_left02.jpg">
    <tr>
        <td><table width="118" border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
                <td width="118" height="34" align="center" valign="bottom"><div align="left"><a href="/jsp/bg/bg-orders.jsp">订单管理</a></div></td>
            </tr>
        </table>
        </td>
    </tr>
</table>
        <table width="170" height="46" border="0" cellpadding="0" cellspacing="0" background="/images/bg_left02.jpg">
    <tr>
        <td><table width="118" border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
                <td width="118" height="34" align="center" valign="bottom"><div align="left"><a href="javascript:quit()">安全退出</a></div></td>
            </tr>
        </table>
        </td>
    </tr>
</table>

<%}%>
