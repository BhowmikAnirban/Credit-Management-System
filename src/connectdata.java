/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author xouvik
 */
import java.sql.*;
import javax.swing.JOptionPane;

public class connectdata {
    
  Connection conn;
  
   public static Connection connectsql()
   {
       try
       {
        Class.forName("org.sqlite.JDBC");
      
       // Connection conn=DriverManager.getConnection("jdbc:sqlite:\\https://drive.google.com/file/d/11JKrfEDEoSMXVU0-V8OyaeIFgcGHpqW6/view?usp=sharing");
        Connection conn=DriverManager.getConnection("jdbc:sqlite:\\D:\\credit system\\mydb.db");
        return conn;
       }
       
       catch(Exception e)
       {
           JOptionPane.showMessageDialog(null, e);
           return null;
       }
   }
}
