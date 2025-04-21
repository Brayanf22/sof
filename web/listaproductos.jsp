<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Lista de Productos</title>
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
            width: 200px;
            background-color: #2c3e50;
            color: white;
            height: 100vh;
            position: fixed;
            padding: 20px 0;
        }
        
        .menu-item {
            padding: 12px 20px;
            cursor: pointer;
            transition: background-color 0.3s;
            display: flex;
            align-items: center;
            color: white;
            text-decoration: none;
            border-left: 4px solid transparent;
        }
        
        .menu-item:hover {
            background-color: #34495e;
            border-left: 4px solid #3498db;
        }
        
        .menu-item i {
            margin-right: 10px;
        }
        
        /* Contenido principal */
        .main-content {
            flex: 1;
            margin-left: 200px;
            padding: 30px;
        }
        
        .container {
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            padding: 30px;
        }
        
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 1px solid #eee;
        }
        
        h1 {
            color: #2c3e50;
            font-size: 24px;
        }
        
        .btn {
            display: inline-block;
            padding: 8px 16px;
            border-radius: 4px;
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            text-decoration: none;
            transition: all 0.2s;
        }
        
        .btn-primary {
            background-color: #3498db;
            color: white;
            border: none;
        }
        
        .btn-primary:hover {
            background-color: #2980b9;
        }
        
        .btn-danger {
            background-color: #e74c3c;
            color: white;
            border: none;
        }
        
        .btn-danger:hover {
            background-color: #c0392b;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        
        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }
        
        th {
            background-color: #f8f9fa;
            font-weight: 600;
            color: #2c3e50;
        }
        
        tr:hover {
            background-color: #f8f9fa;
        }
        
        .action-buttons {
            display: flex;
            gap: 8px;
        }
        
        /* Iconos */
        .icon {
            font-style: normal;
            margin-right: 8px;
        }
    </style>
</head>
<body>
    <!-- Menú lateral -->
    <div class="side-menu">
        <a href="productos" class="menu-item">
            <span class="icon">📦</span> Productos
        </a>
        <a href="productos?accion=nuevo" class="menu-item">
            <span class="icon">➕</span> Nuevo Producto
        </a>
        <a href="alertas" class="menu-item">
            <span class="icon">⚠️</span> Alertas
        </a>
        <a href="/parcial2.1/indexproducto.jsp" class="menu-item">
            <span class="icon">🏠</span> Volver
        </a>
    </div>

    <!-- Contenido principal -->
    <div class="main-content">
        <div class="container">
            <div class="header">
                <h1>Lista de Productos</h1>
            </div>
            
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Nombre</th>
                        <th>Descripción</th>
                        <th>Cantidad</th>
                        <th>Fecha Vencimiento</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="producto" items="${productos}">
                        <tr>
                            <td>${producto.id}</td>
                            <td>${producto.nombre}</td>
                            <td>${producto.descripcion}</td>
                            <td>${producto.cantidad}</td>
                            <td>
                                <fmt:formatDate value="${producto.fechaVencimiento}" pattern="dd/MM/yyyy"/>
                            </td>
                            <td class="action-buttons">
                                <a href="productos?accion=editar&id=${producto.id}" class="btn btn-primary">Editar</a>
                                <a href="productos?accion=eliminar&id=${producto.id}" class="btn btn-danger">Eliminar</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>