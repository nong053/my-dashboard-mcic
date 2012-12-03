package mcic;
import java.sql.*;
import java.io.*;
public class dbAccessBean {
	String dbURL = "jdbc:mysql://localhost:3306/prototype_db";
	String dbDriver = "com.mysql.jdbc.Driver";
	private Connection conn;
	Statement stmt;
	ResultSet rs;
	
	public dbAccessBean(){}
	
	public boolean connect() throws ClassNotFoundException,SQLException{
		Class.forName(dbDriver);
		conn = DriverManager.getConnection(dbURL);
		return true;
	}
	
	public ResultSet executeSQL(String sql)throws SQLException{
		stmt = conn.createStatement();
		rs = stmt.executeQuery(sql);
		if(rs ==null){
			return null;
		}else{
			return rs;
		}
		
	}
	public void close()throws SQLException{
		conn.close();
	}

}
