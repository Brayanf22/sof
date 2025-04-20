package controlador;

import Interfaces.UsuarioDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import modelo.Usuario;

public class UsuarioServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accion = request.getParameter("accion") != null ? 
                        request.getParameter("accion") : "listar";
        
        System.out.println("Acción solicitada: " + accion);
        
        switch(accion) {
            case "listar":
                listarUsuarios(request, response);
                break;
            case "nuevo":
                nuevoUsuario(request, response);
                break;
            case "agregar":
                agregarUsuario(request, response);
                break;
            case "editar":
                editarUsuario(request, response);
                break;
            case "actualizar":
                actualizarUsuario(request, response);
                break;
            case "eliminar":
                eliminarUsuario(request, response);
                break;
            default:
                listarUsuarios(request, response);
        }
    }

    private void listarUsuarios(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            UsuarioDAO dao = new UsuarioDAOImpl();
            List<Usuario> lista = dao.listar();
            request.setAttribute("listaUsuarios", lista);
            request.getRequestDispatcher("listar.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error al listar usuarios: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    private void nuevoUsuario(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("nuevo.jsp").forward(request, response);
    }

    private void agregarUsuario(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            // Obtener parámetros
            String nombre = request.getParameter("nombre");
            String apellido = request.getParameter("apellido");
            String email = request.getParameter("email");
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            boolean esAdmin = "on".equals(request.getParameter("esAdmin"));
            
            // Validar campos obligatorios
            if(nombre == null || nombre.trim().isEmpty() ||
               apellido == null || apellido.trim().isEmpty() ||
               email == null || email.trim().isEmpty() ||
               username == null || username.trim().isEmpty() ||
               password == null || password.trim().isEmpty()) {
                request.setAttribute("error", "Todos los campos son obligatorios");
                request.getRequestDispatcher("nuevo.jsp").forward(request, response);
                return;
            }
            
            // Crear objeto usuario
            Usuario usuario = new Usuario();
            usuario.setNombre(nombre.trim());
            usuario.setApellido(apellido.trim());
            usuario.setEmail(email.trim());
            usuario.setUsername(username.trim());
            usuario.setPassword(password.trim());
            usuario.setPerfiles_idperfiles(esAdmin ? 7 : 8); // 7=admin, 8=user
            
            // Insertar en BD
            UsuarioDAO dao = new UsuarioDAOImpl();
            if(dao.agregar(usuario)) {
                response.sendRedirect("UsuarioServlet?accion=listar&mensaje=Usuario agregado correctamente");
            } else {
                request.setAttribute("error", "No se pudo agregar el usuario");
                request.getRequestDispatcher("nuevo.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error grave al agregar usuario: " + e.getMessage());
            request.getRequestDispatcher("nuevo.jsp").forward(request, response);
        }
    }

    private void editarUsuario(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            UsuarioDAO dao = new UsuarioDAOImpl();
            Usuario usuario = dao.buscarPorId(id);
            
            if(usuario != null) {
                request.setAttribute("usuario", usuario);
                request.getRequestDispatcher("editar.jsp").forward(request, response);
            } else {
                response.sendRedirect("UsuarioServlet?accion=listar&error=Usuario no encontrado");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("UsuarioServlet?accion=listar&error=Error al editar usuario");
        }
    }

    private void actualizarUsuario(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String nombre = request.getParameter("nombre");
            String apellido = request.getParameter("apellido");
            String email = request.getParameter("email");
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            boolean esAdmin = "on".equals(request.getParameter("esAdmin"));
            
            // Validar campos
            if(nombre == null || nombre.trim().isEmpty() ||
               apellido == null || apellido.trim().isEmpty() ||
               email == null || email.trim().isEmpty() ||
               username == null || username.trim().isEmpty() ||
               password == null || password.trim().isEmpty()) {
                request.setAttribute("error", "Todos los campos son obligatorios");
                editarUsuario(request, response);
                return;
            }
            
            Usuario usuario = new Usuario();
            usuario.setIdUsuario(id);
            usuario.setNombre(nombre.trim());
            usuario.setApellido(apellido.trim());
            usuario.setEmail(email.trim());
            usuario.setUsername(username.trim());
            usuario.setPassword(password.trim());
            usuario.setPerfiles_idperfiles(esAdmin ? 7 : 8); // 7=admin, 8=user
            
            UsuarioDAO dao = new UsuarioDAOImpl();
            if(dao.actualizar(usuario)) {
                response.sendRedirect("UsuarioServlet?accion=listar&mensaje=Usuario actualizado correctamente");
            } else {
                request.setAttribute("error", "No se pudo actualizar el usuario");
                editarUsuario(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error grave al actualizar: " + e.getMessage());
            editarUsuario(request, response);
        }
    }

    
    private void eliminarUsuario(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            UsuarioDAO dao = new UsuarioDAOImpl();
            
            if(dao.eliminar(id)) {
                response.sendRedirect("UsuarioServlet?accion=listar&mensaje=Usuario eliminado correctamente");
            } else {
                response.sendRedirect("UsuarioServlet?accion=listar&error=No se pudo eliminar el usuario");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("UsuarioServlet?accion=listar&error=Error al eliminar usuario");
        }
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