<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="board.BoardReplyBean" %>
<%@ page import="drive.DriveDAO" %>
<%@ page import="drive.DriveBean" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Yejin_Board_Write</title>
    <link rel="stylesheet" href="../css/default.css" type="text/css">
    <link rel="stylesheet" href="../css/list.css" type="text/css">
    <link rel="stylesheet" href="../css/BDwrite.css" type="text/css">


</head>
<body>
<jsp:include page="../inc/nav.jsp"/>

<%
    request.setCharacterEncoding("utf-8");
    String id = (String) session.getAttribute("id");
    int num = Integer.parseInt(request.getParameter("num"));
    DriveDAO driveDAO = new DriveDAO();
    driveDAO.updateReadcount(num);
    DriveBean driveBean = driveDAO.getDrive(num);
    SimpleDateFormat sdf = new SimpleDateFormat("yy.MM.dd hh:mm");
%>

<section>
    <div class="write">
        <fieldset>
            <h2><%=driveBean.getTitle()%></h2>
            <p><span><%=driveBean.getId()%></span> &nbsp; <%=sdf.format(driveBean.getDate())%></p>
            <hr>
            <pre class="memo"><%=driveBean.getContent()%></pre>
            <hr>
            <p><a href="../driveUpload/<%=driveBean.getFile()%>"><%=driveBean.getFile()%></a></p>
            <hr>

            <input type="button" value="List" onclick="location.href='driveMain.jsp'"
                   class="button" style="float: right">
            <input type="submit" value="Delete"  onclick="location.href='driveDeleteForm.jsp?num=<%=driveBean.getNum()%>'"
                   class="button" style="float: right">
            <input type="submit" value="Update"  onclick="location.href='driveUpdateForm.jsp?num=<%=driveBean.getNum()%>'"
                   class="button" style="float: right">
        </fieldset>
    </div>
    <br>
    <div id="disqus_thread"><p> </p></div>
    <script>

        /**
         *  RECOMMENDED CONFIGURATION VARIABLES: EDIT AND UNCOMMENT THE SECTION BELOW TO INSERT DYNAMIC VALUES FROM YOUR PLATFORM OR CMS.
         *  LEARN WHY DEFINING THESE VARIABLES IS IMPORTANT: https://disqus.com/admin/universalcode/#configuration-variables*/

        var disqus_config = function () {
            this.page.url = PAGE_URL;  // Replace PAGE_URL with your page's canonical URL variable
            this.page.identifier = PAGE_IDENTIFIER; // Replace PAGE_IDENTIFIER with your page's unique identifier variable
        };

        (function() { // DON'T EDIT BELOW THIS LINE
            var d = document, s = d.createElement('script');
            s.src = 'https://yjboardproject.disqus.com/embed.js';
            s.setAttribute('data-timestamp', +new Date());
            (d.head || d.body).appendChild(s);
        })();
    </script>
    <noscript>Please enable JavaScript to view the </noscript>
</section><a href="https://disqus.com/?ref_noscript">comments powered by Disqus.</a>

<jsp:include page="../inc/footer.jsp"/>
</body>


</html>
