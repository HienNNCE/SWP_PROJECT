package Controller;

import DAO.BlogDAO;
import Model.Blog;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.*;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.*;

@WebServlet(name = "AdminBlogServlet", urlPatterns = {
    "/admin/blog", "/admin/blog/create", "/admin/blog/edit", "/admin/blog/delete", "/admin/blog/detail"
})
@MultipartConfig
public class AdminBlogServlet extends HttpServlet {

    private BlogDAO blogDAO;

    @Override
    public void init() {
        blogDAO = new BlogDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getServletPath();

        switch (action) {
            case "/admin/blog/create":
                showCreateForm(request, response);
                break;
            case "/admin/blog/edit":
                showEditForm(request, response);
                break;
            case "/admin/blog/delete":
                deleteBlog(request, response);
                break;
            case "/admin/blog/detail":
                showDetail(request, response);
                break;
            default:
                listBlogs(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getServletPath();
        switch (action) {
            case "/admin/blog/create":
                handleCreate(request, response);
                break;
            case "/admin/blog/edit":
                handleEdit(request, response);
                break;
        }
    }

    private void listBlogs(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        List<Blog> blogs = (keyword != null && !keyword.isEmpty())
                ? blogDAO.searchByTitle(keyword)
                : blogDAO.getAllBlogs();

        // Chuyển LocalDateTime thành Date để dùng trong fmt:formatDate
        List<Map<String, Object>> blogList = new ArrayList<>();
        for (Blog b : blogs) {
            Map<String, Object> map = new HashMap<>();
            map.put("id", b.getId());
            map.put("title", b.getTitle());
            map.put("summary", b.getSummary());
            map.put("content", b.getContent());
            map.put("image", b.getImage());
            map.put("publishedDate", Date.from(b.getPublishedAt().atZone(ZoneId.systemDefault()).toInstant()));
            blogList.add(map);
        }

        request.setAttribute("blogs", blogList);
        request.getRequestDispatcher("/admin/blog/list.jsp").forward(request, response);
    }

    private void showCreateForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/admin/blog/create-form.jsp").forward(request, response);
    }

    private void handleCreate(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Blog blog = extractBlogFromRequest(request, null);
        Map<String, String> errors = validateBlog(blog);

        if (!errors.isEmpty()) {
            request.setAttribute("errors", errors);
            request.setAttribute("oldBlog", blog);
            request.getRequestDispatcher("/admin/blog/create-form.jsp").forward(request, response);
            return;
        }

        blogDAO.create(blog);
        response.sendRedirect(request.getContextPath() + "/admin/blog?msg=created");
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Blog blog = blogDAO.getBlogById(id);
        if (blog == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }
        request.setAttribute("blog", blog);
        request.getRequestDispatcher("/admin/blog/edit-form.jsp").forward(request, response);
    }

    private void handleEdit(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Blog oldBlog = blogDAO.getBlogById(id);
        if (oldBlog == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        Blog updated = extractBlogFromRequest(request, oldBlog.getImage());
        updated.setId(id);
        Map<String, String> errors = validateBlog(updated);

        if (!errors.isEmpty()) {
            request.setAttribute("errors", errors);
            request.setAttribute("blog", updated);
            request.getRequestDispatcher("/admin/blog/edit-form.jsp").forward(request, response);
            return;
        }

        blogDAO.update(updated);
        response.sendRedirect(request.getContextPath() + "/admin/blog?msg=updated");
    }

    private void deleteBlog(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        blogDAO.delete(id);
        response.sendRedirect(request.getContextPath() + "/admin/blog?msg=deleted");
    }

    private void showDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Blog blog = blogDAO.getBlogById(id);
        if (blog == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        request.setAttribute("blog", blog);
        request.setAttribute("publishedDate", Date.from(blog.getPublishedAt().atZone(ZoneId.systemDefault()).toInstant()));
        request.getRequestDispatcher("/admin/blog/detail.jsp").forward(request, response);
    }

    private Blog extractBlogFromRequest(HttpServletRequest request, String existingImage)
            throws IOException, ServletException {
        request.setCharacterEncoding("UTF-8");

        String title = request.getParameter("title");
        String summary = request.getParameter("summary");
        String content = request.getParameter("content");

        String imageName = existingImage;
        jakarta.servlet.http.Part filePart = request.getPart("image");

        if (filePart != null && filePart.getSize() > 0) {
            imageName = UUID.randomUUID() + "_" + filePart.getSubmittedFileName();

            // ✅ Fixed path
            String uploadPath = getServletContext().getRealPath("/asset/img/blog");
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            try (InputStream input = filePart.getInputStream(); FileOutputStream output = new FileOutputStream(new File(uploadPath, imageName))) {
                byte[] buffer = new byte[1024];
                int bytesRead;
                while ((bytesRead = input.read(buffer)) != -1) {
                    output.write(buffer, 0, bytesRead);
                }
            }
        }

        return new Blog(0, title, summary, content, imageName, LocalDateTime.now());
    }

    private Map<String, String> validateBlog(Blog blog) {
        Map<String, String> errors = new HashMap<>();
        if (blog.getTitle() == null || blog.getTitle().trim().isEmpty()) {
            errors.put("title", "Title is required.");
        }
        if (blog.getSummary() == null || blog.getSummary().trim().isEmpty()) {
            errors.put("summary", "Summary is required.");
        }
        if (blog.getContent() == null || blog.getContent().trim().isEmpty()) {
            errors.put("content", "Content is required.");
        }
        return errors;
    }
}
