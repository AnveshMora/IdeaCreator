package com.ideacreator.ideadetails;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.ideacreator.connection.DataManager;
import com.ideacreator.constants.DataBaseConstants;
import com.ideacreator.user.UserInfo;

public class IdeaDetailDAO {
	public final int USERNAME = 1;
	public final int TITLE = 2;
	public final int DESCRIPTION = 3;
	public final int COMMENT = 4;
	private IdeaDetail idea = null;
	private List<IdeaDetail> ideasList = null;

	public IdeaDetail getIdea(int ideaId) {
		DataManager driver = new DataManager();
		Connection con=null;
		try {
			driver.createConnection();
			con = driver.getConnection();
			PreparedStatement st = con.prepareStatement(DataBaseConstants.QUERY_IDEA_DETAIL);
			st.setInt(1, ideaId);
			ResultSet rs = st.executeQuery();
			IdeaDetail idea = new IdeaDetail();
			while (rs.next()) {
				idea.setIdea_Id(rs.getInt("idea_id"));
				idea.setTitle(rs.getString("title"));
				idea.setDescritpion(rs.getString("description"));
				idea.setIdea_state(rs.getString("state"));
				idea.setPostedUserId(rs.getInt("user_id"));
				idea.setPostedOn(rs.getString("posted_on"));
			}
			return idea;
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
		}

		return null;
	}

	public List<IdeaDetail> getIdeas(HttpServletRequest request) {
		DataManager driver = new DataManager();
		Connection con=null;
		DiskFileItemFactory factory = new DiskFileItemFactory();
		ServletFileUpload upload = new ServletFileUpload(factory);
		List fileItems;
		String title = "";
	    String desc = "";
	    String comment = "";
	    String user="";
		try {
			fileItems = upload.parseRequest(request);
			Iterator i = fileItems.iterator();
			while (i.hasNext()) {
				FileItem fi = (FileItem) i.next();
				if (fi.isFormField()) {
					if(fi.getFieldName().equals("title")){
						title = fi.getString();
					}
					if(fi.getFieldName().equals("description")){
						desc = fi.getString();
					}
					if(fi.getFieldName().equals("comment")){
						comment = fi.getString();
					}
					if(fi.getFieldName().equals("user")){
						user = fi.getString();
					}
				}
			}
		} catch (FileUploadException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		 
			if(title==null)title="";
			if(desc==null)desc="";
			if(comment==null)comment="";
			StringTokenizer tokenTitle = new StringTokenizer(title.trim());
			StringTokenizer tokenDesc = new StringTokenizer(desc.trim());
			StringTokenizer tokenComment = new StringTokenizer(comment.trim());
			int titlecount=tokenTitle.countTokens();
			int desccount=tokenDesc.countTokens();
			int commentcount=tokenComment.countTokens();
			
		    try {
		    	driver.createConnection();
				con=driver.getConnection();
				StringBuffer query=new StringBuffer("select * from idea");
				if(title!=null){
					query.append(" where (lower(title) like ?");
				}
				for(int i=0;i<titlecount-1;i++){
					query.append(" or lower(title) like ?");
					
				}
				query.append(" ) ");
				
				
				if(desc!=null){
					query.append(" and (lower(description) like ?");
				}
				
				for(int i=0;i<desccount-1;i++){
					query.append(" or lower(description) like ? ");
					
				}
				query.append(" ) ");
			
				
				/*if(comment!=null){
					query.append(" and lower(comment)=\'%"+comment.toLowerCase().trim()+"%\'");
				}*/
				System.out.println("query="+query.toString());
				PreparedStatement stmt=con.prepareStatement(query.toString());
		        
				 tokenTitle = new StringTokenizer(title.trim());
				 tokenDesc = new StringTokenizer(desc.trim());
				 tokenComment = new StringTokenizer(comment.trim());
				
				int param=0;
				
				if(tokenTitle.countTokens()==0)
				stmt.setString(++param, "%"+title.toLowerCase().trim()+"%");
				else{
					 while (tokenTitle.hasMoreTokens()) {
						stmt.setString(++param, "%"+tokenTitle.nextToken()+"%");
						
					}
				}
				if(tokenDesc.countTokens()==0)
				stmt.setString(++param, "%"+desc.toLowerCase().trim()+"%");
				else{
						 while (tokenDesc.hasMoreTokens()) {
						stmt.setString(++param, "%"+tokenDesc.nextToken()+"%");
						
					}
					
				}
				ResultSet rs=stmt.executeQuery();
				ideasList= new ArrayList<IdeaDetail>();
				
				int rows=0;
				while(rs.next()){
					IdeaDetail    idea = new IdeaDetail();
					idea.setIdea_Id(rs.getInt("idea_id"));
					idea.setTitle(rs.getString("title"));
					idea.setDescritpion(rs.getString("description"));
					idea.setIdea_state(rs.getString("idea_state_id"));
					idea.setPostedUserId(rs.getInt("user_id"));
					idea.setPostedOn(rs.getString("posted_on"));
					ideasList.add(idea);
					rows++;
				}
				if(rows==0){
					
				}
				else{
					
				}
					
		    }catch(Exception e){
		    	System.out.println(e.getMessage());
		    	
		    }
		   finally {
		  try {
			con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		   }
		
		return ideasList;

		
	}

	public List<IdeaDetail> getIdeas(String value) {
		DataManager driver = new DataManager();
		Connection con=null;
		try {
			driver.createConnection();
			con = driver.getConnection();
			PreparedStatement st = null;
			// retrieve using UserName
			st = con.prepareStatement(DataBaseConstants.QUERY_MYIDEAS_USER_IDEA_DETAIL);
			st.setInt(1, Integer.parseInt(value));
			ResultSet rs = st.executeQuery();
			ideasList = new ArrayList<IdeaDetail>();

			while (rs.next()) {
				idea = new IdeaDetail();
				idea.setIdea_Id(rs.getInt("idea_id"));
				idea.setTitle(rs.getString("title"));
				idea.setDescritpion(rs.getString("description"));
				idea.setIdea_state(rs.getString("state"));
				idea.setPostedOn(rs.getString("posted_on"));
				idea.setPostedUserId(rs.getInt("user_id"));
				ideasList.add(idea);
			}
			return ideasList;
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
		}

		return null;
	}
	
	public List<IdeaDetail> getRecentIdeas() {
		DataManager driver = new DataManager();
		Connection con =null;
		try {
			driver.createConnection();
			con = driver.getConnection();
			PreparedStatement st = null;
			// retrieve using UserName
			st = con.prepareStatement(DataBaseConstants.QUERY_RECENT_IDEA_DETAIL);
			ResultSet rs = st.executeQuery();
			ideasList = new ArrayList<IdeaDetail>();

			while (rs.next()) {
				idea = new IdeaDetail();
				idea.setIdea_Id(rs.getInt("idea_id"));
				idea.setTitle(rs.getString("title"));
				idea.setDescritpion(rs.getString("description"));
				idea.setIdea_state(rs.getString("state"));
				idea.setPostedOn(rs.getString("posted_on"));
				idea.setPostedUserId(rs.getInt("user_id"));
				ideasList.add(idea);
			}
			return ideasList;
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
		}

		return null;
	}
	
	public List<IdeaDetail> getIdeas() {
		DataManager driver = new DataManager();
		Connection con=null;
		try {
			driver.createConnection();
			con = driver.getConnection();
			PreparedStatement st = null;
			// retrieve using UserName
			st = con.prepareStatement(DataBaseConstants.QUERY_ALL_IDEA_DETAIL);
			ResultSet rs = st.executeQuery();
			ideasList = new ArrayList<IdeaDetail>();

			while (rs.next()) {
				idea = new IdeaDetail();
				idea.setIdea_Id(rs.getInt("idea_id"));
				idea.setTitle(rs.getString("title"));
				idea.setDescritpion(rs.getString("description"));
				idea.setIdea_state(rs.getString("state"));
				idea.setPostedOn(rs.getString("posted_on"));
				idea.setPostedUserId(rs.getInt("user_id"));
				ideasList.add(idea);
			}
			return ideasList;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return null;
	}

	public int setIdea(IdeaDetail idea, UserInfo user) {
		DataManager driver = new DataManager();
		int idea_id=0;
		Connection con=null;
		try {
			driver.createConnection();
			con = driver.getConnection();
			String generatedColumns[] = {"Idea_Id"};
			PreparedStatement st = con.prepareStatement(DataBaseConstants.QUERY_ADD_IDEA,generatedColumns);
			st.setInt(1, user.getUserId());
			st.setString(2, idea.getTitle());
			st.setString(3, idea.getDescritpion());
			st.setInt(4, idea.getIdea_state_id());
			if (st.executeUpdate()>0){
				System.out.println("inserted an new Idea to system!!");
				ResultSet generatedKeys=st.getGeneratedKeys();
				if (null != generatedKeys && generatedKeys.next()) {
					idea_id=generatedKeys.getInt(1);
					return idea_id;
				}
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
		}

		return idea_id;
	}
	
	public static Map<String, Integer>  getAggrInfo(int userId){
		Map<String, Integer> counts=null;
		DataManager driver = new DataManager();
		Connection con=null;
		try {
			driver.createConnection();
			con = driver.getConnection();
			PreparedStatement st = con.prepareStatement(DataBaseConstants.QUERY_DASHBOARD_COUNTS);
			st.setInt(1, userId);
			st.setInt(2, userId);
			st.setInt(3, userId);
			ResultSet rs = st.executeQuery();
			if (rs.next()){
				counts=new HashMap<String,Integer>();
				counts.put("ideas", rs.getInt(1));
				counts.put("comments", rs.getInt(2));
				counts.put("upvotes", rs.getInt(3));
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
		}
		return counts;
	}
}
