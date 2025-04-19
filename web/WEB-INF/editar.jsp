<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Editar Usuario</title>
</head>
<body>
    <h1>Editar Usuario</h1>
    <form action="UsuarioServlet?action=actualizar" method="POST">
        <input type="hidden" name="id" value="${usuario.idUsuario}">
        <table>
            <tr>
                <td>Nombre:</td>
                <td><input type="text" name="nombre" value="${usuario.nombre}" required></td>
            </tr>
            <tr>
                <td>Apellido:</td>
                <td><input type="text" name="apellido" value="${usuario.apellido}" required></td>
            </tr>
            <tr>
                <td>Email:</td>
                <td><input type="email" name="email" value="${usuario.email}" required></td>
            </tr>
            <tr>
                <td>Usuario:</td>
                <td><input type="text" name="usuario" value="${usuario.usuario}" required></td>
            </tr>
            <tr>
                <td>Contraseña:</td>
                <td><input type="password" name="clave" value="${usuario.clave}" required></td>
            </tr>
            <tr>
                <td>Perfil:</td>
                <td>
                    <select name="perfil" required>
                        <option value="1" ${usuario.perfil == 1 ? 'selected' : ''}>Administrador</option>
                        <option value="2" ${usuario.perfil == 2 ? 'selected' : ''}>Usuario</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td colspan="2"><input type="submit" value="Actualizar"></td>
            </tr>
        </table>
    </form>
    <a href="UsuarioServlet?action=listar">Volver</a>
</body>
</html>