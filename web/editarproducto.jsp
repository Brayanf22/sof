<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Editar Producto</title>
        <style>
            /* Estilos generales */
            body {
                font-family: 'Arial', sans-serif;
                background-color: #f5f5f5;
                margin: 0;
                padding: 20px;
                color: #333;
                line-height: 1.6;
            }
            
            .container {
                max-width: 800px;
                margin: 0 auto;
                background: #fff;
                padding: 30px;
                border-radius: 8px;
                box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            }
            
            h1 {
                color: #2c3e50;
                text-align: center;
                margin-bottom: 30px;
                padding-bottom: 15px;
                border-bottom: 2px solid #eee;
            }
            
            /* Estilos para mensajes de error */
            .error {
                background-color: #ffebee;
                color: #c62828;
                padding: 15px;
                margin-bottom: 20px;
                border-radius: 4px;
                border-left: 4px solid #c62828;
            }
            
            /* Estilos para el formulario */
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
            
            /* Estilos para botones */
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
            
            /* Responsividad */
            @media (max-width: 600px) {
                .container {
                    padding: 15px;
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
        <div class="container">
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
                           value="<fmt:formatDate value="${producto.fechaVencimiento}" pattern="yyyy-MM-dd"/>" required>
                </div>
                
                <div class="form-group">
                    <button type="submit" class="btn">Actualizar</button>
                    <a href="productos" class="btn">Cancelar</a>
                </div>
            </form>
        </div>
    </body>
</html>