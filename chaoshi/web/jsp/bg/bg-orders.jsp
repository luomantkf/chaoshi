<%@ page import="com.chaoshi.util.DbUtil" %>
<%@ page import="com.chaoshi.dao.FgOrderDao" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="com.chaoshi.model.FgOrderVo" %>
<%@ page contentType="text/html; charset=utf-8"%>
 <script Language="JavaScript">
 function deleteManager(date) {
  if(confirm("确定要删除吗？")){
    window.location="/orderServlet.do?action=6&id="+date;
	}
  }
 </script>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>重邮超市的后台</title>
</head>
 <link href="/css/css.css" rel="stylesheet" type="text/css">
<body style="background-image: url(/images/fg_land1.jpg)">







<jsp:include page="bg-up.jsp" flush="true"/>
<table width="788" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#f5f5dc">
  <tr>
    <td width="170"  valign="top"><jsp:include page="bg-left.jsp" flush="true" /></td>
    <td width="618" align="center" valign="top" bgcolor="#FFFFFF"> <br>
        <div>
            <div class="optitle clearfix">
                <div class="title" align="left">订单管理&gt;&gt;</div>
            </div>
        </div>
        <div class="content">
            <%if(request.getParameter("orderId")==null){%>
            <table  border="1" class="list">
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
                <%}else {%>
            <div align="center">
                <br>
                订货明细查询
                <br>
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
                        <td height="24"><div align="right">付款金额：<%=fgOrderVo.getMoney()%>元&nbsp;&nbsp;<a href="#" onclick="javasrcipt:history.go(-1)">返回</a></div></td>
                    </tr>
                </table>
                <%}%>
            </div>
            <%}%>
        </div>
        <br>

</table>
<script id="test" type="text/html">
    <tr align="center">
        <td width="9%" height="21">订单编号</td>
        <td width="10">姓名</td>
        <td width="13%">送货地址</td>
        <td width="18%">电话</td>
        <td width="14%">付款方式</td>
        <td width="11%">是否出货</td>
        <td width="20%">操作</td>
    </tr>
    {{each items as value i}}
    <tr align="center">
        <td  height="24">{{value.id}}</td>
        <td>{{value.userName}}</td>
        <td>{{value.suShe}}</td>
        <td>{{value.phone}}</td>
        <td>{{value.payType}}</td>
        <td>{{value.status}}</td>
        <td align="right"><a href="/jsp/bg/bg-orders.jsp?orderId={{value.id}}">明细</a>|<select id="selectOne{{value.id}}" onchange="changStatus('{{value.id}}')"><option value="1">未出货</option>
            <option value="2">出货</option></select>|<a href="javascript:deleteManager('{{value.id}}')">删除</a></td>
            </tr>
    {{/each}}
</script>
<script type="text/javascript" src="/js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="/js/art.js"></script>
<script type="text/javascript" src="/js/page.js"></script>
<script type="text/javascript">
    function changStatus(data){
        var obj=document.getElementById('selectOne'+data);
        var index=obj.selectedIndex; //序号，取当前选中选项的序号
        var val = obj.options[index].value;
        window.location="/orderServlet.do?action=7&id="+data+"&status="+val;
    }
    /*分页请求js*/
    $(document).ready(function() {
        <%if(request.getParameter("orderId")==null){%>
        page("/orderServlet.do?action=5");})
    <%}%>
</script>
</body>
</html>
