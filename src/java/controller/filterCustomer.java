package controller.customerController;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import model.User;

@WebFilter(urlPatterns = {"/profile", "/update-profile", "/change-password", "/transaction","/voucher"})
public class filterCustomer implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(jakarta.servlet.ServletRequest request, jakarta.servlet.ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);

        if (session != null) {
            User user = (User) session.getAttribute("account");
            if (user != null && "customer".equals(user.getRole())) {
                chain.doFilter(request, response);
                return;
            }
        }

        // Chuyển hướng về trang đăng nhập nếu chưa đăng nhập hoặc không phải customer
        httpResponse.sendRedirect(httpRequest.getContextPath() + "/customer/login");
    }

    @Override
    public void destroy() {
    }
}
