package com.ideacreator.idea;

import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ideacreator.idea.attachment.AttachmentDAO;
import com.ideacreator.ideadetails.IdeaDetail;
import com.ideacreator.ideadetails.IdeaDetailDAO;
import com.ideacreator.user.UserInfo;

public class IdeaController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		int idea_id = -1;
		String ideaTitle = req.getParameter("qTitle");
		String ideaDesc = req.getParameter("qDescription");
		IdeaDetailDAO push = new IdeaDetailDAO();
		Boolean editing = Boolean.valueOf(req.getParameter("edited"));
		HttpSession session = req.getSession();
		UserInfo user = (UserInfo) session.getAttribute("loggedInUser");
		IdeaDetail idea = new IdeaDetail();
		if(editing){
			idea=(IdeaDetail) session.getAttribute("ideaDetail");
			idea_id=idea.getIdea_Id();
			idea.setTitle(ideaTitle);
			idea.setDescritpion(ideaDesc);
			push.updateIdea(idea,user);
		}else{
		idea.setTitle(ideaTitle);
		idea.setDescritpion(ideaDesc);
		DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		Date date = new Date();
		idea.setPostedOn(dateFormat.format(date));
		/*
		 * Create the two different states for idea: Draft: on Click of Save
		 * button Idea: On Click of Submit for Review button
		 */
			idea.setIdea_state_id(7);
			idea_id = push.setIdea(idea, user);
		}

		AttachmentDAO attachment = new AttachmentDAO();
		@SuppressWarnings("unchecked")
		List<String> fileNames = (List<String>) session.getAttribute("attachments");
		if (fileNames != null && idea_id!=-1) {
			for (String file_name : fileNames) {
				attachment.addAttachment(idea_id, file_name);
			}
		}
		session.removeAttribute("attachments");
		req.getRequestDispatcher("viewIdea.jsp?viewId=" + idea_id).forward(req, resp);

	}

}
