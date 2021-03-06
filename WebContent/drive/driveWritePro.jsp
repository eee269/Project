<%@ page import="member.MemberDAO" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="drive.DriveDAO" %>
<%@ page import="drive.DriveBean" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
</head>
<body>
<%
    String realPath = "C:\\Users\\USER\\eclipse-workspace\\ProjectPersonal\\WebContent\\driveUpload";
    System.out.println(realPath);
    int maxSize = 10*1024*1024;
    MultipartRequest multi = new MultipartRequest(request, realPath, maxSize, "utf-8", new DefaultFileRenamePolicy());

    String id = multi.getParameter("id");
    String pass2 = multi.getParameter("pass2");
    String title = multi.getParameter("title");
    String content = multi.getParameter("content");
    Timestamp date = new Timestamp(System.currentTimeMillis());
    int readcount = 0;
    String file = multi.getFilesystemName("file");
    System.out.println(file);

    MemberDAO mdao = new MemberDAO();
    int check = mdao.userCheck(id, pass2);

    DriveDAO driveDAO = new DriveDAO();
    DriveBean driveBean = new DriveBean();

    driveBean.setId(id);
    driveBean.setPass(pass2);
    driveBean.setTitle(title);
    driveBean.setContent(content);
    driveBean.setDate(date);
    driveBean.setReadcount(readcount);
    driveBean.setFile(file);

    switch (check) {
        case 1:
            driveDAO.insertDrive(driveBean);
            %>
            <script type="text/javascript">
                alert("게시글이 작성되었습니다.");
                location.href="driveMain.jsp"
            </script>
            <%
            break;
        case 0:
            %>
<script type="text/javascript">
    alert("비밀번호를 확인하세요.");
    history.back();
</script>
<%
            break;
        case -1:
%>
<script type="text/javascript">
    alert("잘못된 접근입니다. 다시 로그인 하세요.");
    location.href="../member/loginForm.jsp"
</script>
<%
    }
%>
</body>
</html>