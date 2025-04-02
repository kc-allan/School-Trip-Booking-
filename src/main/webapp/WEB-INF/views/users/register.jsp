<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - School Trips Booking System</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/register.css">
</head>

<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp" />
    <jsp:include page="/WEB-INF/views/common/navigation.jsp" />

    <div class="container">
        <h2><i class="fas fa-user-plus"></i> Create Your Account</h2>

        <c:if test="${not empty errorMessage}">
            <div class="error-message">
                <i class="fas fa-exclamation-circle"></i> ${errorMessage}
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/register" method="post">
            <div class="form-group">
                <label for="fullName"><i class="fas fa-user"></i> Full Name</label>
                <input type="text" id="fullName" name="fullName" required placeholder="Enter your full name">
            </div>

            <div class="form-group">
                <label for="email"><i class="fas fa-envelope"></i> Email</label>
                <input type="email" id="email" name="email" required placeholder="Enter your email address">
            </div>

            <div class="form-group">
                <label for="password"><i class="fas fa-lock"></i> Password</label>
                <input type="password" id="password" name="password" required placeholder="Create a password">
            </div>

            <div class="form-group">
                <label for="role"><i class="fas fa-user-tag"></i> Role</label>
                <select id="role" name="role" required>
                    <option value="" disabled selected>Select your role</option>
                    <option value="cod">COD</option>
                    <option value="admin">Administrator</option>
                </select>
            </div>

            <div class="form-group">
                <label for="departmentId"><i class="fas fa-building"></i> Department</label>
                <select id="departmentId" name="departmentId" required>
                    <option value="" disabled selected>Select your department</option>
                    <c:forEach var="department" items="${departments}">
                        <option value="${department.id}">${department.name}</option>
                    </c:forEach>
                </select>
                
                <div class="add-dept-container">
                    <input type="text" id="newDepartment" name="newDepartment" placeholder="Can't find your department? Add it here">
                    <button type="button" onclick="addDepartment()">
                        <i class="fas fa-plus"></i> Add
                    </button>
                </div>
            </div>

            <div class="form-group">
                <button type="submit">
                    <i class="fas fa-user-plus"></i> Register
                </button>
            </div>
        </form>

        <div class="login-link">
            Already have an account? <a href="${pageContext.request.contextPath}/login">Login here</a>
        </div>
    </div>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    
    <script src="${pageContext.request.contextPath}/js/script.js"></script>
    <script>
        function addDepartment() {
            const newDeptName = document.getElementById('newDepartment').value.trim();
            if (!newDeptName) {
                alert('Please enter a department name');
                return;
            }

            // Show loading state
            const addButton = document.querySelector('.add-dept-container button');
            addButton.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Adding...';
            addButton.disabled = true;

            fetch('${pageContext.request.contextPath}/addDepartment', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'name=' + encodeURIComponent(newDeptName)
            })
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.json();
            })
            .then(data => {
                if (data.success) {
                    // Add the new option to the select
                    const select = document.getElementById('departmentId');
                    const option = document.createElement('option');
                    option.value = data.id;
                    option.textContent = newDeptName;
                    select.appendChild(option);
                    
                    // Select the new option
                    select.value = data.id;
                    
                    // Clear the input
                    document.getElementById('newDepartment').value = '';
                    
                    // Show success message
                    alert('Department added successfully!');
                } else {
                    throw new Error(data.message || 'Failed to add department');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('Error: ' + error.message);
            })
            .finally(() => {
                // Reset button state
                addButton.innerHTML = '<i class="fas fa-plus"></i> Add';
                addButton.disabled = false;
            });
        }
    </script>
</body>
</html>