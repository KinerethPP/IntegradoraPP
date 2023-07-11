package mx.edu.utez.voluntariapp1.controllers.auth;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import mx.edu.utez.voluntariapp1.model.auth.BeanUser;
import mx.edu.utez.voluntariapp1.service.admin.AuthService;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

@WebServlet(
        name = "ServletAuth",
        urlPatterns = {
                "/login",
                "/logout",
                "/signin",
                "recover-password",
                "/send-email"
        }
)
public class ServletAuth extends HttpServlet {
    String action;
    String urlRedirect = "/get-admins";
    HttpSession session;
    AuthService authService = new AuthService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        action = request.getServletPath();
        switch (action) {
            case "/signin":
                urlRedirect = "/index.jsp";
                break;
            case "/recover-password":
                urlRedirect = "/views/auth/recoverPassword.jsp";
                break;
            default:
                urlRedirect = "/index.jsp";
        }
        request.getRequestDispatcher(urlRedirect).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        action = req.getServletPath();
        switch (action) {
            case "/login":
                String username = req.getParameter("email");
                String password = req.getParameter("password");
                BeanUser user = authService.login(username, password);
                if (user != null) {
                    session = req.getSession();
                    session.setAttribute("user", user);
                    //user.getRole() == "ADMIN" -> /dashboard
                    urlRedirect = "/get-admins";
                } else {
                    urlRedirect = "/index.jsp?error=" +
                            URLEncoder.encode("Usuario o contraseña incorrectos",
                                    StandardCharsets.UTF_8);
                }
                break;
            case "/logout":
                session = req.getSession();
                session.invalidate();
                urlRedirect = "/index.jsp";
                break;
            case "/send-email":
                String email = req.getParameter("email");
                authService.sendEmail(email);
                urlRedirect = "/index.jsp";
                break;
            default:
                urlRedirect = "/index.jsp";
        }
        resp.sendRedirect(urlRedirect);
    }
}

