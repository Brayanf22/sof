package Interfaces;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import modelo.Producto;

public class ProductoDAO {
    // Datos de conexión a la base de datos existente (mydb)
    private static final String URL = "jdbc:mysql://localhost:3306/mydb";
    private static final String USER = "root";
    private static final String PASSWORD = "";
    
    // Consultas SQL
    private static final String INSERT_SQL = "INSERT INTO productos (nombre, descripcion, cantidad, fecha_vencimiento) VALUES (?, ?, ?, ?)";
    private static final String SELECT_BY_ID_SQL = "SELECT * FROM productos WHERE id = ?";
    private static final String SELECT_ALL_SQL = "SELECT * FROM productos";
    private static final String UPDATE_SQL = "UPDATE productos SET nombre = ?, descripcion = ?, cantidad = ?, fecha_vencimiento = ? WHERE id = ?";
    private static final String DELETE_SQL = "DELETE FROM productos WHERE id = ?";
    private static final String SELECT_POR_VENCERSE_SQL = "SELECT * FROM productos WHERE fecha_vencimiento <= ? ORDER BY fecha_vencimiento ASC";
    private static final String SELECT_POR_AGOTARSE_SQL = "SELECT * FROM productos WHERE cantidad <= ? ORDER BY cantidad ASC";
    
    // Método para obtener la conexión
    private Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
    
      // Agregar un nuevo producto
    public void agregar(Producto producto) {
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(INSERT_SQL, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setString(1, producto.getNombre());
            stmt.setString(2, producto.getDescripcion());
            stmt.setInt(3, producto.getCantidad());
            stmt.setDate(4, new java.sql.Date(producto.getFechaVencimiento().getTime()));
            
            stmt.executeUpdate();
            
            // Obtener el ID generado
            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    producto.setId(generatedKeys.getInt(1));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    // Obtener producto por ID
    public Producto obtenerPorId(int id) {
        Producto producto = null;
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(SELECT_BY_ID_SQL)) {
            
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    producto = new Producto();
                    producto.setId(rs.getInt("id"));
                    producto.setNombre(rs.getString("nombre"));
                    producto.setDescripcion(rs.getString("descripcion"));
                    producto.setCantidad(rs.getInt("cantidad"));
                    producto.setFechaVencimiento(rs.getDate("fecha_vencimiento"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return producto;
    }
    
    // Obtener todos los productos
    public List<Producto> obtenerTodos() {
        List<Producto> productos = new ArrayList<>();
        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(SELECT_ALL_SQL)) {
            
            while (rs.next()) {
                Producto producto = new Producto();
                producto.setId(rs.getInt("id"));
                producto.setNombre(rs.getString("nombre"));
                producto.setDescripcion(rs.getString("descripcion"));
                producto.setCantidad(rs.getInt("cantidad"));
                producto.setFechaVencimiento(rs.getDate("fecha_vencimiento"));
                
                productos.add(producto);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return productos;
    }
    
    // Actualizar producto
    public void actualizar(Producto producto) {
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(UPDATE_SQL)) {
            
            stmt.setString(1, producto.getNombre());
            stmt.setString(2, producto.getDescripcion());
            stmt.setInt(3, producto.getCantidad());
            stmt.setDate(4, new java.sql.Date(producto.getFechaVencimiento().getTime()));
            stmt.setInt(5, producto.getId());
            
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    // Eliminar producto
    public void eliminar(int id) {
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(DELETE_SQL)) {
            
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
   public List<Producto> obtenerProductosPorVencerse(Date fechaLimite) {
    List<Producto> productos = new ArrayList<>();
    try (Connection conn = getConnection();
         PreparedStatement stmt = conn.prepareStatement(SELECT_POR_VENCERSE_SQL)) {
        
        // Usar java.sql.Date en lugar de java.util.Date
        java.sql.Date sqlDate = new java.sql.Date(fechaLimite.getTime());
        stmt.setDate(1, sqlDate);
        
        try (ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Producto producto = new Producto();
                producto.setId(rs.getInt("id"));
                producto.setNombre(rs.getString("nombre"));
                producto.setDescripcion(rs.getString("descripcion"));
                producto.setCantidad(rs.getInt("cantidad"));
                producto.setFechaVencimiento(rs.getDate("fecha_vencimiento"));
                
                productos.add(producto);
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return productos;
}
  
    public List<Producto> obtenerProductosPorAgotarse(int cantidadLimite) {
        List<Producto> productos = new ArrayList<>();
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(SELECT_POR_AGOTARSE_SQL)) {
            
            stmt.setInt(1, cantidadLimite);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Producto producto = new Producto();
                    producto.setId(rs.getInt("id"));
                    producto.setNombre(rs.getString("nombre"));
                    producto.setDescripcion(rs.getString("descripcion"));
                    producto.setCantidad(rs.getInt("cantidad"));
                    producto.setFechaVencimiento(rs.getDate("fecha_vencimiento"));
                    
                    productos.add(producto);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return productos;
    }

  
}