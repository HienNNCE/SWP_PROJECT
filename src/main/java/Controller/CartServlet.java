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
 * Servlet handling shopping cart operations such as viewing the cart, adding items,
 * updating quantities, and removing items.
 */
@WebServlet(name = "CartServlet", urlPatterns = {"/cart"})
public class CartServlet extends HttpServlet {
    
    /**
     * Handles the HTTP GET request - displays the shopping cart page
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
        
        // For demo purposes, we'll check if there are cart items in the session
        // In a real application, you would fetch the cart items from a database
        List<Object> cartItems = (List<Object>) session.getAttribute("cartItems");
        
        // Pass cart items to the JSP
        request.setAttribute("cartItems", cartItems);
        
        // Forward to cart page
        RequestDispatcher dispatcher = request.getRequestDispatcher("/cart.jsp");
        dispatcher.forward(request, response);
    }

    /**
     * Handles the HTTP POST request - handles adding, updating, or removing cart items
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
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }
        
        switch (action) {
            case "add":
                // Logic for adding item to cart
                addToCart(request, session);
                break;
                
            case "update":
                // Logic for updating cart item quantity
                updateCart(request, session);
                break;
                
            case "remove":
                // Logic for removing item from cart
                removeFromCart(request, session);
                break;
                
            case "clear":
                // Logic for clearing the cart
                clearCart(session);
                break;
                
            default:
                break;
        }
        
        // Redirect back to the cart page
        response.sendRedirect(request.getContextPath() + "/cart");
    }

    /**
     * Adds an item to the shopping cart
     * 
     * @param request the HTTP request
     * @param session the HTTP session
     */
    private void addToCart(HttpServletRequest request, HttpSession session) {
        // Get cart parameters
        String carId = request.getParameter("carId");
        
        // In a real application, you would fetch the car details from a database
        // and create a proper cart item object
        
        // For demo purposes, we'll just add a placeholder
        List<Object> cartItems = (List<Object>) session.getAttribute("cartItems");
        if (cartItems == null) {
            cartItems = new ArrayList<>();
            session.setAttribute("cartItems", cartItems);
        }
        
        // Add car to cart (this would be replaced with actual logic)
        // cartItems.add(new CartItem(...));
    }

    /**
     * Updates the quantity of an item in the shopping cart
     * 
     * @param request the HTTP request
     * @param session the HTTP session
     */
    private void updateCart(HttpServletRequest request, HttpSession session) {
        // Get cart parameters
        String carId = request.getParameter("carId");
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        
        // Update the cart item in the session
        List<Object> cartItems = (List<Object>) session.getAttribute("cartItems");
        if (cartItems != null) {
            // Logic to find and update the cart item
        }
    }

    /**
     * Removes an item from the shopping cart
     * 
     * @param request the HTTP request
     * @param session the HTTP session
     */
    private void removeFromCart(HttpServletRequest request, HttpSession session) {
        // Get cart parameters
        String carId = request.getParameter("carId");
        
        // Remove the cart item from the session
        List<Object> cartItems = (List<Object>) session.getAttribute("cartItems");
        if (cartItems != null) {
            // Logic to find and remove the cart item
        }
    }

    /**
     * Clears all items from the shopping cart
     * 
     * @param session the HTTP session
     */
    private void clearCart(HttpSession session) {
        // Remove the cart items from the session
        session.removeAttribute("cartItems");
    }
    
    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Cart Servlet handling shopping cart operations";
    }
} 