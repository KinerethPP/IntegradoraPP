package mx.edu.utez.voluntariapp1.service.admin;

import mx.edu.utez.voluntariapp1.model.auth.BeanUser;
import mx.edu.utez.voluntariapp1.model.auth.DaoAuth;
import mx.edu.utez.voluntariapp1.utils.EmailService;

public class AuthService {
    DaoAuth auth = new DaoAuth();
    public BeanUser login(String username, String password) {
        return auth.validate(username, password);
    }

    public void sendEmail(String email) {
        if (auth.verifyUser(email)) {
            new EmailService().sendEmail(email);
        }
    }
}
