/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Model.QueryResultEnum;
import Model.SQLConnection;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Lord of Nightmares
 */
@WebServlet(name = "CreateUser", urlPatterns = {"/createUser"})
public class CreateUser extends HttpServlet {

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
            throws ServletException, IOException {
        // Obtiene contraseñas escritas.
        String username = (String) request.getParameter("newUser");
        String password = (String) request.getParameter("newPass");
        String tipoIdent = (String) request.getParameter("tipoIdent");
        String numIdent = (String) request.getParameter("numIdent");

        QueryResultEnum result = QueryResultEnum.USERINACTIVE;

        if (username != null) {
            if (password != null && tipoIdent != null && numIdent != null) {
                if (!username.isEmpty() && !password.isEmpty() && !tipoIdent.isEmpty() && !numIdent.isEmpty()) {
                    System.out.println("Llega aquí.");
                    // Crea conexión y efectúa cambio de contraseña
                    SQLConnection con = new SQLConnection();
                    result = con.queryCreateUser(username, password, tipoIdent, numIdent);
                    con.close();
                } else {
                    result = QueryResultEnum.NODATA;
                }

            }
        }
        System.out.println("Accesando CREAR USUARIO");
        if (result == QueryResultEnum.SUCCESS) {
            RequestDispatcher rd = request.getRequestDispatcher("/lobby.jsp");
            rd.forward(request, response);
        } else {
            if(result != QueryResultEnum.USERINACTIVE) request.setAttribute("message", result.name()+" - Datos inválidos.");
            RequestDispatcher rd = request.getRequestDispatcher("createUser.jsp");
            rd.forward(request, response);
        }
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
        processRequest(request, response);
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
        processRequest(request, response);
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
