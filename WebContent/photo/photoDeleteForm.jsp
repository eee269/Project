<%@ page import="drive.DriveDAO" %>
<%@ page import="drive.DriveBean" %>
<%@ page import="photo.PhotoDAO" %>
<%@ page import="photo.PhotoBean" %>
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
    PhotoDAO photoDAO = new PhotoDAO();
    PhotoBean photoBean = photoDAO.getPhoto(num);

    String id = (String)session.getAttribute("id");
    if(id == null) {
%>
<script type="text/javascript">
    alert("로그인 하세요!");
    location.href="../member/loginForm.jsp";
</script>
<%
} else if (!id.equals(photoBean.getId())){
%>
<script type="text/javascript">
    alert("접근할 수 없습니다.");
    history.back();
</script>
<%
    }
%>


<section>
    <form action="photoDeletePro.jsp" method="post">
        <div class="write">
            <fieldset>
                <h2>Drive Delete</h2><hr>
                <input type="hidden" name="num" value="<%=num%>">
                <input type="text" name="id" class="text" value="<%=id%>" readonly>
                <input type="password" name="pass2" class="text" placeholder="PASSWORD CHECK" required><br>

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
