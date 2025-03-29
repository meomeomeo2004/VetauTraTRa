package controller;

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

@WebFilter(urlPatterns = {"/profile","/update-profile","/change-password","/transaction"})
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
        User user = (session != null) ? (User) session.getAttribute("account") : null;

        
        if (user == null || !user.getRole().equalsIgnoreCase("customer")) {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/customer/login"); 
            return;
        }

        // Tiếp tục chuỗi xử lý yêu cầu nếu kiểm tra thành công
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
    }
}
