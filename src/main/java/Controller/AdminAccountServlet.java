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
import java.time.LocalDate;
import java.util.List;

@WebServlet(name = "AdminAccountServlet", urlPatterns = {"/admin/users", "/admin/users/edit", "/admin/users/search", "/admin/users/create", "/admin/users/toggle-status"})
public class AdminAccountServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getServletPath();

        try {
            switch (action) {
                case "/admin/users/create":
                    showAddForm(request, response);
                    break;
                case "/admin/users":
                    listUsers(request, response);
                    break;
                case "/admin/users/edit":
                    showEditForm(request, response);
                    break;
                case "/admin/users/search":
                    searchUsers(request, response);
                    break;

                default:
                    listUsers(request, response);
                    break;
            }
        } catch (Exception e) {
            request.getSession().setAttribute("message", "Error: " + e.getMessage());
            request.getSession().setAttribute("messageType", "danger");
            response.sendRedirect(request.getContextPath() + "/admin/users");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getServletPath();

        try {
            switch (action) {
                case "/admin/users/create":
                    addUser(request, response);
                    break;
                case "/admin/users/edit":
                    updateUser(request, response);
                    break;
                case "/admin/users/toggle-status":
                    toggleUserStatus(request, response);
                    break;
                default:
                    listUsers(request, response);
                    break;
            }
        } catch (Exception e) {
            request.getSession().setAttribute("message", "Error: " + e.getMessage());
            request.getSession().setAttribute("messageType", "danger");
            response.sendRedirect(request.getContextPath() + "/admin/users");
        }
    }

    private void listUsers(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        String pageParam = request.getParameter("page");
        String sizeParam = request.getParameter("size");

        int page = 1;
        int size = 5;

        try {
            page = pageParam != null ? Integer.parseInt(pageParam) : 1;
            size = sizeParam != null ? Integer.parseInt(sizeParam) : 5;
        } catch (NumberFormatException ignored) {
        }

        int offset = (page - 1) * size;

        List<Users> users = userDAO.searchUsersWithPaging(keyword, offset, size);
        int totalUsers = userDAO.countUsers(keyword);
        int totalPages = (int) Math.ceil((double) totalUsers / size);

        request.setAttribute("users", users);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("keyword", keyword != null ? keyword : "");

        request.getRequestDispatcher("/admin/user/account-list.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, Exception {
        try {
            int userId = Integer.parseInt(request.getParameter("id"));
            Users user = userDAO.getUserById(userId);
            if (user == null) {
                throw new Exception("User not found");
            }
            request.setAttribute("user", user);
            request.getRequestDispatcher("/admin/user/account-edit.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            throw new Exception("Invalid user ID");
        }
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/admin/user/create-form.jsp").forward(request, response);
    }

    private void addUser(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String fullName = request.getParameter("fullName");
        String username = request.getParameter("userName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");
        String genderParam = request.getParameter("gender");
        String dobParam = request.getParameter("dob");
        String aboutMe = request.getParameter("aboutMe");
        String address = request.getParameter("address");
        String roleId = request.getParameter("roleId");

        // Validate data
        String errorMessage = ValidationUtil.validateUserData(fullName, username, email, password, phone, address, genderParam, dobParam, aboutMe);
        if (userDAO.getUserByEmail(email) != null) {
            errorMessage = "Email already exists";
        }
        if (userDAO.getUserByUsername(username) != null) {
            errorMessage = "Username already exists";
        }
        if (userDAO.getUserByPhone(phone) != null) {
            errorMessage = "Phone already exists";
        }
        if (errorMessage != null) {
            request.setAttribute("error", errorMessage);
            request.getRequestDispatcher("/admin/user/create-form.jsp").forward(request, response);
            return;
        }

        try {
            Users user = new Users();
            user.setFullName(fullName);
            user.setUserName(username);
            user.setEmail(email);
            user.setPassword(password);
            user.setPhone(phone);
            user.setAddress(address);
            user.setAboutMe(aboutMe);

            boolean gender = "MALE".equalsIgnoreCase(genderParam);
            user.setGender(gender);

            if (dobParam != null && !dobParam.isEmpty()) {
                user.setDob(LocalDate.parse(dobParam));
            }

            user.setRoleId(Integer.parseInt(roleId));
            user.setUserStatus("Active");

            userDAO.addUser(user);
            request.setAttribute("message", "User added successfully!");
            request.setAttribute("messageType", "success");
        } catch (NumberFormatException e) {
            request.setAttribute("message", "Invalid data format");
            request.setAttribute("messageType", "danger");
        } catch (Exception e) {
            request.setAttribute("message", "Error adding user: " + e.getMessage());
            request.setAttribute("messageType", "danger");
        }
        response.sendRedirect(request.getContextPath() + "/admin/users");
    }

    private void updateUser(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        int parsedUserId = Integer.parseInt(request.getParameter("userId"));

        String fullName = request.getParameter("fullName");
        String genderParam = request.getParameter("gender");
        String dobParam = request.getParameter("dob");
        String aboutMe = request.getParameter("aboutMe");

        String username = request.getParameter("userName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String roleId = request.getParameter("roleId");

        // Validate (có thể thêm validate cho fullName, dob, gender, aboutMe)
        String errorMessage = ValidationUtil.validateUserData(fullName, username, email, password, phone, address, genderParam, dobParam, aboutMe);

        Users existingEmailUser = userDAO.getUserByEmail(email);
        if (existingEmailUser != null && existingEmailUser.getUserId() != parsedUserId) {
            errorMessage = "Email already exists!";
        }

        Users existingUsernameUser = userDAO.getUserByUsername(username);
        if (existingUsernameUser != null && existingUsernameUser.getUserId() != parsedUserId) {
            errorMessage = "Username already exists";
        }

        Users existingPhoneUser = userDAO.getUserByPhone(phone);
        if (existingPhoneUser != null && existingPhoneUser.getUserId() != parsedUserId) {
            errorMessage = "Phone already exists";
        }

        if (errorMessage != null) {
            Users user = userDAO.getUserById(parsedUserId);
            request.setAttribute("user", user);
            request.setAttribute("error", errorMessage);
            request.getRequestDispatcher("/admin/user/account-edit.jsp").forward(request, response);
            return;
        }

        try {
            Users user = new Users();
            user.setUserId(parsedUserId);
            user.setFullName(fullName);
            user.setGender("MALE".equalsIgnoreCase(genderParam));
            user.setDob(LocalDate.parse(dobParam));
            user.setAboutMe(aboutMe);

            user.setUserName(username);
            user.setEmail(email);
            user.setPassword(password);
            user.setPhone(phone);
            user.setAddress(address);
            user.setRoleId(Integer.parseInt(roleId));
            user.setUserStatus("Active");

            userDAO.updateUser(user);
            response.sendRedirect(request.getContextPath() + "/admin/users");
        } catch (Exception e) {
            request.setAttribute("message", "Error updating user: " + e.getMessage());
            request.setAttribute("messageType", "danger");
            request.getRequestDispatcher("/admin/user/account-edit.jsp").forward(request, response);
        }
    }

    private void toggleUserStatus(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        try {
            int userId = Integer.parseInt(request.getParameter("userId"));
            userDAO.toggleUserStatus(userId);
            request.setAttribute("message", "User status updated successfully!");
            request.setAttribute("messageType", "success");
        } catch (NumberFormatException e) {
            request.setAttribute("message", "Invalid user ID");
            request.setAttribute("messageType", "danger");
        } catch (Exception e) {
            request.setAttribute("message", "Error updating user status: " + e.getMessage());
            request.setAttribute("messageType", "danger");
        }
        response.sendRedirect(request.getContextPath() + "/admin/users");
    }

    private void searchUsers(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String keyword = request.getParameter("keyword");

        if (keyword == null || keyword.trim().isEmpty()) {
            // Nếu từ khóa rỗng → redirect về danh sách gốc
            response.sendRedirect(request.getContextPath() + "/admin/users");
            return;
        }

        List<Users> users = userDAO.searchUsers(keyword.trim());
        request.setAttribute("users", users);
        request.setAttribute("keyword", keyword);
        request.getRequestDispatcher("/admin/account-list.jsp").forward(request, response);
    }

}
