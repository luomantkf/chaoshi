<%@ page contentType="text/html; charset=utf-8"%>
 <script Language="JavaScript">
 function deleteManager(date) {
  if(confirm("确定要删除吗？")){
    window.location="/BgManagerServlet.do?action=2&id="+date;
	}
  }
 </script>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>重邮超市的后台</title>
</head>
 <link href="/css/css.css" rel="stylesheet" type="text/css">
<body bgcolor="#f0ffff" style="background-image: url(/images/fg_land1.jpg)">







<jsp:include page="bg-up.jsp" flush="true"/>
<table width="788" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#f5f5dc">
    <tr>
        <td width="170"  valign="top"><jsp:include page="bg-left.jsp" flush="true" /></td>
        <td width="618" align="center" valign="top" bgcolor="#FFFFFF"> <br>
            <div>
                <div class="optitle clearfix">
                    <em><input type="button" name="button" value="添加管理员" class="input-button" onclick="location.href='/jsp/bg/bg-addBgManager.jsp'" /></em>
                    <div class="title" align="left">管理员管理&gt;&gt;</div>
                </div>
            </div>
        <div class="content">
            <table  border="1" class="list">

                <tr id="oneTr">
                    <td>1</td>
                    <td>1</td>
                    <td>1</td>
                    <td>1</td>
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
        </div>
        <br>
</table>
<script id="test" type="text/html">
    <tr bgcolor="#6495ed">
        <td height="25" width="134">数据编号</td>
        <td width="135">用户名</td>
        <td width="135">联系方式</td>
        <td width="134">操作</td>
    </tr>
    {{each items as value i}}
    <tr>
    <td height="30"><div align="center">{{value.id}}</div></td>
    <td><div align="center">{{value.userName}}</div></td>
    <td><div align="center">{{value.phone}}</div></td>
    <td><div align="center">

        <a href="javascript:deleteManager('{{value.id}}')">删除</a></div>
        </td></tr>
    {{/each}}
</script>
<script type="text/javascript" src="/js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="/js/art.js"></script>
<script type="text/javascript" src="/js/page.js"></script>
<script type="text/javascript">
    /*分页请求js*/
    $(document).ready(function() {
        page("/BgManagerServlet.do?action=3");})
</script>
</body>
</html>
