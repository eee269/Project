<%@ page import="member.MemberDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="board.BoardDAO" %>
<%@ page import="board.BoardBean" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Yejin_Board_Write</title>
    <link rel="stylesheet" href="../css/default.css" type="text/css">
    <link rel="stylesheet" href="../css/BDwrite.css" type="text/css">
</head>
<body>
<jsp:include page="../inc/nav.jsp"/>
<%

    int num = Integer.parseInt(request.getParameter("num"));
    BoardDAO bdao = new BoardDAO();
    BoardBean bb = bdao.getBoard(num);

    String id = (String)session.getAttribute("id");
    if(id == null) {
%>
<script type="text/javascript">
    alert("로그인 하세요!");
    location.href="../member/loginForm.jsp";
</script>
<%
    } else if (!id.equals(bb.getId())){
%>
<script type="text/javascript">
    alert("수정할 수 없습니다.");
    history.back();
</script>
<%
    }
%>

<section>
    <form action="updatePro.jsp" method="post">
        <div class="write">
            <fieldset>
                <input type="hidden" name="num" value="<%=num%>">
                <h2>Board Update</h2><hr>
                <input type="text" name="id" class="text" value="<%=bb.getId()%>" readonly>
                <input type="password" name="pass2" class="text" placeholder="PASSWORD CHECK"><br>
                <input type="text" name="title" class="board_title" value="<%=bb.getTitle()%>"><br>
                <hr>
                <textarea name="content" cols="30" rows="10" class="board_content">
                    <%=bb.getContent()%>
                </textarea><br>

                <input type="button" value="수정 취소" onclick="location.href='boardMain.jsp'"
                       class="button" style="float: right">
                <input type="submit" value="수정 완료" class="button" style="float: right">
            </fieldset>
        </div>
    </form>
</section>

<jsp:include page="../inc/footer.jsp"/>
</body>


</html>
