<%@ page import="photo.PhotoDAO" %>
<%@ page import="photo.PhotoBean" %>
<%@ page import="java.text.SimpleDateFormat" %><%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2020-10-04
  Time: 오전 12:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Yejin_Photo_Contents</title>
    <link rel="stylesheet" href="../css/default.css" type="text/css">
    <link rel="stylesheet" href="../css/list.css" type="text/css">
</head>
<body>
<jsp:include page="../inc/nav.jsp"/>
<%
    request.setCharacterEncoding("utf-8");
    String id = (String) session.getAttribute("id");
    int num = Integer.parseInt(request.getParameter("num"));
    PhotoDAO photoDAO = new PhotoDAO();
    photoDAO.updateReadcount(num);
    PhotoBean photoBean = photoDAO.getPhoto(num);
    SimpleDateFormat sdf = new SimpleDateFormat("yy.MM.dd hh:mm");
%>

<section>
    <div class="write">
        <fieldset>
            <h2><%=photoBean.getTitle()%></h2>
            <p><span><%=photoBean.getId()%></span> &nbsp; <%=sdf.format(photoBean.getDate())%></p>
            <hr>
            <pre class="memo"><%=photoBean.getContent()%></pre>
            <hr>
            <p><a href="/photoUpload/<%=photoBean.getFile()%>">
                <img src="../photoUpload/<%=photoBean.getFile()%>" alt="" width="auto" height="300">
            </a></p>
            <hr>

            <input type="button" value="List" onclick="location.href='photoMain.jsp'"
                   class="button" style="float: right">
            <%
            if(id != null) {
                if(id.equals(photoBean.getId())) {
            %>
                <input type="submit" value="Delete"  onclick="location.href='photoDeleteForm.jsp?num=<%=photoBean.getNum()%>'"
            class="button" style="float: right">
            <input type="submit" value="Update"  onclick="location.href='photoUpdateForm.jsp?num=<%=photoBean.getNum()%>'"
                   class="button" style="float: right">
            <%
                }
            }
            %>
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
    <noscript>Please enable JavaScript to view the <a href="https://disqus.com/?ref_noscript">comments powered by Disqus.</a></noscript>
</section>

<jsp:include page="../inc/footer.jsp"/>
</body>
</html>
