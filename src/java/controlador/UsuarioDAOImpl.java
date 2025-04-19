package controlador;

import Driver.Conexion;
import Interfaces.UsuarioDAO;
import modelo.Usuario;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UsuarioDAOImpl implements UsuarioDAO {
    private Connection conexion;
    
    public UsuarioDAOImpl() {
        try {
            conexion = Conexion.getConnection();
            // Verificar si la conexión es válida
            if (conexion == null || conexion.isClosed()) {
                System.err.println("Error: La conexión a la base de datos no está disponible");
            }
        } catch (SQLException ex) {
            System.err.println("Error al conectar: " + ex.getMessage());
        }
    }

    @Override
    public List<Usuario> listar() {
        List<Usuario> usuarios = new ArrayList<>();
        String sql = "SELECT * FROM usuario";
        
        try (PreparedStatement ps = conexion.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Usuario u = new Usuario();
                u.setIdUsuario(rs.getInt("idUsuario"));
                u.setNombre(rs.getString("nombre"));
                u.setApellido(rs.getString("apellido"));
                u.setEmail(rs.getString("email"));
                u.setUsuario(rs.getString("usuario"));
                u.setClave(rs.getString("clave"));
                u.setPerfil(rs.getInt("perfil"));
                usuarios.add(u);
            }
        } catch (SQLException ex) {
            System.err.println("Error al listar usuarios: " + ex.getMessage());
            ex.printStackTrace();
        }
        return usuarios;
    }

    @Override
    public Usuario obtenerPorId(int id) {
        Usuario u = null;
        String sql = "SELECT * FROM usuario WHERE idUsuario = ?";
        
        try (PreparedStatement ps = conexion.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    u = new Usuario();
                    u.setIdUsuario(rs.getInt("idUsuario"));
                    u.setNombre(rs.getString("nombre"));
                    u.setApellido(rs.getString("apellido"));
                    u.setEmail(rs.getString("email"));
                    u.setUsuario(rs.getString("usuario"));
                    u.setClave(rs.getString("clave"));
                    u.setPerfil(rs.getInt("perfil"));
                }
            }
        } catch (SQLException ex) {
            System.err.println("Error al obtener usuario por ID: " + ex.getMessage());
            ex.printStackTrace();
        }
        return u;
    }

    @Override
    public boolean agregar(Usuario usuario) {
        // Query modificada para omitir idUsuario (debe ser AUTO_INCREMENT)
        String sql = "INSERT INTO usuario (nombre, apellido, email, usuario, clave, perfil) VALUES (?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = Conexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            // Validación de datos
            if (usuario.getNombre() == null || usuario.getNombre().trim().isEmpty()) {
                throw new SQLException("El nombre del usuario no puede estar vacío");
            }
            
            ps.setString(1, usuario.getNombre());
            ps.setString(2, usuario.getApellido());
            ps.setString(3, usuario.getEmail());
            ps.setString(4, usuario.getUsuario());
            ps.setString(5, usuario.getClave());
            ps.setInt(6, usuario.getPerfil());

            int filasAfectadas = ps.executeUpdate();
            
            if (filasAfectadas > 0) {
                // Obtener el ID generado automáticamente
                try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        usuario.setIdUsuario(generatedKeys.getInt(1));
                        System.out.println("Usuario insertado con ID: " + usuario.getIdUsuario());
                    }
                }
                return true;
            }
        } catch (SQLException ex) {
            System.err.println("Error SQL al agregar usuario:");
            System.err.println("SQLState: " + ex.getSQLState());
            System.err.println("Error Code: " + ex.getErrorCode());
            System.err.println("Message: " + ex.getMessage());
            ex.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean actualizar(Usuario usuario) {
        String sql = "UPDATE usuario SET nombre=?, apellido=?, email=?, usuario=?, clave=?, perfil=? WHERE idUsuario=?";
        
        try (PreparedStatement ps = conexion.prepareStatement(sql)) {
            ps.setString(1, usuario.getNombre());
            ps.setString(2, usuario.getApellido());
            ps.setString(3, usuario.getEmail());
            ps.setString(4, usuario.getUsuario());
            ps.setString(5, usuario.getClave());
            ps.setInt(6, usuario.getPerfil());
            ps.setInt(7, usuario.getIdUsuario());
            
            int filasAfectadas = ps.executeUpdate();
            System.out.println("Filas afectadas en actualización: " + filasAfectadas);
            
            return filasAfectadas > 0;
        } catch (SQLException ex) {
            System.err.println("Error al actualizar usuario: " + ex.getMessage());
            ex.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean eliminar(int id) {
        String sql = "DELETE FROM usuario WHERE idUsuario=?";
        
        try (PreparedStatement ps = conexion.prepareStatement(sql)) {
            ps.setInt(1, id);
            
            int filasAfectadas = ps.executeUpdate();
            System.out.println("Filas afectadas en eliminación: " + filasAfectadas);
            
            return filasAfectadas > 0;
        } catch (SQLException ex) {
            System.err.println("Error al eliminar usuario: " + ex.getMessage());
            ex.printStackTrace();
            return false;
        }
    }
    
    // Método para verificar la conexión
    public boolean isConnectionValid() {
        try {
            return conexion != null && !conexion.isClosed();
        } catch (SQLException e) {
            return false;
        }
    }
}