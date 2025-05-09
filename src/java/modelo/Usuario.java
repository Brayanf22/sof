package modelo;

public class Usuario {
    private int idUsuario;
    private String nombre;
    private String apellido;
    private String email;
    private String username;
    private String password;
    private String perfil;
    private int perfiles_idperfiles;

    // Constructores
    public Usuario() {
    }

    public Usuario(String nombre, String apellido, String email, String username, String password, int perfiles_idperfiles) {
        this.nombre = nombre;
        this.apellido = apellido;
        this.email = email;
        this.username = username;
        this.password = password;
        this.perfiles_idperfiles = perfiles_idperfiles;
    }

    // Getters y Setters
    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getApellido() {
        return apellido;
    }

    public void setApellido(String apellido) {
        this.apellido = apellido;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPerfil() {
        return perfil;
    }

    public void setPerfil(String perfil) {
        this.perfil = perfil;
    }

    public int getPerfiles_idperfiles() {
        return perfiles_idperfiles;
    }

    public void setPerfiles_idperfiles(int perfiles_idperfiles) {
        this.perfiles_idperfiles = perfiles_idperfiles;
    }
}