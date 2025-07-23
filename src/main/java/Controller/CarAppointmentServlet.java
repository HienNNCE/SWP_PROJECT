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

import DAO.CarAppointmentDAO;
import DAO.CarDAO;
import Model.Car;
import Model.CarAppointment;
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
@WebServlet(name = "CarAppointmentServlet", urlPatterns = { "/carAppointment" })
public class CarAppointmentServlet extends HttpServlet {

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
        String serviceIdS = request.getParameter("carId");
        int carId = Integer.parseInt(serviceIdS);
        CarDAO cDAO = new CarDAO();
        Car car = cDAO.getCarById(carId);

        LocalDate today = LocalDate.now();
        String minDate = today.toString();
        request.setAttribute("minDate", minDate);

        if (userIdObj == null) {
            // Nếu chưa đăng nhập, chuyển về trang login hoặc báo lỗi
            response.sendRedirect("auth/login.jsp");
            return;
        }
        request.setAttribute("car", car);
        request.setAttribute("carId", carId);
        request.getRequestDispatcher("car_appointment.jsp").forward(request, response);
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
            // Lấy dữ liệu từ form
            String fullname = request.getParameter("fullname");
            String phone = request.getParameter("phone");
            String email = request.getParameter("email");
            String carIds = request.getParameter("carId");
            String date = request.getParameter("date");
            String time = request.getParameter("time");
            String note = request.getParameter("note");

            // Gộp ngày giờ
            LocalDateTime appointmentDate = LocalDateTime.of(LocalDate.parse(date), LocalTime.parse(time));

            // Tạo đối tượng
            int carId = Integer.parseInt(carIds);
            CarAppointment ca = new CarAppointment();
            userId = (int) session.getAttribute("userId");
            ca.setUserId(userId); // chưa đăng nhập
            ca.setCarId(carId); // chưa có carId cụ thể
            ca.setCaDate(appointmentDate);
            ca.setCaNote(note);
            ca.setCaStatus("Pending");

            // Lưu DB
            CarAppointmentDAO dao = new CarAppointmentDAO();
            dao.add(ca);

            request.setAttribute("successMsg", "Car appointment scheduled successfully! Please wait for confirmation.");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("successMsg", "Failed to schedule car appointment.");
        }

        request.getRequestDispatcher("/car_appointment.jsp").forward(request, response);
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
