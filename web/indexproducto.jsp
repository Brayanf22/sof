<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Control de Inventario</title>
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
            position: relative;
        }
        
        /* Estilos para el menú lateral */
        .side-menu {
            width: 250px;
            background-color: #2c3e50;
            color: white;
            height: 100vh;
            position: fixed;
        }
        
        .menu-header {
            padding: 20px;
            background-color: #1a252f;
            text-align: center;
            font-size: 18px;
            font-weight: bold;
        }

        /* User info in top right corner of page */
        .user-header {
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 1000;
        }
        
        .user-info {
            display: flex;
            align-items: center;
            gap: 8px;
            background-color: #2c3e50;
            color: white;
            padding: 10px 15px;
            border-radius: 20px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.2);
        }
        
        .user-info span {
            font-size: 14px;
        }
        
        .menu-items {
            padding: 15px 0;
        }
        
        .menu-item {
            padding: 15px 20px;
            cursor: pointer;
            transition: background-color 0.3s;
            display: flex;
            align-items: center;
            border-bottom: 1px solid #34495e;
        }
        
        .menu-item:hover {
            background-color: #34495e;
        }
        
        .menu-item i {
            margin-right: 10px;
        }
        
        /* Estilos para el área de contenido */
        .main-content {
            flex: 1;
            margin-left: 250px;
            padding: 30px;
        }
        
        .welcome-container {
            background-color: white;
            border-radius: 8px;
            padding: 40px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            height: calc(100vh - 60px);
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
        }
        
        .welcome-title {
            font-size: 32px;
            color: #2c3e50;
            margin-bottom: 20px;
        }
        
        .welcome-message {
            font-size: 18px;
            color: #7f8c8d;
            max-width: 600px;
            line-height: 1.6;
        }
        
        /* Iconos usando caracteres Unicode */
        .icon {
            font-style: normal;
            margin-right: 10px;
        }
    </style>
</head>
<body>
    <!-- Mostrar información del usuario en la parte superior derecha de la página -->
    <c:if test="${not empty sessionScope.usuario}">
        <div class="user-header">
            <div class="user-info">
                <span class="icon">👤</span>
                <span class="user-name">${sessionScope.usuario.nombre} ${sessionScope.usuario.apellido}</span>
            </div>
        </div>
    </c:if>

    <!-- Menú lateral simplificado -->
    <div class="side-menu">
        <div class="menu-header">
            SISTEMA DE INVENTARIO
        </div>
        
        <div class="menu-items">
            <div class="menu-item" onclick="location.href='productos'">
                <span class="icon">📦</span> Productos
            </div>
            
            <div class="menu-item" onclick="location.href='productos?accion=nuevo'">
                <span class="icon">➕</span> Agregar Producto
            </div>
            
            <div class="menu-item" onclick="location.href='alertas'">
                <span class="icon">⚠️</span> Alertas
            </div>
            
            <div class="menu-item" onclick="location.href='/parcial2.1/UsuarioServlet'">
                <span class="icon">👥</span> Usuarios
            </div>
        </div>
    </div>

    <!-- Área de contenido principal -->
    <div class="main-content">
        <div class="welcome-container">
            <h1 class="welcome-title">Bienvenido al Sistema de Control de Inventario</h1>
            <p class="welcome-message">
                Gestiona tu inventario de manera eficiente con nuestro sistema integrado. 
                Accede a las diferentes opciones desde el menú lateral.
            </p>
        </div>
    </div>
</body>
</html>