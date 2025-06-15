package Controller;

import DAO.CarDAO;
import Model.Car;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.util.List;
import java.sql.SQLException;
import java.math.BigDecimal;
import java.sql.Date;
import java.util.ArrayList;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.util.UUID;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import javax.imageio.ImageIO;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;

@WebServlet(name = "AdminCarServlet", urlPatterns = {"/admin/car", "/admin/car/add", "/admin/car/edit", "/admin/car/delete", "/admin/car/view"})
public class AdminCarServlet extends HttpServlet {

    private CarDAO carDAO;
    private static final int MAX_WIDTH = 1200;
    private static final int MAX_HEIGHT = 900;

    @Override
    public void init() throws ServletException {
        super.init();
        carDAO = new CarDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getServletPath();

        try {
            switch (action) {
                case "/admin/car/add":
                    showAddForm(request, response);
                    break;
                case "/admin/car/edit":
                    showEditForm(request, response);
                    break;
                case "/admin/car/delete":
                    deleteCar(request, response);
                    break;
                case "/admin/car/view":
                    viewCar(request, response);
                    break;
                case "/admin/car":
                default:
                    listCars(request, response);
                    break;
            }
        } catch (Exception ex) {
            throw new ServletException(ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getServletPath();

        try {
            switch (action) {
                case "/admin/car/add":
                    addCar(request, response);
                    break;
                case "/admin/car/edit":
                    updateCar(request, response);
                    break;
                // Delete will be handled by GET for simplicity in this example
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            String errorMsg = ex.getMessage();
            
            // Xử lý lỗi kích thước file quá lớn
            if (errorMsg != null && errorMsg.contains("FileSizeLimitExceededException")) {
                request.getSession().setAttribute("errorMessage", "Kích thước ảnh quá lớn. Vui lòng chọn ảnh nhỏ hơn 5MB.");
            } else {
                request.getSession().setAttribute("errorMessage", "Lỗi: " + errorMsg);
            }
            
            response.sendRedirect(request.getContextPath() + "/admin/car");
        }
    }

    private void listCars(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException, ServletException {
        List<Car> carList = carDAO.getAllCars();
        ArrayList<String> brandList = carDAO.getAllBrands();
        
        request.setAttribute("carList", carList);
        request.setAttribute("brandList", brandList);
        request.getRequestDispatcher("/admin/car.jsp").forward(request, response);
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ArrayList<String> brandList = carDAO.getAllBrands();
        request.setAttribute("brandList", brandList);
        request.getRequestDispatcher("/admin/car-form.jsp").forward(request, response);
    }

    private void addCar(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException, ServletException {
        // Đọc các tham số cơ bản
        String carName = request.getParameter("carName");
        String carBrand = request.getParameter("carBrand");
        if (carBrand != null && carBrand.equals("other")) {
            carBrand = request.getParameter("newBrand");
        }
        String model = request.getParameter("model");
        BigDecimal carPrice = parseBigDecimal(request.getParameter("carPrice"));
        Date carYear = Date.valueOf(request.getParameter("carYear") + "-01-01"); // Chuyển năm thành ngày đầu năm
        int carStock = parseInt(request.getParameter("carStock"));
        BigDecimal carOdo = parseBigDecimal(request.getParameter("carOdo"));
        String fuelType = request.getParameter("fuelType");
        BigDecimal displacement = parseBigDecimal(request.getParameter("displacement"));
        int categoryId = parseInt(request.getParameter("categoryId"));
        
        // Xử lý ảnh
        String carImg = "default-car.png"; // Mặc định
        
        try {
            Part filePart = request.getPart("carImg");
            if (filePart != null && filePart.getSize() > 0 && filePart.getSubmittedFileName() != null && !filePart.getSubmittedFileName().isEmpty()) {
                // Kiểm tra kích thước file
                if (filePart.getSize() > 10 * 1024 * 1024) { // 10MB - giới hạn ban đầu trước khi nén
                    request.getSession().setAttribute("errorMessage", "Kích thước ảnh quá lớn. Vui lòng chọn ảnh nhỏ hơn 10MB.");
                    response.sendRedirect(request.getContextPath() + "/admin/car/add");
                    return;
                }
                
                String fileName = UUID.randomUUID() + "_" + getFileName(filePart);
                String fileExtension = getFileExtension(fileName).toLowerCase();
                
                // Sửa đường dẫn lưu ảnh - lấy đường dẫn tuyệt đối
                String uploadPath = getServletContext().getRealPath("/asset/img/cars");
                
                // Đường dẫn tương đối cho webapp (để đảm bảo ảnh được lưu trong cả thư mục gốc)
                String webappPath = getServletContext().getRealPath("/").replace("target/DriveXO_Management_Project-1.0-SNAPSHOT/", "src/main/webapp/asset/img/cars");
                
                File uploadDir = new File(uploadPath);
                File webappDir = new File(webappPath);
                
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }
                
                if (!webappDir.exists()) {
                    webappDir.mkdirs();
                }
                
                // Ghi log để debug
                System.out.println("==== DEBUG INFO ====");
                System.out.println("Upload path: " + uploadPath);
                System.out.println("Webapp path: " + webappPath);
                System.out.println("Directory exists (upload): " + uploadDir.exists());
                System.out.println("Directory exists (webapp): " + webappDir.exists());
                System.out.println("File name: " + fileName);
                System.out.println("File size: " + filePart.getSize());
                System.out.println("===================");
                
                // Đọc ảnh và nén
                BufferedImage originalImage = ImageIO.read(filePart.getInputStream());
                if (originalImage != null) {
                    // Nén ảnh
                    BufferedImage resizedImage = resizeImage(originalImage);
                    
                    // Lưu ảnh đã nén
                    File outputFile = new File(uploadDir, fileName);
                    try {
                        // Lưu ảnh vào thư mục target (triển khai)
                        boolean success = ImageIO.write(resizedImage, fileExtension.equals("png") ? "png" : "jpeg", outputFile);
                        System.out.println("Image write success (target): " + success);
                        System.out.println("Output file exists (target): " + outputFile.exists());
                        System.out.println("Output file size (target): " + outputFile.length());
                        
                        // Lưu ảnh vào thư mục webapp (mã nguồn)
                        File webappFile = new File(webappDir, fileName);
                        boolean webappSuccess = ImageIO.write(resizedImage, fileExtension.equals("png") ? "png" : "jpeg", webappFile);
                        System.out.println("Image write success (webapp): " + webappSuccess);
                        System.out.println("Output file exists (webapp): " + webappFile.exists());
                        System.out.println("Output file size (webapp): " + webappFile.length());
                        
                        // Kiểm tra lại xem file đã được lưu thành công chưa
                        if (!outputFile.exists() || outputFile.length() == 0) {
                            System.out.println("WARNING: Target file not saved or empty!");
                            request.getSession().setAttribute("errorMessage", "Có lỗi khi lưu ảnh. Vui lòng thử lại.");
                            throw new IOException("Failed to save image to target directory");
                        }
                        
                        if (!webappFile.exists() || webappFile.length() == 0) {
                            System.out.println("WARNING: Webapp file not saved or empty!");
                            // Không throw exception vì file đã được lưu trong target
                        }
                    } catch (Exception e) {
                        System.out.println("Error writing image: " + e.getMessage());
                        e.printStackTrace();
                    }
                    
                    carImg = fileName;
                } else {
                    System.out.println("Original image is null - not a valid image format");
                    // Nếu không phải ảnh hợp lệ, lưu trực tiếp
                    try (InputStream input = filePart.getInputStream()) {
                        // Lưu vào thư mục target
                        File outputFile = new File(uploadDir, fileName);
                        try (FileOutputStream output = new FileOutputStream(outputFile)) {
                            byte[] buffer = new byte[1024];
                            int bytesRead;
                            while ((bytesRead = input.read(buffer)) != -1) {
                                output.write(buffer, 0, bytesRead);
                            }
                            System.out.println("File saved directly (target): " + outputFile.exists());
                            System.out.println("File size (target): " + outputFile.length());
                        }
                        
                        // Lưu vào thư mục webapp
                        try (InputStream input2 = filePart.getInputStream();
                             FileOutputStream output2 = new FileOutputStream(new File(webappDir, fileName))) {
                            byte[] buffer = new byte[1024];
                            int bytesRead;
                            while ((bytesRead = input2.read(buffer)) != -1) {
                                output2.write(buffer, 0, bytesRead);
                            }
                            System.out.println("File saved directly (webapp): " + new File(webappDir, fileName).exists());
                            System.out.println("File size (webapp): " + new File(webappDir, fileName).length());
                        }
                        
                        carImg = fileName;
                    }
                }
            } else {
                String carImgText = request.getParameter("carImgText");
                if (carImgText != null && !carImgText.trim().isEmpty()) {
                    carImg = carImgText;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            if (e.getMessage() != null && e.getMessage().contains("FileSizeLimitExceededException")) {
                request.getSession().setAttribute("errorMessage", "Kích thước ảnh quá lớn. Vui lòng chọn ảnh nhỏ hơn 5MB.");
                response.sendRedirect(request.getContextPath() + "/admin/car/add");
                return;
            }
            // Tiếp tục với ảnh mặc định nếu có lỗi khác
        }
        
        Car newCar = new Car();
        newCar.setCarName(carName);
        newCar.setCarBrand(carBrand);
        newCar.setModel(model);
        newCar.setCarPrice(carPrice);
        newCar.setCarYear(carYear);
        newCar.setCarImg(carImg);
        newCar.setCarStock(carStock);
        newCar.setCarOdo(carOdo);
        newCar.setFuelType(fuelType);
        newCar.setDisplacement(displacement);
        newCar.setCategoryId(categoryId);
        
        boolean success = carDAO.addCar(newCar);
        if (success) {
            request.getSession().setAttribute("successMessage", "Thêm xe thành công.");
        } else {
            request.getSession().setAttribute("errorMessage", "Không thể thêm xe. Vui lòng thử lại.");
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/car");
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        int carId = Integer.parseInt(request.getParameter("id"));
        Car existingCar = carDAO.getCarById(carId);
        ArrayList<String> brandList = carDAO.getAllBrands();
        
        if (existingCar == null) {
            request.getSession().setAttribute("errorMessage", "Không tìm thấy xe.");
            response.sendRedirect(request.getContextPath() + "/admin/car");
            return;
        }
        
        request.setAttribute("car", existingCar);
        request.setAttribute("brandList", brandList);
        request.getRequestDispatcher("/admin/car-form.jsp").forward(request, response);
    }

    private void updateCar(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException, ServletException {
        // Đọc các tham số cơ bản
        int carId = Integer.parseInt(request.getParameter("carId"));
        String carName = request.getParameter("carName");
        String carBrand = request.getParameter("carBrand");
        if (carBrand != null && carBrand.equals("other")) {
            carBrand = request.getParameter("newBrand");
        }
        String model = request.getParameter("model");
        BigDecimal carPrice = parseBigDecimal(request.getParameter("carPrice"));
        Date carYear = Date.valueOf(request.getParameter("carYear") + "-01-01"); // Chuyển năm thành ngày đầu năm
        int carStock = parseInt(request.getParameter("carStock"));
        BigDecimal carOdo = parseBigDecimal(request.getParameter("carOdo"));
        String fuelType = request.getParameter("fuelType");
        BigDecimal displacement = parseBigDecimal(request.getParameter("displacement"));
        int categoryId = parseInt(request.getParameter("categoryId"));
        
        // Lấy xe hiện tại để lấy ảnh cũ
        Car currentCar = carDAO.getCarById(carId);
        String carImg = currentCar != null ? currentCar.getCarImg() : "default-car.png";
        
        // Xử lý ảnh
        try {
            Part filePart = request.getPart("carImg");
            if (filePart != null && filePart.getSize() > 0 && filePart.getSubmittedFileName() != null && !filePart.getSubmittedFileName().isEmpty()) {
                // Kiểm tra kích thước file
                if (filePart.getSize() > 10 * 1024 * 1024) { // 10MB - giới hạn ban đầu trước khi nén
                    request.getSession().setAttribute("errorMessage", "Kích thước ảnh quá lớn. Vui lòng chọn ảnh nhỏ hơn 10MB.");
                    response.sendRedirect(request.getContextPath() + "/admin/car/edit?id=" + carId);
                    return;
                }
                
                String fileName = UUID.randomUUID() + "_" + getFileName(filePart);
                String fileExtension = getFileExtension(fileName).toLowerCase();
                
                // Sửa đường dẫn lưu ảnh - lấy đường dẫn tuyệt đối
                String uploadPath = getServletContext().getRealPath("/asset/img/cars");
                
                // Đường dẫn tương đối cho webapp (để đảm bảo ảnh được lưu trong cả thư mục gốc)
                String webappPath = getServletContext().getRealPath("/").replace("target/DriveXO_Management_Project-1.0-SNAPSHOT/", "src/main/webapp/asset/img/cars");
                
                File uploadDir = new File(uploadPath);
                File webappDir = new File(webappPath);
                
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }
                
                if (!webappDir.exists()) {
                    webappDir.mkdirs();
                }
                
                // Ghi log để debug
                System.out.println("==== DEBUG INFO ====");
                System.out.println("Upload path: " + uploadPath);
                System.out.println("Webapp path: " + webappPath);
                System.out.println("Directory exists (upload): " + uploadDir.exists());
                System.out.println("Directory exists (webapp): " + webappDir.exists());
                System.out.println("File name: " + fileName);
                System.out.println("File size: " + filePart.getSize());
                System.out.println("===================");
                
                // Đọc ảnh và nén
                BufferedImage originalImage = ImageIO.read(filePart.getInputStream());
                if (originalImage != null) {
                    // Nén ảnh
                    BufferedImage resizedImage = resizeImage(originalImage);
                    
                    // Lưu ảnh đã nén
                    File outputFile = new File(uploadDir, fileName);
                    try {
                        // Lưu ảnh vào thư mục target (triển khai)
                        boolean success = ImageIO.write(resizedImage, fileExtension.equals("png") ? "png" : "jpeg", outputFile);
                        System.out.println("Image write success (target): " + success);
                        System.out.println("Output file exists (target): " + outputFile.exists());
                        System.out.println("Output file size (target): " + outputFile.length());
                        
                        // Lưu ảnh vào thư mục webapp (mã nguồn)
                        File webappFile = new File(webappDir, fileName);
                        boolean webappSuccess = ImageIO.write(resizedImage, fileExtension.equals("png") ? "png" : "jpeg", webappFile);
                        System.out.println("Image write success (webapp): " + webappSuccess);
                        System.out.println("Output file exists (webapp): " + webappFile.exists());
                        System.out.println("Output file size (webapp): " + webappFile.length());
                        
                        // Kiểm tra lại xem file đã được lưu thành công chưa
                        if (!outputFile.exists() || outputFile.length() == 0) {
                            System.out.println("WARNING: Target file not saved or empty!");
                            request.getSession().setAttribute("errorMessage", "Có lỗi khi lưu ảnh. Vui lòng thử lại.");
                            throw new IOException("Failed to save image to target directory");
                        }
                        
                        if (!webappFile.exists() || webappFile.length() == 0) {
                            System.out.println("WARNING: Webapp file not saved or empty!");
                            // Không throw exception vì file đã được lưu trong target
                        }
                    } catch (Exception e) {
                        System.out.println("Error writing image: " + e.getMessage());
                        e.printStackTrace();
                    }
                    
                    // Nếu có ảnh cũ và khác default, xóa file ảnh cũ
                    if (currentCar != null && currentCar.getCarImg() != null && !currentCar.getCarImg().isEmpty() && !currentCar.getCarImg().equals("default-car.png")) {
                        // Xóa ảnh cũ từ thư mục target
                        File oldFile = new File(uploadPath, currentCar.getCarImg());
                        if (oldFile.exists()) {
                            oldFile.delete();
                            System.out.println("Deleted old image (target): " + currentCar.getCarImg());
                        }
                        
                        // Xóa ảnh cũ từ thư mục webapp
                        File oldWebappFile = new File(webappPath, currentCar.getCarImg());
                        if (oldWebappFile.exists()) {
                            oldWebappFile.delete();
                            System.out.println("Deleted old image (webapp): " + currentCar.getCarImg());
                        }
                    }
                    
                    carImg = fileName;
                } else {
                    System.out.println("Original image is null - not a valid image format");
                    // Nếu không phải ảnh hợp lệ, lưu trực tiếp
                    try (InputStream input = filePart.getInputStream()) {
                        // Lưu vào thư mục target
                        File outputFile = new File(uploadDir, fileName);
                        try (FileOutputStream output = new FileOutputStream(outputFile)) {
                            byte[] buffer = new byte[1024];
                            int bytesRead;
                            while ((bytesRead = input.read(buffer)) != -1) {
                                output.write(buffer, 0, bytesRead);
                            }
                            System.out.println("File saved directly (target): " + outputFile.exists());
                            System.out.println("File size (target): " + outputFile.length());
                        }
                        
                        // Lưu vào thư mục webapp
                        try (InputStream input2 = filePart.getInputStream();
                             FileOutputStream output2 = new FileOutputStream(new File(webappDir, fileName))) {
                            byte[] buffer = new byte[1024];
                            int bytesRead;
                            while ((bytesRead = input2.read(buffer)) != -1) {
                                output2.write(buffer, 0, bytesRead);
                            }
                            System.out.println("File saved directly (webapp): " + new File(webappDir, fileName).exists());
                            System.out.println("File size (webapp): " + new File(webappDir, fileName).length());
                        }
                        
                        carImg = fileName;
                    }
                }
            } else {
                // Giữ lại ảnh cũ hoặc cập nhật tên file nếu có
                String carImgText = request.getParameter("carImgText");
                if (carImgText != null && !carImgText.trim().isEmpty()) {
                    carImg = carImgText;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            if (e.getMessage() != null && e.getMessage().contains("FileSizeLimitExceededException")) {
                request.getSession().setAttribute("errorMessage", "Kích thước ảnh quá lớn. Vui lòng chọn ảnh nhỏ hơn 5MB.");
                response.sendRedirect(request.getContextPath() + "/admin/car/edit?id=" + carId);
                return;
            }
            // Tiếp tục với ảnh cũ nếu có lỗi khác
        }
        
        Car car = new Car();
        car.setCarId(carId);
        car.setCarName(carName);
        car.setCarBrand(carBrand);
        car.setModel(model);
        car.setCarPrice(carPrice);
        car.setCarYear(carYear);
        car.setCarImg(carImg);
        car.setCarStock(carStock);
        car.setCarOdo(carOdo);
        car.setFuelType(fuelType);
        car.setDisplacement(displacement);
        car.setCategoryId(categoryId);
        
        boolean success = carDAO.updateCar(car);
        if (success) {
            request.getSession().setAttribute("successMessage", "Cập nhật xe thành công.");
        } else {
            request.getSession().setAttribute("errorMessage", "Không thể cập nhật xe. Vui lòng thử lại.");
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/car");
    }

    private void deleteCar(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        int carId = Integer.parseInt(request.getParameter("id"));
        
        // Lấy xe hiện tại để lấy thông tin ảnh
        Car car = carDAO.getCarById(carId);
        
        boolean success = carDAO.deleteCar(carId);
        
        if (success) {
            // Nếu xóa thành công và có ảnh, xóa file ảnh
            if (car != null && car.getCarImg() != null && !car.getCarImg().isEmpty() && !car.getCarImg().equals("default-car.png")) {
                // Xóa ảnh từ thư mục target
                String uploadPath = getServletContext().getRealPath("/asset/img/cars");
                File imgFile = new File(uploadPath, car.getCarImg());
                if (imgFile.exists()) {
                    imgFile.delete();
                    System.out.println("Deleted car image (target): " + car.getCarImg());
                }
                
                // Xóa ảnh từ thư mục webapp
                String webappPath = getServletContext().getRealPath("/").replace("target/DriveXO_Management_Project-1.0-SNAPSHOT/", "src/main/webapp/asset/img/cars");
                File webappImgFile = new File(webappPath, car.getCarImg());
                if (webappImgFile.exists()) {
                    webappImgFile.delete();
                    System.out.println("Deleted car image (webapp): " + car.getCarImg());
                }
            }
            request.getSession().setAttribute("successMessage", "Xóa xe thành công.");
        } else {
            request.getSession().setAttribute("errorMessage", "Không thể xóa xe. Xe có thể đang được tham chiếu bởi các bản ghi khác.");
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/car");
    }
    
    private void viewCar(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        int carId = Integer.parseInt(request.getParameter("id"));
        Car car = carDAO.getCarById(carId);
        
        if (car == null) {
            request.getSession().setAttribute("errorMessage", "Không tìm thấy xe.");
            response.sendRedirect(request.getContextPath() + "/admin/car");
            return;
        }
        
        request.setAttribute("car", car);
        request.getRequestDispatcher("/admin/car-detail.jsp").forward(request, response);
    }
    
    private String getFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                return s.substring(s.indexOf("=") + 2, s.length() - 1);
            }
        }
        
        return "";
    }
    
    // Phương thức nén ảnh
    private BufferedImage resizeImage(BufferedImage originalImage) {
        int originalWidth = originalImage.getWidth();
        int originalHeight = originalImage.getHeight();
        
        // Nếu ảnh đã nhỏ hơn kích thước tối đa, giữ nguyên
        if (originalWidth <= MAX_WIDTH && originalHeight <= MAX_HEIGHT) {
            return originalImage;
        }
        
        // Tính toán tỷ lệ thu nhỏ
        double widthRatio = (double) MAX_WIDTH / originalWidth;
        double heightRatio = (double) MAX_HEIGHT / originalHeight;
        double ratio = Math.min(widthRatio, heightRatio);
        
        int newWidth = (int) (originalWidth * ratio);
        int newHeight = (int) (originalHeight * ratio);
        
        // Tạo ảnh mới với kích thước đã thu nhỏ
        BufferedImage resizedImage = new BufferedImage(newWidth, newHeight, originalImage.getType() == 0 ? BufferedImage.TYPE_INT_ARGB : originalImage.getType());
        Graphics2D g = resizedImage.createGraphics();
        
        g.drawImage(originalImage, 0, 0, newWidth, newHeight, null);
        g.dispose();
        
        return resizedImage;
    }
    
    // Lấy phần mở rộng của file
    private String getFileExtension(String fileName) {
        if (fileName.lastIndexOf(".") != -1 && fileName.lastIndexOf(".") != 0) {
            return fileName.substring(fileName.lastIndexOf(".") + 1);
        } else {
            return "jpg"; // mặc định
        }
    }
    
    // Phương thức để parse BigDecimal an toàn
    private BigDecimal parseBigDecimal(String value) {
        try {
            return (value != null && !value.trim().isEmpty()) ? new BigDecimal(value) : BigDecimal.ZERO;
        } catch (Exception e) {
            return BigDecimal.ZERO;
        }
    }
    
    // Phương thức để parse int an toàn
    private int parseInt(String value) {
        try {
            return (value != null && !value.trim().isEmpty()) ? Integer.parseInt(value) : 0;
        } catch (Exception e) {
            return 0;
        }
    }
} 