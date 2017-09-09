<%@ page contentType="text/html; charset=utf-8" %>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@ page import="com.chaoshi.util.DbUtil" %>
<%@ page import="com.chaoshi.model.BgGood" %>
<%@ page import="com.chaoshi.dao.BgGoodDao" %>
<%@ page import="com.chaoshi.model.FgUser" %>
<%@ page import="com.chaoshi.dao.FgOrderDao" %>
<html>
<link href="/css/css.css" rel="stylesheet" type="text/css">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>重邮超市</title>
</head>
<script Language="JavaScript">
    function buyGood(data1,data2) {
            window.location="/goodsServlet.do?action=6&id="+data1+"&price="+data2;

    }
</script>
<body>
<jsp:include page="fg/fg-top.jsp" flush="true"/>
<table width="766" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="207" valign="top" bgcolor="#f0ffff">
    <!--左侧01-->
    <jsp:include page="fg/fg-left.jsp" flush="true"/></td>
    <td width="559" valign="top" bgcolor="#FFFFFF">
    <!--右侧01-->	
	<jsp:include page="fg/fg-goodSorts.jsp" flush="true"/>
        <div align="center">
            <%if(session.getAttribute("currentUser")!=null){%>
            <br>
         </div>
            <div align="center">
                <h2 style="background-color: cadetblue">
                    编辑推荐
                </h2>
            </div>
        <table width="100%"  border="0" align="center" cellpadding="0" cellspacing="0" bordercolor="#FFFFFF" bordercolorlight="#FFFFFF" bordercolordark="#819BBC">
        <tr>
            <%
                DbUtil dbUtil= new DbUtil();
                BgGoodDao goodDao=new BgGoodDao();
                FgOrderDao fgOrderDao=new FgOrderDao();
                Connection con=dbUtil.getCon();
                FgUser user=(FgUser)session.getAttribute("currentUser");
                short type=fgOrderDao.getGoodType(con,user.getId());
                List<BgGood> goods=goodDao.listBgGood(con,0,2,type);
                if(goods.size()==0){
                     goods=goodDao.listBgGood(con,0,2);
                }
                for(int i=0;i<goods.size();i++)
                {
                    BgGood good=goods.get(i);
            %>
            <td>				<table width="99%"  border="0" align="center" cellpadding="0" cellspacing="0" bordercolor="#CCCCCC"   >
                <tr>
                    <td height="150" bordercolor="#666666" >
                        <table width="96%"  border="1" align="center" cellpadding="1" cellspacing="1" bordercolor="#FFFFFF" bgcolor="#CCCCCC" >
                            <tr>
                                <td width="36%" rowspan="4" bgcolor="#FFFFFF"><div align="center">
                                    <input name="pricture<%=i%>" type="image" src="<%=good.getGoodPic()%>" width="110" height="100">
                                </div></td>
                                <td width="64%" bgcolor="#FFFFFF"><div align="center"><%=good.getGoodName()%></div></td>
                            </tr>
                            <tr>
                                <td bgcolor="#FFFFFF"><div align="center"><font color="#F14D83">单价：<%=good.getPrice()%>元</font></div></td>
                            </tr>
                            <tr>
                                <td  bgcolor="#FFFFFF" class="linkBlack"  align="center">
                                    <%if(session.getAttribute("currentUser")!=null){%>
                                    <a href="#" onClick="buyGood(<%=good.getId()%>,<%=good.getPrice()%>)"><img src="/images/2.jpg"></a>
                                    <%}else{%>
                                    登录后才能购买</td>
                                <%}%>
                            </tr>
                        </table></td>
                </tr>
            </table></td>
            <%}%>
        </tr>
</table>

        <div align="center">
    <%}%>
            <div>
                <h2 style="background-color: cadetblue">
                    新品上架
            </h2>
            </div>
</div>
<table width="100%"  border="0" align="center" cellpadding="0" cellspacing="0">
    
          <tr>
            <td height="215" valign="top">
			<%
                DbUtil dbUtil= new DbUtil();
                BgGoodDao goodDao=new BgGoodDao();
                Connection con=dbUtil.getCon();
                List<BgGood> goods=goodDao.listBgGood(con,0,4);
                for(int i=0;i<goods.size();i++)
              {
                BgGood good=goods.get(i);
                %><table width="100%"  border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td>				<table width="99%"  border="0" align="center" cellpadding="0" cellspacing="0" bordercolor="#CCCCCC"   >
                  <tr>
                    <td height="150" bordercolor="#666666" >
                      <table width="96%"  border="1" align="center" cellpadding="1" cellspacing="1" bordercolor="#FFFFFF" bgcolor="#CCCCCC" >
                        <tr>
                          <td width="36%" rowspan="4" bgcolor="#FFFFFF"><div align="center">
                              <input name="pricture<%=i%>" type="image" src="<%=good.getGoodPic()%>" width="110" height="100">
                          </div></td>
                          <td width="64%" bgcolor="#FFFFFF"><div align="center"><%=good.getGoodName()%></div></td>
                        </tr>
                        <tr>
                          <td bgcolor="#FFFFFF"><div align="center"><font color="#F14D83">单价：<%=good.getPrice()%>元</font></div></td>
                        </tr>
                        <tr>
                          <td  bgcolor="#FFFFFF" class="linkBlack"  align="center">
                              <%if(session.getAttribute("currentUser")!=null){%>
                              <a href="#" onClick="buyGood(<%=good.getId()%>,<%=good.getPrice()%>)"><img src="/images/2.jpg"></a>
                              <%}else{%>
                           登录后才能购买</td>
                          <%}%>
                        </tr>
                    </table></td>
                  </tr>
                </table></td>
              </tr>
            </table>
			<%}%>
            </td>
          </tr>
        </table>
    </td>
  </tr>
</table>
</body>
</html>
