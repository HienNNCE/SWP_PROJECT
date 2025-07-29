/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import org.checkerframework.checker.units.qual.C;

import Model.CarAppointment;
import Model.Service;
import Model.ServiceAppointment;
import Model.Users;
import DAO.CarAppointmentDAO;
import DAO.ServiceAppointmentDAO;
import DAO.UserDAO;
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
@WebServlet(name = "CarAppointmentManagement", urlPatterns = { "/admin/carAppointment" })
public class CarAppoitmentManagement extends HttpServlet {

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
        CarAppointmentDAO cDAO = new CarAppointmentDAO();
        List<CarAppointment> listCarAppointments = null;
        String action = request.getParameter("action");
        if ("delete".equals(action)) {
            // Xóa đơn hàng
            int id = Integer.parseInt(request.getParameter("id"));
            try {
                cDAO.delete(id);
            } catch (SQLException e) {
                e.printStackTrace();
            }
            response.sendRedirect("carAppointment");
            return;
        }
        try {
            listCarAppointments = cDAO.getAll();
            UserDAO uDAO = new UserDAO();
            for (CarAppointment ca: listCarAppointments){
                int userId = ca.getUserId();
                Users user = uDAO.getUserById(userId);
                ca.setUser(user);
            }
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        request.setAttribute("carAppointments", listCarAppointments);
        request.getRequestDispatcher("/admin/appointment/car-appointment-list.jsp").forward(request, response);
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

                CarAppointmentDAO dao = new CarAppointmentDAO();
                dao.update(status, id);

                // Sau khi cập nhật xong, redirect về danh sách
                response.sendRedirect("carAppointment");

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
