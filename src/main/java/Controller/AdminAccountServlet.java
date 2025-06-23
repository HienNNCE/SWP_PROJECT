package Controller;

import DAO.UserDAO;
import Model.Users;
import util.ValidationUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminAccountServlet", urlPatterns = {"/admin/accounts/*"})
public class AdminAccountServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getPathInfo();
        if (action == null || action.equals("/") || action.isEmpty()) {
            action = "/list";
        }

        try {
            switch (action) {
                case "/list":
                    listUsers(request, response);
                    break;
                case "/edit":
                    showEditForm(request, response);
                    break;
                case "/search":
                    searchUsers(request, response);
                    break;
                default:
                    listUsers(request, response);
                    break;
            }
        } catch (Exception e) {
            request.getSession().setAttribute("message", "Error: " + e.getMessage());
            request.getSession().setAttribute("messageType", "danger");
            response.sendRedirect(request.getContextPath() + "/admin/accounts");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getPathInfo();
        if (action == null) {
            action = "/list";
        }

        try {
            switch (action) {
                case "/add":
                    addUser(request, response);
                    break;
                case "/update":
                    updateUser(request, response);
                    break;
                case "/toggle-status":
                    toggleUserStatus(request, response);
                    break;
                default:
                    listUsers(request, response);
                    break;
            }
        } catch (Exception e) {
            request.getSession().setAttribute("message", "Error: " + e.getMessage());
            request.getSession().setAttribute("messageType", "danger");
            response.sendRedirect(request.getContextPath() + "/admin/accounts");
        }
    }

    private void listUsers(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String keyword = request.getParameter("keyword");

        List<Users> users;
        if (keyword != null && !keyword.trim().isEmpty()) {
            users = userDAO.searchUsers(keyword.trim());
            request.setAttribute("keyword", keyword);
        } else {
            users = userDAO.getAllUsers();
        }

        request.setAttribute("users", users);
        request.getRequestDispatcher("/admin/account-list.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, Exception {
        try {
            int userId = Integer.parseInt(request.getParameter("id"));
            Users user = userDAO.getUserById(userId);
            if (user == null) {
                throw new Exception("User not found");
            }
            request.setAttribute("user", user);
            request.getRequestDispatcher("/admin/account-edit.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            throw new Exception("Invalid user ID");
        }
    }

    private void addUser(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String username = request.getParameter("userName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String roleId = request.getParameter("roleId");

        // Validate data
        String errorMessage = ValidationUtil.validateUserData(username, email, password, phone, address);
        if (errorMessage != null) {
            request.getSession().setAttribute("message", errorMessage);
            request.getSession().setAttribute("messageType", "danger");
            response.sendRedirect(request.getContextPath() + "/admin/accounts");
            return;
        }

        try {
            Users user = new Users();
            user.setUserName(username);
            user.setEmail(email);
            user.setPassword(password);
            user.setPhone(phone);
            user.setAddress(address);
            user.setRoleId(Integer.parseInt(roleId));

            userDAO.addUser(user);
            request.getSession().setAttribute("message", "User added successfully!");
            request.getSession().setAttribute("messageType", "success");
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("message", "Invalid data format");
            request.getSession().setAttribute("messageType", "danger");
        } catch (Exception e) {
            request.getSession().setAttribute("message", "Error adding user: " + e.getMessage());
            request.getSession().setAttribute("messageType", "danger");
        }
        response.sendRedirect(request.getContextPath() + "/admin/accounts");
    }

    private void updateUser(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String userId = request.getParameter("userId");
        String username = request.getParameter("userName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String roleId = request.getParameter("roleId");

        // Validate data
        String errorMessage = ValidationUtil.validateUserData(username, email, "Password123!", phone, address);
        if (errorMessage != null) {
            request.getSession().setAttribute("message", errorMessage);
            request.getSession().setAttribute("messageType", "danger");
            response.sendRedirect(request.getContextPath() + "/admin/accounts");
            return;
        }

        try {
            Users user = new Users();
            user.setUserId(Integer.parseInt(userId));
            user.setUserName(username);
            user.setEmail(email);
            user.setPhone(phone);
            user.setAddress(address);
            user.setRoleId(Integer.parseInt(roleId));

            userDAO.updateUser(user);
            request.getSession().setAttribute("message", "User updated successfully!");
            request.getSession().setAttribute("messageType", "success");
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("message", "Invalid data format");
            request.getSession().setAttribute("messageType", "danger");
        } catch (Exception e) {
            request.getSession().setAttribute("message", "Error updating user: " + e.getMessage());
            request.getSession().setAttribute("messageType", "danger");
        }
        response.sendRedirect(request.getContextPath() + "/admin/accounts");
    }

    private void toggleUserStatus(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        try {
            int userId = Integer.parseInt(request.getParameter("userId"));
            userDAO.toggleUserStatus(userId);
            request.getSession().setAttribute("message", "User status updated successfully!");
            request.getSession().setAttribute("messageType", "success");
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("message", "Invalid user ID");
            request.getSession().setAttribute("messageType", "danger");
        } catch (Exception e) {
            request.getSession().setAttribute("message", "Error updating user status: " + e.getMessage());
            request.getSession().setAttribute("messageType", "danger");
        }
        response.sendRedirect(request.getContextPath() + "/admin/accounts");
    }

    private void searchUsers(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String keyword = request.getParameter("keyword");

        if (keyword == null || keyword.trim().isEmpty()) {
            // Nếu từ khóa rỗng → redirect về danh sách gốc
            response.sendRedirect(request.getContextPath() + "/admin/accounts");
            return;
        }

        List<Users> users = userDAO.searchUsers(keyword.trim());
        request.setAttribute("users", users);
        request.setAttribute("keyword", keyword);
        request.getRequestDispatcher("/admin/account-list.jsp").forward(request, response);
    }

}
