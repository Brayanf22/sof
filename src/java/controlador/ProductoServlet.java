/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador;


import Interfaces.ProductoDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modelo.Producto;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;


@WebServlet("/productos")
public class ProductoServlet extends HttpServlet {
    private ProductoDAO productoDAO;
    
    @Override
    public void init() {
        productoDAO = new ProductoDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accion = request.getParameter("accion");
        
        if (accion == null) {
            accion = "listar";
        }
        
        switch (accion) {
            case "user":
                listarProductosuser(request, response);
                break;
            case "nuevo":
                mostrarFormularioNuevo(request, response);
                break;
            case "editar":
                mostrarFormularioEditar(request, response);
                break;
            case "eliminar":
                eliminarProducto(request, response);
                break;
            default:
                listarProductos(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accion = request.getParameter("accion");
        
        if (accion == null) {
            accion = "listar";
        }
        
        switch (accion) {
            case "guardar":
                guardarProducto(request, response);
                break;
            case "actualizar":
                actualizarProducto(request, response);
                break;
            default:
                listarProductos(request, response);
        }
    }
    
    private void listarProductos(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("productos", productoDAO.obtenerTodos());
        request.getRequestDispatcher("listaproductos.jsp").forward(request, response);
        
    }
    
     private void listarProductosuser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("productos", productoDAO.obtenerTodos());
        request.getRequestDispatcher("listaproductosuser.jsp").forward(request, response);
    } 
    
    private void mostrarFormularioNuevo(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("agregarproductos.jsp").forward(request, response);
    }
    
    private void mostrarFormularioEditar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Producto producto = productoDAO.obtenerPorId(id);
        request.setAttribute("producto", producto);
        request.getRequestDispatcher("editarproducto.jsp").forward(request, response);
    }
    
    private void guardarProducto(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String nombre = request.getParameter("nombre");
            String descripcion = request.getParameter("descripcion");
            int cantidad = Integer.parseInt(request.getParameter("cantidad"));
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date fechaVencimiento = sdf.parse(request.getParameter("fechaVencimiento"));
            
            Producto nuevoProducto = new Producto();
            nuevoProducto.setNombre(nombre);
            nuevoProducto.setDescripcion(descripcion);
            nuevoProducto.setCantidad(cantidad);
            nuevoProducto.setFechaVencimiento(fechaVencimiento);
            
            productoDAO.agregar(nuevoProducto);
            response.sendRedirect("productos");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error al guardar el producto");
            request.getRequestDispatcher("agregarProducto.jsp").forward(request, response);
        }
    }
    
    private void actualizarProducto(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String nombre = request.getParameter("nombre");
            String descripcion = request.getParameter("descripcion");
            int cantidad = Integer.parseInt(request.getParameter("cantidad"));
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date fechaVencimiento = sdf.parse(request.getParameter("fechaVencimiento"));
            
            Producto producto = new Producto();
            producto.setId(id);
            producto.setNombre(nombre);
            producto.setDescripcion(descripcion);
            producto.setCantidad(cantidad);
            producto.setFechaVencimiento(fechaVencimiento);
            
            productoDAO.actualizar(producto);
            response.sendRedirect("productos");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error al actualizar el producto");
            request.getRequestDispatcher("editarproducto.jsp").forward(request, response);
        }
    }
    
    private void eliminarProducto(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        productoDAO.eliminar(id);
        response.sendRedirect("productos");
    }
}