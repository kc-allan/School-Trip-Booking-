<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<nav>
    <ul>
        <li><a href="${pageContext.request.contextPath}/index.jsp"><i class="fas fa-home"></i><span class="nav-text"> Home</span></a></li>
        
        <c:if test="${empty sessionScope.user}">
            <li><a href="${pageContext.request.contextPath}/login"><i class="fas fa-sign-in-alt"></i><span class="nav-text"> Login</span></a></li>
            <li><a href="${pageContext.request.contextPath}/register"><i class="fas fa-user-plus"></i><span class="nav-text"> Register</span></a></li>
        </c:if>
        
        <c:if test="${not empty sessionScope.user}">
            <li><a href="${pageContext.request.contextPath}/trip/list"><i class="fas fa-route"></i><span class="nav-text"> Trips</span></a></li>
            <c:if test="${sessionScope.user.role == 'admin'}">
                <li><a href="${pageContext.request.contextPath}/department/list"><i class="fas fa-building"></i><span class="nav-text"> Departments</span></a></li>
                <li><a href="${pageContext.request.contextPath}/user/manage"><i class="fas fa-users-cog"></i><span class="nav-text"> Users</span></a></li>
            </c:if>
            <li><a href="${pageContext.request.contextPath}/profile"><i class="fas fa-user-circle"></i><span class="nav-text"> Profile</span></a></li>
            <li><a href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt"></i><span class="nav-text"> Logout</span></a></li>
        </c:if>
    </ul>
</nav>