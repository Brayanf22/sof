<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Alertas de Inventario</title>
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

        .alert-container {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            padding: 30px;
        }

        h1 {
            color: #2c3e50;
            font-size: 24px;
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 1px solid #eee;
        }

        .alert-section {
            margin-bottom: 30px;
        }

        h2 {
            color: #2c3e50;
            font-size: 18px;
            margin-bottom: 15px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
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

        .warning {
            background-color: #fff3e0;
        }

        .danger {
            background-color: #ffebee;
        }

        .expired {
            background-color: #ffcdd2;
            font-weight: bold;
        }

        .no-alerts {
            color: #7f8c8d;
            font-style: italic;
            padding: 15px;
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

    <!-- Menú lateral -->
    <div class="side-menu">
        <div class="menu-header">SISTEMA DE INVENTARIO</div>
        <a href="productos" class="menu-item">Ver todos los productos</a>
        <a href="/parcial2.1/indexproducto.jsp" class="menu-item">Volver al inicio</a>
    </div>

    <!-- Contenido principal -->
    <div class="main-content">
        <div class="alert-container">
            <h1>Alertas de Inventario</h1>

            <div class="alert-section">
                <h2>Productos por agotarse (menos de 10 unidades)</h2>
                <c:choose>
                    <c:when test="${empty productosPorAgotarse}">
                        <p class="no-alerts">No hay productos por agotarse.</p>
                    </c:when>
                    <c:otherwise>
                        <table>
                            <thead>
                                <tr>
                                    <th>Nombre</th>
                                    <th>Descripción</th>
                                    <th>Cantidad</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="producto" items="${productosPorAgotarse}">
                                    <tr class="warning">
                                        <td>${producto.nombre}</td>
                                        <td>${producto.descripcion}</td>
                                        <td>${producto.cantidad}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="alert-section">
                <h2>Productos por vencerse (próximos 7 días)</h2>
                <c:choose>
                    <c:when test="${empty productosPorVencerse}">
                        <p class="no-alerts">No hay productos por vencerse.</p>
                    </c:when>
                    <c:otherwise>
                        <table>
                            <thead>
                                <tr>
                                    <th>Nombre</th>
                                    <th>Fecha Vencimiento</th>
                                    <th>Estado</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="producto" items="${productosPorVencerse}">
                                    <tr class="danger">
                                        <td>${producto.nombre}</td>
                                        <td>
                                            <fmt:formatDate value="${producto.fechaVencimiento}" pattern="dd/MM/yyyy"/>
                                        </td>
                                        <td>
                                            <jsp:useBean id="now" class="java.util.Date"/>
                                            <c:set var="diasRestantes" value="${(producto.fechaVencimiento.time - now.time) / (1000*60*60*24)}"/>
                                            <c:choose>
                                                <c:when test="${diasRestantes < 0}">
                                                    <span class="expired">PRODUCTO VENCIDO</span>
                                                </c:when>
                                                <c:when test="${diasRestantes <= 7}">
                                                    <fmt:formatNumber value="${diasRestantes}" maxFractionDigits="0"/> días
                                                </c:when>
                                                <c:otherwise>
                                                    <fmt:formatDate value="${producto.fechaVencimiento}" pattern="dd/MM/yyyy"/>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</body>
</html>