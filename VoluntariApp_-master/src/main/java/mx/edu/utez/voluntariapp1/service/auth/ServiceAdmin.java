package mx.edu.utez.voluntariapp1.service.auth;

import mx.edu.utez.voluntariapp1.model.admin.BeanAdmin;
import mx.edu.utez.voluntariapp1.model.admin.DaoAdmin;
import mx.edu.utez.voluntariapp1.utils.ResultAction;

import java.util.List;



public class ServiceAdmin {
    DaoAdmin daoAdmin = new DaoAdmin();
    public List<BeanAdmin> getAll() {
        return daoAdmin.findAll();
    }

    public ResultAction save(BeanAdmin admin){
        ResultAction result = new ResultAction();
        if (daoAdmin.save(admin)){
            result.setResult(true);
            result.setMessage("Administrador agregado exitosamente");
            result.setStatus(200);
        }else {
            result.setResult(false);
            result.setMessage("Ocurrió un error");
            result.setStatus(400);
        }
        return result;
    }

}
