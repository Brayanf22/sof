<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Editar Usuario</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        .user-header {
            position: fixed;
            top: 15px;
            right: 20px;
            background-color: #f0f0f0;
            padding: 10px 20px;
            border-radius: 20px;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
            z-index: 1000;
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 10px;
            color: #2c3e50;
            font-weight: 500;
        }

        .user-icon {
            font-size: 18px;
        }
    </style>
</head>
<body class="container mt-4">

      <!-- Mostrar información del usuario en la parte superior derecha -->
    <c:if test="${not empty sessionScope.usuario}">
        <div class="user-header">
            <div class="user-info">
                <span class="user-icon">👤</span>
                <span class="user-name">${sessionScope.usuario.nombre} ${sessionScope.usuario.apellido}</span>
            </div>
        </div>
    </c:if>

    <h1>Editar Usuario</h1>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>
   
    <form action="UsuarioServlet?accion=actualizar" method="POST" class="mt-3">
        <input type="hidden" name="id" value="${usuario.idUsuario}">
        
        <div class="mb-3">
            <label class="form-label">Nombre:</label>
            <input type="text" name="nombre" class="form-control" value="${usuario.nombre}" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Apellido:</label>
            <input type="text" name="apellido" class="form-control" value="${usuario.apellido}" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Email:</label>
            <input type="email" name="email" class="form-control" value="${usuario.email}" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Username:</label>
            <input type="text" name="username" class="form-control" value="${usuario.username}" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Password:</label>
            <input type="password" name="password" class="form-control" value="${usuario.password}" required>
        </div>
        <div class="mb-3 form-check">
            <input type="checkbox" name="esAdmin" class="form-check-input" id="esAdmin" 
                   ${usuario.perfiles_idperfiles == 7 ? 'checked' : ''}>
            <label class="form-check-label" for="esAdmin">Es administrador</label>
        </div>
        <button type="submit" class="btn btn-primary">Actualizar</button>
        <a href="UsuarioServlet?accion=listar" class="btn btn-secondary">Cancelar</a>
    </form>
</body>
</html>
