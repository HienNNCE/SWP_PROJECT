package Controller;

import DAO.CartDAO;
import DAO.OrderDAO;
import Model.Cart;
import Model.Order;
import Model.OrderDetail;
import Model.Part;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.Date;

@WebServlet(name = "CheckoutServlet", urlPatterns = { "/checkout" })
public class CheckoutServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        CartDAO cartDAO = new CartDAO();
        Cart cart = cartDAO.getCartDetailByUserId(userId);
        request.setAttribute("cart", cart);
        request.setAttribute("partList", cart.getPartList());
        request.setAttribute("totalPrice", cart.getCartPrice());
        // Bổ sung biến cho navbar
        DAO.CarDAO carDAO = new DAO.CarDAO();
        DAO.PartDAO partDAO = new DAO.PartDAO();
        java.util.List<String> carBrands = carDAO.getAllBrands();
        java.util.List<String> carCategories = carDAO.getAllCategories();
        java.util.List<Model.Car> latestCars = carDAO.getRandomCars(8);
        if (latestCars == null || latestCars.isEmpty()) {
            latestCars = carDAO.getAllCars();
        }
        java.util.List<String> partBrands = partDAO.getAllBrands();
        request.setAttribute("carBrands", carBrands);
        request.setAttribute("carCategories", carCategories);
        request.setAttribute("latestCars", latestCars);
        request.setAttribute("partBrands", partBrands);
        request.getRequestDispatcher("checkout.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        System.out.println("Test 1");

        CartDAO cartDAO = new CartDAO();
        Cart cart = cartDAO.getCartDetailByUserId(userId);
        if (cart == null || cart.getPartList() == null || cart.getPartList().isEmpty()) {
            response.sendRedirect("cart.jsp");
            return;
        }

        System.out.println("Test 2");

        OrderDAO orderDAO = new OrderDAO();
        Order order = new Order();
        order.setUserId(userId);
        order.setOrderPrice(cart.getCartPrice());
        order.setOrderStatus("Processing");
        order.setOrderDate(new java.util.Date());
        order.setPaymentId(1);
        int orderId = 0;
        try {
            orderId = orderDAO.insertOrder(order);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        System.out.println("Test 3");

        for (Part part : cart.getPartList()) {
            OrderDetail detail = new OrderDetail();
            detail.setOrderId(orderId);
            detail.setPartId(part.getPartId());
            detail.setQuantity(part.getQuantityInCart());
            detail.setPrice(part.getPartPrice());
            detail.setTotalPrice(part.getTotalPrice());
            try {
                orderDAO.insertOrderDetail(detail);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        System.out.println("Test 4");
        boolean success = cartDAO.checkoutCartAndUpdateStock(userId);
        if (!success) {
            response.sendRedirect("cart.jsp");
            return;
        }
        System.out.println("Test 5");
        cartDAO.clearCartByUserId(userId);
        response.sendRedirect("success.jsp");
    }
}