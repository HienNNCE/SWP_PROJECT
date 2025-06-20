/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.UserDAO;
import Model.Users;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * LoginServlet handles user login and logout functionalities. It processes HTTP
 * GET requests for logout and HTTP POST requests for login. It interacts with
 * the UserDAO to authenticate users against the database.
 *
 * @author
 */
@WebServlet("/login")

public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get the current session.
        HttpSession session = request.getSession();
        // Retrieve the "action" parameter from the request.
        String action = request.getParameter("action");
        // Check if the action is "logout".
        if (action.equalsIgnoreCase("logout")) {
            // Invalidate or remove the user attribute from the session.
            session.setAttribute("user", null);
            // Redirect the user to the home page after logout.
            response.sendRedirect("../home");
        }
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method. This method is invoked when a
     * user submits the login form. It attempts to authenticate the user using
     * the provided username/email and password.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //processRequest(request, response);
        // Instantiate the UserDAO to interact with the database.
        UserDAO userDao = new UserDAO();
        // Get the current HttpSession.
        HttpSession session = request.getSession();
        // Retrieve the username (or email) and password from the login form.
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        // Attempt to retrieve a user from the database using the provided credentials.
        Users user = userDao.getUserById(username, password);
        // If a user object is returned, authentication was successful.
        if (user != null) {
            session.setAttribute("account", user);
            // response.sendRedirect("/home");
            session.setAttribute("userId", user.getUserId());
            session.setAttribute("userName", user.getUserName());
            response.sendRedirect(request.getContextPath() + "/home");

            // If no user is found with the given credentials, authentication failed.
        } else {
            request.setAttribute("err", "Incorrect email, username or password");

            request.getRequestDispatcher("/login.jsp").forward(request, response);
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
