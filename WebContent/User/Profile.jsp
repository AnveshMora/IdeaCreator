<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@page import="com.ideacreator.user.UserInfo"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:include page="outline.jsp" />
<
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
	<!-- Content Header (Page header) -->
	<section class="content-header">
	<h1>User Profile</h1>
	<ol class="breadcrumb">
		<li><a href="/IdeaCreator/User/homepage.jsp"><i class="fa fa-dashboard"></i> Home</a></li>
		<li class="active">Profile</li>
	</ol>
	</section>

	<!-- Main content -->
	<section class="content"> <!-- Info boxes -->
	<div class="row">
		<div class="col-md-12">
			<div class="box">
				<div class="box-header with-border">
					<h3 class="box-title">Profile</h3>
					<div class="box-tools pull-right">
						<button class="btn btn-box-tool" data-widget="collapse">
							<i class="fa fa-minus"></i>
						</button>
					</div>
				</div>
				<!-- /.box-header -->
				<div class="box-body">
				    <div class="col-sm-12">
				    <div class="row">
						<div class="col-md-5" align="center">
							   <label>User Name:</label>
					    </div>
						<div class="col-md-5">	   
							<%=((UserInfo)session.getAttribute("loggedInUser")).getUserName() %>
						</div>
						<!-- /.col -->
					</div>
					<!-- /.row -->
					<div class="row">
						<div class="col-md-5" align="center">
							   <label>First Name:</label>
					    </div>
						<div class="col-md-5">	   
							<%=((UserInfo)session.getAttribute("loggedInUser")).getFirstName() %>
						</div>
						<!-- /.col -->
					</div>
					<!-- /.row -->
					<div class="row">
						<div class="col-md-5" align="center">
							   <label>Last Name:</label>
					    </div>
						<div class="col-md-5">	   
							<%=((UserInfo)session.getAttribute("loggedInUser")).getLastName() %>
						</div>
						<!-- /.col -->
					</div>
					<!-- /.row -->
					<div class="row">
						<div class="col-md-5" align="center">
							   <label>Email: </label>
					    </div>
						<div class="col-md-5" >	   
						     <%=((UserInfo)session.getAttribute("loggedInUser")).getEmailId() %>
						</div>
						<!-- /.col -->
					</div>
					<!-- /.row -->
					<div class="row">
						<div class="col-md-5" align="center">
							   <label>Phone: </label>
					    </div>
						<div class="col-md-5" >	   
							 <%=((UserInfo)session.getAttribute("loggedInUser")).getPhone() %><br />
							 </div>
							 <!-- /.col -->
							<div class="pull-left">
							   <br> <a href="/IdeaCreator/User/editProfile.jsp" class="btn btn-default btn-flat">Edit</a>
							</div>
						</div>
					<!-- /.row -->
					</div>
					</div>
				</div>
				<!-- ./box-body -->

			</div>
			<!-- /.box -->
		</div>
		<!-- /.col -->
	</div>
	<!-- /.row -->

 </section>
	<!-- /.content -->
<!-- /.content-wrapper -->

<jsp:include page="footer.jsp" />