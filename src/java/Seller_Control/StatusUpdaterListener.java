/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Seller_Control;

import dal.SellerDAO;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

@WebListener
public class StatusUpdaterListener implements ServletContextListener {

    private ScheduledExecutorService scheduler;

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        // Tạo đối tượng SellerDAO (cần đảm bảo kết nối DB đã được thiết lập đúng)
        SellerDAO sellerDAO = new SellerDAO();
        RouteStatusUpdater updater = new RouteStatusUpdater(sellerDAO);

        scheduler = Executors.newSingleThreadScheduledExecutor();
        scheduler.scheduleAtFixedRate(() -> {
            try {
                updater.updateRouteStatuses();
            } catch (Exception e) {
                e.printStackTrace();
            }
        },  0, 10, TimeUnit.MINUTES); // Chạy mỗi 1 phút
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        if (scheduler != null) {
            scheduler.shutdownNow();
        }
    }
}
