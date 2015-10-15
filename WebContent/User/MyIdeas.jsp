<%@page import="com.ideacreator.user.UserInfo"%>
<%@page import="com.ideacreator.ideadetails.IdeaDetail"%>
<%@page import="java.util.List"%>
<%@page import="com.ideacreator.ideadetails.IdeaDetailDAO"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:include page="outline.jsp" />

<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
	<!-- Content Header (Page header) -->
	<section class="content-header">
	<h1>My Ideas</h1>
	<ol class="breadcrumb">
		<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
		<li class="active">My Ideas</li>
	</ol>
	</section>

	<!-- Main content -->
	<section class="content"> <!-- Info boxes -->
	<div class="row">
		<div class="col-md-12">
			<div class="box">
				<div class="box-header with-border">
					<h3 class="box-title">Ideas Entered</h3>
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
						<div class="col-xs-12 table-responsive">
							<table class="table table-striped">
								<thead>
									<tr>
										<th>Idea No</th>
										<th>Idea</th>
										<th>Description</th>
										<th>Status</th>
										<th>Action <a href="/IdeaCreator/User/viewAllIdeas.jsp">View All</a></th>
									</tr>
								</thead>
								<tbody>
									<%
										IdeaDetailDAO ideasList = new IdeaDetailDAO();
										UserInfo user = (UserInfo) session.getAttribute("loggedInUser");
										List<IdeaDetail> list = null;
										list = ideasList.getIdeas(Integer.toString(user.getUserId()));
										if(list.size()<0){
											out.print("<tr>No Ideas Retrieved/ Found!</tr>");
										}
										for (IdeaDetail idea : list) {
											out.print("<tr>");
											out.print("<td>"
													+ idea.getIdea_Id() + "</td>");
											out.print("<td><a href=\"/IdeaCreator/User/viewIdea.jsp?viewId=" + idea.getIdea_Id() + "\">" + idea.getTitle() + "</a></td>");
											out.print("<td>" + idea.getDescritpion() + "</td>");
											out.print("<td>" + idea.getIdea_state() + "</td>");
											out.print("<td><span class=\"glyphicon glyphicon-trash\"" + "onclick=\"\"></span></td>");
											out.print("</tr>");
										}
									%>
								</tbody>
							</table>
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
	<!-- /.row --> </section>
	<!-- /.content -->
</div>
<!-- /.content-wrapper -->

<jsp:include page="footer.jsp" />