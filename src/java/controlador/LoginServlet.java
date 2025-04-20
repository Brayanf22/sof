package controlador;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import modelo.Usuario;
import controlador.UsuarioDAOImpl;

public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Solo muestra el formulario de login sin mensajes de error
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        // Solo validar si se enviaron credenciales
        if (username != null && password != null) {
            UsuarioDAOImpl usuarioDAO = new UsuarioDAOImpl();
            Usuario usuario = usuarioDAO.validarUsuario(username, password);
            
            if (usuario != null) {
                HttpSession session = request.getSession();
                session.setAttribute("usuario", usuario);
                
                if ("admin".equals(usuario.getPerfil())) {
                    response.sendRedirect("UsuarioServlet");
                } else {
                    response.sendRedirect("/parcial2.1/productos?accion=user");
                }
                return; // Importante: salir del método después de redireccionar
            }
        }
        
        // Solo mostrar error si el POST falló
        request.setAttribute("error", "Usuario o contraseña incorrectos");
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
}

   
