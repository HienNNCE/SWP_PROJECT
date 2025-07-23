/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import java.io.IOException;
import java.util.List;

import DAO.OrderDAO;
import DAO.OrderDetailDAO;
import Model.Order;
import Model.OrderDetail;
import Model.Users;
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
@WebServlet(name = "OrderServlet", urlPatterns = { "/order" })
public class OrderServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        OrderDAO orderDAO = new OrderDAO();
        HttpSession session = request.getSession();
        if ("view".equals(action)) {
            // Hiển thị chi tiết đơn hàng
            int orderId = Integer.parseInt(request.getParameter("id"));
            Order order = orderDAO.getOrderById(orderId);
            OrderDetailDAO orderDetailDAO = new OrderDetailDAO();
            List<OrderDetail> orderDetail = orderDetailDAO.getOrderDetailWithPartByOrderId(orderId);
            if (orderDetail != null) {
                request.setAttribute("orderDetail", orderDetail);
                request.setAttribute("order", order);
                request.getRequestDispatcher("/order-detail-customer.jsp").forward(request, response);
                return;
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Order not found");
                return;
            }
        }
        // Hiển thị danh sách đơn hàng
        Users user = (Users) session.getAttribute("user");
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        List<Order> orders = orderDAO.getOrdersByUserId(user.getUserId());
        for (Order order : orders) {
            int countItem = orderDAO.countTotalQuantityByOrderId(order.getOrderId());
            order.setCountItem(countItem);
        }
        request.setAttribute("orders", orders);
        request.getRequestDispatcher("order-history.jsp").forward(request, response);
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
        OrderDAO orderDAO = new OrderDAO();

        if ("updateStatus".equals(action)) {
            try {
                int orderId = Integer.parseInt(request.getParameter("orderId"));
                String status = request.getParameter("status");

                orderDAO.updateOrderStatus(orderId, status);

            } catch (NumberFormatException e) {
                e.printStackTrace(); // Ghi log lỗi nếu cần
            }

            response.sendRedirect("OrderManagementServlet");
            return;
        }

        // Thêm các xử lý POST khác nếu cần
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
