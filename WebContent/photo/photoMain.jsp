<%@ page import="photo.PhotoDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="photo.PhotoBean" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Yejin_Photo_Main</title>
    <link rel="stylesheet" href="../css/default.css" type="text/css">
    <link rel="stylesheet" href="../css/list.css" type="text/css">
</head>
<body>
<jsp:include page="../inc/nav.jsp"/>
<section>
    <table class="list" >
        <tr>
            <td colspan="3">
                <h1>Photo List</h1>
            </td>
        </tr>
        <tr>
            <td colspan="3" style="border-bottom: 2px solid black"></td>
        </tr>
        <%
            int newLine = 0, articleCount = 0, cnt = 0;

            PhotoDAO photoDAO = new PhotoDAO();
            List photoList = photoDAO.getPhotoList();
            SimpleDateFormat sdf = new SimpleDateFormat("yy.MM.dd hh:mm");

            for(int i=0; i<photoList.size(); i++) {
                if(newLine == 0) {
                    out.print("<tr>");
                }
                PhotoBean photoBean = (PhotoBean) photoList.get(i);
                newLine++;
                articleCount++;
        %>
        <td align="center" width="190">
            <input type="hidden" name="num" value="<%=photoBean.getNum()%>">
            <a href="photoContents.jsp?num=<%=photoBean.getNum()%>">
                <img src="../upload/<%=photoBean.getFile()%>" alt="" width="190" height="190"><br>
                <%=photoBean.getTitle()%>&nbsp;&nbsp; <%=sdf.format(photoBean.getDate())%>
            </a>
        </td>
        <%
                if(newLine == 3) {
                    out.print("</tr>");
                    newLine = 0;
                }
            }

            while (newLine>0 && newLine<3) {
                out.print("<td width='180'></td>");
                newLine++;
            }
            out.print("</tr>");
        %>
        <tr>
            <td colspan="3" style="border-bottom: 2px solid black"></td>
        </tr>

    <%--페이지 번호 들어갈 자리--%>
    </table>

    <input type="button" value="Write" onclick="location.href='photoWriteForm.jsp'"
           class="button" style="float: right">
</section>
<jsp:include page="../inc/footer.jsp"/>
</body>
</html>
