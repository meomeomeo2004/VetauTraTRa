package controller;

import dal.DAOTokenForget;
import dal.PasswordDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.TokenForgetPassword;
import model.User;

@WebServlet(name = "requestPassword", urlPatterns = {"/requestPassword"})
public class requestPassword extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("requestPassword.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PasswordDAO pdao = new PasswordDAO();
        String email = request.getParameter("email");
        User user = pdao.getUserByEmail(email);
        
        if (user == null) {
            request.setAttribute("mess", "EMAIL DOES NOT EXISTED");
            request.getRequestDispatcher("requestPassword.jsp").forward(request, response);
            return;
        }

        resetService service = new resetService();
        String token = service.generateToken();
        String linkReset = "http://localhost:8080/tratra/resetPassword?token=" + token;
        TokenForgetPassword newTokenForget = new TokenForgetPassword(user.getId(), false, token, service.expireDateTime());
        DAOTokenForget daotoken = new DAOTokenForget();
        boolean isInsert = daotoken.insertTokenForget(newTokenForget);

        if (!isInsert) {
            request.setAttribute("mess", "HAVE ERROR IN SERVER");
            request.getRequestDispatcher("requestPassword.jsp").forward(request, response);
            return;
        }

        request.setAttribute("mess", "SEND REQUEST SUCCESS");
        request.getRequestDispatcher("requestPassword.jsp").forward(request, response);

        new Thread(() -> {
            try {
                boolean isSend = service.sendEmail(email, linkReset, user.getEmail());
                if (!isSend) {
                    System.err.println("CANNOT SEND REQUEST");
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }).start();
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
