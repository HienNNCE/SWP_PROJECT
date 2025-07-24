/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.UserDAO;
import Model.Address;
import Model.Users;
import Service.HashUtil;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDate;
import java.util.List;
import util.ValidationUtil;

@WebServlet(name = "ProfileServlet", urlPatterns = {"/profile"})
public class ProfileServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Users currentUser = (Users) session.getAttribute("user");
        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Load addresses for display
        List<Address> addresses = userDAO.getAddressesByUserId(currentUser.getUserId());
        int count = addresses.size();
        request.setAttribute("addresses", addresses);
        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Users currentUser = (Users) session.getAttribute("user");
        String action = request.getParameter("action");

        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        if ("update".equals(action)) {
            // Cập nhật thông tin cá nhân (giữ nguyên từ phiên bản trước)
            String userName = request.getParameter("userName");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            String fullName = request.getParameter("fullName");
            String genderParam = request.getParameter("gender");
            String dobParam = request.getParameter("dob");
            String aboutMe = request.getParameter("aboutMe");
            int userId = Integer.parseInt(request.getParameter("userId"));

            String errorMessage = ValidationUtil.validateUserData(fullName, userName, email, currentUser.getPassword(),
                    phone, address, genderParam, dobParam, aboutMe, false);
            if (errorMessage != null) {
                request.setAttribute("message", errorMessage);
                request.setAttribute("success", false);
                request.getRequestDispatcher("profile.jsp").forward(request, response);
                return;
            }

            Users existingEmailUser = userDAO.getUserByEmail(email);
            if (existingEmailUser != null && existingEmailUser.getUserId() != userId) {
                request.setAttribute("message", "Email already in use!");
                request.setAttribute("success", false);
                request.getRequestDispatcher("profile.jsp").forward(request, response);
                return;
            }

            Users existingUsernameUser = userDAO.getUserByUsername(userName);
            if (existingUsernameUser != null && existingUsernameUser.getUserId() != userId) {
                request.setAttribute("message", "Username already in use!");
                request.setAttribute("success", false);
                request.getRequestDispatcher("profile.jsp").forward(request, response);
                return;
            }

            Users existingPhoneUser = userDAO.getUserByPhone(phone);
            if (existingPhoneUser != null && existingPhoneUser.getUserId() != userId) {
                request.setAttribute("message", "Phone number already in use!");
                request.setAttribute("success", false);
                request.getRequestDispatcher("profile.jsp").forward(request, response);
                return;
            }

            Users dbUser = userDAO.getUserById(userId);
            if (dbUser == null) {
                request.setAttribute("message", "User not found!");
                request.setAttribute("success", false);
                request.getRequestDispatcher("profile.jsp").forward(request, response);
                return;
            }

            dbUser.setUserName(userName);
            dbUser.setEmail(email);
            dbUser.setPhone(phone);
            dbUser.setAddress(address);
            dbUser.setFullName(fullName);
            dbUser.setAboutMe(aboutMe);

            dbUser.setGender("MALE".equalsIgnoreCase(genderParam));

            try {
                if (dobParam != null && !dobParam.trim().isEmpty()) {
                    dbUser.setDob(LocalDate.parse(dobParam));
                }
            } catch (Exception e) {
                request.setAttribute("message", "Invalid date format");
                request.setAttribute("success", false);
                request.getRequestDispatcher("profile.jsp").forward(request, response);
                return;
            }

            userDAO.updateUser(dbUser);

            session.setAttribute("user", dbUser);
            request.setAttribute("message", "Update profile successfully!");
            request.setAttribute("success", true);

            List<Address> addresses = userDAO.getAddressesByUserId(userId);
            request.setAttribute("addresses", addresses);

            request.getRequestDispatcher("profile.jsp").forward(request, response);
        } else if ("changePassword".equals(action)) {
            // Thay đổi mật khẩu (giữ nguyên từ phiên bản trước)
            String currentPassword = request.getParameter("currentPassword");
            String newPassword = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmPassword");
            int userId = Integer.parseInt(request.getParameter("userId"));

            if (currentPassword == null || newPassword == null || confirmPassword == null
                    || currentPassword.trim().isEmpty() || newPassword.trim().isEmpty() || confirmPassword.trim().isEmpty()) {
                request.setAttribute("message", "All password fields are required!");
                request.setAttribute("success", false);
                request.getRequestDispatcher("profile.jsp").forward(request, response);
                return;
            }

            Users dbUser = userDAO.getUserById(userId);
            if (dbUser == null) {
                request.setAttribute("message", "User not found!");
                request.setAttribute("success", false);
                request.getRequestDispatcher("profile.jsp").forward(request, response);
                return;
            }

            if (!dbUser.getPassword().equals(HashUtil.toMD5(currentPassword))) {
                request.setAttribute("message", "Current password is incorrect!");
                request.setAttribute("success", false);
                request.getRequestDispatcher("profile.jsp").forward(request, response);
                return;
            }

            if (!newPassword.equals(confirmPassword)) {
                request.setAttribute("message", "New password does not match!.");
                request.setAttribute("success", false);
                request.getRequestDispatcher("profile.jsp").forward(request, response);
                return;
            }

            userDAO.updateUserPassword(userId, newPassword);
            dbUser.setPassword(newPassword);
            session.setAttribute("user", dbUser);
            request.setAttribute("message", "Change password successfully!");
            request.setAttribute("success", true);
            List<Address> addresses = userDAO.getAddressesByUserId(userId);
            request.setAttribute("addresses", addresses);
            request.getRequestDispatcher("profile.jsp").forward(request, response);
        } else if ("addAddress".equals(action)) {
            // Thêm địa chỉ mới
            String addressName = request.getParameter("addressName");
            String addressDetails = request.getParameter("addressDetails");
            String phone = request.getParameter("phone");
            boolean isDefault = "on".equals(request.getParameter("isDefault"));
            int userId = Integer.parseInt(request.getParameter("userId"));

            if (addressName == null || addressName.trim().isEmpty() || addressDetails == null || addressDetails.trim().isEmpty()) {
                request.setAttribute("message", "Address name and address details are required!");
                request.setAttribute("success", false);
                List<Address> addresses = userDAO.getAddressesByUserId(userId);
                request.setAttribute("addresses", addresses);
                request.getRequestDispatcher("profile.jsp").forward(request, response);
                return;
            }

            Address address = new Address();
            address.setUserId(userId);
            address.setAddressName(addressName);
            address.setAddressDetails(addressDetails);
            address.setPhone(phone);
            address.setDefault(isDefault);
            userDAO.addAddress(address);

            request.setAttribute("message", "Add address successfully!.");
            request.setAttribute("success", true);
            List<Address> addresses = userDAO.getAddressesByUserId(userId);
            request.setAttribute("addresses", addresses);
            request.getRequestDispatcher("profile.jsp").forward(request, response);
        } else if ("editAddress".equals(action)) {
            // Sửa địa chỉ
            int addressId = Integer.parseInt(request.getParameter("addressId"));
            String addressName = request.getParameter("addressName");
            String addressDetails = request.getParameter("addressDetails");
            String phone = request.getParameter("phone");
            boolean isDefault = "on".equals(request.getParameter("isDefault"));
            int userId = Integer.parseInt(request.getParameter("userId"));

            if (addressName == null || addressName.trim().isEmpty() || addressDetails == null || addressDetails.trim().isEmpty()) {
                request.setAttribute("message", "Address name and address details are required!");
                request.setAttribute("success", false);
                List<Address> addresses = userDAO.getAddressesByUserId(userId);
                request.setAttribute("addresses", addresses);
                request.getRequestDispatcher("profile.jsp").forward(request, response);
                return;
            }

            Address address = new Address();
            address.setAddressId(addressId);
            address.setUserId(userId);
            address.setAddressName(addressName);
            address.setAddressDetails(addressDetails);
            address.setPhone(phone);
            address.setDefault(isDefault);
            userDAO.updateAddress(address);

            request.setAttribute("message", "Update address successfully!");
            request.setAttribute("success", true);
            List<Address> addresses = userDAO.getAddressesByUserId(userId);
            request.setAttribute("addresses", addresses);
            request.getRequestDispatcher("profile.jsp").forward(request, response);
        } else if ("deleteAddress".equals(action)) {
            // Xóa địa chỉ
            int addressId = Integer.parseInt(request.getParameter("addressId"));
            int userId = Integer.parseInt(request.getParameter("userId"));

            userDAO.deleteAddress(addressId);

            request.setAttribute("message", "Delete address successfully!.");
            request.setAttribute("success", true);
            List<Address> addresses = userDAO.getAddressesByUserId(userId);
            request.setAttribute("addresses", addresses);
            request.getRequestDispatcher("profile.jsp").forward(request, response);
        } else {
            response.sendRedirect("profile.jsp");
        }
    }
}
