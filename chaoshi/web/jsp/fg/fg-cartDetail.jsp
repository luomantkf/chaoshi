<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="com.chaoshi.model.FgOrderVo" %>
<%@ page import="com.chaoshi.util.DbUtil" %>
<%@ page import="com.chaoshi.dao.FgOrderDao" %>
<%@ page import="java.sql.Connection" %>
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
        <%if(request.getParameter("orderId")==null){%>
	<br><br>
	<strong>订单查看</strong>
	 <br>	 <br>	 <br>

		  <table width="95%"  border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#FFFFFF" bordercolorlight="#FFFFFF" bordercolordark="#819BBC">
              <tr id="oneTr">
              </tr>
        </table>
        <div class="pagecontrol">
            <span>共1页</span>
            <span>当前第 1 / 1 页</span>
                        <span>
                        	<a href="#" class="up-all">第一页&nbsp;&nbsp;</a>
                            <a href="#" class="up">上一页&nbsp;&nbsp;</a>
        					<a href="#" class="down">下一页&nbsp;&nbsp; </a>
        					<a href="#" class="down-all">最后一页&nbsp;&nbsp;</a>
        				</span>
        </div>
        <%}else{%>
      <div align="center"><br>
          <br>
	      订货明细查询
	      <br><br>
    <%
        DbUtil dbUtil= new DbUtil();
        FgOrderDao orderDao=new FgOrderDao();
        Connection con=dbUtil.getCon();
        FgOrderVo fgOrderVo=orderDao.listFgOrderVo2(con,Integer.parseInt(request.getParameter("orderId")));
        if(fgOrderVo!=null){
    %>
      <table width="89%"  border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#FFFFFF" bordercolorlight="#FFFFFF" bordercolordark="#819BBC">
          <tr>
              <td width="40%" height="30"><div align="right">订单编号：</div></td>
              <td width="60%">&nbsp;<%=fgOrderVo.getId()%></td>
          </tr>
          <tr>
              <td height="30"><div align="right">支付编号：</div></td>
              <td >&nbsp;<%=fgOrderVo.getPayId()%></td>
          </tr>
          <tr>
            <td  height="30"><div align="right">商品名称：</div></td>
            <td>&nbsp;<%=fgOrderVo.getGoodName()%></td>
          </tr>
          <tr>
            <td height="30"><div align="right">商品单价：</div></td>
            <td>&nbsp;<%=fgOrderVo.getPrice()%></td>
          </tr>
          <tr>
              <td  height="30"><div align="right">购买数量：</div></td>
              <td>&nbsp;<%=fgOrderVo.getCount()%></td>
          </tr>
          <tr>
              <td height="30"><div align="right">下单时间：</div></td>
              <td>&nbsp;<%=fgOrderVo.getPayTime()%></td>
          </tr>
      </table>

	   <table width="89%"  border="0" cellspacing="0" cellpadding="0">
         <tr>
           <td height="24"><div align="right">付款金额：<%=fgOrderVo.getMoney()%>元&nbsp;&nbsp;&nbsp;
               <a href="#" onClick="javasrcipt:history.go(-1)">返回</a></div></td>
         </tr>
       </table>
          <%}%>
      </div>
      <%}%>
	
	
</td>
  </tr>
</table>
<script id="test" type="text/html">
    <tr align="center">
        <td width="15%" height="21">订单编号</td>
        <td width="15%">送货地址</td>
        <td width="20%">电话</td>
        <td width="15%">付款方式</td>
        <td width="15%">是否出货</td>
        <td width="15%">操作</td>
    </tr>
    {{each items as value i}}
    <tr align="center">
        <td  height="24">{{value.id}}</td>
        <td>{{value.suShe}}</td>
        <td>{{value.phone}}</td>
        <td>{{value.payType}}</td>
        <td>{{value.status}}</td>
        <td><a href="/jsp/fg/fg-cartDetail.jsp?orderId={{value.id}}">查看明细</a>|<a href="/orderServlet.do?action=8&orderId={{value.id}}">退款</a></td>
    </tr>
    {{/each}}
</script>
<script type="text/javascript" src="/js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="/js/art.js"></script>
<script type="text/javascript" src="/js/page.js"></script>
<script type="text/javascript">
    /*分页请求js*/
    $(document).ready(function() {
        <%if(request.getParameter("orderId")==null){%>
        page("/orderServlet.do?action=3");})
    <%}%>
</script>
<%}%>
</body>
</html>
