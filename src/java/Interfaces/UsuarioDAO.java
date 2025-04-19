// Interfaces/UsuarioDAO.java
package Interfaces;

import modelo.Usuario;
import java.util.List;

public interface UsuarioDAO {
    public List<Usuario> listar();
    public Usuario obtenerPorId(int id);
    public boolean agregar(Usuario usuario);
    public boolean actualizar(Usuario usuario);
    public boolean eliminar(int id);
}