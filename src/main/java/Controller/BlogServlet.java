package Controller;

import DAO.BlogDAO;
import Model.Blog;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.time.ZoneId;
import java.util.*;
import util.MenuDataHelper;

@WebServlet(name = "BlogServlet", urlPatterns = {"/blog", "/blog/detail"})
public class BlogServlet extends HttpServlet {

    private BlogDAO blogDAO;

    @Override
    public void init() {
        blogDAO = new BlogDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        MenuDataHelper.preloadCarList(request);
        String path = request.getServletPath();

        if ("/blog/detail".equals(path)) {
            int id = Integer.parseInt(request.getParameter("id"));
            Blog selected = blogDAO.getBlogById(id);

            if (selected == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                return;
            }

            Date publishedDate = Date.from(selected.getPublishedAt().atZone(ZoneId.systemDefault()).toInstant());
            request.setAttribute("blog", selected);
            request.setAttribute("publishedDate", publishedDate);
            request.getRequestDispatcher("/blog-detail.jsp").forward(request, response);
        } else {
            List<Blog> blogs = blogDAO.getAllBlogs();
            List<Map<String, Object>> result = new ArrayList<>();
            for (Blog b : blogs) {
                Map<String, Object> map = new HashMap<>();
                map.put("id", b.getId());
                map.put("title", b.getTitle());
                map.put("summary", b.getSummary());
                map.put("content", b.getContent());
                map.put("image", b.getImage());
                map.put("publishedDate", Date.from(b.getPublishedAt().atZone(ZoneId.systemDefault()).toInstant()));
                result.add(map);
            }
            request.setAttribute("blogs", result);
            request.getRequestDispatcher("/blog-list.jsp").forward(request, response);
        }
    }
}
