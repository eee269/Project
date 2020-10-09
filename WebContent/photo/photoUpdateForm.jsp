<%@ page import="photo.PhotoDAO" %>
<%@ page import="photo.PhotoBean" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Yejin_Photo_Write</title>
    <link rel="stylesheet" href="../css/default.css" type="text/css">
    <link rel="stylesheet" href="../css/list.css" type="text/css">
</head>
<body>
<jsp:include page="../inc/nav.jsp"/>
<%
    String id = (String)session.getAttribute("id");
    if(id == null) {
%>
<script type="text/javascript">
    alert("로그인 하세요!");
    location.href="../member/loginForm.jsp";
</script>
<%
    }
    int num = Integer.parseInt(request.getParameter("num"));

    PhotoDAO photoDAO = new PhotoDAO();
    PhotoBean photoBean = photoDAO.getPhoto(num);
%>

<section>
    <form action="photoUpdatePro.jsp" method="post" enctype="multipart/form-data">
        <div class="write">
            <fieldset>
                <h2>Photo Write</h2><hr>
                <input type="hidden" name="num" value="<%=photoBean.getNum()%>">
                <input type="hidden" name="readcount" value="<%=photoBean.getReadcount()%>">
                <input type="text" name="id" class="text" value="<%=id%>" readonly>
                <input type="password" name="pass2" class="text" placeholder="PASSWORD CHECK"><br>
                <input type="text" name="title" class="board_title" value="<%=photoBean.getTitle()%>"><br>
                <input type="text" name="date" class="board_title" value="<%=photoBean.getDate()%>" readonly><br>
                <hr>
                <input type="file" name="oldfile" value="<%=photoBean.getFile()%>"><br>
                <hr>
                <textarea name="content" cols="30" rows="5" class="board_content"
                          placeholder="MEMO"><%=photoBean.getContent()%></textarea><br>

                <input type="button" value="수정 취소" onclick="history.back()"
                       class="button" style="float: right">
                <input type="submit" value="수정 완료" class="button" style="float: right">
            </fieldset>
        </div>
    </form>
</section>
<jsp:include page="../inc/footer.jsp"/>
</body>
</html>
