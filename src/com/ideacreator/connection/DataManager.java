package com.ideacreator.connection;

import java.sql.Connection;
import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.ideacreator.constants.DataBaseConstants;
import com.ideacreator.util.PropertyUtil;

/**
 * This Class Manages the DataBase Connection Creation.Creates a connection
 * object named connection .
 * 
 */

public class DataManager {

	/** conenction-The DataBase Connection Object */
	private Connection connection;

	/**
	 * This method creates a connection with the database
	 * 
	 * @throws SQLException
	 *             when it is not able to create connection with the given url
	 *             username and password
	 */
	public void createConnection() throws SQLException {
		final Driver driver = new oracle.jdbc.OracleDriver();// Creates the
																// MySql
		// Driver object
		DriverManager.registerDriver(driver); // Registers the Driver object
		// with DriverManager
		setConnection(DriverManager.getConnection(PropertyUtil.getDataBaseUrl(), PropertyUtil.getDataBaseUserName(),
				PropertyUtil.getDataBasePassWord()));// Creates the Connection
														// and
		// set it to the connection
		// object of the class named connection

	}

	/**
	 * Setter Method for the connection object
	 * 
	 * @param connection
	 *            The connection object
	 */

	public void setConnection(final Connection connection) {
		this.connection = connection;
	}

	/**
	 * Getter method for the connection object
	 * 
	 * @return the connection object
	 */
	public Connection getConnection() {
		return connection;
	}

	public int executeQuery(String query) {
		try {
			createConnection();
			Connection con = getConnection();
			PreparedStatement st = con.prepareStatement(query);
			st.execute();
			return st.getUpdateCount();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return 0;
	}
}
