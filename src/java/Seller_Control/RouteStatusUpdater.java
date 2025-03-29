/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Seller_Control;

import dal.SellerDAO;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.ZoneOffset;
import java.util.List;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;
import model.Route;

public class RouteStatusUpdater {

    private SellerDAO sellerDAO;

    public RouteStatusUpdater(SellerDAO sellerDAO) {
        this.sellerDAO = sellerDAO;
    }

    public void updateRouteStatuses() {
        // Lấy thời gian hiện tại theo giờ UTC
        LocalDateTime now = LocalDateTime.now(ZoneId.of("Asia/Ho_Chi_Minh"));

        // Lấy danh sách route (bao gồm các route có status 0 và 1)
        List<Route> routes = sellerDAO.getListRoute();

        for (Route route : routes) {
            // Chỉ cập nhật nếu status hiện tại là 1 (Active)
            if (route.getStatus() != 1) {
                continue;
            }

            // Chuyển Timestamp sang LocalDateTime
            LocalDateTime departure = route.getDepartureTime().toLocalDateTime();
            LocalDateTime arrival = route.getArrivalTime().toLocalDateTime();

            // Xử lý trường hợp qua đêm: nếu arrival nhỏ hơn departure, cộng thêm 1 ngày cho arrival
            if (arrival.isBefore(departure)) {
                arrival = arrival.plusDays(1);
            }

            // Kiểm tra và cập nhật trạng thái
            if ((!now.isBefore(departure)) && (now.isBefore(arrival) || now.isEqual(arrival))) {
                sellerDAO.updateRouteStatus(route.getId(), 2);  // Cập nhật thành In Transit (2)
                System.out.println("Route ID: " + route.getRouteCode() + " - Status updated to In Transit (2)");
            } else if (now.isAfter(arrival)) {
                sellerDAO.updateRouteStatus(route.getId(), 3);  // Cập nhật thành Completed (3)
                System.out.println("Route ID: " + route.getRouteCode() + " - Status updated to Completed (3)");
            }

            // In thông tin log để kiểm tra
            System.out.println("Route ID: " + route.getRouteCode());
            System.out.println("Departure (DB): " + route.getDepartureTime());
            System.out.println("Arrival (DB): " + route.getArrivalTime());
            System.out.println("Departure (LocalDateTime): " + departure);
            System.out.println("Arrival (LocalDateTime): " + arrival);
            System.out.println("Now (UTC): " + now);
            System.out.println("Is now before departure? " + now.isBefore(departure));
            System.out.println("Is now before arrival? " + now.isBefore(arrival));
            System.out.println("Is now equal to arrival? " + now.isEqual(arrival));
            System.out.println("Current Status: " + route.getStatus());
        }
    }

    // Phương thức lên lịch cập nhật trạng thái mỗi 1 phút
    public void scheduleStatusUpdates() {
        ScheduledExecutorService scheduler = Executors.newSingleThreadScheduledExecutor();
        scheduler.scheduleAtFixedRate(() -> {
            try {
                updateRouteStatuses();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }, 0, 10, TimeUnit.MINUTES);
    }
}
