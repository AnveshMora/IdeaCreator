package com.ideacreator.login;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.catalina.connector.Request;

import com.ideacreator.user.UserDAO;
import com.ideacreator.user.UserInfo;
	
public class LoginController extends HttpServlet {

	
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		UserInfo user = new UserInfo();
		user.setUserName(req.getParameter("un"));
		user.setPassWord(req.getParameter("pw"));
		UserDAO authenticator = new UserDAO();
		HttpSession session= req.getSession();
		if(authenticator.validateLogin(user)){
			UserInfo userDetails=authenticator.getUserDetails(user.getUserName());
			session.setAttribute("loggedInUser", userDetails);
			/*session.setAttribute("loggedInUser", userDetails.getUserName());
			session.setAttribute("emailId", userDetails.getEmailId());
			session.setAttribute("roleId", userDetails.getRoleId());
			session.setAttribute("userId", userDetails.getUserId());*/
			RequestDispatcher reqDispatch=req.getRequestDispatcher("User/homepage.jsp");
			reqDispatch.forward(req, resp);
			return;
		}else{
			session.setAttribute("message", "Invalid login");
			RequestDispatcher reqDispatch=req.getRequestDispatcher(resp.encodeURL(""));
			resp.sendRedirect("");
		}
		
		
	}

}
