<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Register - School Trips Booking System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp" />
    <jsp:include page="/WEB-INF/views/common/navigation.jsp" />
    
    <div class="container">
        <h2>Register</h2>
        
        <c:if test="${not empty errorMessage}">
            <div class="error-message">
                <p>${errorMessage}</p>
            </div>
        </c:if>
        
        <form action="${pageContext.request.contextPath}/register" method="post">
            <div class="form-group">
                <label for="username">Username:</label>
                <input type="text" id="username" name="username" required>
            </div>
            
            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required>
            </div>
            
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" required>
            </div>
            
            <div class="form-group">
                <label for="fullName">Full Name:</label>
                <input type="text" id="fullName" name="fullName" required>
            </div>
            
            <div class="form-group">
                <label for="role">Role:</label>
                <select id="role" name="role" required>
                    <option value="student">Student</option>
                    <option value="teacher">Teacher</option>
                    <option value="admin">Admin</option>
                </select>
            </div>
            
            <div class="form-group">
                <label for="departmentId">Department:</label>
                <select id="departmentId" name="departmentId" required>
                    <option value="1">Computer Science</option>
                    <option value="2">Engineering</option>
                    <option value="3">Business</option>
                    <!-- In production, these would be loaded dynamically from the database -->
                </select>
            </div>
            
            <div class="form-group">
                <button type="submit">Register</button>
            </div>
        </form>
        
        <p>Already have an account? <a href="${pageContext.request.contextPath}/login">Login here</a></p>
    </div>
    
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    <script src="${pageContext.request.contextPath}/js/script.js"></script>
</body>
</html>