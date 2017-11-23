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
    public static String QUERY_GETACCESSLEVEL = "select NOMBRE_USUARIO,TIPO from USUARIO where NOMBRE_USUARIO = '%s'"; // username

    public static String QUERY_INSERTPROVINCE = "BEGIN INSERT_PROVINCIA('%d', '%s');END;";
    public static String QUERY_INSERTCANTON = "BEGIN INSERT_CANTON('%d', '%s');END;";
    public static String QUERY_INSERTDISTRICT = "BEGIN INSERT_DISTRITO('%d', '%s');END;";
    public static String QUERY_INSERTDIRECTION = "BEGIN INSERT_DIRECCION('%s', '%d', '%d', '%d');END;"; // zipcode, prov, distr, canton

    private Connection con;

    public SQLConnection() {
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            con = DriverManager.getConnection(DRIVER_CONNECTION, DB_USERNAME, DB_PASSWORD);
        } catch (SQLException ex) {
            Logger.getLogger(SQLConnection.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(SQLConnection.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public QueryResultEnum queryAuthenticateUser(String username, String password) {
        String query = String.format(QUERY_AUTHENTICATE, username);
        RowSet rSet = doQuery(query);
        if(rSet != null && rSet.success()) {
            if (rSet != null && rSet.rows()>0) {
                String realPass = rSet.getString("CONTRASENA");
                String checkPass = MD5Generator.GetMD5(password);
                if (realPass.equals(checkPass)) {
                    String status = rSet.getString("ESTADO");
                    if (status.equalsIgnoreCase("INACTIVO")) {
                        return QueryResultEnum.USERINACTIVE;
                    }
                    return QueryResultEnum.SUCCESS;
                } // Password correcto. Establecer conexión.
                else {
                    return QueryResultEnum.WRONGPASSWORD; // Password inválido.
                }
            }
            return QueryResultEnum.WRONGUSERNAME; // Nombre de usuario inválido.
        }
        return QueryResultEnum.SQLERROR; // Problema al establecer conexión con servidor.
    }

    public QueryResultEnum queryChangePassword(String username, String password) {

        String newPass = MD5Generator.GetMD5(password);
        String query = String.format(QUERY_CHANGEPASS, newPass, username);

        RowSet rSet = doQuery(query);
        if (rSet != null && rSet.success()) {
            return QueryResultEnum.SUCCESS; // Password correcto. Establecer conexión.
        } else {
            return QueryResultEnum.SQLERROR;
        }
    }

    public int queryUserAccessLevel(String username) {
        String kind = queryUserKind(username);
        if (kind != null) {
            switch (kind) {
                case "SUPER":
                    return 9;
                case "ADMIN":
                    return 2;
                case "OPER":
                    return 1;
                case "USER":
                    return 0;
                default:
                    break;
            }
        }
        return -1;
    }

    public String queryUserKind(String username) {
        String query = String.format(QUERY_GETACCESSLEVEL, username);
        RowSet rSet = doQuery(query);
        if(rSet != null && rSet.success()) {
            String kind = rSet.getString("TIPO");
            return kind;
        }
        return null;
    }

    public QueryResultEnum queryInsertProvince(int code, String name) {
        String query = String.format(QUERY_INSERTPROVINCE, code, name);
        RowSet rSet = doQuery(query);
        if (rSet != null && rSet.success()) {
            return QueryResultEnum.SUCCESS;
        }
        return QueryResultEnum.SQLERROR;
    }

    public QueryResultEnum queryInsertCanton(int code, String name) {
        String query = String.format(QUERY_INSERTCANTON, code, name);
        RowSet rSet = doQuery(query);
        if (rSet != null && rSet.success()) {
            return QueryResultEnum.SUCCESS;
        }
        return QueryResultEnum.SQLERROR;
    }

    public QueryResultEnum queryInsertDistrict(int code, String name) {
        String query = String.format(QUERY_INSERTDISTRICT, code, name);
        RowSet rSet = doQuery(query);
        if (rSet != null && rSet.success()) {
            return QueryResultEnum.SUCCESS;
        }
        return QueryResultEnum.SQLERROR;
    }

    public QueryResultEnum queryInsertDirection(String zip, int prov, int cant, int dist) {
        String query = String.format(QUERY_INSERTDIRECTION, zip, prov, dist, cant);
        RowSet rSet = doQuery(query);
        if (rSet != null && rSet.success()) {
            return QueryResultEnum.SUCCESS;
        }
        return QueryResultEnum.SQLERROR;
    }

    public void Close() {
        try {
            if (con != null && !con.isClosed()) {
                con.close();
            }
        } catch (SQLException ex) {
            Logger.getLogger(SQLConnection.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    private RowSet doQuery(String query) {
        try {
            Statement st = con.createStatement();
            try {
                ResultSet rSet = st.executeQuery(query);
                RowSet rows = new RowSet(rSet);
                rSet.close();
                return rows;
            } catch (SQLException ex) {
                Logger.getLogger(Login.class.getName()).log(Level.SEVERE, null, ex);
                return null;
            } finally {
                try {
                    st.close();
                } catch (Exception ignore) {
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(SQLConnection.class.getName()).log(Level.SEVERE, null, ex);
        }

        return null;
    }

}
