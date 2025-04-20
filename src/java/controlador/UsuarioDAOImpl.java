package controlador;

import Conexion.Conexion;
import Interfaces.UsuarioDAO;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import modelo.Usuario;

public class UsuarioDAOImpl implements UsuarioDAO {
    
    @Override
    public boolean agregar(Usuario usuario) {
        String sql = "INSERT INTO usuario(nombre, apellido, email, usuario, clave, perfiles_idperfiles) VALUES(?,?,?,?,?,?)";
        
        try (Connection conn = Conexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, usuario.getNombre());
            ps.setString(2, usuario.getApellido());
            ps.setString(3, usuario.getEmail());
            ps.setString(4, usuario.getUsername());
            ps.setString(5, usuario.getPassword());
            
            // 7 para admin, 8 para user
            int perfilId = usuario.getPerfiles_idperfiles() == 7 ? 7 : 8;
            ps.setInt(6, perfilId);
            
            int filasAfectadas = ps.executeUpdate();
            return filasAfectadas > 0;
        } catch (SQLException ex) {
            System.err.println("Error al agregar usuario: " + ex.getMessage());
            ex.printStackTrace();
            return false;
        }
    }

    public Usuario validarUsuario(String username, String password) {
    String sql = "SELECT idUsuario, nombre, apellido, email, usuario, perfil, perfiles_idperfiles " +
                 "FROM usuario WHERE usuario = ? AND clave = ?";
    
    try (Connection conn = Conexion.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        
        ps.setString(1, username);
        ps.setString(2, password);
        
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                Usuario usuario = new Usuario();
                usuario.setIdUsuario(rs.getInt("idUsuario"));
                usuario.setNombre(rs.getString("nombre"));
                usuario.setApellido(rs.getString("apellido"));
                usuario.setEmail(rs.getString("email"));
                usuario.setUsername(rs.getString("usuario"));
                usuario.setPerfil(rs.getString("perfil"));
                usuario.setPerfiles_idperfiles(rs.getInt("perfiles_idperfiles"));
                return usuario;
            }
        }
    } catch (SQLException ex) {
        System.err.println("Error al validar usuario: " + ex.getMessage());
    }
    return null;
}
    
    @Override
    public List<Usuario> listar() {
        List<Usuario> lista = new ArrayList<>();
        String sql = "SELECT idUsuario, nombre, apellido, email, usuario, perfiles_idperfiles FROM usuario";
        
        try (Connection conn = Conexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while(rs.next()) {
                Usuario usuario = new Usuario();
                usuario.setIdUsuario(rs.getInt("idUsuario"));
                usuario.setNombre(rs.getString("nombre"));
                usuario.setApellido(rs.getString("apellido"));
                usuario.setEmail(rs.getString("email"));
                usuario.setUsername(rs.getString("usuario"));
                
                // Convertir ID de perfil a texto
                int perfilId = rs.getInt("perfiles_idperfiles");
                usuario.setPerfil(perfilId == 7 ? "admin" : "user");
                
                lista.add(usuario);
            }
        } catch (SQLException ex) {
            System.err.println("Error al listar usuarios: " + ex.getMessage());
            ex.printStackTrace();
        }
        return lista;
    }

    @Override
    public Usuario buscarPorId(int id) {
        String sql = "SELECT idUsuario, nombre, apellido, email, usuario, clave, perfiles_idperfiles FROM usuario WHERE idUsuario = ?";
        
        try (Connection conn = Conexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Usuario usuario = new Usuario();
                    usuario.setIdUsuario(rs.getInt("idUsuario"));
                    usuario.setNombre(rs.getString("nombre"));
                    usuario.setApellido(rs.getString("apellido"));
                    usuario.setEmail(rs.getString("email"));
                    usuario.setUsername(rs.getString("usuario"));
                    usuario.setPassword(rs.getString("clave"));
                    usuario.setPerfiles_idperfiles(rs.getInt("perfiles_idperfiles"));
                    return usuario;
                }
            }
        } catch (SQLException ex) {
            System.err.println("Error al buscar usuario: " + ex.getMessage());
            ex.printStackTrace();
        }
        return null;
    }

    @Override
    public boolean actualizar(Usuario usuario) {
        String sql = "UPDATE usuario SET nombre=?, apellido=?, email=?, usuario=?, clave=?, perfiles_idperfiles=? WHERE idUsuario=?";
        
        try (Connection conn = Conexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, usuario.getNombre());
            ps.setString(2, usuario.getApellido());
            ps.setString(3, usuario.getEmail());
            ps.setString(4, usuario.getUsername());
            ps.setString(5, usuario.getPassword());
            
            // 7 para admin, 8 para user
            int perfilId = usuario.getPerfiles_idperfiles() == 7 ? 7 : 8;
            ps.setInt(6, perfilId);
            
            ps.setInt(7, usuario.getIdUsuario());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException ex) {
            System.err.println("Error al actualizar usuario: " + ex.getMessage());
            ex.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean eliminar(int id) {
        String sql = "DELETE FROM usuario WHERE idUsuario=?";
        
        try (Connection conn = Conexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException ex) {
            System.err.println("Error al eliminar usuario: " + ex.getMessage());
            ex.printStackTrace();
            return false;
        }
    }
}