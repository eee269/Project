<%@ page import="java.sql.Timestamp" %>
<%@ page import="member.MemberDAO" %>
<%@ page import="drive.DriveDAO" %>
<%@ page import="drive.DriveBean" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    String realPath = request.getServletContext().getRealPath("driveUpload");
    int maxSize = 10*1024*1024;
    MultipartRequest multi = new MultipartRequest(request, realPath, maxSize, "utf-8", new DefaultFileRenamePolicy());

    int num = Integer.parseInt(multi.getParameter("num"));
    String id = multi.getParameter("id");
    String pass2 = multi.getParameter("pass2");
    String title = multi.getParameter("title");
    String content = multi.getParameter("content");
    Timestamp date = new Timestamp(System.currentTimeMillis());
    String file = multi.getParameter("file");

    MemberDAO mdao = new MemberDAO();
    int check = mdao.userCheck(id, pass2);

    DriveDAO driveDAO = new DriveDAO();
    DriveBean driveBean = new DriveBean();

    driveBean.setNum(num);
    driveBean.setId(id);
    driveBean.setPass(pass2);
    driveBean.setTitle(title);
    driveBean.setContent(content);
    driveBean.setDate(date);
    driveBean.setFile(file);

    switch (check) {
        case 1:
            driveDAO.updateDrive(driveBean);
%>
<script type="text/javascript">
    alert("게시글이 수정되었습니다.");
    location.href="contents.jsp?num=<%=num%>"
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
