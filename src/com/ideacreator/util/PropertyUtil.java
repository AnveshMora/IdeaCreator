package com.ideacreator.util;

import java.util.Locale;
import java.util.ResourceBundle;

import com.ideacreator.constants.DataBaseConstants;
import com.ideacreator.constants.ErrorConstants;
import com.ideacreator.constants.SuccessConstants;
import com.ideacreator.constants.UIConstants;
import com.ideacreator.constants.UserRoles;

/**
 * PropertyUtil class manages the reading of resource bundles from the
 * .properties files.
 * 
 * @author Anvesh Mora
 */
public class PropertyUtil {

	/**
	 * Accepts the filename of the property file and returns the bundle
	 * 
	 * @param filename
	 *            -The name of the property file from which the resource bundle
	 *            needs to be loaded.
	 * @returns ResourceBoundle object
	 */
	private static ResourceBundle getBundles(
			final String filename) {
		final Locale currentLocale = Locale.getDefault();
		return ResourceBundle.getBundle(filename, currentLocale);

	}

	/**
	 * Called by the BOs to get the success messages.Accepts the key as argument
	 * and returns the message as string by reading from the property file
	 * 
	 * @param key
	 *            -The key for which the messages is to be retrieved from the
	 *            properties file
	 * @return message as string
	 */
	public static String getSuccessMessage(final String key) {
		final ResourceBundle messages = getBundles(SuccessConstants.SUCCESSMESSAGES);
		return messages.getString(key);

	}

	/**
	 * Called by the BOs to get the error messages.Accepts the key as argument
	 * and returns the message as string by reading from the property file
	 * 
	 * @param key
	 *            -The key for which the messages is to be retrieved from the
	 *            properties file
	 * @return message as string
	 */
	public static String getErrorMessage(final String key) {
		final ResourceBundle messages = getBundles(ErrorConstants.ERRORMESSAGES);
		return messages.getString(key);

	}

	/**
	 * Called by the DataManager class to get the DataBase URL stored in the
	 * property file dataBase.properties
	 * 
	 * @return the database url
	 */
	public static String getDataBaseUrl() {
		final ResourceBundle url = getBundles(DataBaseConstants.DBPROPERTIES);
		return url.getString("database.url");
	}

	/**
	 * Called by the DataManager class to get the database user name stored in
	 * the property file dataBase.properties
	 * 
	 * @return database user name as string
	 */
	public static String getDataBaseUserName() {
		final ResourceBundle userName = getBundles(DataBaseConstants.DBPROPERTIES);
		return userName
				.getString(DataBaseConstants.DATABASEUSERNAME);
	}

	/**
	 * Called by the DataManager class to get the database password stored in
	 * the property file dataBase.properties
	 * 
	 * @return the database password
	 */
	public static String getDataBasePassWord() {
		final ResourceBundle passWord = getBundles(DataBaseConstants.DBPROPERTIES);
		return passWord
				.getString(DataBaseConstants.DATABASEPASSWORD);
	}

	/**
	 * @return gets the database defined for the application from the propery
	 *         file
	 */
	public static String getDataBase() {
		final ResourceBundle passWord = getBundles(DataBaseConstants.DBPROPERTIES);
		return passWord
				.getString(DataBaseConstants.DATABASETYPE);

	}

	/**
	 * This method accepts the label attribute name and returns the label text
	 * based on the locale
	 * 
	 * @param label
	 *            - The label attribute name
	 * @return label text
	 */
	public static String getUIText(final String label) {
		final ResourceBundle bundle = getBundles(UIConstants.UITEXT);
		return bundle.getString(label);

	}
	
	/**
	 * This method accepts the role attribute name and returns the role id
	 * based on the locale
	 * 
	 * @param role
	 *            - The role name
	 * @return role id
	 */
	public static int getUserRole(final String role) {
		final ResourceBundle bundle = getBundles(UserRoles.USERROLES);
		return Integer.parseInt(bundle.getString(role));

	}

}
