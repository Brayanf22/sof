<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Gratafy Login</title>
    <style>
        body {
            font-family: 'Helvetica Neue', Arial, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            color: #333;
        }
        
        .login-container {
            background-color: #ffffff;
            width: 320px;
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
            text-align: center;
        }
        
        .logo {
            color: #2c3e50;
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 40px;
            letter-spacing: 1px;
        }
        
        .form-group {
            margin-bottom: 20px;
            text-align: left;
        }
        
        .form-label {
            display: block;
            margin-bottom: 8px;
            font-size: 12px;
            font-weight: 600;
            color: #7f8c8d;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        .form-input {
            width: 100%;
            padding: 12px;
            border: 1px solid #e0e0e0;
            border-radius: 4px;
            font-size: 14px;
            box-sizing: border-box;
            background-color: #f8f9fa;
        }
        
        .form-input:focus {
            outline: none;
            border-color: #3498db;
            background-color: #ffffff;
        }
        
        .submit-btn {
            background-color: #2c3e50;
            color: white;
            border: none;
            padding: 14px;
            width: 100%;
            border-radius: 4px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            margin-top: 10px;
            transition: background-color 0.2s;
            letter-spacing: 0.5px;
        }
        
        .submit-btn:hover {
            background-color: #1a252f;
        }
        
        .forgot-password {
            margin-top: 20px;
            font-size: 12px;
        }
        
        .forgot-password a {
            color: #7f8c8d;
            text-decoration: none;
        }
        
        .forgot-password a:hover {
            color: #3498db;
        }
        
        .error-message {
            color: #e74c3c;
            font-size: 12px;
            margin-bottom: 15px;
            padding: 8px 12px;
            background-color: #fdedec;
            border-radius: 4px;
            display: inline-block;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="logo">Inventario</div>
        
        <c:if test="${not empty error}">
            <div class="error-message">${error}</div>
        </c:if>
        
        <form action="LoginServlet" method="POST">
            <div class="form-group">
                <label class="form-label">User</label>
                <input type="text" class="form-input" name="username"  required>
            </div>
            
            <div class="form-group">
                <label class="form-label">Password</label>
                <input type="password" class="form-input" name="password" required>
            </div>
            
            <button type="submit" class="submit-btn">LOG IN</button>
        </form>
        
       
    </div>
</body>
</html>