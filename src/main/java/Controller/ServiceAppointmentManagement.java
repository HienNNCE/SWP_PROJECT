/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import Model.CarAppointment;
import Model.Service;
import Model.ServiceAppointment;
import DAO.CarAppointmentDAO;
import DAO.ServiceAppointmentDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author thien
 */
@WebServlet(name = "SeriviceAppointmentManagement", urlPatterns = { "/admin/serviceAppointment" })
public class ServiceAppointmentManagement extends HttpServlet {

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
        ServiceAppointmentDAO sDAO = new ServiceAppointmentDAO();
        List<ServiceAppointment> listServiceAppointments = null;
        String action = request.getParameter("action");
        if ("delete".equals(action)) {
            // Xóa đơn hàng
            int id = Integer.parseInt(request.getParameter("id"));
            try {
                sDAO.delete(id);
            } catch (SQLException e) {
                e.printStackTrace();
            }
            response.sendRedirect("serviceAppointment");
            return;
        }
        try {
            listServiceAppointments = sDAO.getAll();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        request.setAttribute("serviceAppointments", listServiceAppointments);
        request.getRequestDispatcher("/admin/appointment/service-appointment-list.jsp").forward(request, response);
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
        String action = request.getParameter("action");
        if ("updateStatus".equals(action)) {
            try {
                String idRaw = request.getParameter("serviceAppointmentId");
                String status = request.getParameter("status");
                int id = Integer.parseInt(idRaw);

                ServiceAppointmentDAO dao = new ServiceAppointmentDAO();
                dao.update(status, id);

                // Sau khi cập nhật xong, redirect về danh sách
                response.sendRedirect("serviceAppointment");

            } catch (Exception e) {
                e.printStackTrace();
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid input");
            }
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
