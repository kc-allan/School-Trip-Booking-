//package com.schooltrip.controller;
//
//
//
//import java.io.IOException;
//
//import com.schooltrip.dao.UserDAO;
//import com.schooltrip.model.User;
//
//import javax.servlet.ServletException;
//import javax.servlet.http.HttpServlet;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import javax.servlet.annotation.WebServlet;
//
//@WebServlet("/register")
//public class UserServlet extends HttpServlet {
//    private static final long serialVersionUID = 1L;
//    
//    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        // Forward to registration page
//        request.getRequestDispatcher("/WEB-INF/views/users/register.jsp").forward(request, response);
//    }
//    
//    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        // Get form parameters
//        String username = request.getParameter("username");
//        String password = request.getParameter("password");
//        String email = request.getParameter("email");
//        String fullName = request.getParameter("fullName");
//        String role = request.getParameter("role");
//        int departmentId = Integer.parseInt(request.getParameter("departmentId"));
//        
//        // Create user object
//        User user = new User();
//        user.setUsername(username);
//        user.setPassword(password); 
//        user.setEmail(email);
//        user.setFullName(fullName);
//        user.setRole(role);
//        user.setDepartmentId(departmentId);
//        
//        // Register user
//        UserDAO userDAO = new UserDAO();
//        boolean registered = userDAO.registerUser(user);
//        
//        if (registered) {
//            // Registration successful, redirect to login page
//            response.sendRedirect(request.getContextPath() + "/login");
//        } else {
//            // Registration failed, set error message
//            request.setAttribute("errorMessage", "Registration failed. Please try again.");
//            request.getRequestDispatcher("/WEB-INF/views/users/register.jsp").forward(request, response);
//        }
//    }
//}
//
