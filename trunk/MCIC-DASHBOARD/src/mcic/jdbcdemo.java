package mcic;
import java.sql.*;
//import javax.sql.*;

public class jdbcdemo{
	String dbtime;
	String dbUrl = "";
	String user="root";
	String pass="root";
	String driver = "com.mysql.jdbc.Driver";
	String query = "";
	Statement stmt;
	ResultSet rs;
	//jdbc:mysql://localhost:3306/prototype_db
public void setDbUrl(String url){
		dbUrl=url;
}
public String getDbUrl(){
		return dbUrl;
}

public ResultSet selectData(String query){

	try {
	
	Class.forName(driver);
	Connection con = DriverManager.getConnection (getDbUrl(),user,pass);
	Statement stmt = con.createStatement();
	ResultSet rs = stmt.executeQuery(query);
	return rs;
	} //end try

catch(ClassNotFoundException e) {
e.printStackTrace();
}

catch(SQLException e) {
e.printStackTrace();
}
return null;

}  //end selectData

}  //end class
