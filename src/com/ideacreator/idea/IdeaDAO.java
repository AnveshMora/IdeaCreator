package com.ideacreator.idea;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.ideacreator.connection.DataManager;
import com.ideacreator.constants.DataBaseConstants;
import com.ideacreator.idea.comment.CommentVO;
import com.ideacreator.user.UserInfo;

public class IdeaDAO {
	public static List<String> ideaStates = new ArrayList<String>();

	public static List<String> getIdeaStates() {
		DataManager dm = new DataManager();
		if (ideaStates.isEmpty()) {

			try {
				dm.createConnection();
				Connection con = dm.getConnection();
				Statement st = con.createStatement();
				st.executeQuery(DataBaseConstants.QUERY_IDEA_STATES);
				ResultSet rs = st.getResultSet();

				while (rs.next()) {
					ideaStates.add(rs.getString("STATE").toString());
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return ideaStates;
	}

	public static List<CommentVO> getComments(int ideaId) {
		DataManager driver = new DataManager();
		Connection con = null;
		try {
			driver.createConnection();
			con = driver.getConnection();
			PreparedStatement st = con.prepareStatement(DataBaseConstants.QUERY_SELECT_COMMENT);
			st.setInt(1, ideaId);
			st.execute();

			ResultSet rs = st.getResultSet();
			if (rs.getFetchSize() > 0) {
				List<CommentVO> comments = new ArrayList<CommentVO>();
				while (rs.next()) {
					CommentVO comment = new CommentVO();
					comment.setCommentId(rs.getInt("comment_id"));
					comment.setCommentDesc(rs.getString("comment_desc"));
					comment.setIdeaId(rs.getInt("idea_id"));
					comment.setCommentedBy(rs.getString("user_name"));
					comments.add(comment);
				}
				return comments;
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
		return null;
	}

	public static int getUpVoteCount(int ideaId) {
		DataManager driver = new DataManager();
		Connection con = null;
		try {
			driver.createConnection();
			con = driver.getConnection();
			PreparedStatement st = con.prepareStatement(DataBaseConstants.QUERY_RETRIEVE_IDEA_UPVOTES);
			st.setInt(1, ideaId);
			st.execute();

			ResultSet rs = st.getResultSet();
			if (rs.getFetchSize() > 0) {
					rs.next();
					return rs.getInt("count");
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
		return 0;
	}
	
	public static int isIdeaFlaged(int userId,int ideaId) {
		DataManager driver = new DataManager();
		Connection con = null;
		try {
			driver.createConnection();
			con = driver.getConnection();
			PreparedStatement st = con.prepareStatement(DataBaseConstants.QUERY_RETRIEVE_IDEA_FLAG);
			st.setInt(1, userId);
			st.setInt(2, ideaId);
			st.execute();

			ResultSet rs = st.getResultSet();
			if (rs.getFetchSize() > 0) {
					rs.next();
					return rs.getInt("flag");
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
		return 0;
	}
}
