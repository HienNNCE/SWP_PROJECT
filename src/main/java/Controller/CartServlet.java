package Controller;

import DAO.CartDAO;
import Model.Cart;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "CartServlet", urlPatterns = { "/cart" })
public class CartServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        CartDAO cDAO = new CartDAO();
        Cart cart = (Cart) cDAO.getCartDetailByUserId(userId);
        if (cart == null) {
            cart = new Cart();
            cart.setUserId(userId);
            cart.setPartList(List.of());
        }
        request.setAttribute("cart", cart);
        request.setAttribute("partList", cart.getPartList());
        request.setAttribute("totalPrice", cart.getCartPrice());
        for (Model.Part part : cart.getPartList()) {
            System.out.println("Part Stock: " + part.getPartStock());
        }
        // Bổ sung biến cho navbar
        DAO.CarDAO carDAO = new DAO.CarDAO();
        DAO.PartDAO partDAO = new DAO.PartDAO();
        List<String> carBrands = carDAO.getAllBrands();
        List<String> carCategories = carDAO.getAllCategories();
        List<Model.Car> latestCars = carDAO.getRandomCars(8);
        if (latestCars == null || latestCars.isEmpty()) {
            latestCars = carDAO.getAllCars();
        }
        List<String> partBrands = partDAO.getAllBrands();
        request.setAttribute("carBrands", carBrands);
        request.setAttribute("carCategories", carCategories);
        request.setAttribute("latestCars", latestCars);
        request.setAttribute("partBrands", partBrands);
        request.getRequestDispatcher("/cart.jsp").forward(request, response);
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

        String action = request.getParameter("action");

        String partIdRaw = request.getParameter("partId");
        if (partIdRaw == null || partIdRaw.trim().isEmpty()) {
            // Xử lý lỗi hoặc chuyển hướng về trang giỏ hàng với thông báo
            response.sendRedirect("cart?error=missingPartId");
            return;
        }
        try {
            int partId = Integer.parseInt(partIdRaw);
            CartDAO cDAO = new CartDAO();

            switch (action) {
                case "increase":
                    cDAO.increaseQuantity(userId, partId);
                    break;
                case "decrease":
                    cDAO.decreaseQuantity(userId, partId);
                    break;
                case "remove":
                    cDAO.removePartFromCart(userId, partId);
                    break;
            }
            response.sendRedirect("cart"); // load lại trang giỏ hàng

        } catch (NumberFormatException e) {
            // Xử lý lỗi khi partId không hợp lệ
            response.sendRedirect("cart?error=invalidPartId");
            return;
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

}
