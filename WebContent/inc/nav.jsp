<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<header>
	<nav class="navbar">
		<h1><a href="../member/main.jsp">YJ/</a></h1>
		<ul class="navbar_menu">
			<li><a href="/about/aboutMain.jsp">About</a></li>
			<li><a href="/board/boardMain.jsp">Board</a></li>
			<li><a href="/drive/driveMain.jsp">Drive</a></li>
			<li><a href="/photo/photoMain.jsp">Photo</a></li>
		</ul>
		<ul class="navbar_icons">
			<%
				String id = (String)session.getAttribute("id");
				if(id==null) {
			%>
			<li><a href="../member/loginForm.jsp">Login</a></li>
			<li><a href="../member/joinForm.jsp">Join</a></li>
			<%
				} else {
			%>

			<li><a href="../member/logout.jsp">Logout</a></li>
			<li><a href="../member/updateForm.jsp">Setting</a></li>
			<%
				}
			%>
		</ul>
	</nav>
</header>