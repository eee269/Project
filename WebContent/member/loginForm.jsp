<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>loginForm.jsp</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
</head>
<body>

<jsp:include page="../inc/nav.jsp"/>
<section>
    <form action="loginPro.jsp" method="post">
        <div class="left_notice">
            <h2>Login</h2>
            <p>이상이 있을 시에는<br>아래의 연락처로 연락해주세요.</p>
        </div>

        <div class="login">
            <fieldset style="padding-top: 100px">
                <input type="text" name="id" class="text" placeholder="ID"><br>
                <input type="password" name="pass1" class="text" placeholder="PASSWORD"><br><br>

                <input type="submit" value="로그인" class="button">
                <input type="button" value="회원가입" onclick="location.href='joinForm.jsp'" class="button">
            </fieldset>
        </div>
    </form>
</section>
<jsp:include page="../inc/footer.jsp"/>

</body>
</html>

