/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Model.QueryResultEnum;
import Model.SQLConnection;
import java.io.IOException;
import java.sql.SQLException;
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
 * @author ZERO
 */
@WebServlet(name = "DeleteCampania", urlPatterns = {"/deleteCampania"})
public class DeleteCampania extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        String codigo = request.getParameter("codigoCamp");

        if (codigo != null) {
            QueryResultEnum result;
            System.out.println(codigo);
            SQLConnection con = new SQLConnection();
         //   result = con.queryDeleteCampania(codigo);
            con.close();
        //    request.setAttribute("message", result.name());
        }

        if (authenticateUser(request)) {
            // If user is authenticated, redirect to lobby.jsp
            RequestDispatcher rd = request.getRequestDispatcher("deleteCampania.jsp");
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
        } catch (SQLException ex) {
            Logger.getLogger(DeleteCampania.class.getName()).log(Level.SEVERE, null, ex);
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
        } catch (SQLException ex) {
            Logger.getLogger(DeleteCampania.class.getName()).log(Level.SEVERE, null, ex);
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
