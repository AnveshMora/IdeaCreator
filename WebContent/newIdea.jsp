<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>|
	Dashboard</title>
<!-- Tell the browser to be responsive to screen width -->
<meta
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"
	name="viewport">
<!-- Bootstrap 3.3.5 -->
<link rel="stylesheet" href="/IdeaCreator/bootstrap/css/bootstrap.min.css">
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
<link rel="stylesheet" href="/IdeaCreator/dist/css/skins/_all-skins.min.css">

<link rel="stylesheet" href="/IdeaCreator/css/bubble-style.css">
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
				<button data-toggle="modal" data-target="#reviewerDialog"
					onclick="ideaValidation()">Submit For Review</button>
				<!-- Modal -->
				<div id="reviewerDialog" class="modal fade" role="dialog">
					<div class="modal-dialog">

						<!-- Modal content-->
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal">&times;</button>
								<h4 class="modal-title">Modal Header</h4>
							</div>
							<div class="modal-body">
								<input type="text" name="qAddReviewIds" id="qAddReviewIds"
									class="form-control" placeholder="(Optional) Enter Peer Reviewers">
								<label>Selected Peers :</label>
								<small><i>* Defaul Reviewers will be notifed!</i></small>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-default"
									data-dismiss="modal">Close</button>
							</div>
						</div>

					</div>
				</div>
			</div>
			<!-- /.col -->
		</div>
		</section>
	</form>
	<!-- /.content -->
	<div class="clearfix"></div>
</div>
<!-- /.content-wrapper -->

<footer class="main-footer">
	<strong>Copyright &copy; </strong> All rights reserved.
</footer>



<!-- ./wrapper -->

<!-- jQuery 2.1.4 -->
<script src="../plugins/jQuery/jQuery-2.1.4.min.js"></script>
<!-- Bootstrap 3.3.5 -->
<script src="../bootstrap/js/bootstrap.min.js"></script>
<!-- FastClick -->
<script src="../plugins/fastclick/fastclick.min.js"></script>
<!-- AdminLTE App -->
<script src="../dist/js/app.min.js"></script>

</body>
</html>