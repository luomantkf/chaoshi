<%@ page contentType="text/html; charset=utf-8" %>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<table  border="0" cellpadding="0" cellspacing="0" align="center">
   <tr>
       <td  align="center">
           <form action="/goodsServlet.do?action=5" method="post">
            <table width="559" height="50" border="0"  cellpadding="0" cellspacing="0" bordercolor="#FFFFFF" bordercolorlight="#FFFFFF" bordercolordark="#819BBC" bgcolor="#5f9ea0">

            <tr align="left">

                <td colspan="3" bgcolor="#dcdcdc"><font color="#ff7f50">商品搜索：&nbsp;&nbsp;</font><input name="goodName" type="text" size="18" value="">&nbsp;&nbsp;类别：&nbsp;&nbsp;<select name="type">
                    <option value="0">不限</option>
                    <option value="1">小吃</option>
                    <option value="2">饮料</option>
                    <option value="4">文具</option>
                    <option value="3">日常用品</option>

                    <option value="5">电子商品</option>
                </select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" value="搜索"></td>
            </tr>

           <tr align="center">
                    <td width="100" onMouseOver="this.style.backgroundImage='url(/images/fg_top02.jpg)'" onMouseOut="this.style.backgroundImage=''"><a href="/goodsServlet.do?action=5&type=1" class="a4">小吃</a></td>
                    <td width="100" onMouseOver="this.style.backgroundImage='url(/images/fg_top02.jpg)'" onMouseOut="this.style.backgroundImage=''"><a href="/goodsServlet.do?action=5&type=2" class="a4">饮料</a></td>
                    <td width="100"  onMouseOver="this.style.backgroundImage='url(/images/fg_top02.jpg)'" onMouseOut="this.style.backgroundImage=''"><a href="/goodsServlet.do?action=5&type=4" class="a4">文具</a></td>

           </tr>
                <tr align="center">
                    <td  width="200" onMouseOver="this.style.backgroundImage='url(/images/fg_top02.jpg)'" onMouseOut="this.style.backgroundImage=''"><a href="/goodsServlet.do?action=5&type=3" class="a4">日常用品</a></td>
                    <td  width="200" onMouseOver="this.style.backgroundImage='url(/images/fg_top02.jpg)'" onMouseOut="this.style.backgroundImage=''"><a href="/goodsServlet.do?action=5&type=5" class="a4">电子商品</a></td>
                    <td>&nbsp;</td>
                </tr>
          </td>
       </table>
           </form>

   </tr>

</table>
