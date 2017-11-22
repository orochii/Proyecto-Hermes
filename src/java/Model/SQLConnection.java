/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

/**
 *
 * @author Lord of Nightmares
 */

import Controller.Login;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

public class SQLConnection {
    // Connection strings
    private static String DRIVER_CONNECTION = "jdbc:oracle:thin:@localhost:1521:XE";
    private static String DB_USERNAME = "hermes";
    private static String DB_PASSWORD = "123queso";
    // Query strings
    public static String QUERY_AUTHENTICATE = "select NOMBRE_USUARIO,CONTRASENA,ESTADO from USUARIO where NOMBRE_USUARIO = '%s'"; // username
    public static String QUERY_CHANGEPASS = "update USUARIO set CONTRASENA = '%s' where NOMBRE USUARIO = '%s'"; // username, password
   
    private Connection con;
    
    public SQLConnection() {
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            con = DriverManager.getConnection(DRIVER_CONNECTION,DB_USERNAME,DB_PASSWORD);
        } catch (SQLException ex) {
            Logger.getLogger(SQLConnection.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(SQLConnection.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public QueryResultEnum queryAuthenticateUser(String username, String password) {
        try {
            String query = String.format(QUERY_AUTHENTICATE, username);
            ResultSet rSet = doQuery(query);
            
            if(rSet != null && rSet.next()) {
                String realPass = rSet.getString("CONTRASENA");
                System.out.println(realPass);
                String checkPass = MD5Generator.GetMD5(password);
                if(realPass.equals(checkPass)) {
                    String status = rSet.getString("ESTADO");
                    if(status.equalsIgnoreCase("INACTIVO")) return QueryResultEnum.USERINACTIVE;
                    return QueryResultEnum.SUCCESS;
                } // Password correcto. Establecer conexión.
                else return QueryResultEnum.WRONGPASSWORD; // Password inválido.
            }
            return QueryResultEnum.WRONGUSERNAME; // Nombre de usuario inválido.
        } catch (SQLException ex) {
            Logger.getLogger(SQLConnection.class.getName()).log(Level.SEVERE, null, ex);
        }
        return QueryResultEnum.SQLERROR; // Problema al establecer conexión con servidor.
    }
    
    public QueryResultEnum queryChangePassword(String username, String password) {
        
        String newPass = MD5Generator.GetMD5(password);
        String query = String.format(QUERY_CHANGEPASS, newPass, username);
        
        ResultSet rSet = doQuery(query);
        if(rSet != null) return QueryResultEnum.SUCCESS; // Password correcto. Establecer conexión.
        else return QueryResultEnum.SQLERROR;
    }
    
    public void Close() {
        try {
            if(con != null && !con.isClosed()) con.close();
        } catch (SQLException ex) {
            Logger.getLogger(SQLConnection.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    private ResultSet doQuery(String query) {
        try {
          System.out.println(query);
          Statement st = con.createStatement();
          ResultSet rSet = st.executeQuery(query);
          return rSet;
        } catch (SQLException ex) {
            Logger.getLogger(Login.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
}
