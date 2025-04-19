package controlador;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modelo.Usuario;
import java.io.IOException;

@WebServlet(name = "UsuarioServlet", urlPatterns = {"/UsuarioServlet"})
public class UsuarioServlet extends HttpServlet {
    private UsuarioDAOImpl usuarioDAO = new UsuarioDAOImpl();
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        try {
            if (action == null || action.isEmpty()) {
                action = "listar";
            }
            
            switch (action) {
                case "listar":
                    listarUsuarios(request, response);
                    break;
                case "nuevo":
                    mostrarFormulario(request, response);
                    break;
                case "agregar":
                    agregarUsuario(request, response);
                    break;
                case "editar":
                    mostrarEditar(request, response);
                    break;
                case "actualizar":
                    actualizarUsuario(request, response);
                    break;
                case "eliminar":
                    eliminarUsuario(request, response);
                    break;
                default:
                    listarUsuarios(request, response);
                    break;
            }
        } catch (Exception e) {
            request.setAttribute("error", "Error en la operación: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/error.jsp").forward(request, response);
        }
    }
    
    private void listarUsuarios(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("usuarios", usuarioDAO.listar());
        request.getRequestDispatcher("/WEB-INF/index.jsp").forward(request, response);
    }
    
    private void mostrarFormulario(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/agregar.jsp").forward(request, response);
    }
    
   private void agregarUsuario(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    try {
        // Validación básica de parámetros
        if (request.getParameter("nombre") == null || request.getParameter("nombre").isEmpty() ||
            request.getParameter("email") == null || request.getParameter("email").isEmpty()) {
            throw new ServletException("Datos incompletos");
        }

        Usuario u = new Usuario();
        u.setNombre(request.getParameter("nombre"));
        u.setApellido(request.getParameter("apellido"));
        u.setEmail(request.getParameter("email"));
        u.setUsuario(request.getParameter("usuario"));
        u.setClave(request.getParameter("clave"));
        u.setPerfil(Integer.parseInt(request.getParameter("perfil")));

        // Debug: Mostrar datos recibidos
        System.out.println("Datos recibidos para agregar:");
        System.out.println(u.toString());

        boolean resultado = usuarioDAO.agregar(u);
        
        if (resultado) {
            request.getSession().setAttribute("mensaje", "Usuario agregado correctamente con ID: " + u.getIdUsuario());
        } else {
            request.getSession().setAttribute("error", "No se pudo agregar el usuario");
        }
    } catch (NumberFormatException e) {
        request.getSession().setAttribute("error", "Formato de perfil inválido");
    } catch (Exception e) {
        request.getSession().setAttribute("error", "Error al agregar usuario: " + e.getMessage());
        e.printStackTrace();
    }
    response.sendRedirect(request.getContextPath() + "/UsuarioServlet?action=listar");
}
    
    private void mostrarEditar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Usuario u = usuarioDAO.obtenerPorId(id);
        if (u != null) {
            request.setAttribute("usuario", u);
            request.getRequestDispatcher("/WEB-INF/editar.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Usuario no encontrado");
            listarUsuarios(request, response);
        }
    }
    
    private void actualizarUsuario(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Usuario u = new Usuario();
            u.setIdUsuario(Integer.parseInt(request.getParameter("id")));
            u.setNombre(request.getParameter("nombre"));
            u.setApellido(request.getParameter("apellido"));
            u.setEmail(request.getParameter("email"));
            u.setUsuario(request.getParameter("usuario"));
            u.setClave(request.getParameter("clave"));
            u.setPerfil(Integer.parseInt(request.getParameter("perfil")));
            
            if (usuarioDAO.actualizar(u)) {
                request.getSession().setAttribute("mensaje", "Usuario actualizado exitosamente");
            } else {
                request.getSession().setAttribute("error", "No se pudo actualizar el usuario");
            }
        } catch (Exception e) {
            request.getSession().setAttribute("error", "Error al actualizar: " + e.getMessage());
        }
        response.sendRedirect(request.getContextPath() + "/UsuarioServlet?action=listar");
    }
    
    private void eliminarUsuario(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            if (usuarioDAO.eliminar(id)) {
                request.getSession().setAttribute("mensaje", "Usuario eliminado exitosamente");
            } else {
                request.getSession().setAttribute("error", "No se pudo eliminar el usuario");
            }
        } catch (Exception e) {
            request.getSession().setAttribute("error", "Error al eliminar: " + e.getMessage());
        }
        response.sendRedirect(request.getContextPath() + "/UsuarioServlet?action=listar");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}