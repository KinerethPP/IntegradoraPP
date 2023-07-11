package mx.edu.utez.voluntariapp1.model.auth;

import mx.edu.utez.voluntariapp1.utils.MySQLConnection;

import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DaoAuth {
    Connection conn;
    PreparedStatement pstm;
    CallableStatement cstm;
    ResultSet rs;
    public BeanUser validate(String username, String password) {
        try {
            conn = new MySQLConnection().getConnection();
            String query = "SELECT * FROM users WHERE email = ? " +
                    "AND password = ? AND isActive = 1;";
            pstm = conn.prepareStatement(query);
            pstm.setString(1, username);
            pstm.setString(2, password);
            rs = pstm.executeQuery();
            if (rs.next()) {
                BeanUser user = new BeanUser();
                user.setEmail(rs.getString("username"));
                user.setIsActive(rs.getInt("status"));
                return user;
            }
            return null;
        } catch (SQLException e) {
            Logger.getLogger(DaoAuth.class.getName())
                    .log(Level.SEVERE, "Error validate method" + e);
            return null;
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

    public boolean verifyUser(String email) {
        try {
            conn = new MySQLConnection().getConnection();
            String query = "SELECT id FROM users WHERE " +
                    "email = ?";
            pstm = conn.prepareStatement(query);
            pstm.setString(1, email);
            rs = pstm.executeQuery();
            if (rs.next())
                return true;
        } catch (SQLException e) {
            Logger.getLogger(DaoAuth.class.getName())
                    .log(Level.SEVERE, "Error verifyUser" + e);
        } finally {
            closeConnections();
        }
        return false;
    }
}
