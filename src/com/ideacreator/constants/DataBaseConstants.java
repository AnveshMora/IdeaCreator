package com.ideacreator.constants;

/**
 * This class contains the constant declarations related to database
 * 
 * @author Anvesh Mora
 * 
 */
public class DataBaseConstants {
	/**
	 * The Database properties file
	 */
	public static final String DBPROPERTIES = "dataBase";
	/**
	 * Data base user name
	 */
	public static final String DATABASEUSERNAME = "database.username";
	/**
	 * Data base password
	 */
	public static final String DATABASEPASSWORD = "database.password";
	/**
	 * The type of data base the application uses
	 */
	public static final String DATABASETYPE = "database.databaseType";
	/**
	 * The SQL query for getting the user details for user validation
	 */
	public static final String QUERY_USER_VALIDATION = "select * from user_info where user_name=? and password=?";

	public static final String QUERY_USER_DETAILS = "select * from user_info where user_name=? ";

	public static final String QUERY_IDEA_DETAIL = "select * from idea, idea_states where idea.idea_id=? and idea.idea_state_id= idea_states.idea_state_id";

	// retrieve ideas where idea state and based on user id
	public static final String QUERY_MYIDEAS_USER_IDEA_DETAIL = "select * from idea, idea_states where idea.user_id=? and idea.idea_state_id= idea_states.idea_state_id";

	// retrieve ideas which are not in draft or idea state and based on user id
	public static final String QUERY_USER_IDEA_DETAIL = "select * from idea, idea_states where idea.user_id=? and idea.idea_state_id= idea_states.idea_state_id and idea.idea_state_id not in (1,7)";

	// retrieve ideas which are not in draft or idea state and based on
	// description
	public static final String QUERY_DESC_IDEA_DETAIL = "select * from idea, idea_states where idea.description in (?) and "
			+ "idea.idea_state_id= idea_states.idea_state_id and idea.idea_state_id not in (1,7)";

	// retrieve ideas which are not in draft or idea state and based on comments
	public static final String QUERY_CMNT_IDEA_DETAIL = "select * from idea, idea_states, comments where comments.comment_desc in (?) and "
			+ "comments.idea_state_id=idea.idea_state_id and idea.idea_state_id= idea_states.idea_state_id and idea.idea_state_id not in (1,7)";

	// retrieve ideas which are not in draft or idea state and based on idea
	// title
	public static final String QUERY_TITLE_IDEA_DETAIL = "select * from idea, idea_states where idea.title in (?) and "
			+ "idea.idea_state_id= idea_states.idea_state_id and idea.idea_state_id not in (1,7)";

	public static final String QUERY_ADD_IDEA = "insert into idea(idea_id,user_id,title,description,posted_on,idea_state_id) values(IDEA_SEQ.nextval,?,?,?,sysdate,?)";

	public static final String QUERY_USERNAME_INFO = "select user_id, user_name from user_info where user_id <> ?";

	public static final String QUERY_DASHBOARD_COUNTS = "select (select count(*) from idea where idea.user_id=?)  ideasCount,"
			+ "(select count(*) from comments where comments.idea_id in (select idea.idea_id from idea where idea.user_id=?))  CommentsCount, "
			+ "(select count(*) from upvotes where upvotes.idea_id in (select idea.idea_id from idea where idea.user_id=?))  upvoteCount from dual";

	public static final String QUERY_INSERT_COMMENT = "insert into comments(comment_id, comment_desc, idea_id, user_id, reply_id) values(comments_seq.nextval,?,?,?,?)";

	public static final String QUERY_SELECT_COMMENT = "select comments.comment_id, comments.comment_desc, comments.idea_id, user_info.user_name from "
			+ "comments, user_info where comments.user_id= user_info.user_id  and comments.idea_id=?";

	public static final String QUERY_ADD_VOTE = "insert into upvotes(vote_id,user_id,idea_id) values(upvote_seq.nextval,?,?)";

	public static final String QUERY_RETRIEVE_IDEA_UPVOTES = "SELECT COUNT(*) count from upvotes where idea_id=?";

	public static final String QUERY_RETRIEVE_USER_UPVOTE = "select count(*) VOTES from upvotes where user_id=? and idea_id=?";

	public static final String QUERY_IDEA_STATES = "select * from idea_states where idea_state_id<>7";

	public static final String QUERY_IDEA_ATTACHMENTS = "select * from attachments where idea_id=?";

	public static final String QUERY_IDEA_ADD_ATTACHMENT = "insert into attachments(attachment_id, idea_id,attachment_url) values(attachments_seq.nextval,?,?)";

	public static final String QUERY_IDEA_UPDATE_STATE = "update idea set idea_state_id=? where idea_id=?";

	public static final String QUERY_ALL_IDEA_DETAIL = "select * from idea, idea_states where idea.idea_state_id not in (1,7) and idea.idea_state_id= idea_states.idea_state_id";

	public static final String QUERY_RECENT_IDEA_DETAIL = "select * from idea, idea_states where idea.idea_state_id not in (1,7) and idea.idea_state_id= idea_states.idea_state_id and rownum <=10  order by posted_on desc";
	
	public static final String QUERY_IDEA_FLAG_NEW ="insert into idea_flags(user_id,idea_id,flag) values(?,?,?)";
	
	public static final String QUERY_RETRIEVE_IDEA_FLAG ="select flag from idea_flags where user_id=? and idea_id=?";
	
	public static final String QUERY_IDEA_FLAG_TOGGLE ="update idea_flags set flag=? where user_id=? and idea_id=?";
	public static final String QUERY_UPDATE_IDEA = "update idea set title=?, description=? where user_id=? and idea_id=?";
}
