package com.schooltrip.controller;

import java.io.IOException;

import com.schooltrip.dao.UserDAO;
import com.schooltrip.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@jakarta.servlet.annotation.WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Forward to login page
        request.getRequestDispatcher("/WEB-INF/views/users/login.jsp").forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        UserDAO userDAO = new UserDAO();
        
        if (userDAO.validateUser(username, password)) {
            // Valid login, get user details
            User user = userDAO.getUserByUsername(username);
            
            // Store user in session
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            
            // Redirect to home page
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        } else {
            // Invalid login, set error message
            request.setAttribute("errorMessage", "Invalid username or password");
            request.getRequestDispatcher("/WEB-INF/views/users/login.jsp").forward(request, response);
        }
    }
}
