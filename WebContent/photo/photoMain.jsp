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
    <table class="list">
        <tr>
            <td colspan="4">
                <h1>Photo List</h1>
            </td>
        </tr>
        <tr>
            <td colspan="4" style="border-bottom: 2px solid black"></td>
        </tr>
        <%
            int newLine = 0;

            PhotoDAO photoDAO = new PhotoDAO();

            int count = photoDAO.getPhotoCount();

            int pageSize = 12;
            String pageNum = request.getParameter("pageNum");
            if(pageNum == null) {
                pageNum = "1";
            }

            int currentPage = Integer.parseInt(pageNum);
            int startRow = (currentPage-1) * pageSize + 1;

            List photoList = photoDAO.getPhotoList(startRow, pageSize);
            SimpleDateFormat sdf = new SimpleDateFormat("yy.MM.dd hh:mm");

            for(int i=0; i<photoList.size(); i++) {
                if(newLine == 0) {
                    out.print("<tr>");
                }
                PhotoBean photoBean = (PhotoBean) photoList.get(i);
                newLine++;
        %>
        <td align="center" width="190">
            <input type="hidden" name="num" value="<%=photoBean.getNum()%>">
            <a href="photoContents.jsp?num=<%=photoBean.getNum()%>">
                <%
                    if(photoBean.getFile() == null) {
                        %>
                <img src="../photoUpload/icons8-image-gallery-100.png" alt="Photo" width="190" height="190"><br>
                <%
                    } else {
                %>
                <img src="../photoUpload/<%=photoBean.getFile()%>" alt="" width="190" height="190"><br>
                <%
                }
                %>
                <%=photoBean.getTitle()%>&nbsp;&nbsp; <%=sdf.format(photoBean.getDate())%>
            </a>
        </td>
        <%
                if(newLine == 4) {
                    out.print("</tr>");
                    newLine = 0;
                }
            }

            while (newLine>0 && newLine<4) {
                out.print("<td width='180'></td>");
                newLine++;
            }
            out.print("</tr>");
        %>
        <tr>
            <td colspan="4" style="border-bottom: 2px solid black"></td>
        </tr>

    </table>

    <%
        int pageBlock = 10;
        int startPage = (currentPage-1)/pageSize * pageSize + 1;
        int endPage = startPage + pageBlock - 1;
        int pageCount = count/pageSize + (count%pageSize == 0? 0 : 1);
        if(endPage > pageCount) {
            endPage = pageCount;
        }
        if(startPage > pageBlock) {
    %><a href="photoMain.jsp?pageNum=<%=startPage-pageBlock%>">[PREV]</a> <%
    }
    for(int i=startPage; i<endPage+1; i++) {
%><a href="photoMain.jsp?pageNum=<%=i%>"><%=i%> </a><%
    }
    if(endPage > pageBlock) {
%><a href="photoMain.jsp?pageNum=<%=startPage+pageBlock%>">[NEXT]</a> <%
    }
%>

    <input type="button" value="Write" onclick="location.href='photoWriteForm.jsp'"
           class="button" style="float: right">
</section>
<jsp:include page="../inc/footer.jsp"/>
</body>
</html>
