/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;

import DAO.ServiceAppointmentDAO;
import Model.ServiceAppointment;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author thien
 */
@WebServlet(name = "ServiceApoimentServlet", urlPatterns = { "/serviceAppointment" })
public class ServiceAppointmentServlet extends HttpServlet {

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the
    // + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Object userIdObj = session.getAttribute("userId");

        if (userIdObj == null) {
            // Nếu chưa đăng nhập, chuyển về trang login hoặc báo lỗi
            response.sendRedirect("auth/login.jsp");
            return;
        }
        String serviceIdS = request.getParameter("serviceId");
        int serviceId = Integer.parseInt(serviceIdS);
        request.setAttribute("serviceId", serviceId);
        request.getRequestDispatcher("contact.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Object userIdObj = session.getAttribute("userId");

        if (userIdObj == null) {
            // Nếu chưa đăng nhập, chuyển về trang login hoặc báo lỗi
            response.sendRedirect("auth/login.jsp");
            return;
        }

        int userId = (Integer) userIdObj;
        try {
            String fullname = request.getParameter("fullname");
            String phone = request.getParameter("phone");
            String email = request.getParameter("email");
            String repairType = request.getParameter("repairType");
            String carInfor = request.getParameter("car");
            String date = request.getParameter("date");
            String time = request.getParameter("time");
            String note = request.getParameter("note");

            LocalDateTime appointmentDate = LocalDateTime.of(LocalDate.parse(date), LocalTime.parse(time));

            ServiceAppointment sa = new ServiceAppointment();
            userId = (int) session.getAttribute("userId");
            sa.setUserId(userId);
            sa.setServiceId(Integer.parseInt(repairType));
            sa.setSaDate(appointmentDate);
            sa.setSaNote(note);
            sa.setSaStatus("Pending");
            sa.setCarInfo(carInfor);

            ServiceAppointmentDAO dao = new ServiceAppointmentDAO();
            dao.add(sa);
            request.setAttribute("successMsg",
                    "Service appointment scheduled successfully! Please wait for confirmation.");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("successMsg", "Failed to schedule service appointment.");
        }

        request.getRequestDispatcher("/contact.jsp").forward(request, response);
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
