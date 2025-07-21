/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Filter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author Nguyen Huynh Nhat Thien
 */
@WebFilter("/staff/*")
public class StaffFilter implements Filter {
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = ((HttpServletRequest) request).getSession(false);

        if (session != null) {
            Object roleObj = session.getAttribute("role");

            if (roleObj instanceof Integer) {
                int role = (Integer) roleObj;

                if (role == 4) {
                    chain.doFilter(request, response);
                    return;
                }
            }
        }
        // Nếu không hợp lệ
        res.sendRedirect(((HttpServletRequest) request).getContextPath() + "/home");

    }
}
