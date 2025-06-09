package Controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * Servlet handling booking operations such as viewing bookings, scheduling test drives,
 * managing service appointments, rescheduling, and canceling bookings.
 */
@WebServlet(name = "BookingsServlet", urlPatterns = {"/bookings"})
public class BookingsServlet extends HttpServlet {
    
    /**
     * Handles the HTTP GET request - displays the bookings page
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        
        // For demo purposes, we'll check if there are bookings in the session
        // In a real application, you would fetch the bookings from a database
        List<Object> testDrives = (List<Object>) session.getAttribute("testDrives");
        List<Object> serviceAppointments = (List<Object>) session.getAttribute("serviceAppointments");
        List<Object> bookingHistory = (List<Object>) session.getAttribute("bookingHistory");
        
        // Pass bookings to the JSP
        request.setAttribute("testDrives", testDrives);
        request.setAttribute("serviceAppointments", serviceAppointments);
        request.setAttribute("bookingHistory", bookingHistory);
        
        // Forward to bookings page
        RequestDispatcher dispatcher = request.getRequestDispatcher("/bookings.jsp");
        dispatcher.forward(request, response);
    }

    /**
     * Handles the HTTP POST request - handles booking actions like scheduling, 
     * rescheduling or canceling
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        
        if (action == null) {
            response.sendRedirect(request.getContextPath() + "/bookings");
            return;
        }
        
        switch (action) {
            case "schedule_test_drive":
                // Logic for scheduling a test drive
                scheduleTestDrive(request, session);
                break;
                
            case "schedule_service":
                // Logic for scheduling a service appointment
                scheduleService(request, session);
                break;
                
            case "reschedule":
                // Logic for rescheduling a booking
                rescheduleBooking(request, session);
                break;
                
            case "cancel":
                // Logic for canceling a booking
                cancelBooking(request, session);
                break;
                
            default:
                break;
        }
        
        // Redirect back to the bookings page
        response.sendRedirect(request.getContextPath() + "/bookings");
    }

    /**
     * Schedules a test drive
     * 
     * @param request the HTTP request
     * @param session the HTTP session
     */
    private void scheduleTestDrive(HttpServletRequest request, HttpSession session) {
        // Get booking parameters
        String carId = request.getParameter("carId");
        String date = request.getParameter("date");
        String time = request.getParameter("time");
        String location = request.getParameter("location");
        
        // In a real application, you would save the booking to a database
        // and create a proper booking object
        
        // For demo purposes, we'll just add a placeholder
        List<Object> testDrives = (List<Object>) session.getAttribute("testDrives");
        if (testDrives == null) {
            testDrives = new ArrayList<>();
            session.setAttribute("testDrives", testDrives);
        }
        
        // Add test drive to bookings (this would be replaced with actual logic)
        // testDrives.add(new TestDriveBooking(...));
    }

    /**
     * Schedules a service appointment
     * 
     * @param request the HTTP request
     * @param session the HTTP session
     */
    private void scheduleService(HttpServletRequest request, HttpSession session) {
        // Get booking parameters
        String carId = request.getParameter("carId");
        String date = request.getParameter("date");
        String time = request.getParameter("time");
        String serviceType = request.getParameter("serviceType");
        String location = request.getParameter("location");
        
        // In a real application, you would save the booking to a database
        // and create a proper booking object
        
        // For demo purposes, we'll just add a placeholder
        List<Object> serviceAppointments = (List<Object>) session.getAttribute("serviceAppointments");
        if (serviceAppointments == null) {
            serviceAppointments = new ArrayList<>();
            session.setAttribute("serviceAppointments", serviceAppointments);
        }
        
        // Add service appointment to bookings (this would be replaced with actual logic)
        // serviceAppointments.add(new ServiceBooking(...));
    }

    /**
     * Reschedules an existing booking
     * 
     * @param request the HTTP request
     * @param session the HTTP session
     */
    private void rescheduleBooking(HttpServletRequest request, HttpSession session) {
        // Get booking parameters
        String bookingId = request.getParameter("bookingId");
        String newDate = request.getParameter("newDate");
        String newTime = request.getParameter("newTime");
        String bookingType = request.getParameter("bookingType");
        
        // In a real application, you would update the booking in the database
        // For demo purposes, we'll just log the action
        System.out.println("Rescheduled booking " + bookingId + " to " + newDate + " " + newTime);
    }

    /**
     * Cancels an existing booking
     * 
     * @param request the HTTP request
     * @param session the HTTP session
     */
    private void cancelBooking(HttpServletRequest request, HttpSession session) {
        // Get booking parameters
        String bookingId = request.getParameter("bookingId");
        String reason = request.getParameter("cancelReason");
        String bookingType = request.getParameter("bookingType");
        
        // In a real application, you would update the booking status in the database
        // For demo purposes, we'll just log the action
        System.out.println("Cancelled booking " + bookingId + " for reason: " + reason);
    }
    
    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Bookings Servlet handling test drive and service appointment operations";
    }
} 