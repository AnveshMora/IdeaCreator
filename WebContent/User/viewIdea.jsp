<%@page import="com.ideacreator.idea.comment.CommentVO"%>
<%@page import="com.ideacreator.idea.attachment.AttachmentDAO"%>
<%@page import="java.util.List"%>
<%@page import="com.ideacreator.idea.IdeaDAO"%>
<%@page import="com.ideacreator.user.UserDAO"%>
<%@page import="com.ideacreator.user.UserInfo"%>
<%@page import="com.ideacreator.ideadetails.IdeaDetailDAO"%>
<%@page import="com.ideacreator.ideadetails.IdeaDetail"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:include page="outline.jsp" />
<link rel="stylesheet" href="/IdeaCreator/css/attachment.css">
<%
	IdeaDetailDAO obj = new IdeaDetailDAO();
	int id = Integer.parseInt(request.getParameter("viewId"));
	IdeaDetail detail = obj.getIdea(id);
	session.setAttribute("ideaDetail", detail);
	UserInfo user = (UserInfo) session.getAttribute("loggedInUser");
	AttachmentDAO attachments = new AttachmentDAO();
	List<String> fileNames = attachments.getAttachments(id);
%>
<script type="text/javascript">
<!--
	//-->
	function ideaUpVote() {
		var xhttp = new XMLHttpRequest();
		var formData = new FormData();
		formData.append("upVote", 1);
		xhttp.onreadystatechange = function() {
			if (xhttp.readyState == 4 && xhttp.status == 200) {
				document.getElementById("voteCount").innerHTML = voteCount + 1;
				document.getElementById("ideaUpVote").remove();
				this.style.visibility = false;
			}
		}

		xhttp.open("POST", "ViewIdeaController", true);
		xhttp.send(formData);
	}

	function ideaStateChange() {
		var xhttp = new XMLHttpRequest();
		var formData = new FormData();
		var changedState = document.getElementById("stateChangeButton").innerText;
		var currentState = document.getElementById("currentState").innerText;
		formData.append("state", changedState.trim());
		formData.append("currentState", currentState);
		xhttp.onreadystatechange = function() {
			if (xhttp.readyState == 4 && xhttp.status == 200) {
				document.getElementById("currentState").innerText = "["
						+ xhttp.responseText + "]";
			}
		}
		xhttp.open("POST", "ViewIdeaController", true);
		xhttp.send(formData);
	}

	function addComment() {
		var xhttp = new XMLHttpRequest();
		var formData = new FormData();
		formData.append("comment", userComment);
		xhttp.onreadystatechange = function() {
			if (xhttp.readyState == 4 && xhttp.status == 200) {
				document.getElementById("userComment").innerHTML = xhttp.responseText;
			}
		}
		xhttp.open("POST", "ViewIdeaController", true);
		xhttp.send(formData);
	}

	function toggleFlagIdea() {
		var xhttp = new XMLHttpRequest();
		var formData = new FormData();
		formData.append("flagIdeaId",
<%=id%>
	);
		xhttp.onreadystatechange = function() {
			if (xhttp.readyState == 4 && xhttp.status == 200) {
				if (document.getElementById("ideaFlag").className == "fa fa-flag") {
					document.getElementById("ideaFlag").className = "fa fa-flag-o";
				} else {
					document.getElementById("ideaFlag").className = "fa fa-flag";
				}
			}
		}
		xhttp.open("POST", "ViewIdeaController", true);
		xhttp.send(formData);
	}
</script>
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
	<!-- Content Header (Page header) -->
	<section class="content-header">
	<h1>
		<i
			class=<%if (IdeaDAO.isIdeaFlaged(user.getUserId(), id) == 0) {
				out.print("\"fa fa-flag-o\"");
			} else {
				out.print("\"fa fa-flag\"");
			}%>
			id="ideaFlag" onclick="return toggleFlagIdea()"></i> View Idea <small>#<%=detail.getIdea_Id()%></small>
		Vote #<small id="voteCount"><%=IdeaDAO.getUpVoteCount(id)%></small>
	</h1>
	<ol class="breadcrumb">

		<%
			if (UserDAO.isReviewer(user)) {
				out.print(
						"<button class=\"pull-right btn btn-primary\" style=\"margin-top:-10px;\" onclick=\"ideaStateChange()\">Go</button>");
				out.print("<div class=\"dropdown pull-right\" style=\"margin-top:-10px;\">"
						+ "<button class=\"btn btn-primary dropdown-toggle\" type=\"button\" data-toggle=\"dropdown\" id=\"stateChangeButton\">"
						+ "---Idea States--- <span class=\"caret\"></span></button>");
				out.print("&nbsp;&nbsp;");
				out.print("<ul class=\"dropdown-menu\">");
				List<String> items = IdeaDAO.getIdeaStates();
				for (String item : items) {
					out.print("<li><a href=\"#\">" + item + "</a></li>");
				}
				out.print("</ul>");
				out.print("</div>");

			}
			IdeaDetailDAO ideaDetail = new IdeaDetailDAO();
			IdeaDetail idea = ideaDetail.getIdea(id);
			if (user.getUserId() == idea.getPostedUserId()) {
				out.print("<a href=\"/IdeaCreator/User/editIdea.jsp?viewId=" + id
						+ "\" class=\"btn btn-primary\" id=\"editIdea\"style=\"margin-top: -10px;\">"
						+ "<i class=\"glyphicon glyphicon-edit\" ></i>Edit</a>");
			}
			if (!UserDAO.alreadyVoted(user, id) && user.getUserId() != idea.getPostedUserId()) {
				out.print("<button class=\"btn btn-primary\" id=\"ideaUpVote\"style=\"margin-top: -10px;\""
						+ "onclick=\"ideaUpVote()\">WoW</button>");
			}
		%>


		<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
		<li class="active">View Idea</li> &nbsp;&nbsp;
	</ol>

	</section>
	<!-- Main content -->
	<section class="invoice"> <!-- title row -->
	<div class="row">
		<div class="col-xs-12">
			<h2 class="page-header">
				<i class="fa fa-globe"></i>
				<%
					out.print(detail.getTitle() + "&nbsp;<small id=\"currentState\">[" + detail.getIdea_state() + "]</small>");
				%>
				<small class="pull-right" style="position: relative; top: -25px;">Post
					Date: <%=detail.getPostedOn()%></small>
			</h2>
		</div>
		<!-- /.col -->
	</div>
	<!-- info row -->
	<div class="row">
		<div class="col"><%=detail.getDescritpion()%></div>
		<!-- /.col -->
	</div>

	</section>

	<section class="invoice">
	<div class="row">
		<div class="col-xs-12">
			<h2 class="page-header">Attachments</h2>
		</div>
		<!-- /.col -->
	</div>
	<!-- info row -->

	<div class="row">
		<div class="col">
			<%
				if (fileNames.isEmpty()) {
					out.print("No Attachments Found!");
				} else {
					for (String fileName : fileNames) {
						int index = fileName.lastIndexOf(".");
						String displayFileName = fileName;
						String tempFileExt = "";
						if (index > 0) {
							displayFileName = (fileName.substring(0, fileName.lastIndexOf(".")));
							displayFileName = displayFileName.replaceAll(Integer.toString(id), "");
							displayFileName = displayFileName.length() > 25 ? displayFileName.substring(0, 25).concat("...")
									: displayFileName;
							tempFileExt = fileName.substring(fileName.lastIndexOf("."));
						}
						out.println("<div class=\"attachment\" title=\"Click to Download the Attachment!\">" + "<p>"
								+ displayFileName + tempFileExt + "</p>" + "<div class=\"overlay\">"
								+ "<a href=\"DownloadAttachment?fileName=" + fileName
								+ "\" style\"text-decoration: none;color:back;\""
								+ "<button class=\".btn glyphicon glyphicon-download-alt\" title=\"Preview/Delete Attachment\" style=\"margin-left:20px; margin-top:20px\"></button></a>"
								+ "<button class=\".btn glyphicon glyphicon-trash\" style=\"margin-left:20px; margin-top:20px\" title=\"Delete Attachment\"></button>"
								+ "</div>" + "</div>");

					}
				}
			%>
		</div>
		<!-- /.col -->
	</div>
	</section>

	<section class="invoice">
	<div class="row">
		<div class="col-xs-12">
			<h2 class="page-header">Comments</h2>
		</div>
		<!-- /.col -->
	</div>
	<!-- info row -->

	<div class="row">
		<div class="input-group">
			<input type="text" id="userComment"
				class="form-control input-sm chat-input"
				placeholder="Comments Starts here..." /> <span
				class="input-group-btn" onclick="addComment()"> <a href="#"
				class="btn btn-primary btn-sm"><span
					class="glyphicon glyphicon-comment"></span> Add Comment</a>
			</span>
		</div>
		<%
			List<CommentVO> comments = IdeaDAO.getComments(id);
			if (comments.isEmpty()) {
				out.print("<p>No Comments till Now!!</p>");
			}
			for (CommentVO comment : comments) {
				out.print("<div class=\"bubble\">" + "<div class=\"bubble-heading\">" + "<strong>"
						+ comment.getCommentedBy() + "</strong></div>");
				//out.print("<span class=\"text-muted\">commented 5 days ago</span>");
				out.print("<p class=\"comment\" align=\"left\">" + comment.getCommentDesc() + "</p></div>");
			}
		%>
		<!-- /.col -->
	</div>
	</section>
	<!-- /.content -->
	<div class="clearfix"></div>
</div>
<!-- /.content-wrapper -->

<jsp:include page="footer.jsp" />