package util;

import DAO.CarDAO;
import Model.Car;
import java.util.List;
import jakarta.servlet.http.HttpServletRequest;

public class MenuDataHelper {
    public static void preloadCarList(HttpServletRequest request) {
        try {
            CarDAO carDAO = new CarDAO();
            List<Car> cars = carDAO.getRandomCars(8);
            request.setAttribute("latestCars", cars);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
