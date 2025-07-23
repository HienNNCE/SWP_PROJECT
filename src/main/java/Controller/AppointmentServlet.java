package Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

import DAO.CarAppointmentDAO;
import DAO.ServiceAppointmentDAO;
import Model.AppointmentViewModel;
import Model.CarAppointment;
import Model.ServiceAppointment;

@WebServlet(name = "AppointmentServlet", urlPatterns = { "/appointment" })
public class AppointmentServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        CarAppointmentDAO carDAO = new CarAppointmentDAO();
        ServiceAppointmentDAO serviceDAO = new ServiceAppointmentDAO();

        int userId = (Integer) session.getAttribute("userId");

        List<CarAppointment> carAppointments = null;
        List<ServiceAppointment> serviceAppointments = null;
        try {
            carAppointments = carDAO.getByUserId(userId);
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        try {
            serviceAppointments = serviceDAO.getByUserId(userId);
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        List<AppointmentViewModel> allAppointments = new ArrayList<>();

        for (CarAppointment car : carAppointments) {
            AppointmentViewModel vm = new AppointmentViewModel(
                    "Car",
                    car.getCarName() + " " + car.getCarModel(),
                    car.getCaNote(),
                    car.getCaStatus(),
                    car.getCaDate(),
                    car.getFormattedCaDate());
            allAppointments.add(vm);
        }

        for (ServiceAppointment sa : serviceAppointments) {
            AppointmentViewModel vm = new AppointmentViewModel(
                    "Service",
                    sa.getServiceName(),
                    sa.getSaNote(),
                    sa.getSaStatus(),
                    sa.getSaDate(),
                    sa.getFormattedSaDate());
            allAppointments.add(vm);
        }

        for (AppointmentViewModel a : allAppointments){
            System.out.println(a.getType());
        }

        // Sắp xếp theo thời gian tăng dần
        allAppointments.sort(Comparator.comparing(AppointmentViewModel::getDate));
        // Đưa vào JSP
        request.setAttribute("appointments", allAppointments);
        request.getRequestDispatcher("/appointment.jsp").forward(request, response);

    }

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