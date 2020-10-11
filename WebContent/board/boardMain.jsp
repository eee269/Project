<%@ page import="board.BoardDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="board.BoardBean" %>
<%@ page import="java.text.SimpleDateFormat" %>
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

<%
    BoardDAO boardDAO = new BoardDAO();
    int count = boardDAO.getBoardCount();

    int pageSize = 10;
    String pageNum = request.getParameter("pageNum");
    if(pageNum == null) {
        pageNum = "1";
    }

    int currentPage = Integer.parseInt(pageNum);
    int startRow = (currentPage-1) * pageSize + 1;

    List boardList = boardDAO.getBoardList(startRow, pageSize);
    SimpleDateFormat sdf = new SimpleDateFormat("yy.MM.dd hh:mm");

%>
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

            for(int i=0; i<boardList.size(); i++) {
                BoardBean bb = (BoardBean) boardList.get(i);
                int replyCount = boardDAO.getBoardReplyCount(bb.getNum());
                %>
            <tr class="list_menu" onclick="location.href='contents.jsp?num=<%=bb.getNum()%>'">
                <td><%=bb.getNum()%></td>
                <td><%=bb.getTitle()%> [<%=replyCount%>]</td>
                <td><%=bb.getId()%></td>
                <td><%=sdf.format(bb.getDate())%></td>
                <td><%=bb.getReadcount()%></td>
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
    <input type="button" value="Write" onclick="location.href='writeForm.jsp'"
           class="button" style="float: right">
</section>

<jsp:include page="../inc/footer.jsp"/>
</body>
</html>