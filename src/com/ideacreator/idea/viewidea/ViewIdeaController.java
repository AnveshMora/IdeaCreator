package com.ideacreator.idea.viewidea;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.ideacreator.connection.DataManager;
import com.ideacreator.constants.DataBaseConstants;
import com.ideacreator.ideadetails.IdeaDetail;
import com.ideacreator.ideadetails.IdeaDetailDAO;
import com.ideacreator.user.UserInfo;

public class ViewIdeaController extends HttpServlet {

	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		IdeaDetail ideaDetail = (IdeaDetail) session.getAttribute("ideaDetail");
		UserInfo user = (UserInfo) session.getAttribute("loggedInUser");
		PrintWriter out = resp.getWriter();
		boolean isMultipart = ServletFileUpload.isMultipartContent(req);
		resp.setContentType("text/html");
		DiskFileItemFactory factory = new DiskFileItemFactory();
		ServletFileUpload upload = new ServletFileUpload(factory);
		List fileItems;
		String fieldname = "";
		String fieldvalue = "";
		try {
			fileItems = upload.parseRequest(req);
			Iterator i = fileItems.iterator();
			if (i.hasNext()) {
				FileItem fi = (FileItem) i.next();
				if (fi.isFormField()) {
					fieldname = fi.getFieldName();
					fieldvalue = fi.getString();
				}
			}
		} catch (FileUploadException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if (fieldname.equalsIgnoreCase("upVote")) {
			// update Up Vote
			String query = DataBaseConstants.QUERY_ADD_VOTE.substring(0, DataBaseConstants.QUERY_ADD_VOTE.indexOf('?'));
			query = query.concat(Integer.toString(user.getUserId()) + ",");
			query = query.concat(Integer.toString(ideaDetail.getIdea_Id()) + ")");
			DataManager dm = new DataManager();
			int rs = dm.executeQuery(query);
			if (rs > 0)
				out.print(1);
		}
		if (fieldname.equalsIgnoreCase("state")) {
			// Move the state
			String query = DataBaseConstants.QUERY_IDEA_UPDATE_STATE.substring(0,
					DataBaseConstants.QUERY_IDEA_UPDATE_STATE.lastIndexOf('?'));
			String idea_state_id = "";
			fieldvalue = fieldvalue.replace('[', ' ');
			fieldvalue = fieldvalue.replace(']', ' ');
			fieldvalue = fieldvalue.trim();
			if (fieldvalue.equalsIgnoreCase("Idea")) {
				idea_state_id = "1";
			} else if (fieldvalue.equalsIgnoreCase("Concept Candidate")) {
				idea_state_id = "2";
			} else if (fieldvalue.equalsIgnoreCase("Concept")) {
				idea_state_id = "3";
			} else if (fieldvalue.equalsIgnoreCase("Project")) {
				idea_state_id = "4";
			} else if (fieldvalue.equalsIgnoreCase("Closed")) {
				idea_state_id = "5";
			} else if (fieldvalue.equalsIgnoreCase("Abandoned")) {
				idea_state_id = "6";
			}
			query = query.replace("?", idea_state_id);
			query = query.concat(Integer.toString(ideaDetail.getIdea_Id()));
			DataManager dm = new DataManager();
			int rs = dm.executeQuery(query);
			if (rs > 0)
				out.print(fieldvalue);
		}
		if (fieldname.equalsIgnoreCase("comment")) {
			// insert comment
			String query = DataBaseConstants.QUERY_INSERT_COMMENT.substring(0,
					DataBaseConstants.QUERY_INSERT_COMMENT.indexOf('?'));
			query = query.concat("\'" + fieldvalue + "\'" + ",");
			query = query.concat(Integer.toString(ideaDetail.getIdea_Id()) + ",");
			query = query.concat(Integer.toString(user.getUserId()) + ",");
			query = query.concat("null" + ")");
			DataManager dm = new DataManager();
			int rs = dm.executeQuery(query);
			if (rs > 0){
				out.print("<div class=\"bubble\">" + "<div class=\"bubble-heading\">" + "<strong>"
						+ user.getUserName() + "</strong></div>");
				//out.print("<span class=\"text-muted\">commented 5 days ago</span>");
				out.print("<p class=\"comment\" align=\"left\">" + fieldvalue + "</p></div>");
			}
		}
		
		if (fieldname.equalsIgnoreCase("flagIdeaId")) {
			// insert comment
			String query = DataBaseConstants.QUERY_RETRIEVE_IDEA_FLAG;
			
			DataManager dm = new DataManager();
			Connection con=null;
			try {
				dm.createConnection();
				con=dm.getConnection();
				PreparedStatement st= con.prepareStatement(query);
				st.setInt(1, user.getUserId());
				st.setInt(2, Integer.parseInt(fieldvalue));
				ResultSet rs = st.executeQuery();
				if(rs.next()){
					//update the toggle flag
					int flag=rs.getInt(1);
					st.close();
					st=con.prepareStatement(DataBaseConstants.QUERY_IDEA_FLAG_TOGGLE);
					st.setInt(1, flag^1);
					st.setInt(2, user.getUserId());
					st.setInt(3, Integer.parseInt(fieldvalue));
					st.execute();
					
				}else{
					//insert the flag with value 1
					st=con.prepareStatement(DataBaseConstants.QUERY_IDEA_FLAG_NEW);
					st.setInt(1, user.getUserId());
					st.setInt(2, Integer.parseInt(fieldvalue));
					//1-idea is flagged, 0- un flagged
					st.setInt(3, 1);
					st.execute();
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				if(con!=null){
					try {
						con.close();
					} catch (SQLException e1) {
						// TODO Auto-generated catch block
						e1.printStackTrace();
					}
				}
				e.printStackTrace();
			}
			
		}
	}

}
