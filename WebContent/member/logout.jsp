<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2020-09-23
  Time: 오후 1:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    session.invalidate();
    response.sendRedirect("../member/main.jsp");
%>
</body>
</html>
