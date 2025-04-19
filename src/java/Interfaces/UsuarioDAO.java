// Interfaces/UsuarioDAO.java
package Interfaces;

import java.util.List;
import modelo.Usuario;

public interface UsuarioDAO {
    boolean agregar(Usuario usuario);
    List<Usuario> listar();
    Usuario buscarPorId(int id);
    boolean actualizar(Usuario usuario);
    boolean eliminar(int id);
}