package mx.edu.utez.voluntariapp1.model.admin;

import mx.edu.utez.voluntariapp1.utils.MySQLConnection;

import java.sql.*;
import java.util.LinkedList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DaoAdmin {
    Connection conn;
    PreparedStatement pstm;
    CallableStatement cstm;
    ResultSet rs;
    public List<BeanAdmin> findAll() {
        List<BeanAdmin> admins = new LinkedList<>();
        BeanAdmin admin;
        try {
            conn = new MySQLConnection().getConnection();
            String query = "SELECT * FROM users;";
            pstm = conn.prepareStatement(query);
            rs = pstm.executeQuery();
            while (rs.next()){
                admin = new BeanAdmin();
                admin.setId_user(rs.getLong("id"));
                admin.setName(rs.getString("name"));
                admin.setLastanme(rs.getString("lastName"));
                admin.setEmail(rs.getString("email"));
                admin.setIsActive(rs.getInt("isActive"));
                admins.add(admin);
            }
        } catch (SQLException e){
            Logger.getLogger(DaoAdmin.class.getName())
                    .severe("Error al consultar usuarios: " + e);
        } finally {
            closeConnections();
        }
        return admins;
    }

    public boolean save(BeanAdmin admin) {
        try {
            conn = new MySQLConnection().getConnection();
            String query = "INSERT INTO users" +
                    "(name, lastname, surname, email, password, isActive)" +
                    " VALUES (?,?,?,?,?,1)";
            pstm = conn.prepareStatement(query);
            pstm.setString(1, admin.getName());
            pstm.setString(2,admin.getLastname());
            pstm.setString(3, admin.getSurname());
            pstm.setString(4, admin.getEmail());
            pstm.setString(5, admin.getPassword());
            return pstm.executeUpdate() == 1;
        } catch (SQLException e) {
            Logger.getLogger(DaoAdmin.class.getName())
                    .log(Level.SEVERE, "Error save", e);
            return false;
        } finally {
            closeConnections();
        }
    }
    public void closeConnections() {
        try {
            if (conn != null) {
                conn.close();
            }
            if (pstm != null) {
                pstm.close();
            }
            if (cstm != null) {
                cstm.close();
            }
            if (rs != null) {
                rs.close();
            }
        } catch (SQLException e) {
        }
    }
}
