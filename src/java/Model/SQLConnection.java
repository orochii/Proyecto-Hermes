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
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.logging.Level;
import java.util.logging.Logger;
import oracle.jdbc.OracleTypes;

public class SQLConnection {

    // Connection strings
    private static String DRIVER_CONNECTION = "jdbc:oracle:thin:@localhost:1521:XE";
    private static String DB_USERNAME = "hermes";
    private static String DB_PASSWORD = "123queso";
    // Query strings
    public static String QUERY_AUTHENTICATE = "select NOMBRE_USUARIO,CONTRASENA,ESTADO from USUARIO where NOMBRE_USUARIO = '%s'"; // username
    public static String QUERY_CHANGEPASS = "update USUARIO set CONTRASENA = '%s' where NOMBRE_USUARIO = '%s'"; // password, username
    public static String QUERY_GETACCESSLEVEL = "select NOMBRE_USUARIO,TIPO from USUARIO where NOMBRE_USUARIO = '%s'"; // username

    // Esta es la línea donde se define la stored procedure (la cabecera)
    // INSERT_CICLO_FACTURABLE  (p_CODIGO_CICLO IN VARCHAR2,p_NOMBRE_CICLO IN VARCHAR2,p_TIEMPO_CICLO IN NUMBER,p_DESCRIPCION_CICLO IN VARCHAR2,p_DESCRIPCION_STATUS IN VARCHAR2,p_CODIGO_STATUS_CF IN VARCHAR2)
    // Para formar el query, simplemente añaden BEGIN al inicio y ;END; al final. Fue lo más que logré acortarlo sin que explotara.
    // Y le quitan eso del tipo de dato. Es básicamente como llamar una función en Java.
    //INSERT
    public static String QUERY_INSERTPROVINCE = "BEGIN INSERT_PROVINCIA('%d', '%s');END;";
    public static String QUERY_INSERTCANTON = "BEGIN INSERT_CANTON('%d', '%s');END;";
    public static String QUERY_INSERTDISTRICT = "BEGIN INSERT_DISTRITO('%d', '%s');END;";
    public static String QUERY_INSERTDIRECTION = "BEGIN INSERT_DIRECCION('%s', '%d', '%d', '%d');END;"; // zipcode, prov, distr, canton
    public static String QUERY_INSERTBILLINGCYCLE = "BEGIN INSERT_CICLO_FACTURABLE('%s', '%s', %d, '%s', '%s', '%s');END;"; // codCiclo, nombre, tiempociclo, descCiclo, descStatus, codStatus
    public static String QUERY_INSERTCAMPANIA = "BEGIN INSERT_CAMPANIA('%s', '%s', '%s', '%s', '%s', '%s');END;";
    //public static String QUERY_INSERTCLIENT = "BEGIN INSERT_CLIENTE('%s', %d, %d, '%s', '%s', '%s', %t, '%s', '%s', %d, %d, %t);END;"; // codCiclo, nombre, tiempociclo, descCiclo, descStatus, codStatus
    public static String QUERY_INSERTCLIENT = "BEGIN INSERT_CLIENTE('%s', %d, %d, '%s', '%s', '%s', '%s', '%s', '%s', %d, %d, '%s');END;";
    //DELETE
    public static String QUERY_DELETECAMPANIA = "BEGIN DELETE_CAMPANIA('%s');END;";
    //UPDATE
    public static String QUERY_UPDATE_CAMPANIA = "BEGIN UPDATE_CAMPANIA('%s', '%s', '%s', '%s', '%s', '%s');END;";

    private Connection con;

    public SQLConnection() throws SQLException {

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
        if (rSet != null && rSet.success()) {
            if (rSet != null && rSet.rows() > 0) {
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
        if (rSet != null && rSet.success()) {
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

    // Recuerden respetar el orden de las entradas de la función/stored procedure
    // codCiclo, nombre, tiempociclo, descC, descStatus, codStatus
    public QueryResultEnum queryInsertBillingCycle(String codCiclo, String nombre, int tiempoCiclo, String descCiclo,
            String descStatus, String codStatus) {
        String query = String.format(QUERY_INSERTBILLINGCYCLE, codCiclo, nombre, tiempoCiclo, descCiclo, descStatus, codStatus);
        RowSet rSet = doQuery(query);
        if (rSet != null && rSet.success()) {
            return QueryResultEnum.SUCCESS;
        }
        return QueryResultEnum.SQLERROR;
    }

    public QueryResultEnum queryInsertCampania(String codigo, String descripcion, String estado, String proposito, String nombre, String tipo) {
        String query = String.format(QUERY_INSERTCAMPANIA, codigo, descripcion, estado, proposito, nombre, tipo);
        RowSet rSet = doQuery(query);

        if (rSet != null && rSet.success()) {
            return QueryResultEnum.SUCCESS;
        }
        return QueryResultEnum.SQLERROR;
    }

    public QueryResultEnum queryDeleteCampania(String codigo) {
        String query = String.format(QUERY_DELETECAMPANIA, codigo);
        RowSet rSet = doQuery(query);
        if (rSet != null && rSet.success()) {
            return QueryResultEnum.SUCCESS;
        }
        return QueryResultEnum.SQLERROR;
    }

    public QueryResultEnum queryUpdateCampania(String codigo, String descripcion, String estado, String proposito, String nombre, String tipo) {
        String query = String.format(QUERY_UPDATE_CAMPANIA, codigo, descripcion, estado, proposito, nombre, tipo);
        RowSet rSet = doQuery(query);
        if (rSet != null && rSet.success()) {
            return QueryResultEnum.SUCCESS;
        }
        return QueryResultEnum.SQLERROR;
    }
    public QueryResultEnum queryInsertClient(String tipoIdent, int numeroIdent, int codigoPostal, String nombre, String estadoCivil, String email, String fechaNac,
            String sexo, String nacionalidad, int tiempoRec, int numeroDep, String fechaVenc) throws ParseException, SQLException {
        String query = String.format(QUERY_INSERTCLIENT, tipoIdent, numeroIdent, codigoPostal, nombre, estadoCivil, email, fechaNac, sexo, nacionalidad, tiempoRec, numeroDep, fechaVenc);
        RowSet rSet = doQuery(query);
        if (rSet != null && rSet.success()) {
            return QueryResultEnum.SUCCESS;
        }
        return QueryResultEnum.SQLERROR;
    }

    public void close() {
        try {
            if (con != null && !con.isClosed()) {
                con.close();
            }
        } catch (SQLException ex) {
            Logger.getLogger(SQLConnection.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    private RowSet doQuery(String query) {

        System.out.println(query);
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

    public static java.sql.Date convertFromJAVADateToSQLDate(
            java.util.Date javaDate) {
        java.sql.Date sqlDate = null;
        if (javaDate != null) {
            sqlDate = new Date(javaDate.getTime());
        }
        return sqlDate;
    }

    public RowSet querySelectClient(String tipoIdent, int numeroIdent) throws SQLException {
        CallableStatement st = con.prepareCall("{? = call SELECT_CLIENTE(?, ?)}");
        st.registerOutParameter(1, OracleTypes.CURSOR);
        st.setString(2, tipoIdent);
        st.setInt(3, numeroIdent);
        st.execute();
        ResultSet rset = (ResultSet) st.getObject(1);
        RowSet rowSet = new RowSet(rset);
        return rowSet;

    }
}
