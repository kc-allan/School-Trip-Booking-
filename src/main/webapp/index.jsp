<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>School Trips Booking System</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <style>
        :root {
            --primary-color: #3498db;
            --secondary-color: #2980b9;
            --success-color: #2ecc71;
            --warning-color: #f39c12;
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
            max-width: 1200px;
            overflow-y: scroll;
            margin: 2rem auto;
            padding: 2rem;
            background: white;
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
        }
        
        h1 {
            color: var(--primary-color);
            text-align: center;
            margin-bottom: 1.5rem;
            font-size: 2.2rem;
        }
        
        .welcome-message {
            text-align: center;
            font-size: 1.2rem;
            margin-bottom: 2rem;
            color: #555;
        }
        
        .auth-prompt {
            text-align: center;
            padding: 1.5rem;
            background-color: var(--light-gray);
            border-radius: var(--border-radius);
            margin: 2rem 0;
        }
        
        .auth-prompt a {
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 600;
            margin: 0 0.5rem;
        }
        
        .auth-prompt a:hover {
            text-decoration: underline;
        }
        
        .dashboard {
            margin-top: 2rem;
        }
        
        .dashboard h2 {
            color: var(--primary-color);
            border-bottom: 2px solid var(--light-gray);
            padding-bottom: 0.5rem;
            margin-bottom: 1.5rem;
        }
        
        .quick-actions {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 1.5rem;
            margin-top: 1.5rem;
        }
        
        .action-card {
            background: white;
            border-radius: var(--border-radius);
            padding: 1.5rem;
            box-shadow: var(--box-shadow);
            transition: transform 0.3s, box-shadow 0.3s;
            border-left: 4px solid var(--primary-color);
        }
        
        .action-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }
        
        .action-card i {
            font-size: 1.8rem;
            color: var(--primary-color);
            margin-bottom: 1rem;
        }
        
        .action-card h3 {
            margin: 0.5rem 0;
            color: var(--dark-gray);
        }
        
        .action-card p {
            color: #666;
            margin-bottom: 1.5rem;
            font-size: 0.9rem;
        }
        
        .action-card a {
            display: inline-block;
            padding: 0.5rem 1rem;
            background-color: var(--primary-color);
            color: white;
            text-decoration: none;
            border-radius: var(--border-radius);
            transition: background-color 0.3s;
        }
        
        .action-card a:hover {
            background-color: var(--secondary-color);
        }
        
        .user-greeting {
            text-align: center;
            font-size: 1.3rem;
            margin-bottom: 1.5rem;
            color: var(--dark-gray);
        }
        
        .user-greeting span {
            color: var(--primary-color);
            font-weight: 600;
        }
        
        @media (max-width: 768px) {
            .container {
                margin: 1rem;
                padding: 1.5rem;
            }
            
            .quick-actions {
                grid-template-columns: 1fr;
            }
            
            h1 {
                font-size: 1.8rem;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp" />
    <jsp:include page="/WEB-INF/views/common/navigation.jsp" />
    
    <div class="container">
        <h1><i class="fas fa-bus"></i> School Trips Booking System</h1>
        <p class="welcome-message">Manage and book school trips with ease</p>
        
        <c:if test="${empty sessionScope.user}">
            <div class="auth-prompt">
                <p>Please <a href="${pageContext.request.contextPath}/login"><i class="fas fa-sign-in-alt"></i> Login</a> or 
                <a href="${pageContext.request.contextPath}/register"><i class="fas fa-user-plus"></i> Register</a> to access the system</p>
            </div>
        </c:if>
        
        <c:if test="${not empty sessionScope.user}">
            <div class="user-greeting">
                Welcome back, <span>${sessionScope.user.fullName}</span>!
            </div>
            
            <div class="dashboard">
                <h2><i class="fas fa-bolt"></i> Quick Actions</h2>
                <div class="quick-actions">
                    <div class="action-card">
                        <i class="fas fa-plus-circle"></i>
                        <h3>Request a Trip</h3>
                        <p>Submit a new trip request for approval</p>
                        <a href="${pageContext.request.contextPath}/trip/request.jsp">Get Started</a>
                    </div>
                    
                    <div class="action-card">
                        <i class="fas fa-list-alt"></i>
                        <h3>View Trips</h3>
                        <p>Browse all upcoming and past trips</p>
                        <a href="${pageContext.request.contextPath}/trip/list.jsp">View Trips</a>
                    </div>
                    
                    <c:if test="${sessionScope.user.role == 'admin'}">
                        <div class="action-card">
                            <i class="fas fa-building"></i>
                            <h3>Manage Departments</h3>
                            <p>Add or modify department information</p>
                            <a href="${pageContext.request.contextPath}/department/manage.jsp">Manage</a>
                        </div>
                    </c:if>
                </div>
            </div>
        </c:if>
    </div>
    
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    <script src="${pageContext.request.contextPath}/js/script.js"></script>
</body>
</html>