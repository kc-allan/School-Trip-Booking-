<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - School Trips Booking System</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <style>
        :root {
            --primary-color: #3498db;
            --secondary-color: #2980b9;
            --error-color: #e74c3c;
            --success-color: #2ecc71;
            --light-gray: #f5f5f5;
            --dark-gray: #333;
            --border-radius: 4px;
            --box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            line-height: 1.6;
            color: var(--dark-gray);
            background-color: #f9f9f9;
        }
        
        .container {
            max-width: 500px;
            margin: 3rem auto;
            padding: 2.5rem;
            background: white;
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            text-align: center;
        }
        
        h2 {
            color: var(--primary-color);
            margin-bottom: 1.8rem;
            font-size: 1.8rem;
        }
        
        .form-group {
            margin-bottom: 1.5rem;
            text-align: left;
        }
        
        label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 600;
        }
        
        input {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid #ddd;
            border-radius: var(--border-radius);
            font-size: 1rem;
            transition: border 0.3s;
        }
        
        input:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 2px rgba(52, 152, 219, 0.2);
        }
        
        .error-message {
            background-color: #fdecea;
            color: var(--error-color);
            padding: 1rem;
            border-radius: var(--border-radius);
            margin-bottom: 1.5rem;
            border-left: 4px solid var(--error-color);
            text-align: left;
        }
        
        .error-message i {
            margin-right: 0.5rem;
        }
        
        button {
            background-color: var(--primary-color);
            color: white;
            border: none;
            padding: 0.75rem 1.5rem;
            border-radius: var(--border-radius);
            cursor: pointer;
            font-size: 1rem;
            font-weight: 600;
            transition: background-color 0.3s;
            width: 100%;
            margin-top: 0.5rem;
        }
        
        button:hover {
            background-color: var(--secondary-color);
        }
        
        .auth-links {
            margin-top: 1.5rem;
            text-align: center;
        }
        
        .auth-links a {
            color: var(--primary-color);
            text-decoration: none;
            transition: color 0.3s;
        }
        
        .auth-links a:hover {
            color: var(--secondary-color);
            text-decoration: underline;
        }
        
        .input-icon {
            position: relative;
        }
        
        .input-icon i {
            position: absolute;
            left: 10px;
            top: 38px;
            color: #777;
        }
        
        .input-icon input {
            padding-left: 35px;
        }
        
        .forgot-password {
            text-align: right;
            margin-top: -0.5rem;
            margin-bottom: 1rem;
        }
        
        .forgot-password a {
            color: #666;
            font-size: 0.9rem;
            text-decoration: none;
        }
        
        .forgot-password a:hover {
            color: var(--primary-color);
            text-decoration: underline;
        }
        
        @media (max-width: 768px) {
            .container {
                margin: 1.5rem;
                padding: 1.5rem;
            }
        }
    </style>
</head>
<body>    
    <jsp:include page="/WEB-INF/views/common/header.jsp" />
    <jsp:include page="/WEB-INF/views/common/navigation.jsp" />
    
    <div class="container">
        <h2><i class="fas fa-sign-in-alt"></i> Welcome Back</h2>
        
        <c:if test="${not empty errorMessage}">
            <div class="error-message">
                <i class="fas fa-exclamation-circle"></i> ${errorMessage}
            </div>
        </c:if>
        
        <form action="${pageContext.request.contextPath}/login" method="post">
            <div class="form-group input-icon">
                <label for="email">Email Address</label>
                <i class="fas fa-envelope"></i>
                <input type="email" id="email" name="email" required placeholder="Enter your email address">
            </div>
            
            <div class="form-group input-icon">
                <label for="password">Password</label>
                <i class="fas fa-lock"></i>
                <input type="password" id="password" name="password" required placeholder="Enter your password">
            </div>
            
            <div class="forgot-password">
                <a href="${pageContext.request.contextPath}/forgot-password">Forgot password?</a>
            </div>
            
            <div class="form-group">
                <button type="submit">
                    <i class="fas fa-sign-in-alt"></i> Login
                </button>
            </div>
        </form>
        
        <div class="auth-links">
            Don't have an account? <a href="${pageContext.request.contextPath}/register">Register here</a>
        </div>
    </div>
    
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    <script src="${pageContext.request.contextPath}/js/script.js"></script>
</body>
</html>