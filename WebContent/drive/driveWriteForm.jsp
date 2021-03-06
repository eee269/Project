<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Yejin_Drive_Write</title>
    <link rel="stylesheet" href="../css/default.css" type="text/css">
    <link rel="stylesheet" href="../css/BDwrite.css" type="text/css">
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
%>

<section>
    <form action="driveWritePro.jsp" method="post" enctype="multipart/form-data">
        <div class="write">
            <fieldset>
                <h2>Drive Write</h2><hr>
                <input type="text" name="id" class="text" value="<%=id%>" readonly>
                <input type="password" name="pass2" class="text" placeholder="PASSWORD CHECK" required><br>
                <input type="text" name="title" class="board_title" placeholder="TITLE" required><br>
                <hr>
                <input type="file" name="file" required><br>
                <hr>
                <textarea name="content" cols="30" rows="5" class="board_content"
                    placeholder="MEMO"></textarea><br>

                <input type="button" value="작성 취소" onclick="location.href='driveMain.jsp'"
                       class="button" style="float: right">
                <input type="submit" value="작성 완료" class="button" style="float: right">
            </fieldset>
        </div>
    </form>
</section>

<jsp:include page="../inc/footer.jsp"/>
</body>


</html>
