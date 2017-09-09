<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.util.*"%>
<%@ page import="com.chaoshi.util.DbUtil" %>
<%@ page import="com.chaoshi.dao.FgOrderDao" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="com.chaoshi.model.FgOrderVo" %>
<%@ page import="com.chaoshi.model.FgUser" %>
<%@ page import="com.chaoshi.util.DataTypeUtil" %>
<html>
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
	<strong>我的购物车</strong>	<div align="center"><br>
              <%
                  DbUtil dbUtil= new DbUtil();
                  FgOrderDao orderDao=new FgOrderDao();
                  Connection con=dbUtil.getCon();
                  List<FgOrderVo> orderVos=orderDao.listFgOrderVo(con,((FgUser) session.getAttribute("currentUser")).getId());
                  if(orderVos.size()==0){%>
           您还没有购物！！！
           <%}else{%>

        </div>
        <form method="post" action="/orderServlet.do?action=1" name="form">
		  <table width="92%"  border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#FFFFFF" bordercolordark="#819BBC" bordercolorlight="#FFFFFF">
          <tr>
            <td width="13%" height="28"><div align="center">序号</div></td>
            <td width="20%"><div align="center">商品的名称</div></td>
            <td width="19%"><div align="center">单价</div></td>
            <td width="19%"><div align="center">购买数量</div></td>
            <td width="14%"><div align="center">总金额</div></td>
              <td width="15%"><div align="center">操作</div></td>
          </tr>
            <%
                session.setAttribute("orderVos",orderVos);
                double sum=0;
                StringBuffer orderIds=new StringBuffer();
                for(int i=0;i<orderVos.size();i++){
                    FgOrderVo orderVo=orderVos.get(i);
                    orderIds.append(orderVo.getId()+"_");
                    sum+=orderVo.getMoney();
        %>
          <tr>
            <td height="28"><div align="center"><%=i+1%></div></td>
            <td><div align="center"><%=orderVo.getGoodName()%></div></td>
            <td><div align="center"><%=orderVo.getPrice()%>元</div></td>
            <td><div align="center"><input style="text-align: center" name="count<%=i%>" size="7" type="text"  value="<%=orderVo.getCount()%>" onBlur="check(this.form)"></div></td>
              <td><div align="center"><%=orderVo.getMoney()%>元</div></td>
              <td><div align="center"><a href="/orderServlet.do?action=6&type=1&id=<%=orderVo.getId()%>">删除</a></div></td>
          </tr>
		     <script language="javascript">
			<!--
			function check(myform){
				if(isNaN(myform.count<%=i%>.value) || myform.count<%=i%>.value.indexOf('.',0)!=-1){
					alert("请不要输入非法字符");myform.count<%=i%>.focus();return;}
				if(myform.count<%=i%>.value==""){
					alert("请输入修改的数量");myform.count<%=i%>.focus();return;}
				myform.submit();
			}
			-->
		</script>
          <%}%>
        </table>

        </form>

<table width="100%" height="52" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr align="center" valign="middle">
		<td height="10">&nbsp;		</td>
        <td width="24%" height="10" colspan="-3" align="left">&nbsp;</td>
		</tr>
      <tr align="center" valign="middle">
        <td height="21" class="tableBorder_B1">&nbsp;</td>
        <td height="21" colspan="-3" align="left" >合计总金额：￥<%=DataTypeUtil.formatDouble(sum)%></td>
      </tr>
      <tr align="center" valign="middle">
        <td height="21" colspan="2"> <a href="/jsp/index.jsp">继续购物</a> | <a href="/jsp/fg/fg-cartCheckOut.jsp?sum=<%=sum%>">去收银台结账</a> | <a href="/orderServlet.do?action=4&orderIds=<%=orderIds.toString()%>">清空购物车</a></td>
        </tr>
</table>
<%}%>
</td>
  </tr>
</table>
<%}%>






















</body>
</html>
