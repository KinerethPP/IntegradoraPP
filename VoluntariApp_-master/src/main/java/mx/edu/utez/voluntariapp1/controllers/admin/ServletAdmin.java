package mx.edu.utez.voluntariapp1.controllers.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import mx.edu.utez.voluntariapp1.model.admin.BeanAdmin;
import mx.edu.utez.voluntariapp1.service.auth.ServiceAdmin;
import mx.edu.utez.voluntariapp1.utils.ResultAction;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "ServletAdmin",
        urlPatterns = {"/get-admins",
                "/add-admin",
                "/create-admin",
                "/save-admin",
                "get-admin",
                "/delete-admin"
        })
public class ServletAdmin extends HttpServlet {
    Logger logger = Logger.getLogger(ServletAdmin.class.getName());
    String action;
    String urlRedirect = "/get-admins";
    ServiceAdmin serviceAdmin = new ServiceAdmin();
    String uploadPath = "C:" + File.separator + "temp" + File.separator;
    String fileName;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        action = request.getServletPath();
        logger.log(Level.INFO, "Path-> " + action);
        switch (action){
            case "/get-admins":
                List<BeanAdmin> admins = serviceAdmin.getAll();
                System.out.println(admins.size());
                request.setAttribute("admins", admins);
                urlRedirect = "/pages/administrators/index_admin.jsp";
                break;
            case "/create-admin":
                urlRedirect = "/pages/administrators/create_admin.jsp";
                break;
            case "/save-admin":
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException{
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html");
        action = request.getServletPath();
        switch (action){
            case "/add-admin":
                try {
                    for (Part part : request.getParts()){
                        fileName = part.getSubmittedFileName();
                        if (fileName != null)
                            part.write(uploadPath + fileName);
                    }
                    String nombre = request.getParameter("name");
                    //String apellido = request.getParameter("apellido");
                    String correo = request.getParameter("email");
                    String contrasena = request.getParameter("password");
                    BeanAdmin admin = new BeanAdmin();
                    admin.setFileName(fileName);
                    admin.getName(nombre);
                    admin.getEmail(correo);
                    admin.getPassword(contrasena);
                    ResultAction result = serviceAdmin.save(admin);
                    urlRedirect = "/get-admins?result="+
                            result.isResult() + "&message="+
                            URLEncoder.encode(result.getMessage(), StandardCharsets.UTF_8.name())+
                            "&status="+ result.getStatus();
                } catch (Exception e){
                    Logger.getLogger(ServletAdmin.class.getName()).log(Level.SEVERE,
                            "Error addAdmin method"+ e.getMessage());
                    urlRedirect = "/get-admin?result=false&message="+
                            URLEncoder.encode("Error al registrar el Administrador",
                                    StandardCharsets.UTF_8.name())+
                            "&status=400";
                }
                break;

            default:
                throw new IllegalStateException("Unexpected value: " + action);
        }
    }
}
