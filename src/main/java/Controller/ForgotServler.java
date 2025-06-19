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
public class ForgotServler extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ForgotServler</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ForgotServler at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
                Logger.getLogger(ForgotServler.class.getName()).log(Level.SEVERE, null, ex);
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
