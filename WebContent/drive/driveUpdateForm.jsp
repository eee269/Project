<%@ page import="drive.DriveDAO" %>
<%@ page import="drive.DriveBean" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Yejin_Drive_Update</title>
    <link rel="stylesheet" href="../css/default.css" type="text/css">
    <link rel="stylesheet" href="../css/BDwrite.css" type="text/css">
</head>
<body>
<jsp:include page="../inc/nav.jsp"/>
<%
    int num = Integer.parseInt(request.getParameter("num"));
    DriveDAO driveDAO = new DriveDAO();
    DriveBean driveBean = driveDAO.getDrive(num);

    String id = (String)session.getAttribute("id");
    if(id == null) {
%>
<script type="text/javascript">
    alert("로그인 하세요!");
    location.href="../member/loginForm.jsp";
</script>
<%
    } else if (!id.equals(driveBean.getId())){
%>
<script type="text/javascript">
    alert("접근할 수 없습니다.");
    history.back();
</script>
<%
    }
%>

<section>
    <form action="driveUpdatePro.jsp" method="post">
        <div class="write">
            <fieldset>
                <input type="hidden" name="num" value="<%=num%>">
                <h2>Drive Update</h2><hr>
                <input type="text" name="id" class="text" value="<%=driveBean.getId()%>" readonly>
                <input type="password" name="pass2" class="text" placeholder="PASSWORD CHECK" required><br>
                <input type="text" name="title" class="board_title" value="<%=driveBean.getTitle()%>" required><br>
                <hr>
                <input type="file" name="file" value="<%=driveBean.getFile()%>"> <br>
                <hr>
                <textarea name="content" cols="30" rows="5" class="board_content">
                    <%=driveBean.getContent()%>
                </textarea><br>

                <input type="button" value="수정 취소" onclick="location.href='driveMain.jsp'"
                       class="button" style="float: right">
                <input type="submit" value="수정 완료" class="button" style="float: right">
            </fieldset>
        </div>
    </form>
</section>

<jsp:include page="../inc/footer.jsp"/>
</body>


</html>
