<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Editar Usuario</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Arial, sans-serif;
        }

        body {
            display: flex;
            min-height: 100vh;
            background-color: #f5f5f5;
        }

        /* Menú lateral reducido */
        .side-menu {
            width: 250px;
            background-color: #2c3e50;
            color: white;
            height: 100vh;
            position: fixed;
            padding: 20px 0;
        }

        .menu-header {
            padding: 15px 20px;
            font-size: 18px;
            font-weight: bold;
            border-bottom: 1px solid #34495e;
            margin-bottom: 20px;
        }

        .menu-item {
            padding: 12px 20px;
            color: white;
            text-decoration: none;
            display: block;
            transition: background-color 0.3s;
            border-left: 4px solid transparent;
        }

        .menu-item:hover {
            background-color: #34495e;
            border-left: 4px solid #3498db;
        }

        /* Contenido principal */
        .main-content {
            flex: 1;
            margin-left: 250px;
            padding: 30px;
        }

        .form-container {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            padding: 30px;
            max-width: 800px;
            margin: 0 auto;
        }

        h1 {
            color: #2c3e50;
            font-size: 24px;
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 1px solid #eee;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: #2c3e50;
        }

        input[type="text"],
        input[type="email"],
        input[type="password"] {
            width: 100%;
            padding: 10px 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
        }

        .form-check {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }

        .form-check-input {
            margin-right: 10px;
        }

        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            margin-right: 10px;
        }

        .btn-primary {
            background-color: #3498db;
            color: white;
        }

        .btn-secondary {
            background-color: #95a5a6;
            color: white;
        }

        /* Usuario en parte superior derecha */
        .user-header {
            position: fixed;
            top: 15px;
            right: 20px;
            background-color: #ecf0f1;
            padding: 10px 20px;
            border-radius: 20px;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
            z-index: 999;
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

        .error-message {
            color: #e74c3c;
            margin-bottom: 20px;
            padding: 10px;
            background-color: #ffebee;
            border-radius: 4px;
        }
    </style>
</head>
<body>
    <!-- Mostrar información del usuario en la parte superior derecha -->
    <c:if test="${not empty sessionScope.usuario}">
        <div class="user-header">
            <div class="user-info">
                <span class="user-icon">👤</span>
                <span class="user-name">${sessionScope.usuario.nombre} ${sessionScope.usuario.apellido}</span>
            </div>
        </div>
    </c:if>

    <!-- Menú lateral reducido -->
    <div class="side-menu">
        <div class="menu-header">EDITAR USUARIOS</div>
        <a href="UsuarioServlet?accion=listar" class="menu-item">Volver</a>
      
    </div>

    <!-- Contenido principal -->
    <div class="main-content">
        <div class="form-container">
            <h1>Editar Usuario</h1>

            <c:if test="${not empty error}">
                <div class="error-message">${error}</div>
            </c:if>
           
            <form action="UsuarioServlet?accion=actualizar" method="POST">
                <input type="hidden" name="id" value="${usuario.idUsuario}">
                
                <div class="form-group">
                    <label>Nombre:</label>
                    <input type="text" name="nombre" value="${usuario.nombre}" required>
                </div>
                
                <div class="form-group">
                    <label>Apellido:</label>
                    <input type="text" name="apellido" value="${usuario.apellido}" required>
                </div>
                
                <div class="form-group">
                    <label>Email:</label>
                    <input type="email" name="email" value="${usuario.email}" required>
                </div>
                
                <div class="form-group">
                    <label>Username:</label>
                    <input type="text" name="username" value="${usuario.username}" required>
                </div>
                
                <div class="form-group">
                    <label>Password:</label>
                    <input type="password" name="password" value="${usuario.password}" required>
                </div>
                
                <div class="form-check">
                    <input type="checkbox" name="esAdmin" id="esAdmin" 
                           ${usuario.perfiles_idperfiles == 7 ? 'checked' : ''}>
                    <label for="esAdmin">Es administrador</label>
                </div>
                
                <button type="submit" class="btn btn-primary">Actualizar</button>
                <a href="UsuarioServlet?accion=listar" class="btn btn-secondary">Cancelar</a>
            </form>
        </div>
    </div>
</body>
</html>