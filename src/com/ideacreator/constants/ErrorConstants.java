package com.ideacreator.constants;

/**
 * Contains the constants to be used for the login application
 * 
 * @author Anvesh Mora
 * 
 */
public class ErrorConstants {

	/**
	 * The error message property file
	 */
	public static final String ERRORMESSAGES = "errormessages";

	/**
	 * The login page
	 */
	public static final String LOGINPAGE = "login.jsp";
	/**
	 * 
	 */
	public static final String ADMINPAGE = "adminhome.jsp";
	/**
	 * The add course page
	 */
	public static final String ADDCOURSE = "addIdea.jsp";
	/**
	 * The error page which is to be shown on fatal errors
	 */
	public static final String ERRORPAGE = "error.jsp";
	/**
	 * The error code for fatal error
	 */
	public static final String FATALERROR = "500";
	/**
	 * Error message key for invalid user
	 */

	public static final String INVALIDUSERNAME = "510";
	/**
	 * Error message key for invalid password
	 */
	public static final String INVALIDPASSWORD = "511";
	/**
	 * The error message key for empty Idea Title
	 */
	public static final String TITLE_EMPTY = "520";
	/**
	 * The error message key for empty Idea description
	 */
	public static final String DESCRIPTION_EMPTY = "521";
	/**
	 * The error message key for Idea description text size
	 * It should be minimum 100
	 */
	public static final String DESCRIPTION_SIZE_LIMIT = "522";
}
