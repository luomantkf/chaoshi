<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>无标题文档</title>
</head>
<script language="javascript">
function checkEmpty(form){
for(i=0;i<form.length;i++){
if(form.elements[i].value==""){
alert("表单信息不能为空");
return false;
}
}
}
function quit() {
    window.location.href="/jsp/fg/loginOut.jsp";
  }
</script>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@ page import="com.chaoshi.model.FgUser" %>
<%@ page import="com.chaoshi.util.DateUtil" %>
<%@ page import="com.chaoshi.util.DbUtil" %>
<%@ page import="com.chaoshi.dao.BgGoodDao" %>
<%@ page import="com.chaoshi.model.BgGoodVo" %>
<%@ page import="com.chaoshi.util.DataTypeUtil" %>
<body>
<!--左侧01-->
	<%if(session.getAttribute("currentUser")==null){%>
	<table width="100%" height="138"  border="0" cellpadding="0" cellspacing="0" background="/images/fg_left.jpg">
      <tr>
        <td valign="top"><table width="100%"  border="0" cellpadding="0" cellspacing="0">
		 <tr>
            <td height="26">&nbsp;</td>
          </tr>
        </table>
        <form name="form" method="post" action="/FgUserServlet.do?action=3" onSubmit="return checkEmpty(form)">
          <table width="167" border="0" align="center">
            <tr>
              <td width="60" height="25">用户名：</td>
              <td width="117"> <input name="userName" type="text" style="width:107px;"></td>
            </tr>
            <tr>
              <td height="25">密&nbsp;&nbsp;码：</td>
              <td><input name="password" type="password" style="width:107px;"></td>
            </tr>
			 <tr>
              <td height="26"><input type="image"  src="/images/1.png" width="51" height="20"></td>
              <td height="26" align="right"><a href="/jsp/fg/fg-UserRegister.jsp">注册</a></td>
			 </tr>	  
          </table>
		  </form>
		  </td>
      </tr>
    </table>
	<%}else{
	   FgUser user=(FgUser)session.getAttribute("currentUser");
	%>

	<table width="100%" height="100"  border="0" cellpadding="0" cellspacing="0" background="/images/fg_left.jpg">
      <tr>
        <td valign="top">
            <table width="100%"  border="0" cellpadding="0" cellspacing="0">
		 <tr>
            <td height="15">&nbsp;</td>
          </tr>
        </table>
       
          <table width="167" border="0" align="center">
            <tr>
              <td width="161" height="20"><font color="#FB6801"><%=user.getUserName()%>,</font>欢迎回来</td>
              </tr>
            <tr>
              <td height="20"><%=DateUtil.getCurrentDateStr()%></td>
              </tr>
			 <tr>
              <td height="20" >用户姓名：<%=user.getUserName()%></td>
              </tr>	 
			  <tr>
              <td height="20"  valign="middle"><a href="/FgUserServlet.do?action=5">修改信息</a>&nbsp;<a href="javascript:quit()">安全退出</a></td>
              </tr>	
          </table>
	  </td>
     </tr>
    </table>

		<%}%>
    <table width="100%" height="194" border="0" background="/images/fg_left02.jpg">
    <tr>
        <td valign="top">
            <table width="150" border="0">
                <tr>
                    <td height="32">&nbsp;</td>
                </tr>
            </table>
            <table width="179" border="0" align="center">
                <tr>
                    <td width="171" height="143">
                        <marquee direction="up" height="114" onmouseout="this.start()"
                                 onmouseover="this.stop()" scrollAmount="1" scrollDelay="1">
                             <%

                                 DbUtil dbUtil= new DbUtil();
                                 BgGoodDao goodDao=new BgGoodDao();
                                 Connection con=dbUtil.getCon();
                                 List<BgGoodVo> bgGoodVos1=goodDao.selectHighCount(con,0,5);
                                 //讲每种商品的销售量查询出来放入数组中进行冒泡排序
                                 int[] arr=new int[bgGoodVos1.size()];
                                 for(int i=0;i<bgGoodVos1.size();i++){
                                     arr[i]=bgGoodVos1.get(i).getSaleCount();
                                 }
                                 DataTypeUtil.bubbleSort(arr);
                                 //根据排序重新设置BgGoodVo列表
                                 List<BgGoodVo> bgGoodVos=new ArrayList<BgGoodVo>();
                                 for(int i=0;i<arr.length;i++){
                                    for(BgGoodVo bgGoodVo:bgGoodVos1){
                                        if(bgGoodVo.getSaleCount()==arr[i]){
                                            bgGoodVos.add(bgGoodVo);
                                        }
                                    }
                                 }
                                 for(int i=0;i<bgGoodVos.size();i++){
                                     BgGoodVo bgGoodVo=bgGoodVos.get(i);
                             %>
                            <img src="/images/sign.gif">
                            &nbsp;<font color="#ff7f50"><%=bgGoodVo.getGoodName()%>&nbsp;销售量为:<%=bgGoodVo.getSaleCount()%></font><br>
                            <%}%>
                        </marquee>

                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
</body>
</html>
