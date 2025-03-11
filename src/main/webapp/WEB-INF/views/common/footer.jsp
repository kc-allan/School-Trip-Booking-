<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<footer>
    <p>&copy; <span id="year"></span> School Trips Booking System</p>
</footer>

<script>
    
    document.getElementById("year").textContent = new Date().getFullYear();
</script>
