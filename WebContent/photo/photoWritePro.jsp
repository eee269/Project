<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="member.MemberDAO" %>
<%@ page import="photo.PhotoDAO" %>
<%@ page import="photo.PhotoBean" %>
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
    request.setCharacterEncoding("utf-8");
    String realPath = "C:\\Users\\USER\\eclipse-workspace\\ProjectPersonal\\WebContent\\photoUpload";
    System.out.print(realPath);
    int maxSize = 10*1024*1024;
    MultipartRequest multi = new MultipartRequest(request, realPath, maxSize, "utf-8", new DefaultFileRenamePolicy());

    String id = multi.getParameter("id");
    String pass = multi.getParameter("pass2");
    String title = multi.getParameter("title");
    String content = multi.getParameter("content");
    Timestamp date = new Timestamp(System.currentTimeMillis());
    int readcount = 0;
    String file = multi.getFilesystemName("file");

    MemberDAO mdao = new MemberDAO();
    int check = mdao.userCheck(id, pass);

    PhotoDAO photoDAO = new PhotoDAO();
    PhotoBean photoBean = new PhotoBean();

    switch (check) {
        case 1:
            photoBean.setId(id);
            photoBean.setPass(pass);
            photoBean.setTitle(title);
            photoBean.setContent(content);
            photoBean.setDate(date);
            photoBean.setReadcount(readcount);
            photoBean.setFile(file);

            photoDAO.insertPhoto(photoBean);
%>
<script type="text/javascript">
    alert("게시글이 작성되었습니다.");
    location.href="photoMain.jsp";
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
    location.href="../member/loginForm.jsp";
</script>
<%
    }
%>
</body>
</html>