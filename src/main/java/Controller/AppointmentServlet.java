package Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "AppointmentServlet", urlPatterns = {"/appointment"})
public class AppointmentServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String fullname = request.getParameter("fullname");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String serviceType = request.getParameter("serviceType");
        String car = request.getParameter("car");
        String date = request.getParameter("date");
        String time = request.getParameter("time");
        String note = request.getParameter("note");

        // You can save to DB here if needed
        request.setAttribute("successMsg", "Đặt lịch hẹn thành công! Chúng tôi sẽ liên hệ bạn sớm.");
        request.getRequestDispatcher("contact.jsp").forward(request, response);
    }
} 