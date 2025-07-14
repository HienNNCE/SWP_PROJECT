/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.OrderDAO;
import DAO.OrderDetailDAO;
import Model.Order;
import Model.OrderDetail;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

/**
 *
 * @author thien
 */
@WebServlet(name = "OrderManagementServlet", urlPatterns = { "/OrderManagementServlet" })
public class OrderManagementServlet extends HttpServlet {

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
        String action = request.getParameter("action");
        OrderDAO orderDAO = new OrderDAO();
        if ("delete".equals(action)) {
            // Xóa đơn hàng
            int orderId = Integer.parseInt(request.getParameter("id"));
            orderDAO.deleteOrder(orderId);
            response.sendRedirect("OrderManagementServlet");
            return;
        }
        if ("view".equals(action)) {
            // Hiển thị chi tiết đơn hàng
            int orderId = Integer.parseInt(request.getParameter("id"));
            Order order = orderDAO.getOrderById(orderId);
            OrderDetailDAO orderDetailDAO = new OrderDetailDAO();
            System.out.println("Order date: " + order.getOrderDate());
            List<OrderDetail> orderDetail = orderDetailDAO.getOrderDetailWithPartByOrderId(orderId);
            if (orderDetail != null) {
                request.setAttribute("orderDetail", orderDetail);
                request.setAttribute("order", order);
                request.getRequestDispatcher("/admin/order/order-detail.jsp").forward(request, response);
                return;
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Order not found");
                return;
            }
        }
        // Hiển thị danh sách đơn hàng
        List<Order> orders = orderDAO.getAllOrders();
        request.setAttribute("orders", orders);
        request.getRequestDispatcher("/admin/order/order.jsp").forward(request, response);
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
