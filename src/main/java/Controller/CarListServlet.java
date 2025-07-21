package Controller;

import DAO.CarDAO;
import DAO.PartDAO;
import Model.Car;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "CarListServlet", urlPatterns = {"/car/list"})
public class CarListServlet extends HttpServlet {

    private CarDAO carDAO;
    private PartDAO partDAO;
    private final int CARS_PER_PAGE = 12;

    @Override
    public void init() throws ServletException {
        super.init();
        carDAO = new CarDAO();
        partDAO = new PartDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            System.out.println("CarListServlet: Xử lý request");
            
            // Lấy các tham số lọc từ request
            String category = request.getParameter("category");
            String brand = request.getParameter("brand");
            String year = request.getParameter("year");
            String price = request.getParameter("price");
            String fuelType = request.getParameter("fuel");
            String odoRange = request.getParameter("odo");
            String searchTerm = request.getParameter("search");
            
            // Debug log
            System.out.println("Params: category=" + category + ", brand=" + brand + 
                               ", year=" + year + ", price=" + price + 
                               ", fuel=" + fuelType + ", odo=" + odoRange + 
                               ", search=" + searchTerm);
            
            // Kiểm tra xem đây có phải là AJAX request
            boolean isAjaxRequest = "true".equals(request.getParameter("ajax"));
            
            // Chuyển đổi fuel type sang chữ hoa đầu tiên nếu có
            if (fuelType != null && !fuelType.isEmpty()) {
                fuelType = fuelType.substring(0, 1).toUpperCase() + fuelType.substring(1).toLowerCase();
            }
            
            // Lấy số trang từ request, mặc định là trang 1
            int page = 1;
            if (request.getParameter("page") != null) {
                try {
                    page = Integer.parseInt(request.getParameter("page"));
                    if (page < 1) page = 1;
                } catch (NumberFormatException e) {
                    page = 1;
                }
            }
            
            // Lấy danh sách xe dựa trên các tham số lọc
            ArrayList<Car> filteredCars = new ArrayList<>();
            boolean hasFilters = false;
            
            // Xử lý tìm kiếm nếu có
            if (searchTerm != null && !searchTerm.isEmpty()) {
                System.out.println("Tìm kiếm xe với từ khóa: " + searchTerm);
                filteredCars = carDAO.searchCars(searchTerm);
                hasFilters = true;
            }
            // Nếu không có tìm kiếm, áp dụng các filter khác
            else {
                // Kết hợp nhiều filter thay vì chỉ áp dụng một filter
                ArrayList<Car> allCars = carDAO.getAllCars();
                filteredCars = allCars;
                
                // Áp dụng filter theo category
                if (category != null && !category.isEmpty()) {
                    System.out.println("Lọc theo category: " + category);
                    ArrayList<Car> categoryFiltered = new ArrayList<>();
                    for (Car car : filteredCars) {
                        if (carDAO.isCarInCategory(car.getCarId(), category)) {
                            categoryFiltered.add(car);
                        }
                    }
                    filteredCars = categoryFiltered;
                    hasFilters = true;
                }
                
                // Áp dụng filter theo brand
                if (brand != null && !brand.isEmpty()) {
                    System.out.println("Lọc theo brand: " + brand);
                    ArrayList<Car> brandFiltered = new ArrayList<>();
                    for (Car car : filteredCars) {
                        if (car.getCarBrand().equalsIgnoreCase(brand)) {
                            brandFiltered.add(car);
                        }
                    }
                    filteredCars = brandFiltered;
                    hasFilters = true;
                }
                
                // Áp dụng filter theo year
                if (year != null && !year.isEmpty()) {
                    try {
                        int yearInt = Integer.parseInt(year);
                        System.out.println("Lọc theo year: " + yearInt);
                        ArrayList<Car> yearFiltered = new ArrayList<>();
                        for (Car car : filteredCars) {
                            if (car.getCarYear() != null && car.getCarYear().getYear() + 1900 == yearInt) {
                                yearFiltered.add(car);
                            }
                        }
                        filteredCars = yearFiltered;
                        hasFilters = true;
                    } catch (NumberFormatException e) {
                        System.out.println("Năm không hợp lệ: " + year);
                    }
                }
                
                // Áp dụng filter theo fuel type
                if (fuelType != null && !fuelType.isEmpty()) {
                    System.out.println("Lọc theo fuel type: " + fuelType);
                    ArrayList<Car> fuelFiltered = new ArrayList<>();
                    for (Car car : filteredCars) {
                        if (car.getFuelType() != null && car.getFuelType().equalsIgnoreCase(fuelType)) {
                            fuelFiltered.add(car);
                        }
                    }
                    filteredCars = fuelFiltered;
                    hasFilters = true;
                }
                
                // Áp dụng filter theo price range
                if (price != null && !price.isEmpty() && price.contains("-")) {
                    String[] priceRange = price.split("-");
                    if (priceRange.length == 2) {
                        try {
                            double minPrice = Double.parseDouble(priceRange[0]);
                            double maxPrice = Double.parseDouble(priceRange[1]);
                            System.out.println("Lọc theo price range: " + minPrice + " - " + maxPrice);
                            ArrayList<Car> priceFiltered = new ArrayList<>();
                            for (Car car : filteredCars) {
                                if (car.getCarPrice() != null && 
                                    car.getCarPrice().doubleValue() >= minPrice && 
                                    car.getCarPrice().doubleValue() <= maxPrice) {
                                    priceFiltered.add(car);
                                }
                            }
                            filteredCars = priceFiltered;
                            hasFilters = true;
                        } catch (NumberFormatException e) {
                            System.out.println("Price range không hợp lệ: " + price);
                        }
                    }
                }
                
                // Áp dụng filter theo odo range
                if (odoRange != null && !odoRange.isEmpty() && odoRange.contains("-")) {
                    String[] odoValues = odoRange.split("-");
                    if (odoValues.length == 2) {
                        try {
                            double minOdo = Double.parseDouble(odoValues[0]);
                            double maxOdo = Double.parseDouble(odoValues[1]);
                            System.out.println("Lọc theo odo range: " + minOdo + " - " + maxOdo);
                            ArrayList<Car> odoFiltered = new ArrayList<>();
                            for (Car car : filteredCars) {
                                if (car.getCarOdo() != null && 
                                    car.getCarOdo().doubleValue() >= minOdo && 
                                    car.getCarOdo().doubleValue() <= maxOdo) {
                                    odoFiltered.add(car);
                                }
                            }
                            filteredCars = odoFiltered;
                            hasFilters = true;
                        } catch (NumberFormatException e) {
                            System.out.println("Odo range không hợp lệ: " + odoRange);
                        }
                    }
                }
            }
            
            // Nếu không có bộ lọc nào được áp dụng, lấy trang xe hiện tại
            if (!hasFilters) {
                System.out.println("Không có filter, lấy trang xe mặc định");
                filteredCars = carDAO.getPaginatedCars(page, CARS_PER_PAGE);
            }
            
            // Tính toán phân trang
            int totalCars = hasFilters ? filteredCars.size() : carDAO.getTotalCarCount();
            int totalPages = (int) Math.ceil((double) totalCars / CARS_PER_PAGE);
            if (page > totalPages && totalPages > 0) page = totalPages;
            
            System.out.println("Tổng số xe: " + totalCars + ", Tổng số trang: " + totalPages + ", Trang hiện tại: " + page);
            
            // Nếu áp dụng bộ lọc, cần lấy subset của danh sách đã lọc cho trang hiện tại
            List<Car> currentPageCars;
            if (hasFilters) {
                int startIndex = (page - 1) * CARS_PER_PAGE;
                int endIndex = Math.min(startIndex + CARS_PER_PAGE, filteredCars.size());
                if (startIndex < filteredCars.size()) {
                    currentPageCars = filteredCars.subList(startIndex, endIndex);
                } else {
                    currentPageCars = new ArrayList<>();
                }
            } else {
                currentPageCars = filteredCars; // Đã được phân trang từ DAO
            }
            
            System.out.println("Số xe trên trang hiện tại: " + currentPageCars.size());
            
            // Lấy danh sách thương hiệu và danh mục cho bộ lọc
            ArrayList<String> brands = carDAO.getAllBrands();
            ArrayList<String> categories = carDAO.getAllCategories();
            
            // Debug: kiểm tra danh sách brand và category - có thể xóa sau khi fix
            System.out.println("Brands fetched: " + brands.size() + " items");
            System.out.println("Categories fetched: " + categories.size() + " items");
            
            // Thiết lập các thuộc tính cho JSP
            request.setAttribute("carList", currentPageCars);
            request.setAttribute("brandList", brands);
            request.setAttribute("categoryList", categories);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalCars", totalCars);
            
            // Lưu các tham số đã chọn để sử dụng trong JSP
            request.setAttribute("selectedCategory", category);
            request.setAttribute("selectedBrand", brand);
            request.setAttribute("selectedYear", year);
            request.setAttribute("selectedPriceRange", price);
            request.setAttribute("selectedFuelType", fuelType);
            request.setAttribute("selectedOdoRange", odoRange);
            request.setAttribute("searchTerm", searchTerm);

            // --- Bổ sung biến cho navbar ---
            request.setAttribute("carBrands", brands);
            request.setAttribute("carCategories", categories);
            request.setAttribute("latestCars", carDAO.getRandomCars(8));
            request.setAttribute("partBrands", partDAO.getAllBrands());
            
            // Xử lý tùy theo loại request
            if (isAjaxRequest) {
                // Đối với AJAX request, chỉ forward tới một phần của trang
                System.out.println("Xử lý AJAX request");
                request.getRequestDispatcher("/car-list-ajax.jsp").forward(request, response);
            } else {
                // Đối với request thông thường, forward tới trang đầy đủ
                System.out.println("Xử lý request thông thường");
                request.getRequestDispatcher("/car-list.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace(); // Log the exception
            // Handle the error
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error loading car list: " + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
} 