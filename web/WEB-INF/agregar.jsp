<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Agregar Usuario</title>
</head>
<body>
    <h1>Agregar Nuevo Usuario</h1>
    
    <form action="${pageContext.request.contextPath}/UsuarioServlet?action=agregar" method="POST">
        <div>
            <label>Nombre:</label>
            <input type="text" name="nombre" required>
        </div>
        <div>
            <label>Apellido:</label>
            <input type="text" name="apellido" required>
        </div>
        <div>
            <label>Email:</label>
            <input type="email" name="email" required>
        </div>
        <div>
            <label>Usuario:</label>
            <input type="text" name="usuario" required>
        </div>
        <div>
            <label>Contraseña:</label>
            <input type="password" name="clave" required>
        </div>
        <div>
            <label>Perfil:</label>
            <select name="perfil" required>
                <option value="1">Administrador</option>
                <option value="2">Usuario</option>
            </select>
        </div>
        <div>
            <input type="submit" value="Guardar">
        </div>
    </form>
    
    <a href="${pageContext.request.contextPath}/UsuarioServlet?action=listar">Volver</a>
</body>
</html>