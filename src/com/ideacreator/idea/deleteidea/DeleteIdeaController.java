package com.ideacreator.idea.deleteidea;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Iterator;
import java.util.List;

import javax.servlet.RequestDispatcher;
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

public class DeleteIdeaController extends HttpServlet {

	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			IdeaDetailDAO deleteIdea= new IdeaDetailDAO();
			int ideaId= Integer.parseInt(req.getParameter("ideaId"));
			String redirectPage= req.getParameter("rd").toString();
			int deleted=deleteIdea.deleteIdea(ideaId);
			PrintWriter out =resp.getWriter();
			if (deleted>0){
				out.print("<script>alert('Idea:"+ideaId+", Delete!')</script>");
			}else{
				out.print("<script>alert('No Ideas found to Delete')</script>");
			}
			if(redirectPage.equals("view")){
				redirectPage="viewIdea.jsp";
			}else if(redirectPage.equals("my")){
				redirectPage="MyIdeas.jsp";
			}
			resp.sendRedirect(redirectPage);
//			RequestDispatcher dispatch = req.getRequestDispatcher(redirectPage);
//			dispatch.forward(req, resp);
		}
	}
