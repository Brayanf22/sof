<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Alertas de Inventario</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f5f5f5;
        }
        .container {
            max-width: 1000px;
            margin: 0 auto;
            background: white;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h1, h2 {
            color: #333;
        }
        .alert-section {
            margin-bottom: 30px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 15px 0;
        }
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #f2f2f2;
        }
        .warning {
            background-color: #fff3e0;
        }
        .danger {
            background-color: #ffebee;
        }
        .btn {
            display: inline-block;
            padding: 8px 15px;
            margin-top: 10px;
            text-decoration: none;
            border-radius: 4px;
            background-color: #4CAF50;
            color: white;
        }
        .no-alerts {
            color: #666;
            font-style: italic;
        }
    </style>
</head>
<body>
    <div class="container">
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
                                <th>Días restantes</th>
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
                                        <fmt:formatNumber value="${(producto.fechaVencimiento.time - now.time) / (1000*60*60*24)}" 
                                                          maxFractionDigits="0"/>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:otherwise>
            </c:choose>
        </div>
        
        <a href="productos" class="btn">Ver todos los productos</a>
        <a href="/parcial2.1/indexproducto.jsp" class="btn">Volver al inicio</a>
    </div>
</body>
</html>