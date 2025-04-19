<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Listado de Usuarios</title>
</head>
<body>
    <h1>Usuarios</h1>
    <a href="UsuarioServlet?action=nuevo">Agregar Usuario</a>
    <table border="1">
        <tr>
            <th>ID</th>
            <th>Nombre</th>
            <th>Apellido</th>
            <th>Email</th>
            <th>Usuario</th>
            <th>Perfil</th>
            <th>Acciones</th>
        </tr>
        <c:forEach var="u" items="${usuarios}">
            <tr>
                <td>${u.idUsuario}</td>
                <td>${u.nombre}</td>
                <td>${u.apellido}</td>
                <td>${u.email}</td>
                <td>${u.usuario}</td>
                <td>${u.perfil}</td>
                <td>
                    <a href="UsuarioServlet?action=editar&id=${u.idUsuario}">Editar</a>
                    <a href="UsuarioServlet?action=eliminar&id=${u.idUsuario}" 
                       onclick="return confirm('¿Está seguro?')">Eliminar</a>
                </td>
            </tr>
        </c:forEach>
    </table>
</body>
</html>