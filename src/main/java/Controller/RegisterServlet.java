/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.AuthenticationDAO;
import DAO.UserDAO;
import Model.Users;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import util.ValidationUtil;

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
        AuthenticationDAO authenDao = new AuthenticationDAO();
        HttpSession session = request.getSession();

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
        UserDAO userDAO = new UserDAO();

        String errorMessage = ValidationUtil.validateUserData(fullName, userName, email, password, phone, address,
                genderParam, dobParam, aboutMe, true);
        if (userDAO.getUserByEmail(email) != null) {
            errorMessage = "Email already exists";
        }
        if (userDAO.getUserByUsername(userName) != null) {
            errorMessage = "Username already exists";
        }
        if (userDAO.getUserByPhone(phone) != null) {
            errorMessage = "Phone already exists";
        }
        if (!password.equals(confirm)) {
            errorMessage = "Passwords do not match.";
        }
        System.out.println("Error Message: " + errorMessage);
        if (errorMessage != null) {
            request.setAttribute("error", errorMessage);
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }


        String otp = AuthenticationDAO.generateFiveRandomNumbersString();
        session.setAttribute("otp", otp);

        session.setAttribute("reg_email", email);
        session.setAttribute("reg_password", password);
        session.setAttribute("reg_fullname", fullName);
        session.setAttribute("reg_username", userName);
        session.setAttribute("reg_phone", phone);
        session.setAttribute("reg_address", address);
        session.setAttribute("reg_gender", gender);
        session.setAttribute("reg_dob", dob);
        session.setAttribute("reg_aboutme", aboutMe);

        try {
            AuthenticationDAO.sendEmail(email, "Your DriverXO Verification Code", otp);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("err", "Failed to send verification code. Please try again.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        request.getRequestDispatcher("OTP.jsp").forward(request, response);
    }
}
