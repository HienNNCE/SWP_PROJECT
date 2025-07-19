/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.AuthenticationDAO;
import Model.Users;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * RegisterServlet handles user registration requests. It processes form
 * submissions from the registration page, validates input, and interacts with
 * the UserDAO to create new user accounts in the database.
 *
 * @author
 */
public class RegisterServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // processRequest(request, response);
        AuthenticationDAO authenDao = new AuthenticationDAO();
        HttpSession session = request.getSession();
        // Retrieve parameters from the registration form.
        String fullName = request.getParameter("fullname");
        String email = request.getParameter("email");
        String userName = request.getParameter("username");
        String password = request.getParameter("password");
        String confirm = request.getParameter("confirm");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String genderParam = request.getParameter("gender");
        boolean gender = Boolean.parseBoolean(genderParam);
        String dobParam = request.getParameter("dob");
        LocalDate dob = LocalDate.parse(dobParam);
        String aboutMe = request.getParameter("aboutMe");

        String passwordPattern = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[@$!%*#?&])[A-Za-z\\d@$!%*#?&]{8,}$";

        if (!password.equals(confirm)) {
            request.setAttribute("err", "Passwords do not match.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        if (!password.matches(passwordPattern)) {
            request.setAttribute("err",
                    "Password must be at least 8 characters long and contain a mix of letters, numbers, and symbols.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        boolean emailExists = authenDao.checkEmailUser(email);
        if (emailExists) {
            request.setAttribute("err", "This email has already been registered.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        } else {
            authenDao.registerUser(userName, email, password, phone, fullName, gender, dob, aboutMe, address);
            request.setAttribute("success_msg", "Registration successful! Please log in.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
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
