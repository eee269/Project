<%@ page import="board.BoardDAO" %>
<%@ page import="board.BoardBean" %>
<%@ page import="board.BoardReplyDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="board.BoardReplyBean" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Yejin_Board_Write</title>
    <link rel="stylesheet" href="../css/default.css" type="text/css">
    <link rel="stylesheet" href="../css/list.css" type="text/css">
    <link rel="stylesheet" href="../css/BDwrite.css" type="text/css">

    <%
        BoardReplyBean brb = new BoardReplyBean();
        BoardReplyDAO brdao = new BoardReplyDAO();
        String id = (String) session.getAttribute("id");
    %>

</head>
<body>
<jsp:include page="../inc/nav.jsp"/>
<script>
    function replySubmit() {
        if(document.replyInputForm.rememo.value == "") {
            alert("글 내용을 입력해주세요.");
            document.replyInputForm.rememo.focus();
            return;
        }
        document.replyInputForm.submit();
    }
    function replyDelete(reno) {
        if (!confirm("삭제하시겠습니까?")) {
            return;
        }
        return location.href = "reply/replyDelete.jsp?reno=" + reno;
    }

    function replyUpdate(reno){
        var div = document.getElementById("replyUpdatediv" + reno);
        div.style.display = 'block';
        document.replyInputForm.style.display = 'none';

    }

    function replyUpdateSave(reno) {
        // var form = document.getElementById("replyUpdateForm" + reno);
        document.updateformtable.action="reply/replyUpdate.jsp?reno=" + reno;
        document.updateformtable.submit();
    }
    function replyUpdateCancel(reno){
        var div = document.getElementById("replyUpdatediv" + reno);
        div.style.display = 'none';
        document.replyInputForm.style.display = 'block';
    }

</script>
<%
    request.setCharacterEncoding("utf-8");
    int num = Integer.parseInt(request.getParameter("num"));
    BoardDAO bdao = new BoardDAO();
    bdao.updateReadcount(num);
    BoardBean bb = bdao.getBoard(num);
    SimpleDateFormat sdf = new SimpleDateFormat("yy.MM.dd hh:mm");
%>

<section>
    <div class="write">
        <fieldset>
            <h2><%=bb.getTitle()%></h2>
            <p><span><%=bb.getId()%></span> &nbsp; <%=sdf.format(bb.getDate())%></p>
            <hr>
            <pre class="content"><%=bb.getContent()%></pre>
            <hr>
            <%--댓글자리--%>
            <h3>Comments</h3>

            <form name="updateformtable" action="reply/replySubmit.jsp" method="post">
                <input type="hidden" name="brdno" value="<%=bb.getNum()%>">
            <table class="list" align="left">
                <%
                    List boardReplyList = brdao.getBoardReplyList();

                    for(int i=0; i<boardReplyList.size(); i++) {
                        brb = (BoardReplyBean) boardReplyList.get(i);
                        if(brb.getBrdno() == bb.getNum()){
                %>
                    <tr class="list_menu">
                        <td name="rewriter"><%=brb.getRewriter()%></td>
                        <td name="rememo"><%=brb.getRememo()%></td>
                        <td name="redate"><%=sdf.format(brb.getRedate())%><input type="hidden" name="reno" value="<%=brb.getReno()%>"></td>
                        <%
                            if(brb.getRewriter().equals(id)) {
                        %>
                        <td><input type="button" value="수정" onclick="replyUpdate(<%=brb.getReno()%>)" class="button">
                            <input type="button" value="삭제" onclick="replyDelete(reno)" class="button"></td>
                        <%
                            } else {    %> <td></td> <%   }
                        %>
                    </tr>

                    <tr>
                        <td colspan="4">
                       <div id="replyUpdatediv<%=brb.getReno()%>" style="border: 0; width: auto; padding: 5px; display: none">
                            <textarea name="rememo<%=brb.getReno()%>" rows="3" cols="60" maxlength="500" class="board_reply_content">
                                <%=brb.getRememo()%>
                        </textarea>


                            <input type="button" value="저장" onclick="replyUpdateSave(<%=brb.getReno()%>)" class="button">
                            <input type="button" value="취소" onclick="replyUpdateCancel(<%=brb.getReno()%>)" class="button">
                       </div>

                        </td>
                    </tr>
                <%
                        }
                    }
                %>
            </table>
            </form>
            <p>&nbsp;</p>
            <hr>
            <form name="replyInputForm" action="reply/replySubmit.jsp" method="post" style="border: 0; width: 800px; padding: 5px">
                <input type="hidden" name="brdno" value="<%=bb.getNum()%>">
                <input type="hidden" name="reno">
                <%
                    if(id == null) {
                        %>
                <textarea name="rememo" rows="3" cols="60" maxlength="500" class="board_reply_content"
                          onclick="location.href='../member/loginForm.jsp'" readonly>로그인 하세요.</textarea>
                <%
                    } else {%>
                <%=id%>&nbsp;
                <textarea name="rememo" rows="3" cols="60" maxlength="500" class="board_reply_content" placeholder="댓글을 달아주세요."></textarea>
                <a href="#" onclick="replySubmit()" class="button">저장</a>
                <%}%>
            </form>

            <input type="button" value="List" onclick="location.href='boardMain.jsp'"
                   class="button" style="float: right">
            <input type="submit" value="Delete"  onclick="location.href='deleteForm.jsp?num=<%=bb.getNum()%>'"
                   class="button" style="float: right">
            <input type="submit" value="Update"  onclick="location.href='updateForm.jsp?num=<%=bb.getNum()%>'"
                   class="button" style="float: right">
        </fieldset>
    </div>
</section>

<jsp:include page="../inc/footer.jsp"/>
</body>


</html>
