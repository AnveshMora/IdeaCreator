<%@page import="java.util.List"%>
<%@page import="com.ideacreator.idea.IdeaDAO"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:include page="outline.jsp" />

<link rel="stylesheet" type="text/css" media="all"
	href="/IdeaCreator/css/autosearch.css">
<script type="text/javascript" src="/IdeaCreator/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript"
	src="/IdeaCreator/js/jquery.autocomplete.min.js"></script>
<script type="text/javascript" src="/IdeaCreator/js/autocompleter.js"></script>


<script type="text/javascript">
<!--
	//-->
	function searchIdea() {

		var xhttp = new XMLHttpRequest();
		var formData = new FormData();
		var user = document.getElementById("qUser").value;
		var title = document.getElementById("qTitle").value;
		var desc = document.getElementById("qDescription").value;
		var status = document.getElementById("idStatus").value;
		var comment = document.getElementById("qComment").value;
		if (title != undefined)
			formData.append("title", title);
		if (desc != undefined)
			formData.append("description", desc);
		if (comment != undefined)
			formData.append("comment", comment);
		if (user != undefined && !user.trim()=="")
			formData.append("user", user);
		if (status != undefined)
			formData.append("status", status);
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
		<li><a href="/IdeaCreator/User/homepage.jsp"><i class="fa fa-dashboard"></i> Home</a></li>
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
								placeholder="Title" id="qTitle" /> <br /> <input type="text"
								name="qComment" class="form-control" placeholder="Comments"
								id="qComment" /> <br />
							<%
								out.print(
										"<select class='btn btn-primary selectpicker' style='margin-top:-10px;' data-style='btn-primary' id='idStatus'>");
								out.print("&nbsp;&nbsp;");
								List<String> items = IdeaDAO.getIdeaStates();
								for (String item : items) {
									out.print("<option>" + item + "</option>");
								}
								out.print("</select>");
							%>
						</div>
						<!-- /.col -->
						<div class="col-md-6">
							<input type="text" name="qDescription" class="form-control"
								placeholder="Description" size='75px' id="qDescription" /> <br />
							<input type="text" name="qUser" class="form-control" id="qUser"
								placeholder="Posted User" /> <br />
							<div class="row">
								<div class="col-md-6">
									<input type='text' class="form-control" name="fromDate"
										placeholder="From Date" id='fromDatepicker' />
									<script type="text/javascript">
										$(function() {
											$('#fromDatepicker').datepicker();
										});
									</script>
								</div>
								<div class="col-md-6">
									<input type='text' class="form-control" name="toDate"
										placeholder="To Date" id='toDatepicker' />
									<script type="text/javascript">
										$(function() {
											$('#toDatepicker').datepicker();
										});
									</script>
								</div>
								
								<div class="input-group pull-right">
								<br/>
									<button class="btn btn-primary" onclick="searchIdea()">Search</button>
								</div>


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