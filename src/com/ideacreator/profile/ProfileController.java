package com.ideacreator.profile;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ideacreator.connection.DataManager;
import com.ideacreator.constants.DataBaseConstants;
import com.ideacreator.user.UserInfo;

public class ProfileController extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(req,resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session= req.getSession();
		UserInfo user= (UserInfo) session.getAttribute("loggedInUser");
		String FirstName= req.getParameter("fname");
		String LastName= req.getParameter("lname");
		String Email= req.getParameter("email");
		String Phone= req.getParameter("phone");
		
		String queryText = "update user_info set first_name='"+FirstName+"',last_name='"+LastName+"',email_id='"+Email+"',Mobile_no='"+Phone+"' where user_id="+user.getUserId()+"";
			
		DataManager driver = new DataManager();
		Connection con=null;
		
		try {
			driver.createConnection();
			con = driver.getConnection();
			 Statement stat = con.createStatement();
	         stat.executeUpdate(queryText);
	         user.setEmailId(Email);
	         user.setFirstName(FirstName);
	         user.setLastName(LastName);
	     	 user.setPhone(Phone);
	         session.setAttribute("loggedInUser", user);
	     	 stat.close();
	         con.close();
		
				}
		
		catch (SQLException e) {
			// TODO Auto-generated catch block
			if(con!=null){
				try {
					con.close();
				} catch (SQLException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
			}
		}
		finally
		{
		RequestDispatcher reqDispatch=req.getRequestDispatcher("EditProfile.jsp");
		reqDispatch.forward(req, resp);
		}
	}

}
