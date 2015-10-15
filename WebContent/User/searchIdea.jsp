<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:include page="outline.jsp" />
<
<script type="text/javascript">
<!--
	//-->
	function searchIdea() {
		
		var xhttp = new XMLHttpRequest();
		var formData = new FormData();
		var user = document.getElementById("qUser").value;
		var title = document.getElementById("qTitle").value;
		var desc = document.getElementById("qDescription").value;
		var comment = document.getElementById("qComment").value;
		if (title !=undefined)
			formData.append("title", title);
		else if (desc!=undefined)
			formData.append("description", desc);
		else if (comment!=undefined)
			formData.append("comment", commment);
		else if (user!=undefined && !user.trim().equals(""))
			formData.append("user", user);
		xhttp.onreadystatechange = function() {
			if (xhttp.readyState == 4 && xhttp.status == 200) {
				document.getElementById("searchResult").innerHTML = xhttp.responseText;
			}
		}
		xhttp.open("POST", "SearchController", true);
		xhttp.send(formData);
	}
</script>
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
	<!-- Content Header (Page header) -->
	<section class="content-header">
	<h1>Search Idea</h1>
	<ol class="breadcrumb">
		<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
		<li class="active">Search Idea</li>
	</ol>
	</section>

	<!-- Main content -->
	<section class="content"> <!-- Info boxes -->
	<div class="row">
		<div class="col-md-12">
			<div class="box">
				<div class="box-header with-border">
					<h3 class="box-title">Search</h3>
					<div class="box-tools pull-right">
						<button class="btn btn-box-tool" data-widget="collapse">
							<i class="fa fa-minus"></i>
						</button>
					</div>
				</div>
				<!-- /.box-header -->
				<div class="box-body">
					<div class="row">
						<div class="col-md-6">
							<input type="text" name="qTitle" class="form-control"
								placeholder="Title" id="qTitle"/> <br /> <input type="text"
								name="qComment" class="form-control" placeholder="Comments" id="qComment"/>
						</div>
						<!-- /.col -->
						<div class="col-md-6">
							<input type="text" name="qDescription" class="form-control"
								placeholder="Description" size='75px' id="qDescription"/> <br /> <input
								type="text" name="qUser" class="form-control" id="qUser"
								placeholder="Posted User" /> <br />
							<div class="input-group">
								<button class="btn btn-primary" onclick="searchIdea()">Search</button>
							</div>


						</div>
						<!-- /.col -->
					</div>
					<!-- /.row -->
				</div>
				<!-- ./box-body -->

			</div>
			<!-- /.box -->
		</div>
		<!-- /.col -->
	</div>
	<!-- /.row -->

	<div class="row">
		<div class="col-md-12">
			<div class="box">
				<div class="box-header with-border">
					<h3 class="box-title">Ideas Found</h3>
					<div class="box-tools pull-right">
						<button class="btn btn-box-tool" data-widget="collapse">
							<i class="fa fa-minus"></i>
						</button>
					</div>
				</div>
				<!-- /.box-header -->
				<div class="box-body">
					<!-- Table row -->
					<div class="row">
						<div class="col-xs-12 table-responsive" id="searchResult"></div>
						<!-- /.col -->
					</div>
					<!-- /.row -->
				</div>
				<!-- ./box-body -->

			</div>
			<!-- /.box -->
		</div>
		<!-- /.col -->
	</div>
	<!-- /.row --> </section>
	<!-- /.content -->
</div>
<!-- /.content-wrapper -->

<jsp:include page="footer.jsp" />