/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Seller_Control;

import dal.SellerDAO;
import java.time.LocalDateTime;
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
        // Lấy thời gian hiện tại theo giờ UTC rồi chuyển sang giờ Việt Nam (UTC+7)
        LocalDateTime now = LocalDateTime.now(ZoneOffset.UTC).plusHours(7);

        // Lấy danh sách route (bao gồm các route có status 0 và 1)
        List<Route> routes = sellerDAO.getListRoute();

        for (Route route : routes) {
            // Chỉ cập nhật nếu status hiện tại là 1 (Active)
            if (route.getStatus() != 1) {
                continue;
            }

            // Chuyển Timestamp sang LocalDateTime và điều chỉnh theo giờ Việt Nam
            LocalDateTime departure = route.getDepartureTime().toLocalDateTime().plusHours(7);
            LocalDateTime arrival = route.getArrivalTime().toLocalDateTime().plusHours(7);

            // Xử lý trường hợp qua đêm: nếu arrival nhỏ hơn departure, cộng thêm 1 ngày cho arrival
            if (arrival.isBefore(departure)) {
                arrival = arrival.plusDays(1);
            }

            // Nếu thời gian hiện tại nằm giữa departure và arrival (bao gồm biên)
            if ((!now.isBefore(departure)) && (now.isBefore(arrival) || now.isEqual(arrival))) {
                sellerDAO.updateRouteStatus(route.getId(), 2);  // Cập nhật thành In Transit (2)
            } // Nếu thời gian hiện tại vượt qua arrival
            else if (now.isAfter(arrival)) {
                sellerDAO.updateRouteStatus(route.getId(), 3);  // Cập nhật thành Completed (3)
            }
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
        }, 0, 1, TimeUnit.MINUTES);
    }
}
