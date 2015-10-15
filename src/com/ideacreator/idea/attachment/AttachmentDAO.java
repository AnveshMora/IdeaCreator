package com.ideacreator.idea.attachment;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.ideacreator.connection.DataManager;
import com.ideacreator.constants.DataBaseConstants;

public class AttachmentDAO {

	public List<String> attachments = new ArrayList<String>();

	public  List<String> getAttachments(int idea_id) {
		DataManager dm = new DataManager();
		if (attachments.isEmpty()) {

			try {
				dm.createConnection();
				Connection con = dm.getConnection();
				PreparedStatement st = con.prepareStatement(DataBaseConstants.QUERY_IDEA_ATTACHMENTS);
				st.setInt(1, idea_id);
				ResultSet rs=st.executeQuery();
				while (rs.next()) {
					attachments.add(rs.getString("ATTACHMENT_URL").toString());
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return attachments;
	}

	public List<String> addAttachment(int idea_id, String file_name) {
		DataManager dm = new DataManager();
		if (attachments.isEmpty()) {

			try {
				dm.createConnection();
				Connection con = dm.getConnection();
				PreparedStatement st = con.prepareStatement(DataBaseConstants.QUERY_IDEA_ADD_ATTACHMENT);
				st.setInt(1, idea_id);
				st.setString(2, file_name);
				st.executeQuery();
				/*
				 * Move files uploaded to temp to actual server folder
				 */

			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return attachments;
	}
}
