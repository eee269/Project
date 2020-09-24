<%@ page import="board.BoardDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="board.BoardBean" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="drive.DriveDAO" %>
<%@ page import="drive.DriveBean" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <link rel="stylesheet" href="../css/default.css" type="text/css">
    <link rel="stylesheet" href="../css/list.css" type="text/css">
</head>
<body>
<jsp:include page="../inc/nav.jsp"/>

<section>
    <input type="button" value="Write" onclick="location.href='writeForm.jsp'"
           class="button" style="float: right">

    <div class="wrap_list">
        <table class="list">
            <tr class="list_menu">
                <th>No.</th>
                <th>Title</th>
                <th>ID</th>
                <th>Date</th>
                <th>Read</th>
            </tr>
            <%
                DriveDAO ddao = new DriveDAO();
                List driveList = ddao.getDriveList();
                SimpleDateFormat sdf = new SimpleDateFormat("yy.MM.dd hh:mm");

                for(int i=0; i<driveList.size(); i++) {
                    DriveBean db = (DriveBean) driveList.get(i);
            %>
            <tr class="list_menu" onclick="location.href='contents.jsp?num=<%=db.getNum()%>'">
                <td><%=db.getNum()%></td>
                <td><%=db.getTitle()%></td>
                <td><%=db.getId()%></td>
                <td><%=sdf.format(db.getDate())%></td>
                <td><%=db.getReadcount()%></td>
            </tr>
            <%
                }
            %>
        </table>
    </div>

    <div id="page">
        <a href="">prev</a>
        <a href="">1</a>
        <a href="">2</a>
        <a href="">3</a>
        <a href="">4</a>
        <a href="">5</a>
        <a href="">6</a>
        <a href="">7</a>
        <a href="">8</a>
        <a href="">9</a>
        <a href="">10</a>
        <a href="">next</a>
    </div>

    <input type="button" value="Write" onclick="location.href='writeForm.jsp'"
           class="button" style="float: right">
</section>

<jsp:include page="../inc/footer.jsp"/>
</body>
</html>