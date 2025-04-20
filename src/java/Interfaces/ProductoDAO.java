/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Interfaces;



import modelo.Producto;
import java.util.*;
import java.text.SimpleDateFormat;

public class ProductoDAO {
    private static List<Producto> productos = new ArrayList<>();
    private static int ultimoId = 0;
    
    static {
        // Datos de ejemplo
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            productos.add(new Producto(++ultimoId, "Leche", "Leche entera 1L", 50, sdf.parse("2023-12-15")));
            productos.add(new Producto(++ultimoId, "Pan", "Pan integral", 30, sdf.parse("2023-11-20")));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    // CRUD operations
    public List<Producto> obtenerTodos() {
        return new ArrayList<>(productos);
    }
    
    public Producto obtenerPorId(int id) {
        return productos.stream()
                .filter(p -> p.getId() == id)
                .findFirst()
                .orElse(null);
    }
    
    public void agregar(Producto producto) {
        producto.setId(++ultimoId);
        productos.add(producto);
    }
    
    public void actualizar(Producto producto) {
        for (int i = 0; i < productos.size(); i++) {
            if (productos.get(i).getId() == producto.getId()) {
                productos.set(i, producto);
                break;
            }
        }
    }
    
    public void eliminar(int id) {
        productos.removeIf(p -> p.getId() == id);
    }
    
    // Métodos para alertas
    public List<Producto> obtenerProductosPorAgotarse(int limite) {
        List<Producto> resultado = new ArrayList<>();
        for (Producto p : productos) {
            if (p.getCantidad() <= limite) {
                resultado.add(p);
            }
        }
        return resultado;
    }
    
    public List<Producto> obtenerProductosPorVencerse(Date fechaLimite) {
        List<Producto> resultado = new ArrayList<>();
        for (Producto p : productos) {
            if (p.getFechaVencimiento() != null && 
                p.getFechaVencimiento().before(fechaLimite)) {
                resultado.add(p);
            }
        }
        return resultado;
    }
}