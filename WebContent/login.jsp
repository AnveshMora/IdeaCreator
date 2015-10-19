<%@page import="com.ideacreator.constants.ErrorConstants"%>
<%@page import="com.ideacreator.util.PropertyUtil"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript">
function checkLogin() {
	
	<%

	if(session.getAttribute("loggedInUser")!=null){
		out.print("alert(\"redirecting to HomePage!\")");
		response.sendRedirect("User/homepage.jsp");
	}
	%>
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="css/style.css" media="screen"
	type="text/css" />
<title>Login |Idea Creator</title>
</head>
<body onload="checkLogin()">
	<form method="post" action="LoginController">
		<br /> <br /> <br /> <br /> <br /> <br /> <br /> <br />
		<table style="margin-left: 13%;">
		<tr style="background-color: #ECF0F1"><td >
		<img src="/IdeaCreator/dist/img/ATeam_FinalLogoTotal.png" style="height:310px;">
		</td>
		<td>
		<div class="login-wrap" >
			<h2>Login</h2>
			<br />
			<%
				String message = session.getAttribute("message") != null ? session.getAttribute("message").toString() : "";
				out.print("<div class=\"error_message_login\" id=\"error_message_login\"");

				if (!message.isEmpty()) {
					out.print( ">"+PropertyUtil.getErrorMessage(ErrorConstants.INVALIDPASSWORD) );
					session.invalidate();
				} else
					out.print("style=\"display: none\">Please enter both username and password");
				out.print("</div>");
			%>

			<div class="form" >
				<input type="text" placeholder="Username" name="un" id="un" /> <input
					type="password" placeholder="Password" name="pw" id="pw" />
				<button id="submit">Log in</button>

			</div>
		</div>
		</td>
		</tr>
		</table>
	</form>
	<script src='http://codepen.io/assets/libs/fullpage/jquery.js'></script>

	<script src="js/index.js"></script>
	<script src="js/my.js"></script>
</body>
</body>
</html>