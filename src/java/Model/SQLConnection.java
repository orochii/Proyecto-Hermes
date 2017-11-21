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
    private static String DRIVER_CONNECTION = "jdbc:oracle:thin:@localhost:1521:XE";
    private static String DB_USERNAME = "HR";
    private static String DB_PASSWORD = "123queso";
    
    private Connection con;
    
    public SQLConnection() {
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","HR","123queso");
        } catch (SQLException ex) {
            Logger.getLogger(SQLConnection.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(SQLConnection.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public QueryResultEnum queryForLogin(String username, String password) {
        try {
            ResultSet rSet = doQuery("select NOMBRE_USUARIO,CONTRASENA from USUARIOS where NOMBRE_USUARIO = " + username);
            if(rSet != null && rSet.next()) {
                String realPass = rSet.getString("CONTRASENA");
                String checkPass= MD5Generator.GetMD5(password);
                if(realPass.equals(checkPass)) return QueryResultEnum.SUCCESS; // Password correcto. Establecer conexión.
                else return QueryResultEnum.WRONGPASSWORD; // Password inválido.
            }
            return QueryResultEnum.WRONGUSERNAME; // Nombre de usuario inválido.
        } catch (SQLException ex) {
            Logger.getLogger(SQLConnection.class.getName()).log(Level.SEVERE, null, ex);
        }
        return QueryResultEnum.SQLERROR; // Problema al establecer conexión con servidor.
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
          Statement st = con.createStatement();
          ResultSet rSet = st.executeQuery(query);
          return rSet;
        } catch (SQLException ex) {
            Logger.getLogger(Login.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
}
