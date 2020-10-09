<%@ page import="photo.PhotoDAO" %>
<%@ page import="photo.PhotoBean" %>
<%@ page import="java.text.SimpleDateFormat" %><%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2020-10-04
  Time: 오전 12:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Yejin_Photo_Contents</title>
    <link rel="stylesheet" href="../css/default.css" type="text/css">
    <link rel="stylesheet" href="../css/list.css" type="text/css">
</head>
<body>
<jsp:include page="../inc/nav.jsp"/>
<%
    request.setCharacterEncoding("utf-8");
    String id = (String) session.getAttribute("id");
    int num = Integer.parseInt(request.getParameter("num"));
    PhotoDAO photoDAO = new PhotoDAO();
    photoDAO.updateReadcount(num);
    PhotoBean photoBean = photoDAO.getPhoto(num);
    SimpleDateFormat sdf = new SimpleDateFormat("yy.MM.dd hh:mm");
%>

<section>
    <div class="write">
        <fieldset>
            <h2><%=photoBean.getTitle()%></h2>
            <p><span><%=photoBean.getId()%></span> &nbsp; <%=sdf.format(photoBean.getDate())%></p>
            <hr>
            <pre class="memo"><%=photoBean.getContent()%></pre>
            <hr>
            <p><a href="/photoUpload/<%=photoBean.getFile()%>"><%=photoBean.getFile()%></a></p>
            <hr>

            <input type="button" value="List" onclick="location.href='photoMain.jsp'"
                   class="button" style="float: right">
            <%
            if(id != null) {
                if(id.equals(photoBean.getId())) {
            %>
                <input type="submit" value="Delete"  onclick="location.href='photoDeleteForm.jsp?num=<%=photoBean.getNum()%>'"
            class="button" style="float: right">
            <input type="submit" value="Update"  onclick="location.href='photoUpdateForm.jsp?num=<%=photoBean.getNum()%>'"
                   class="button" style="float: right">
            <%
                }
            }
            %>
        </fieldset>
    </div>
</section>

<jsp:include page="../inc/footer.jsp"/>
</body>
</html>
