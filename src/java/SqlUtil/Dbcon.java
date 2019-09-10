package SqlUtil;

/*
This class establishesh the connection to the database
*/


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Dbcon {
    // Database name
    static String dbName="minor_projectv2";
    
    // Database username
    static String userName="root";
    
    // Database password
    static String userPass="";
    
    // Connection object
    public static Connection con;
    
    
    // Creating connection
    public static void getConnection() {
        try{
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/"+dbName,userName,userPass);
        }catch(ClassNotFoundException ex){
            System.out.println("Problem in creating connection: "+ex.getMessage());
        }catch(SQLException ex){
            System.out.println("Problem in DriverManager: "+ex.getMessage());
        }
    }
    
    public static void create(String query) throws SQLException
    {
        PreparedStatement st = con.prepareStatement(query);
        st.execute();
    }
    
    public static void update(PreparedStatement st) throws SQLException
    {
        st.executeUpdate();
    }
    
    public static ResultSet retrive(PreparedStatement st) throws SQLException
    {
        return st.executeQuery();
    }
    
    public static void close() {
        try{
            con.close();
        }catch(Exception ex){
            System.out.println("Problem in closing connection: "+ex.getMessage());
        }
    }

}
