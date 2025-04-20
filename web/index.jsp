<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Verificar si viene de una IP de administrador o tiene cookie de admin
    String ip = request.getRemoteAddr();
    boolean isAdminIP = ip.equals("IP_ADMIN"); // Reemplaza con IP real
    
    // O verificar cookie de administrador si existe
    Cookie[] cookies = request.getCookies();
    boolean hasAdminCookie = false;
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals("adminAccess") && cookie.getValue().equals("true")) {
                hasAdminCookie = true;
                break;
            }
        }
    }
    
    if (isAdminIP || hasAdminCookie) {
        response.sendRedirect("UsuarioServlet");
    } else {
        response.sendRedirect("LoginServlet");
    }
%>