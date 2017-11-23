/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Model.DirectionReader;
import Model.QueryResultEnum;
import Model.SQLConnection;
import java.io.IOException;
import java.io.PrintWriter;
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
 * @author Lord of Nightmares
 */
@WebServlet(name = "UploadDirections", urlPatterns = {"/uploadDirections"})
public class UploadDirections extends HttpServlet {

    private int accessLevel;
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
            throws ServletException, IOException, SQLException {
        String directions = (String) request.getParameter("directions");
        if(directions != null && !directions.isEmpty()) {
            DirectionReader dr = new DirectionReader();
            dr.readString(directions);
            QueryResultEnum result = dr.uploadDirNames();
            if(result != QueryResultEnum.SUCCESS) request.setAttribute("message", result.name());
            request.setAttribute("accessLevel", 9);
        }
        if(authenticateUser(request)) {
            if(accessLevel > 8) {
                // If user is authenticated, redirect to lobby.jsp
                RequestDispatcher rd = request.getRequestDispatcher("uploadDirections.jsp");
                rd.forward(request, response);
            } else {
                RequestDispatcher rd = request.getRequestDispatcher("errorPageWWWW");
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
        if(username != null && !username.isEmpty()) {
            String password = (String) session.getAttribute("password");
            SQLConnection con = new SQLConnection();
            QueryResultEnum result = con.queryAuthenticateUser(username, password);
            accessLevel = con.queryUserAccessLevel(username);
            request.setAttribute("accessLevel", accessLevel);
            con.close();
            if(result==QueryResultEnum.SUCCESS) return true;
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
            Logger.getLogger(UploadDirections.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(UploadDirections.class.getName()).log(Level.SEVERE, null, ex);
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
