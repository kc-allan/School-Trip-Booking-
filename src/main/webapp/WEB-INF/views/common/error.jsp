<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Page Not Found</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container">
        <h1>Oops! Page Not Found (404)</h1>
        <p>Sorry, the page you are looking for does not exist.</p>
        <a href="${pageContext.request.contextPath}/users/login">Go to Login</a>
    </div>
</body>
</html>
