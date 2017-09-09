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

	<br><br>
	<strong>用户修改信息</strong>
	 <br>	 <br>	 <br>

        <form method="post" name="form" action="/FgUserServlet.do?action=6" onSubmit="return beforeSubmit(this);">
            <input type="hidden" name="id" value="${user.id}">
            <table>
                <tr width="270"  border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="107" height="35">
                        <div align="right">用户名称：</div></td>
                    <td width="163">
                        <div align="left">
                            <input type="text" name="userName" value="${user.userName}" readonly="true">
                        </div></td>
                </tr>
                <tr>
                    <td height="30">
                        <div align="right">年级：</div></td>
                    <td>
                        <div align="left">
                            <input type="text" name="grade" value="${user.grade}">
                        </div></td></tr>
                <tr>
                    <td height="30">
                        <div align="right">宿舍：</div></td>
                    <td>
                        <div align="left">
                            <input type="text" name="sushe" value="${user.sushe}">
                        </div></td></tr>
                <tr>
                    <td height="30">
                        <div align="right">手机号码：</div></td>
                    <td>
                        <div align="left">
                            <input type="text" name="phone" value="${user.phone}">
                        </div></td>
                </tr>
                </tr>
            </table>
            <br>
            <input type="submit"   value="修改" width="51" height="20">
            &nbsp;&nbsp;&nbsp;&nbsp;
            <a href="#" onClick="javasrcipt:history.go(-1)"><input type="button"   value="返回" width="51" height="20"></a>
        </form>

      <%}%>


</td>
  </tr>
</table>

</body>
<script type="text/javascript">
function beforeSubmit(form) {
    if (form.userName.value == '') {
        alert('请输入用户名！');
        form.grade.focus();
        return false;
    }
    if (form.grade.value == '') {
        alert('请输入年级！');
        form.grade.focus();
        return false;
    }
    if (form.sushe.value == '') {
        alert('请宿舍！');
        form.sushe.focus();
        return false;
    }
    if (form.phone.value == '') {
        alert('请手机号码！');
        form.phone.focus();
        return false;
    }
}


</script>
</html>
