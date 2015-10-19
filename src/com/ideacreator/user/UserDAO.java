package com.ideacreator.user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.ideacreator.connection.DataManager;
import com.ideacreator.constants.DataBaseConstants;
import com.ideacreator.constants.UserRoles;
import com.ideacreator.util.PropertyUtil;

public class UserDAO {
	public boolean validateLogin(UserInfo user) {
		DataManager driver = new DataManager();
		try {
			driver.createConnection();
			Connection con = driver.getConnection();
			PreparedStatement st = con.prepareStatement(DataBaseConstants.QUERY_USER_VALIDATION);
			st.setString(1, user.getUserName());
			st.setString(2, user.getPassWord());
			if (st.execute()) {
				ResultSet rs = st.getResultSet();
				while (rs.next()) {
					return true;
				}
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}

	public UserInfo getUserDetails(String userName) {
		// TODO Auto-generated method stub
		DataManager driver = new DataManager();
		try {
			driver.createConnection();
			Connection con = driver.getConnection();
			PreparedStatement st = con.prepareStatement(DataBaseConstants.QUERY_USER_DETAILS);
			st.setString(1, userName);
			if (st.execute()) {
				ResultSet rs = st.getResultSet();
				UserInfo userDetails = new UserInfo();
				while (rs.next()) {
					userDetails.setUserId(rs.getInt("user_id"));
					userDetails.setUserName(rs.getString("user_name"));
					userDetails.setEmailId(rs.getString("email_id"));
					userDetails.setRoleId(rs.getInt("role_id"));
					userDetails.setFirstName(rs.getString("first_name"));
					userDetails.setLastName(rs.getString("last_name"));
					userDetails.setPhone(rs.getString("mobile_no"));
				}
				return userDetails;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

	public static boolean isReviewer(UserInfo user) {
		if (user.getRoleId() == PropertyUtil.getUserRole(UserRoles.REVIEWER)) {
			return true;
		}
		return false;
	}

	public static boolean alreadyVoted(UserInfo user, int ideaId) {
		DataManager driver = new DataManager();
		Connection con = null;
		try {
			driver.createConnection();
			con = driver.getConnection();
			PreparedStatement st = con.prepareStatement(DataBaseConstants.QUERY_RETRIEVE_USER_UPVOTE);
			st.setInt(1, user.getUserId());
			st.setInt(2, ideaId);
			if (st.execute()) {
				ResultSet rs = st.getResultSet();
				if (rs.next()) {
					if (rs.getInt(1) > 0)
						return true;
				}
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return false;
	}
	
	public JsonArray getUsersArray(){
		JsonArray userDetails = new JsonArray();
		DataManager driver = new DataManager();
		try {
			driver.createConnection();
			Connection con = driver.getConnection();
			PreparedStatement st = con.prepareStatement(DataBaseConstants.QUERY_ALL_USER_DETAILS);
			if (st.execute()) {
				ResultSet rs = st.getResultSet();
				while (rs.next()) {
					JsonObject obj= new JsonObject();
					obj.addProperty("userId", rs.getString("user_id"));
					obj.addProperty("userName", rs.getString("user_name"));
					userDetails.add(obj);
				}
				return userDetails;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
}
