/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Model.QueryResultEnum;
import Model.RowSet;
import Model.SQLConnection;
import Model.TypeParser;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Lord of Nightmares
 */
@WebServlet(name = "SelectClient", urlPatterns = {"/selectClient"})
public class SelectClient extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ParseException, SQLException {
        String tipoIdent = request.getParameter("tipoIdent");
        int numeroIdent = TypeParser.parseInt(request.getParameter("numeroIdent"));
        RowSet result = null;
        if (tipoIdent != null && numeroIdent != 0) {
            SQLConnection con = new SQLConnection();
            result = con.querySelectClient(tipoIdent, numeroIdent);
            con.close();
            if (!result.success()) {
                request.setAttribute("message", QueryResultEnum.SQLERROR);
            }
        }

        if (authenticateUser(request)) {
            if(result != null) {
                request.setAttribute("tipoIdent",result.getString("TIPO_IDENTIFICACION"));
                request.setAttribute("numIdent", result.getString("NUMERO_IDENTIFICACION"));
                request.setAttribute("codPostal",result.getString("CODIGO_POSTAL_CLIENTE"));
                request.setAttribute("nomClient",result.getString("NOMBRE_CLIENTE"));
                request.setAttribute("estCivil",result.getString("ESTADO_CIVIL"));
                request.setAttribute("email",result.getString("EMAIL"));
                request.setAttribute("fechaNac",result.getString("FECHANACIMIENTO"));
                request.setAttribute("sexo",result.getString("SEXO"));
                request.setAttribute("nacional",result.getString("NACIONALIDAD"));
                request.setAttribute("tResidDom",result.getString("TIEMPO_RESIDENCIA_DOMICILIO"));
                request.setAttribute("numDepend",result.getString("NUMERO_DEPENDIENTES"));
                request.setAttribute("vencIdent",result.getString("VENCIMIENTO_IDENTIFICACION"));
                RequestDispatcher rd = request.getRequestDispatcher("showClient.jsp");
                rd.forward(request, response);
            } else {
                // If user is authenticated, redirect to lobby.jsp
                RequestDispatcher rd = request.getRequestDispatcher("selectClient.jsp");
                rd.forward(request, response);
            }
            
        } else {
            // If user isn't authenticated, redirect to login.jsp
            RequestDispatcher rd = request.getRequestDispatcher("dologin.jsp");
            rd.forward(request, response);
        }
    }

    private boolean authenticateUser(HttpServletRequest request) throws SQLException {
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");
        if (username != null && !username.isEmpty()) {
            String password = (String) session.getAttribute("password");
            SQLConnection con = new SQLConnection();
            QueryResultEnum result = con.queryAuthenticateUser(username, password);
            con.close();
            if (result == QueryResultEnum.SUCCESS) {
                return true;
            }
        }
        return false;
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (ParseException ex) {
            Logger.getLogger(InsertClient.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(InsertClient.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (ParseException ex) {
            Logger.getLogger(InsertClient.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(InsertClient.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
