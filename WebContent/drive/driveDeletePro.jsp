<%@ page import="member.MemberDAO" %>
<%@ page import="drive.DriveDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>YEJIN_Drive_Delete</title>
</head>
<body>
<%
    int num = Integer.parseInt(request.getParameter("num"));
    String id = (String) session.getAttribute("id");
    String pass = request.getParameter("pass2");

    MemberDAO mdao = new MemberDAO();
    int check = mdao.userCheck(id, pass);

    switch (check) {
        case 1:
            DriveDAO driveDAO = new DriveDAO();
            driveDAO.deleteDrive(num, id);
//driveUpload에 있는 파일도 삭제해야할것같은디?
%>
<script type="text/javascript">
    alert("게시물이 삭제되었습니다.");
    location.href = "driveMain.jsp";
</script>
<%
        break;
    case 0:
%>
<script type="text/javascript">
    alert("비밀번호를 확인하세요");
    history.back();
</script>
<%
        break;
    case -1:
%>
<script type="text/javascript">
    alert("아이디를 확인하세요");
    history.back();
</script>
<%
    }
%>
</body>
</html>
