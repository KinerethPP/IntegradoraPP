package mx.edu.utez.voluntariapp1.model.auth;

public class BeanUser {
    private long id_user;
    private String name;
    private String surname;
    private String lastname;
    private String email;
    private String password;
    private int isActive;

    public BeanUser() {
    }

    public BeanUser(long id_user, String name, String surname, String lastname, String email, String password, int isActive) {
        this.id_user = id_user;
        this.name = name;
        this.surname = surname;
        this.lastname = lastname;
        this.email = email;
        this.password = password;
        this.isActive = isActive;
    }

    public long getId_user() {
        return id_user;
    }

    public void setId_user(long id_user) {
        this.id_user = id_user;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSurname() {
        return surname;
    }

    public void setSurname(String surname) {
        this.surname = surname;
    }

    public String getLastname() {
        return lastname;
    }

    public void setLastname(String lastname) {
        this.lastname = lastname;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getIsActive() {
        return isActive;
    }

    public void setIsActive(int isActive) {
        this.isActive = isActive;
    }
}
