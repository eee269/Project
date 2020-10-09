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
        document.replyInputForm.rememo.value = "";
        location.reload();
        document.replyInputForm.submit();
    }
    function replyDelete(reno) {
        if (!confirm("삭제하시겠습니까?")) {
            return;
        }
        return location.href = "./reply/replyDelete.jsp?reno=" + reno;
    }

    function replyUpdate(f_reno, f_rememo){
            // var reply = document.getElementById("reply" + reno);
        document.replyUpdateForm.style.display = 'block';
        document.replyInputForm.style.display = 'none';

        document.replyUpdateForm.reno.value = f_reno;
        document.replyUpdateForm.rememo.value = f_rememo;
        document.replyUpdateForm.rememo.focus();

        document.body.appendChild(document.replyUpdateForm);
            // if (updateReno) {
            //     document.body.appendChild(replyDiv);
            //     var oldReno = document.getElementById("reply" + updateReno);
            //     oldReno.innerText = updateRememo;
            // }
        //     form.reno.value = reno;
        //     form.rememo.value = reply.innerText;
        //     reply.innerText = "";
        //     reply.appendChild(replyDiv);
        //     updateReno = reno;
        //     updateRememo = form.rememo.value;
        //     form.rememo.focus();
    }
    //
    // function replyUpdateSave(){
    //     var form = document.replyUpdateForm;
    //     if (form.rememo.value=="") {
    //         alert("글 내용을 입력해주세요.");
    //         form.rememo.focus();
    //         return;
    //     }
    //     form.submit();
    // }
    //
    function replyUpdateCancel(){
        document.replyUpdateForm.style.display = 'none';
        document.replyInputForm.style.display = '';

        // var form = document.replyUpdateForm;
        // var replyDiv = document.getElementById("replyDiv");
        // document.body.appendChild(replyDiv);
        // replyDiv.style.display = "none";
        //
        // var oldReno = document.getElementById("reply"+updateReno);
        // oldReno.innerText = updateRememo;
        // updateReno = updateRememo = null;
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

            <table class="list" align="left">
                <%
                    List boardReplyList = brdao.getBoardReplyList();

                    for(int i=0; i<boardReplyList.size(); i++) {
                        brb = (BoardReplyBean) boardReplyList.get(i);
                        if(brb.getBrdno() == bb.getNum()){
                %>
                    <tr class="list_menu">
                        <input type="hidden" name="reno" value="<%=brb.getReno()%>">
                        <td name="rewriter"><%=brb.getRewriter()%></td>
                        <td name="rememo"><%=brb.getRememo()%></td>
                        <td name="redate"><%=sdf.format(brb.getRedate())%></td>
                        <%
                            if(brb.getRewriter().equals(id)) {
                        %>
                        <td><input type="button" value="수정" onclick="replyUpdate(<%=brb.getReno()%>, <%=brb.getRememo()%>)" class="button">
                            <input type="button" value="삭제" onclick="replyDelete(<%=brb.getReno()%>)" class="button"></td>
                        <%
                            } else {    %> <td></td> <%   }
                        %>
                    </tr>
                <%
                        }
                    }
                %>
            </table>

            <form name="replyUpdateForm" action="reply/replySubmit.jsp" method="post" style="border: 0; width: 800px; padding: 5px; display: none">
                <input type="hidden" name="brdno" value="<%=bb.getNum()%>">
                <input type="hidden" name="reno">
                <textarea name="rememo" rows="3" cols="60" maxlength="500"
                          class="board_reply_content" placeholder="댓글을 달아주세요.">
                </textarea>
                <input type="button" value="저장" onclick="replyUpdateSave()" class="button">
                <input type="button" value="취소" onclick="replyUpdateCancel()" class="button">
            </form>

            <p>&nbsp;</p>
            <hr>
            <form name="replyInputForm" action="reply/replySubmit.jsp" method="post" style="border: 0; width: 800px; padding: 5px">
                <input type="hidden" name="brdno" value="<%=bb.getNum()%>">
                <input type="hidden" name="reno">
                <%
                    if(id == null) {
                        %>
                <textarea rows="3" cols="60" maxlength="500" class="board_reply_content"
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
