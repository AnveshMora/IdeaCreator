<%@page import="java.util.Iterator"%>
<%@page import="com.ideacreator.ideadetails.IdeaDetail"%>
<%@page import="java.util.List"%>
<%@page import="com.ideacreator.ideadetails.IdeaDetailDAO"%>
<%@page import="com.ideacreator.user.UserInfo"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title><%=((UserInfo) session.getAttribute("loggedInUser")).getUserName()%>|
	Dashboard</title>
<!-- Tell the browser to be responsive to screen width -->
<meta
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"
	name="viewport">
<!-- Bootstrap 3.3.5 -->
<link rel="stylesheet"
	href="/IdeaCreator/bootstrap/css/bootstrap.min.css">
<!-- Font Awesome -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
<!-- Ionicons -->
<link rel="stylesheet"
	href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
<!-- jvectormap -->
<link rel="stylesheet"
	href="/IdeaCreator/plugins/jvectormap/jquery-jvectormap-1.2.2.css">
<!-- Theme style -->
<link rel="stylesheet" href="/IdeaCreator/dist/css/AdminLTE.min.css">
<!-- AdminLTE Skins. Choose a skin from the css/skins
         folder instead of downloading all of them to reduce the load. -->
<link rel="stylesheet"
	href="/IdeaCreator/dist/css/skins/_all-skins.min.css">

<link rel="stylesheet" href="/IdeaCreator/css/bubble-style.css">
<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    
    
 
<link id="bsdp-css" href="/IdeaCreator/bootstrap-datepicker/css/datepicker3.css"
	rel="stylesheet">
<script src="/IdeaCreator/bootstrap-datepicker/js/bootstrap-datepicker.js"></script>
<script type="text/javascript">
	function checkLogin() {
<%if (session.getAttribute("loggedInUser") == null) {
				out.print("alert(\"redirecting to HomePage!\")");
				response.sendRedirect("login.jsp");
			}%>
	}

	function searchIdea() {

		var xhttp = new XMLHttpRequest();
		var formData = new FormData();
		var title = document.getElementById("qTitle").value;
		var desc = document.getElementById("qDescription").value;
		if (title != undefined)
			formData.append("title", title);
		xhttp.onreadystatechange = function() {
			if (xhttp.readyState == 4 && xhttp.status == 200) {
				document.getElementById("searchResult").innerHTML = xhttp.responseText;
			}
		}
		xhttp.open("POST", "SearchController", true);
		xhttp.send(formData);
	}
</script>
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script src="//code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
<script src="/IdeaCreator/js/autocompleter.js"></script>
</head>
<body class="hold-transition skin-yellow layout-boxed sidebar-mini"
	onload="checkLogin()">
	<div class="wrapper">
		<header class="main-header">
			<!-- Logo -->
			<a href="/IdeaCreator/User/homepage.jsp" > <!-- logo for regular state and mobile devices -->
			
			
<div class="logo">
					<div class="pull-left image" >
						<img src="/IdeaCreator/dist/img/ATeam_FinalLogoOnly.png"
							 class="img-circle" alt="Logo" style="width: 50px;height: 50px;margin-left:-15px; margin-top:5px">
					</div>
					<div>
						<span ><sup style="font-size: 30px; top:12px;left:-50px">
										<span style="color:#fc9027;">i</span>deaPlug
								</sup>
						</span>
						
						<span class="logo-lg" style="">
						<sub style=" font-size: 15px;top:23px;left:-24px"><font color=black>plug your <font style="color:#fc9027;">ideas</font> to</font> Model N</sub>
						</span>
					</div>
				</div>
				</a>
			<!-- Header Navbar: style can be found in header.less -->
			<nav class="navbar navbar-static-top" role="navigation">
				<!-- Sidebar toggle button-->
				<a href="#" class="sidebar-toggle" data-toggle="offcanvas"
					role="button"> <span class="sr-only">Toggle navigation</span>
				</a>
				<!-- Navbar Right Menu -->
				<div class="navbar-custom-menu">
					<ul class="nav navbar-nav">
						<!-- Messages: style can be found in dropdown.less-->
						<li class="dropdown messages-menu"><a href="#"
							class="dropdown-toggle" data-toggle="dropdown"> <i
								class="fa fa-envelope-o"></i> <span class="label label-success">4</span>
						</a>
							<ul class="dropdown-menu">
								<li class="header">You have 4 messages</li>
								<li>
									<!-- inner menu: contains the actual data -->
									<ul class="menu">
										<li>
											<!-- start message --> <a href="#">
												<div class="pull-left">
													<img src="/IdeaCreator/dist/img/user2-160x160.jpg"
														class="img-circle" alt="User Image">
												</div>
												<h4>
													Support Team <small><i class="fa fa-clock-o"></i> 5
														mins</small>
												</h4>
												<p>Why not buy a new awesome theme?</p>
										</a>
										</li>
										<!-- end message -->
									</ul>
								</li>
								<li class="footer"><a href="#">See All Messages</a></li>
							</ul></li>
						<!-- Notifications: style can be found in dropdown.less -->
						<li class="dropdown notifications-menu"><a href="#"
							class="dropdown-toggle" data-toggle="dropdown"> <i
								class="fa fa-bell-o"></i> <span class="label label-warning">10</span>
						</a>
							<ul class="dropdown-menu">
								<li class="header">You have 10 notifications</li>
								<li>
									<!-- inner menu: contains the actual data -->
									<ul class="menu">
										<li><a href="#"> <i class="fa fa-users text-aqua"></i>
												5 new Idea's posted today
										</a></li>
									</ul>
								</li>
								<li class="footer"><a href="#">View all</a></li>
							</ul></li>
						<!-- Tasks: style can be found in dropdown.less -->
						<%
							UserInfo user = (UserInfo) session.getAttribute("loggedInUser");
							List<IdeaDetail> ideas = IdeaDetailDAO.getFlaggedIdeas(user.getUserId());
						%>
						<li class="dropdown tasks-menu"><a href="#"
							class="dropdown-toggle" data-toggle="dropdown"
							data-target="#flaggedIdeas"> <i class="fa fa-flag-o"></i> <span
								class="label label-danger"><%=ideas.size()%></span>
						</a></li>
						<div id="flaggedIdeas" class="modal fade" role="dialog">
							<div class="modal-dialog">

								<!-- Modal content-->
								<div class="modal-content">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal">&times;</button>
										<h4 class="modal-title">Modal Header</h4>
									</div>
									<div class="modal-body">
										<%
											Iterator it = ideas.iterator();
											out.print("<div class='box-body'><!-- Table row -->" + "<div class='row'>"
													+ "<div class='col-xs-12 table-responsive'>" + "<table class='table table-striped'>" + "<thead>");
											if (!it.hasNext()) {
												out.print("<tr>No Ideas Flagged</tr>");
											} else {
												out.print(
														"<tr><th>Idea No</th><th>Idea</th><th>Description</th><th>Status</th><th>Posted on</th></tr></thead><tbody>");
												for (IdeaDetail idea : ideas) {

													out.print("<tr>");
													out.print("<td>" + idea.getIdea_Id() + "</td>");
													out.print("<td><a href=\"/IdeaCreator/User/viewIdea.jsp?viewId=" + idea.getIdea_Id() + "\">"
															+ idea.getTitle() + "</a></td>");
													out.print("<td>" + idea.getDescritpion() + "</td>");
													out.print("<td>" + idea.getIdea_state() + "</td>");
													out.print("<td>" + idea.getPostedOn() + "</td>");
													out.print("</tr>");

												}
											}

											out.print("</tbody></table></div><!-- /.col --></div><!-- /.row --></div>");
										%>
									</div>
									<div class="modal-footer">
										<button type="button" class="btn btn-default"
											data-dismiss="modal">Close</button>
									</div>
								</div>
							</div>
						</div>
						<!-- User Account: style can be found in dropdown.less -->
						<li class="dropdown user user-menu"><a href="#"
							class="dropdown-toggle" data-toggle="dropdown"> <img
								src="/IdeaCreator/dist/img/user2-160x160.jpg" class="user-image"
								alt="User Image"> <span class="hidden-xs"><%=((UserInfo) session.getAttribute("loggedInUser")).getUserName()%></span>
						</a>
							<ul class="dropdown-menu">
								<!-- User image -->
								<li class="user-header"><img
									src="/IdeaCreator/dist/img/user2-160x160.jpg"
									class="img-circle" alt="User Image">
									<p>
										<%=((UserInfo) session.getAttribute("loggedInUser")).getUserName()%>
									</p></li>
								<!-- Menu Footer-->
								<li class="user-footer">
									<div class="pull-left">
										<a href="/IdeaCreator/User/Profile.jsp"
											class="btn btn-default btn-flat">Profile</a>
									</div>
									<div class="pull-right">
										<a href="/IdeaCreator/LogOutController"
											class="btn btn-default btn-flat">Sign out</a>
									</div>
								</li>
							</ul></li>
					</ul>
				</div>

			</nav>
		</header>
		<!-- Left side column. contains the logo and sidebar -->
		<aside class="main-sidebar">
			<!-- sidebar: style can be found in sidebar.less -->
			<section class="sidebar">
				<!-- Sidebar user panel -->
				<div class="user-panel">
					<div class="pull-left image">
						<img src="/IdeaCreator/dist/img/user2-160x160.jpg"
							class="img-circle" alt="User Image">
					</div>
					<div class="pull-left info">
						<p><%=((UserInfo) session.getAttribute("loggedInUser")).getUserName()%></p>
					</div>
				</div>
				<!-- search form -->
				<form action="#" method="get" class="sidebar-form">
					<div class="input-group">
						<input type="text" name="q" class="form-control"
							placeholder="Search..."> <span class="input-group-btn">
							<button type="submit" name="search" id="search-btn"
								class="btn btn-flat">
								<i class="fa fa-search"></i>
							</button>
						</span>
					</div>
				</form>
				<!-- /.search form -->
				<!-- sidebar menu: : style can be found in sidebar.less -->
				<ul class="sidebar-menu">
					<li class="header">MAIN NAVIGATION</li>
					<%
						String uri = request.getRequestURI();
						uri = uri.substring(uri.lastIndexOf('/'));
					%>
					<li
						class="<%if (uri.equals("/homepage.jsp"))
				out.print("active ");%>treeview"><a
						href="/IdeaCreator/User/homepage.jsp"> <i
							class="fa fa-dashboard"></i> <span>Dashboard</span>
					</a></li>
					<li
						class="<%if (uri.equals("/newIdea.jsp"))
				out.print("active ");%>treeview"><a
						href="/IdeaCreator/User/newIdea.jsp"> <i
							class="fa fa-dashboard"></i> <span>New Idea</span>
					</a></li>
					<li
						class="<%if (uri.equals("/MyIdeas.jsp"))
				out.print("active ");%>treeview"><a
						href="/IdeaCreator/User/MyIdeas.jsp"> <i
							class="fa fa-dashboard"></i> <span>My Ideas</span>
					</a></li>
					<li
						class="<%if (uri.equals("/searchIdea.jsp"))
				out.print("active ");%>treeview"><a
						href="/IdeaCreator/User/searchIdea.jsp"> <i
							class="fa fa-dashboard"></i> <span>Search Idea</span>
					</a></li>
					<li
						class="<%if (uri.equals("/viewAllIdeas.jsp"))
				out.print("active ");%>treeview"><a
						href="/IdeaCreator/User/viewAllIdeas.jsp"> <i
							class="fa fa-dashboard"></i> <span>View All Ideas</span>
					</a></li>
				</ul>
			</section>
			<!-- /.sidebar -->
		</aside>