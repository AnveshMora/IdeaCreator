<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@page import="com.ideacreator.user.UserInfo"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:include page="outline.jsp" />
<
<script type="text/javascript">
<!--
	//-->
	function Edit() {
	
	var phone = document.getElementById("phone").value;
	var email = document.getElementById("email").value;
	if(phone.length < 10 || phone.length > 10)
	{
	alert("Phone number should be 10 digits");
    return false;
	}
	if(email == "")
    {
    alert("Enter email ");
    return false;
    }
    else if(email.indexOf('@')==-1)
    {
    alert("Use @ email correctly");
    return false;
    }
    else if(email.indexOf('.')==-1)
    {
    alert("Use . email correctly");
    return false;
    }
    return true;
}
</script>
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
	<!-- Content Header (Page header) -->
	<section class="content-header">
	<h1>User Profile</h1>
	<ol class="breadcrumb">
		<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
		<li class="active">Profile</li>
	</ol>
	</section>
	<form action="/IdeaCreator/User/ProfileController" method="post" onsubmit="return Edit();">
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
						  <input type="text" name="uname" id="uname" class="form-control"
						  value="<%=((UserInfo)session.getAttribute("loggedInUser")).getUserName() %>" readonly /><br />
						</div>
						<!-- /.col -->
					</div>
					<!-- /.row -->
					<div class="row">
						<div class="col-md-5" align="center">
							   <label>First Name:</label>
					    </div>
						<div class="col-md-5">	   
						   <input type="text" name="fname" id="fname" class="form-control"
					        value="<%=((UserInfo)session.getAttribute("loggedInUser")).getFirstName()%>"/><br />
						</div>
						<!-- /.col -->
					</div>
					<!-- /.row -->
					<div class="row">
						<div class="col-md-5" align="center">
							   <label>Last Name:</label>
					    </div>
						<div class="col-md-5" >	   
							 <input type="text" name="lname" id="lname" class="form-control"
								value="<%=((UserInfo)session.getAttribute("loggedInUser")).getLastName()%>" /><br />
						</div>
						<!-- /.col -->
					</div>
					<!-- /.row -->
					<div class="row">
						<div class="col-md-5" align="center">
							   <label>Email: </label>
					    </div>
						<div class="col-md-5" >	   
							<input type="text" name="email" id="email" class="form-control"
								value="<%=((UserInfo)session.getAttribute("loggedInUser")).getEmailId()%>" /><br />
						</div>
						<!-- /.col -->
					</div>
					<!-- /.row -->
					<div class="row">
						<div class="col-md-5" align="center">
							   <label>Phone: </label>
					    </div>
						<div class="col-md-4" >	   
							<input type="text" name="phone" id="phone" class="form-control" id="qUser"
								value="<%=((UserInfo)session.getAttribute("loggedInUser")).getPhone()%>" />
									</div>
						<!-- /.col -->
						<div class="col-md-12" align="center">
							<div class="input-group" >
								<br><button class="btn btn-primary" onclick="return Edit()">Save</button><br/>
							</div>
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