<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Lista de Usuarios</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            display: flex;
            min-height: 100vh;
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        /* Sidebar styles */
        .sidebar {
            width: 250px;
            background-color: #2c3e50;
            color: white;
            padding: 20px 0;
            height: 100vh;
            position: fixed;
        }
        
        .sidebar-header {
            padding: 0 20px 20px;
            border-bottom: 1px solid #34495e;
            margin-bottom: 20px;
        }
        
        .sidebar-header h2 {
            font-size: 1.3rem;
            font-weight: 600;
            margin: 0;
        }
        
        .nav-menu {
            list-style: none;
            padding: 0;
        }
        
        .nav-item {
            margin-bottom: 5px;
        }
        
        .nav-link {
            display: flex;
            align-items: center;
            padding: 10px 20px;
            color: white;
            text-decoration: none;
            transition: all 0.3s;
        }
        
        .nav-link:hover {
            background-color: #34495e;
            border-left: 4px solid #3498db;
        }
        
        .nav-link i {
            margin-right: 10px;
            font-size: 1.3rem;
        }
        
        /* Main content styles */
        .main-content {
            flex: 1;
            padding: 30px;
            background-color: #f8f9fa;
            margin-left: 250px;
        }
        
        .user-info-container {
            display: flex;
            justify-content: flex-end;
            margin-bottom: 20px;
        }
        
        .user-info {
            background-color: white;
            padding: 10px 15px;
            border-radius: 20px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            display: flex;
            align-items: center;
        }
        
        .user-icon {
            margin-right: 10px;
            font-size: 1.2rem;
        }
        
        .user-name {
            font-weight: 500;
        }
        
        .card {
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }
        
        .card-header {
            background-color: white;
            border-bottom: 1px solid rgba(0,0,0,0.1);
            padding: 20px;
        }
        
        .card-body {
            padding: 0;
        }
        
        .table-responsive {
            overflow-x: auto;
        }
        
        .table {
            margin-bottom: 0;
        }
        
        .table th {
            background-color: #f8f9fa;
            font-weight: 600;
        }

        .btn-sm {
            padding: 0.25rem 0.5rem;
            font-size: 0.875rem;
        }

        .btn-outline-warning:hover {
            background-color: #f39c12;
            border-color: #f39c12;
        }

        .btn-outline-danger:hover {
            background-color: #e74c3c;
            border-color: #e74c3c;
        }

        /* Responsividad */
        @media (max-width: 768px) {
            .sidebar {
                width: 200px;
            }

            .main-content {
                padding: 15px;
                margin-left: 200px;
            }
        }
    </style>
</head>
<body>
    <!-- Sidebar Navigation -->
    <div class="sidebar">
        <div class="sidebar-header">
            <h2>SISTEMA DE CONTROL DE USUARIOS</h2>
        </div>
        <ul class="nav-menu">
            <li class="nav-item">
                <a href="UsuarioServlet?accion=nuevo" class="nav-link">
                    <i class="fas fa-user-plus"></i>
                    <span>Nuevo Usuario</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="indexproducto.jsp" class="nav-link">
                    <i class="fas fa-boxes"></i>
                    <span>Lista de Productos</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="LogoutServlet" class="nav-link">
                    <i class="fas fa-sign-out-alt"></i>
                    <span>Cerrar Sesión</span>
                </a>
            </li>
        </ul>
    </div>

    <!-- Main Content Area -->
    <div class="main-content">
        <!-- Mostrar información del usuario en la parte superior derecha -->
        <c:if test="${not empty sessionScope.usuario}">
            <div class="user-info-container">
                <div class="user-info">
                    <span class="user-icon"><i class="fas fa-user"></i></span>
                    <span class="user-name">${sessionScope.usuario.nombre} ${sessionScope.usuario.apellido}</span>
                </div>
            </div>
        </c:if>
        
        <div class="card">
            <div class="card-header">
                <h1 class="h4 mb-0">Lista de Usuarios</h1>
            </div>
            <div class="card-body">
                <c:if test="${not empty mensaje}">
                    <div class="alert alert-success alert-dismissible fade show mx-3 mt-3" role="alert">
                        ${mensaje}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>
                
                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show mx-3 mt-3" role="alert">
                        ${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>
                
                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Nombre</th>
                                <th>Apellido</th>
                                <th>Email</th>
                                <th>Username</th>
                                <th>Perfil</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="usuario" items="${listaUsuarios}">
                                <tr>
                                    <td>${usuario.idUsuario}</td>
                                    <td>${usuario.nombre}</td>
                                    <td>${usuario.apellido}</td>
                                    <td>${usuario.email}</td>
                                    <td>${usuario.username}</td>
                                    <td>
                                        <span class="badge ${usuario.perfil == 'admin' ? 'bg-primary' : 'bg-secondary'}">
                                            ${usuario.perfil}
                                        </span>
                                    </td>
                                    <td>
                                        <a href="UsuarioServlet?accion=editar&id=${usuario.idUsuario}" 
                                           class="btn btn-sm btn-outline-warning" title="Editar">
                                            <i class="fas fa-edit"></i>
                                        </a>
                                        <a href="UsuarioServlet?accion=eliminar&id=${usuario.idUsuario}" 
                                           class="btn btn-sm btn-outline-danger" 
                                           onclick="return confirm('¿Está seguro de eliminar este usuario?')"
                                           title="Eliminar">
                                            <i class="fas fa-trash-alt"></i>
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>