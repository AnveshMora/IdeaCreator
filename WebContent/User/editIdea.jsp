<%@page import="com.ideacreator.idea.IdeaDAO"%>
<%@page import="java.util.List"%>
<%@page import="com.ideacreator.idea.attachment.AttachmentDAO"%>
<%@page import="com.ideacreator.user.UserInfo"%>
<%@page import="com.ideacreator.ideadetails.IdeaDetail"%>
<%@page import="com.ideacreator.ideadetails.IdeaDetailDAO"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:include page="outline.jsp" />
<link rel="stylesheet" href="/IdeaCreator/css/attachment.css">
<%
	IdeaDetailDAO obj = new IdeaDetailDAO();
	int id = Integer.parseInt(request.getParameter("viewId"));
	IdeaDetail detail = obj.getIdea(id);
	IdeaDetail detail2 =(IdeaDetail)session.getAttribute("ideaDetail");
	session.setAttribute("ideaDetail", detail);
	UserInfo user = (UserInfo) session.getAttribute("loggedInUser");
	AttachmentDAO attachments = new AttachmentDAO();
	List<String> fileNames = attachments.getAttachments(id);
%>
<script>
	function myFunction() {
		var x = document.getElementById("myFile");
		var formData = new FormData();

		var txt = "";
		if ('files' in x) {
			if (x.files.length == 0) {
				alert("Select one or more files.");
			} else {
				for (var i = 0; i < x.files.length; i++) {

					var file = x.files[i];
					var xp = x.files[i];
					var formData = new FormData();
					formData.append("myFile", xp);
					if ('name' in file) {
						txt += "<a href=\"DownloadAttachment?fileName=";
						txt += file.name;
						txt += "\">" + file.name + "</a><br>";

						var xhttp = new XMLHttpRequest();
						xhttp
								.addEventListener(
										'progress',
										function(e) {
											var done = e.position || e.loaded, total = e.totalSize
													|| e.total;
											console
													.log('xhr progress: '
															+ (Math.floor(done
																	/ total
																	* 1000) / 10)
															+ '%');
											document.getElementById("progress").innerHTML = 'Progress: '
													+ (Math.floor(done / total
															* 1000) / 10) + '%';
										}, false);
						if (xhttp.upload) {
							xhttp.upload.onprogress = function(e) {
								var done = e.position || e.loaded, total = e.totalSize
										|| e.total;
								document.getElementById("progress").innerHTML = 'Progress: '
										+ (Math.floor(done / total * 1000) / 10)
										+ '%';
								console
										.log('xhr.upload progress: '
												+ done
												+ ' / '
												+ total
												+ ' = '
												+ (Math.floor(done / total
														* 1000) / 10) + '%');
							};
						}
						xhttp.onreadystatechange = function(e) {
							if (xhttp.readyState == 4 && xhttp.status == 200) {
								document.getElementById("attachments").innerHTML = document
										.getElementById("attachments").innerHTML
										+ xhttp.responseText;
								document.getElementById("progress").innerHTML = 'Upload Complete!!';
								console.log([ 'xhr upload complete', e ]);
							}
						};
						/*     xhttp.onreadystatechange = function() {
						 if (xhttp.readyState == 4 && xhttp.status == 200) {
						 document.getElementById("progress").innerHTML = xhttp.responseText;
						 document.getElementById("progress").innerHTML = txt;
						 }
						 xhr.setRequestHeader("Content-Type","multipart/form-data");
						 } */

						xhttp.open("POST", "UploadServlet", true);
						xhttp.send(formData);
					}
				}
			}
		}

	}
	function ideaValidation() {
		var validation = 0;
		var title = document.getElementById("qTitle").value;
		var desc = document.getElementById("qDescription").value;
		document.getElementById("alert-validation").innerHTML = "";
		if (title == undefined || title == null || title.trim() == "") {
			document.getElementById("alert-validation").innerHTML = "<span class=\"glyphicon glyphicon-warning-sign\" style=\"word-spacing:normal;\"/> Idea Title can't be empty!";
			document.getElementById("alert-validation").style.display = "block";
			validation += 1;
		}
		if (desc == undefined || desc == null || desc == "") {
			document.getElementById("alert-validation").innerHTML += "<span class=\"glyphicon glyphicon-warning-sign\"  style=\"word-spacing:normal;\" /> Idea Description can't be empty! </span>";
			document.getElementById("alert-validation").style.display = "block";
			validation += 1;
		}

		if (validation == 0) {
			document.getElementById("alert-validation").style.display = "none";
			return true;
		}
		return false;
	}

	function callAttachment() {
		var element = document.getElementById('myFile');
		element.click();
	}
</script>
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
	<!-- Content Header (Page header) -->
	<section class="content-header">
	<h1>
		Edit Idea <small>#<%=id%></small>
	</h1>
	<ol class="breadcrumb">
		<li><a href="/IdeaCreator/User/homepage.jsp"><i class="fa fa-dashboard"></i> Home</a></li>
		<li class="active">Edit Idea</li>
	</ol>
	</section>
	<form action="/IdeaCreator/User/IdeaController" method="post"
		onsubmit="return ideaValidation();">
		<!-- Main content -->
		<section class="content"> <!-- title row -->
		<div class="box">
			<div class="box-header with-border">
				<h3 class="box-title">Idea Details</h3>
				<div class="box-tools pull-right">
					<button class="btn btn-box-tool" data-widget="collapse">
						<i class="fa fa-minus"></i>
					</button>
				</div>
			</div>

			<div class="box-body">
				<div class="row">
					<div class="col-md-6">
						<div class="alert alert-warning" id="alert-validation"
							style="display: none; font-style: normal;"></div>
						<input type="text" name="qTitle" id="qTitle" class="form-control"
							placeholder="Title" width="100%" value=<%=detail.getTitle()%>
							onblur="ideaValidation()"> <br />
						<textarea name="qDescription" id="qDescription"
							class="form-control" rows='4' cols='50' size='75px'
							placeholder="Description" 
							onblur="ideaValidation()"><%=detail.getDescritpion()%></textarea>

					</div>

					<!-- /.col -->
				</div>

			</div>
		</div>
		<div class="box">
			<div class="box-header with-border">
				<h3 class="box-title">Attachments</h3>
				<div class="box-tools pull-right">
					<button class="btn btn-box-tool" data-widget="collapse">
						<i class="fa fa-minus"></i>
					</button>
				</div>
			</div>
			<div class="box-body">
				<!-- info row -->

				<div class="row">
					<div class="col-md-6">
						<input type="file" id="myFile" size="50" onchange="myFunction()"
							style="visibility: hidden;" multiple>
						<button class="btn btn-primary" id="ideaUpVote"
							onclick="return callAttachment()">
							<b>+</b>
						</button>
						<input type="hidden" name="edited" value="true"/>
						<p id="progress"></p>
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
			</div>
		</section>

		<section class="invoice">
		<div class="row">
			<div class="col-xs-12">
				<%
					if (detail.getIdea_state().equalsIgnoreCase("Saved")) {
						out.println("<button class=\"btn btn-primary\" onclick=\"return ideaValidation()\">Save</button>");
						out.println(
								"<button class=\"btn btn-primary\" onclick=\"return ideaValidation()\">Submit For Review</button>");
					} else {
						out.println("<button class=\"btn btn-primary\" onclick=\"return ideaValidation()\">Update</button>");
					}
				%>
			</div>
			<!-- /.col -->
		</div>
		</section>
	</form>
	<!-- /.content -->
	<div class="clearfix"></div>
</div>
<!-- /.content-wrapper -->

<jsp:include page="footer.jsp" />