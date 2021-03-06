/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Model.QueryResultEnum;
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
@WebServlet(name = "InsertClient", urlPatterns = {"/insertClient"})
public class InsertClient extends HttpServlet {

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
        SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
        String tipoIdent = request.getParameter("tipoIdent");
        int numeroIdent = TypeParser.parseInt(request.getParameter("numeroIdent"));
        int codigoPostal = TypeParser.parseInt(request.getParameter("codigoPostal"));
        String nombre = request.getParameter("nombre");
        String estadoCivil = request.getParameter("estadoCivil");
        String email = request.getParameter("email");
       String fechaNac = request.getParameter("fechaNac");
      //  Date fechaNacJav = (Date) formatter.parse(fechaNacimiento);
     //   java.sql.Date fechaNac = java.sql.Date.valueOf(fechaNacimiento);
        
        
        String sexo = request.getParameter("sexo");
        String nacionalidad = request.getParameter("nacionalidad");
        int tiempoRec = TypeParser.parseInt(request.getParameter("tiempoRec"));
        int numeroDep = TypeParser.parseInt(request.getParameter("numeroDep"));
        String vencimientoIdent = request.getParameter("vencimientoIdent");
       // Date vencimientoIdent = (Date) formatter.parse(fechaVencimiento);
       // java.sql.Date vencimientoIdent = java.sql.Date.valueOf(fechaVencimiento);

        // Si hay un codCiclo (requerido), se procede a intentar insertar el ciclo facturable.
        if(tipoIdent != null && numeroIdent != 0) {
            QueryResultEnum result;
            System.out.println("Llego aca" + numeroIdent);
            SQLConnection con = new SQLConnection();
            result = con.queryInsertClient(tipoIdent, numeroIdent, codigoPostal, nombre, estadoCivil, email, fechaNac, sexo, nacionalidad, tiempoRec, numeroDep, vencimientoIdent);
            con.close();
            
            request.setAttribute("message", result.name());
        }
        
        if (authenticateUser(request)) {
            // If user is authenticated, redirect to lobby.jsp
            RequestDispatcher rd = request.getRequestDispatcher("insertClient.jsp");
            rd.forward(request, response);
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
