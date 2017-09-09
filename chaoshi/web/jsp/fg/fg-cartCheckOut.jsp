<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.util.*"%>
<%@ page import="com.chaoshi.util.DateUtil" %>
<%@ page import="com.chaoshi.model.FgOrderVo" %>
<%@ page import="com.chaoshi.model.FgUser" %>
<%@ page import="com.chaoshi.dao.FgUserDao" %>
<%@ page import="com.chaoshi.util.DbUtil" %>
<%@ page import="java.sql.Connection" %>
<html>
<script language="javascript">
function checkEmpty(form){
for(i=0;i<form.length;i++){
if(form.elements[i].value==""){
alert("表单信息不能为空");
return false;
}
}

}
</script>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>重邮超市</title>
</head>
<link href="/css/css.css" rel="stylesheet" type="text/css">
<body>
<%if(session.getAttribute("currentUser")==null){
    out.print("<script>alert(\"请登录\");window.location.href=\"/jsp/index.jsp\"</script>");
}else{%>

<jsp:include page="fg-top.jsp" flush="true"/>
<table width="766" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="207" bgcolor="#F5F5F5">
    <!--左侧01-->
    <jsp:include page="fg-left.jsp" flush="true"/></td>
    <td width="559" valign="top" bgcolor="#FFFFFF" align="center">
    <!--右侧01-->	
	<jsp:include page="fg-goodSorts.jsp" flush="true"/>	
	
	<br><br>
	<strong>收银结帐</strong>   <form name="form" method="post" action="/orderServlet.do?action=2"  onSubmit="checkEmpty(form)">
        <%
            DbUtil dbUtil= new DbUtil();
            Connection con=dbUtil.getCon();
            FgUserDao userDao=new FgUserDao();
            List<FgOrderVo> orderVos=(List<FgOrderVo>)session.getAttribute("orderVos");
            StringBuffer payId=new StringBuffer();
            FgUser user=(FgUser)session.getAttribute("currentUser");
            user= userDao.selectFgUserById(con, user.getId());
            payId.append(DateUtil.formatDate(new Date(),"yyyyMMddHHmm")+"0b1c");
            for(int i=0;i<orderVos.size();i++){
                FgOrderVo orderVo=orderVos.get(i);
                if(orderVo.getCount()!=0) {
                    payId.append("Ha"+orderVo.getId());
                }
            }

        %>
		  <table width="68%"  border="0" cellspacing="0" cellpadding="0">
              <tr>
              <td height="30"><div align="center">支付编号：</div></td>
              <td>&nbsp;<input type="hidden" name="payId" value="<%=payId.toString()%>"><%=payId.toString()%></td>
            </tr>
            <tr>
              <td width="24%" height="30"><div align="center">用户名称：</div></td>
              <td width="76%">&nbsp;<%=user.getUserName()%></td>
            </tr>
              <tr>
              <td height="30"><div align="center">联系地址：</div></td>
              <td>&nbsp;<%=user.getSushe()%></td>
            </tr>
            <tr>
              <td height="30"><div align="center">联系电话：</div></td>
              <td>&nbsp;<%=user.getPhone()%></td>
            </tr>
              <tr>
                  <td height="30"><div align="center">消费金额：</div></td>
                  <td>&nbsp;<%=request.getParameter("sum")%></td>
              </tr>
            <tr>
              <td height="30"><div align="center">付款方式：</div></td>
              <td>&nbsp;
			  <select name="payType">
                  <option value="0">在线支付</option>
                     <option value="1">现金支付</option>
                </select>
			  </td>
        </table>
		  <br>

                <input type="submit" name="Submit2" value="提交">&nbsp;

          <input type="button" name="back" value="返回" onClick="javasrcipt:history.go(-1)">
      </form>
</td>
  </tr>
</table>
<%}%>














































</body>
</html>
