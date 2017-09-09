<%@ page contentType="text/html; charset=utf-8" language="java" errorPage="" %>
<%
    session.invalidate();
 out.println("<script>parent.location.href='/jsp/index.jsp';</script>");
%>

