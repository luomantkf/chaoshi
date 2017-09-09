<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/1/29
  Time: 18:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>修改商品</title>
</head>
<link href="/css/css.css" rel="stylesheet" type="text/css">
<body style="background-image: url(/images/fg_land1.jpg)">
<jsp:include page="bg-up.jsp" flush="true"/>
<table width="788" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#f5f5dc">
  <tr>
    <td width="170"  valign="top"><jsp:include page="bg-left.jsp" flush="true" /></td>
    <td width="618" align="center" valign="top" bgcolor="#FFFFFF">
      <div>
        <div class="optitle clearfix">

          <div class="title" align="left">修改商品&gt;&gt;</div>
        </div>
      </div>
      <form action="/goodsServlet.do?action=1&ctype=1&id=${bgGood.id}" method="post" enctype="multipart/form-data"  name="form" onSubmit="return checkEmpty(form)" >
        <div class="content">
          <table class="box">
            <tr>
              <td class="field">商品名称：</td>
              <td><input type="text" name="goodName" class="text" value="${bgGood.goodName}" /></td>
            </tr>
            <tr>
              <td class="field">商品定价：</td>
              <td><input type="text" name="price" class="text" value="${bgGood.price}"/></td>
            </tr>
            <tr>
              <td class="field">所属类别：</td>
              <td>当前类别:${bgGood.type}  &nbsp;&nbsp;<select name="type"><option value="">请选择</option>
                <option value="1">小吃</option>
                <option value="2">饮料</option>
                <option value="4">文具</option>
                <option value="3">日常用品</option>
                <option value="5">电子商品</option>
              </select></td>
            </tr>
            <tr>
              <td class="field">商品图片:</td>
              <td>&nbsp;&nbsp;<a href="#" onclick="window.open('/goodsServlet.do?action=4&goodPic=${bgGood.goodPic}','','width=260,height=300,top=250, left=350');">查看</a>
                <input name="formFile" type="file" id="formFile" value="${bgGood.goodPic}"></td>
            </tr>
          </table>
        </div>
        <input type="submit"   value="更改" width="51" height="20">
        &nbsp;&nbsp;&nbsp;&nbsp;
        <a href="#" onClick="javasrcipt:history.go(-1)"><input type="button"   value="返回" width="51" height="20"></a>
      </form>
      <br>
</table>
<script language="javascript">
  function checkEmpty(form){
    for(i=0;i<form.length;i++){
      if(form.elements[i].value==""){
        alert("表单信息不能为空");
        return false;
      }
    }
    if(isNaN(document.form.price.value)){
      window.alert("价格只能为数字");
      return false;
    }
  }
  </script>
</body>
</html>
