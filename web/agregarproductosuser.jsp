<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Agregar Producto</title>
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
            display: flex;
            flex-direction: column;
        }
        
        .menu-header {
            padding: 15px 20px;
            font-size: 18px;
            font-weight: bold;
            border-bottom: 1px solid #34495e;
            margin-bottom: 20px;
            text-align: center;
        }
        
        .button-container {
            padding: 20px;
            display: flex;
            flex-direction: column;
            gap: 15px;
        }
        
        .menu-btn {
            display: flex;
            align-items: center;
            padding: 10px 15px;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            transition: background-color 0.3s;
        }
        
        .menu-btn:hover {
            background-color: #34495e;
        }
        
        .btn-icon {
            width: 20px;
            height: 20px;
            margin-right: 10px;
            filter: invert(1);
        }
        
        /* Contenido principal */
        .main-content {
            flex: 1;
            margin-left: 250px;
            padding: 30px;
            display: flex;
            justify-content: center;
            align-items: flex-start;
        }
        
        .form-container {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            padding: 30px;
            width: 100%;
            max-width: 600px;
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
        input[type="number"],
        input[type="date"],
        textarea {
            width: 100%;
            padding: 10px 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
            box-sizing: border-box;
        }
        
        textarea {
            height: 100px;
            resize: vertical;
        }
        
        .form-actions {
            display: flex;
            gap: 10px;
            margin-top: 30px;
        }
        
        .btn {
            display: flex;
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
        
        .btn-save {
            background-color: #4CAF50;
            color: white;
        }
        
        .btn-save:hover {
            background-color: #3e8e41;
        }
        
        .btn-cancel {
            background-color: #f44336;
            color: white;
        }
        
        .btn-cancel:hover {
            background-color: #d32f2f;
        }
        
        .btn-icon-small {
            width: 16px;
            height: 16px;
            margin-right: 8px;
            filter: invert(1);
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
    <!-- Menú lateral con botones -->
    <div class="side-menu">
        <div class="menu-header">SISTEMA DE INVENTARIO</div>
        <div class="button-container">
            <a href="/parcial2.1/productos?accion=user" class="menu-btn">
                <img src="https://cdn-icons-png.flaticon.com/512/709/709612.png" class="btn-icon" alt="Ver productos">
                Ver productos
            </a>
        </div>
    </div>

    <!-- Contenido principal - Formulario -->
    <div class="main-content">
        <div class="form-container">
            <h1>Agregar Nuevo Producto</h1>
            
            <c:if test="${not empty error}">
                <div class="error">${error}</div>
            </c:if>
            
            <form action="productos?accion=guardar2" method="post">
                <div class="form-group">
                    <label for="nombre">Nombre:</label>
                    <input type="text" id="nombre" name="nombre" required>
                </div>
                
                <div class="form-group">
                    <label for="descripcion">Descripción:</label>
                    <textarea id="descripcion" name="descripcion"></textarea>
                </div>
                
                <div class="form-group">
                    <label for="cantidad">Cantidad:</label>
                    <input type="number" id="cantidad" name="cantidad" min="0" required>
                </div>
                
                <div class="form-group">
                    <label for="fechaVencimiento">Fecha de Vencimiento:</label>
                    <input type="date" id="fechaVencimiento" name="fechaVencimiento" required>
                </div>
                
      <div class="form-actions">
    <button type="submit" class="btn btn-save">
        <img src="https://cdn-icons-png.flaticon.com/512/709/709586.png" class="btn-icon-small" alt="Guardar">
        Guardar
    </button>
    
    <a href="/parcial2.1/productos?accion=user" class="btn btn-cancel">
        <img src="https://cdn-icons-png.flaticon.com/512/709/709612.png" class="btn-icon-small" alt="Cancelar">
        Cancelar
    </a>
</div>
            </form>
        </div>
    </div>
</body>
</html>