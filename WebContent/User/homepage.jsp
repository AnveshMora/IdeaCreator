<%@page import="com.ideacreator.ideadetails.IdeaDetail"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="com.ideacreator.user.UserInfo"%>
<%@page import="com.ideacreator.ideadetails.IdeaDetailDAO"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:include page="outline.jsp" />

<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
	<!-- Content Header (Page header) -->
	<section class="content-header">
	<h1>Dashboard</h1>
	<ol class="breadcrumb">
		<li><a><i class="fa fa-dashboard"></i> Home</a></li>
	</ol>
	</section>

	<!-- Main content -->
	<section class="content"> <!-- Info boxes -->
	<div class="row">
	<%UserInfo user= (UserInfo)session.getAttribute("loggedInUser");
	Map<String, Integer> dashBoardCounts= IdeaDetailDAO.getAggrInfo(user.getUserId()); %>
		<div class="col-md-3 col-sm-6 col-xs-12">
			<div class="info-box">
				<span class="info-box-icon bg-aqua" style="background-image: url('/IdeaCreator/dist/img/idea.png'); background-position: center;"><i
					class="ion" style="background-image: url('/IdeaCreator/dist/img/idea.jpg');"></i></span>
				<div class="info-box-content">
					<span class="info-box-text">Idea's Posted</span> <span
						class="info-box-number"><%= dashBoardCounts.containsKey("ideas")?dashBoardCounts.get("ideas"):"N/A" %>
						</span>
				</div>
				<!-- /.info-box-content -->
			</div>
			<!-- /.info-box -->
		</div>
		<!-- /.col -->
		<div class="col-md-3 col-sm-6 col-xs-12">
			<div class="info-box">
				<span class="info-box-icon bg-red" style="background-image: url('/IdeaCreator/dist/img/vote.png'); background-position: center;"><i
					class="fa" ></i></span>
				<div class="info-box-content">
					<span class="info-box-text">Votes</span> <span
						class="info-box-number"><%= dashBoardCounts.containsKey("upvotes")?dashBoardCounts.get("upvotes"):"N/A" %></span>
				</div>
				<!-- /.info-box-content -->
			</div>
			<!-- /.info-box -->
		</div>
		<!-- /.col -->

		<!-- fix for small devices only -->
		<div class="clearfix visible-sm-block"></div>

		<div class="col-md-3 col-sm-6 col-xs-12">
			<div class="info-box">
				<span class="info-box-icon bg-green" style="background-image: url('/IdeaCreator/dist/img/comments.png'); background-position: center;"><i
					class="ion"></i></span>
				<div class="info-box-content">
					<span class="info-box-text" >Coments </span> <span class="info-box-number"><%= dashBoardCounts.containsKey("comments")?dashBoardCounts.get("comments"):"N/A" %></span>
				</div>
				<!-- /.info-box-content -->
			</div>
			<!-- /.info-box -->
		</div>
		<!-- /.col -->
	</div>
	<!-- /.row -->

	<div class="row">
		<div class="col-md-12">
			<div class="box">
				<div class="box-header with-border">
					<h3 class="box-title">Quick Actions</h3>
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
							<div class="input-group">
								<input type="text" name="qTitle" class="form-control"
									placeholder="Title" size='75px'>
							</div>
							<br />
							<div class="input-group">
								<input type="text" name="qComment" class="form-control"
									placeholder="Comments" size='75px'>
							</div>

						</div>
						<!-- /.col -->
						<div class="col-md-6">
							<div class="input-group">
								<textarea name="qDescriptiont" class="form-control" rows='4'
									cols='50' size='75px' placeholder="Description"></textarea>

							</div>
							<br />
							<div class="input-group">
								<button class="btn btn-primary">Quick Add</button>
								&nbsp;&nbsp;&nbsp;&nbsp;
								<button class="btn btn-primary">Quick Find</button>
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
					<h3 class="box-title">Recent Posted Ideas</h3>
					<div class="box-tools pull-right">
						<a href="/IdeaCreator/User/viewAllIdeas.jsp">View All</a>
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
										<th>Idea No.</th>
										<th>Title</th>
										<th>Description</th>
										<th>Status</th>
										<th>Posted On</th>
									</tr>
								</thead>
								<tbody>
								<%
										IdeaDetailDAO ideasList = new IdeaDetailDAO();
										List<IdeaDetail> list = null;
										list = ideasList.getRecentIdeas();
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
											out.print("<td>" + idea.getPostedOn() + "</td>");
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