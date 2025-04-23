<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Sistema de Inventario - Nuevo Usuario</title>
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
        
        /* Menú lateral */
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
            text-align: center;
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
        
        .menu-icon {
            width: 20px;
            height: 20px;
            margin-right: 10px;
            filter: invert(1);
            vertical-align: middle;
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
            max-width: 600px;
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
            padding: 10px 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
            box-sizing: border-box;
        }
        
        .form-check {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }
        
        .form-check-input {
            margin-right: 10px;
        }
        
        .form-actions {
            display: flex;
            gap: 10px;
            margin-top: 30px;
        }
        
        .btn {
            display: inline-flex;
            align-items: center;
            padding: 10px 20px;
            border-radius: 6px;
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.2s;
            text-decoration: none;
            border: none;
        }
        
        .btn-success {
            background-color: #4CAF50;
            color: white;
        }
        
        .btn-success:hover {
            background-color: #3e8e41;
        }
        
        .btn-secondary {
            background-color: #6c757d;
            color: white;
        }
        
        .btn-secondary:hover {
            background-color: #5a6268;
        }
        
        .error {
            color: #d32f2f;
            background-color: #fce4ec;
            padding: 10px 15px;
            border-radius: 4px;
            margin-bottom: 20px;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <!-- Menú lateral -->
    <div class="side-menu">
        <div class="menu-header">SISTEMA DE INVENTARIO</div>
        
        <a href="/parcial2.1/UsuarioServlet" class="menu-item">
            <img src="https://cdn-icons-png.flaticon.com/512/869/869636.png" class="menu-icon" alt="/parcial2.1/UsuarioServlet">
            Lista de usuarios
        </a>
        
        <a href="UsuarioServlet" class="menu-item">
            <img src="https://cdn-icons-png.flaticon.com/512/1269/1269654.png" class="menu-icon" alt="Salir">
            volver
        </a>
    </div>

    <!-- Contenido principal -->
    <div class="main-content">
        <div class="form-container">
            <h1>Nuevo Usuario</h1>
            
            <c:if test="${not empty error}">
                <div class="error">${error}</div>
            </c:if>
            
            <form action="UsuarioServlet?accion=agregar" method="POST">
                <div class="form-group">
                    <label>Nombre:</label>
                    <input type="text" name="nombre" required>
                </div>
                
                <div class="form-group">
                    <label>Apellido:</label>
                    <input type="text" name="apellido" required>
                </div>
                
                <div class="form-group">
                    <label>Email:</label>
                    <input type="email" name="email" required>
                </div>
                
                <div class="form-group">
                    <label>Username:</label>
                    <input type="text" name="username" required>
                </div>
                
                <div class="form-group">
                    <label>Password:</label>
                    <input type="password" name="password" required>
                </div>
                
                <div class="form-check">
                    <input type="checkbox" name="esAdmin" id="esAdmin">
                    <label for="esAdmin">Es administrador</label>
                </div>
                
                <div class="form-actions">
                    <button type="submit" class="btn btn-success">
                        <img src="https://cdn-icons-png.flaticon.com/512/190/190411.png" class="menu-icon" alt="Guardar">
                        Guardar
                    </button>
                    <a href="UsuarioServlet?accion=listar" class="btn btn-secondary">
                        <img src="https://cdn-icons-png.flaticon.com/512/753/753345.png" class="menu-icon" alt="Cancelar">
                        Cancelar
                    </a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>