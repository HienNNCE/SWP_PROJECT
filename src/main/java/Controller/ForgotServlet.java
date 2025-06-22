/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.UserDAO;
import jakarta.mail.MessagingException;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ASUS_FX507Z
 */
@WebServlet("/forgot")

public class ForgotServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get the current session, or create one if it doesn't exist.
        HttpSession session = request.getSession();
        UserDAO uDao = new UserDAO();
        // Retrieve the email submitted from the forgot password form.
        String email = request.getParameter("email");
        // Check if the provided email is registered in the system.
        boolean checkEmail = uDao.checkEmailUser(email);
        // If the email does not exist in the database
        if (!checkEmail) {
            request.setAttribute("err", "Email not registered");
            request.getRequestDispatcher("forgot.jsp").forward(request, response);
        } else {
            // If the email exists, generate a five-digit OTP string.
            String otp = UserDAO.generateFiveRandomNumbersString();
            // Store the generated OTP and the email in the session.
            session.setAttribute("otp", otp);
            session.setAttribute("femail", email);
            
            try {
                // Send the OTP to the user's email address for verification.
                UserDAO.sendEmail(email, "Your OTP", otp);
            } catch (MessagingException ex) {
                Logger.getLogger(ForgotServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            // Forward the user to the OTP.jsp page where they can enter the received OTP.
            request.getRequestDispatcher("OTP.jsp").forward(request, response);
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
