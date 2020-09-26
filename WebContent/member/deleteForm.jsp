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
    String id = (String) session.getAttribute("id");
%>
<section style="text-align: center">
    <form action="deletePro.jsp" method="post">
        <h1><%=id%> 님, 정보를 삭제 하시겠습니까?</h1>
        <p> 삭제 후 복구는 불가합니다. <br> <strong>신중하게 선택하세요.</strong></p>
        <br> <hr>  <br>
        <p>삭제를 원하신다면 비밀번호를 입력하세요. <br></p>
        <input type="text" name="pass" class="text" placeholder="PASSWORD CHECK">
        <br><br><br> <hr>  <br>
        <input type="submit" value="회원삭제" class="button">
        <input type="button" value="회원삭제취소" class="button">
    </form>
</section>

<jsp:include page="../inc/footer.jsp"/>
</body>


</html>
