<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Editar Producto</title>
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

        .error {
            background-color: #ffebee;
            color: #c62828;
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 4px;
            border-left: 4px solid #c62828;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #2c3e50;
        }

        input[type="text"],
        input[type="number"],
        input[type="date"],
        textarea {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
            transition: border 0.3s;
            box-sizing: border-box;
        }

        input[type="text"]:focus,
        input[type="number"]:focus,
        input[type="date"]:focus,
        textarea:focus {
            border-color: #3498db;
            outline: none;
            box-shadow: 0 0 5px rgba(52, 152, 219, 0.3);
        }

        textarea {
            min-height: 100px;
            resize: vertical;
        }

        .btn {
            display: inline-block;
            padding: 12px 20px;
            background-color: #3498db;
            color: white;
            text-decoration: none;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s;
            margin-right: 10px;
        }

        .btn:hover {
            background-color: #2980b9;
        }

        a.btn {
            background-color: #95a5a6;
        }

        a.btn:hover {
            background-color: #7f8c8d;
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
            z-index: 1000;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .user-info {
            color: #2c3e50;
            font-weight: 500;
        }

        .user-icon {
            font-size: 18px;
        }

        @media (max-width: 768px) {
            .side-menu {
                width: 100%;
                height: auto;
                position: relative;
            }
            
            .main-content {
                margin-left: 0;
                padding: 20px;
            }
            
            .btn {
                display: block;
                width: 100%;
                margin-bottom: 10px;
            }
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
        <div class="menu-header">EDITAR PRODUCTO</div>
        <a href="productos" class="menu-item">Volver</a>
    </div>

    <!-- Contenido principal -->
    <div class="main-content">
        <div class="form-container">
            <h1>Editar Producto</h1>

            <c:if test="${not empty error}">
                <div class="error">${error}</div>
            </c:if>

            <form action="productos?accion=actualizar" method="post">
                <input type="hidden" name="id" value="${producto.id}">

                <div class="form-group">
                    <label for="nombre">Nombre:</label>
                    <input type="text" id="nombre" name="nombre" value="${producto.nombre}" required>
                </div>

                <div class="form-group">
                    <label for="descripcion">Descripción:</label>
                    <textarea id="descripcion" name="descripcion" rows="3">${producto.descripcion}</textarea>
                </div>

                <div class="form-group">
                    <label for="cantidad">Cantidad:</label>
                    <input type="number" id="cantidad" name="cantidad" min="0" value="${producto.cantidad}" required>
                </div>

                <div class="form-group">
                    <label for="fechaVencimiento">Fecha de Vencimiento:</label>
                    <input type="date" id="fechaVencimiento" name="fechaVencimiento" 
                           value="<fmt:formatDate value='${producto.fechaVencimiento}' pattern='yyyy-MM-dd'/>" required>
                </div>

                <div class="form-group">
                    <button type="submit" class="btn">Actualizar</button>
                    <a href="productos" class="btn">Cancelar</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>