package controlador;

import Interfaces.ProductoDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modelo.Producto;
import java.io.IOException;
import java.util.Date;
import java.util.List;

@WebServlet("/alertas")
public class AlertaServlet extends HttpServlet {
    private ProductoDAO productoDAO;
    
    @Override
    public void init() {
        productoDAO = new ProductoDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Productos por agotarse (menos de 10 unidades)
        List<Producto> productosPorAgotarse = productoDAO.obtenerProductosPorAgotarse(10);
        
        // Productos por vencerse (en los próximos 7 días)
        Date hoy = new Date();
        long sieteDias = 7 * 24 * 60 * 60 * 1000L;
        Date fechaLimite = new Date(hoy.getTime() + sieteDias);
        
        // Convertir java.util.Date a java.sql.Date correctamente
        java.sql.Date sqlFechaLimite = new java.sql.Date(fechaLimite.getTime());
        List<Producto> productosPorVencerse = productoDAO.obtenerProductosPorVencerse(sqlFechaLimite);
        
        request.setAttribute("productosPorAgotarse", productosPorAgotarse);
        request.setAttribute("productosPorVencerse", productosPorVencerse);
        
        request.getRequestDispatcher("alerta.jsp").forward(request, response);
    }
} 