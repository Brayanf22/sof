<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Dashboard Usuario</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h1>¡Hola <%= ((modelo.Usuario)session.getAttribute("usuario")).getNombre() %>!</h1>
        <p>Bienvenido al sistema como usuario normal</p>
        <a href="LogoutServlet" class="btn btn-danger">Cerrar Sesión</a>
    </div>
</body>
</html>