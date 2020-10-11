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
    <input type="button" value="Write" onclick="location.href='driveWriteForm.jsp'"
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
                DriveDAO driveDAO = new DriveDAO();
                int count = driveDAO.getDriveCount();

                int pageSize = 10;
                String pageNum = request.getParameter("pageNum");
                if(pageNum == null) {
                    pageNum = "1";
                }

                int currentPage = Integer.parseInt(pageNum);
                int startRow = (currentPage-1) * pageSize + 1;

                List driveList = driveDAO.getDriveList();
                SimpleDateFormat sdf = new SimpleDateFormat("yy.MM.dd hh:mm");

                for(int i=0; i<driveList.size(); i++) {
                    DriveBean driveBean = (DriveBean) driveList.get(i);
            %>
            <tr class="list_menu" onclick="location.href='driveContents.jsp?num=<%=driveBean.getNum()%>'">
                <td><%=driveBean.getNum()%></td>
                <td><%=driveBean.getTitle()%> <a href="http://foo.com/bar.html#disqus_thread"> </a></td>
                <td><%=driveBean.getId()%></td>
                <td><%=sdf.format(driveBean.getDate())%></td>
                <td><%=driveBean.getReadcount()%></td>
            </tr>
            <%
                }
            %>
        </table>
    </div>
    <%
        int pageBlock = 10;
        int startPage = (currentPage-1)/pageSize * pageSize + 1;
        int endPage = startPage + pageBlock - 1;
        int pageCount = count/pageSize + (count%pageSize == 0? 0 : 1);
        if(endPage > pageCount) {
            endPage = pageCount;
        }
        if(startPage > pageBlock) {
    %><a href="boardMain.jsp?pageNum=<%=startPage-pageBlock%>">[PREV]</a> <%
    }
    for(int i=startPage; i<endPage+1; i++) {
%><a href="boardMain.jsp?pageNum=<%=i%>"><%=i%> </a><%
    }
    if(endPage > pageBlock) {
%><a href="boardMain.jsp?pageNum=<%=startPage+pageBlock%>">[NEXT]</a> <%
    }
%>

    <input type="button" value="Write" onclick="location.href='driveWriteForm.jsp'"
           class="button" style="float: right">
</section>

<jsp:include page="../inc/footer.jsp"/>
</body>
</html>