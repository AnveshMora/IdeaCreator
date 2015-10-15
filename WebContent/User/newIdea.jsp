<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:include page="outline.jsp" />
<link rel="stylesheet" href="/IdeaCreator/css/attachment.css">
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
							if (4 == this.readyState) {
								document.getElementById("attachments").innerHTML = document
										.getElementById("attachments").innerHTML
										+ this.responseText;
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
</script>
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
	<!-- Content Header (Page header) -->
	<section class="content-header">
	<h1>
		New Idea <small>#007612</small>
	</h1>
	<ol class="breadcrumb">
		<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
		<li class="active">New Idea</li>
	</ol>
	</section>
	<form action="/IdeaCreator/User/IdeaController" method="post" onsubmit="return ideaValidation();">
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
							placeholder="Title" width="100%" onblur="ideaValidation()">
						<br />
						<textarea name="qDescription" id="qDescription"
							class="form-control" rows='4' cols='50' size='75px'
							placeholder="Description" onblur="ideaValidation()"></textarea>

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
					<div class="col">
						<input type="file" id="myFile" multiple size="50"
							onchange="myFunction()">

						<p id="progress"></p>
						<div id="attachments" />

					</div>
					<!-- /.col -->
				</div>
			</div>
		</section>

		<section class="invoice">
		<div class="row">
			<div class="col-xs-12">
				<button onclick="return ideaValidation()">Save</button>
				<button onclick="return ideaValidation()">Submit For Review</button>
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