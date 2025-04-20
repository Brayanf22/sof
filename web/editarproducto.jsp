<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Editar Producto</title>
        <link rel="stylesheet" href="css/estilo.css">
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
                
                <button type="submit" class="btn">Actualizar</button>
                <a href="productos" class="btn">Cancelar</a>
            </form>
        </div>
    </body>
</html>