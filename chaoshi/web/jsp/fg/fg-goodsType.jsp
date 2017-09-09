<%@ page contentType="text/html; charset=utf-8" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>重邮超市</title>
</head>
<script Language="JavaScript">
    function buyGood(data1,data2) {
        window.location="/goodsServlet.do?action=6&id="+data1+"&price="+data2;
    }
</script>
 <link href="/css/css.css" rel="stylesheet" type="text/css">
<body>
<jsp:include page="fg-top.jsp" flush="true"/>
<table width="766" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="207" valign="top" bgcolor="#F5F5F5">
    <!--左侧01-->
    <jsp:include page="fg-left.jsp" flush="true"/></td>
    <td width="559" valign="top" bgcolor="#FFFFFF">
    <!--右侧01-->	
	<jsp:include page="fg-goodSorts.jsp" flush="true"/>

<table width="559"  border="0" align="center" cellpadding="0" cellspacing="0">

          <tr>
            <td height="168" valign="top" id="oneTr">

            </td>
          </tr>

</table>
        <div align="center" class="pagecontrol">
            <span>共1页</span>&nbsp;
            <span>当前第 1 / 1 页</span>&nbsp;&nbsp;
                                <span>
                                    <a href="#" class="up-all">第一页&nbsp;&nbsp;</a>
                                    <a href="#" class="up">上一页&nbsp;&nbsp;</a>
                                    <a href="#" class="down">下一页&nbsp;&nbsp; </a>
                                    <a href="#" class="down-all">最后一页&nbsp;&nbsp;</a>
                                </span>
        </div>
        <script id="test" type="text/html">
            {{each items as value i}}
            <table width="100%"  border="0" align="center" cellpadding="0" cellspacing="0">
                <tr>
                    <td>
                        <table width="99%"  border="0" align="center" cellpadding="0" cellspacing="0" bordercolor="#CCCCCC">
                            <tr>
                            <td height="150" bordercolor="#666666" >
                                <table width="96%"  border="1" align="center" cellpadding="1" cellspacing="1" bordercolor="#FFFFFF" bgcolor="#CCCCCC" >
                                    <tr>
                                        <td width="36%" rowspan="4" bgcolor="#FFFFFF"><div align="center">
                                            <input name="pricture" type="image" src="{{value.goodPic}}" width="110" height="100">

                                        </div></td>
                                        <td width="64%" bgcolor="#FFFFFF"><div align="center">{{value.goodName}}</div>
                                    </tr>
                                    <tr>
                                        <td bgcolor="#FFFFFF"><div align="center"><font color="#F14D83">单价：{{value.price}}元</font></div></td>
                                    </tr>
                                    <tr>
                                        <td  bgcolor="#FFFFFF" class="linkBlack"  align="center">
                                            <%if(session.getAttribute("currentUser")!=null){%>
                                            <a href="#" onClick="buyGood('{{value.id}}','{{value.price}}')"><img src="/images/2.jpg"></a>
                                            <%}else{%>
                                            登录后才能购买</td>
                                        <%}%>
                                    </tr></td>
                                </table></td>
                        </tr>
                    </table></td>
                </tr>
            </table>

            {{/each}}
        </script>
        <script type="text/javascript" src="/js/jquery-1.11.3.min.js"></script>
        <script type="text/javascript" src="/js/art.js"></script>
        <script type="text/javascript" src="/js/page.js"></script>
        <script type="text/javascript">
            /*分页请求js*/
            $(document).ready(function() {
                page("/goodsServlet.do?action=3&type="+"${type}"+"&goodName="+"${goodName}");})
        </script>
</table>
</body>
</html>
