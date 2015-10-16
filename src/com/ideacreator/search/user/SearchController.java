package com.ideacreator.search.user;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.ideacreator.connection.DataManager;
import com.ideacreator.constants.DataBaseConstants;
import com.ideacreator.ideadetails.IdeaDetail;
import com.ideacreator.ideadetails.IdeaDetailDAO;
import com.ideacreator.user.UserDAO;
import com.ideacreator.user.UserInfo;

public class SearchController extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		UserDAO userInfo = new UserDAO();
		IdeaDetailDAO ideas = new IdeaDetailDAO();
		List<IdeaDetail> ideaList = new ArrayList<IdeaDetail>();
		ideaList = ideas.getIdeas(req);
		String response = "";
		if (ideaList.size() > 0)
			response += "<table class=\"table table-striped\"> <thead>" + "<tr>" + "<th>S.No</th>" + "<th>Idea</th>"
					+ "<th>Description</th>" + "</tr>" + "</thead><tbody>";
		for (IdeaDetail ideaDetail : ideaList) {

			response += "" + "<tr>" + "<td>" + ideaDetail.getIdea_Id() + "</td>"
					+ "<td> <a href=\"/IdeaCreator/User/viewIdea.jsp?viewId=" + ideaDetail.getIdea_Id() + "\" >"
					+ ideaDetail.getTitle() + "</a></td>" + "<td>" + ideaDetail.getDescritpion() + "</td>" + "</tr>";
			// userNameList.add(rs.getString("user_name"));
		}
		if (!response.isEmpty()) {
			response += "</tbody></table>";
		}
		resp.getWriter().println(response);

	}

}
