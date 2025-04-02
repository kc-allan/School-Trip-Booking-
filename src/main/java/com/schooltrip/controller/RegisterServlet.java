package com.schooltrip.controller;

import java.io.IOException;

import com.schooltrip.dao.UserDAO;
import com.schooltrip.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private UserDAO userDAO;

    public void init() {
        userDAO = new UserDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/users/register.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");
        int departmentId = Integer.parseInt(request.getParameter("departmentId"));

        User user = new User(fullName, email, role, departmentId);

        try {
            // Check if email already exists
            if (userDAO.emailExists(email)) {
                request.setAttribute("errorMessage", "Email already exists");
                request.getRequestDispatcher("/WEB-INF/views/users/register.jsp").forward(request, response);
                return;
            }

            // Validate input (you can expand on this)
            if (fullName == null || fullName.trim().isEmpty() || 
                email == null || email.trim().isEmpty() ||
                password == null || password.length() < 6) {
                request.setAttribute("errorMessage", "Invalid input. Please check your details.");
                request.getRequestDispatcher("/WEB-INF/views/users/register.jsp").forward(request, response);
                return;
            }

            // Register user
            if (userDAO.registerUser(user, password)) {
                // Redirect to login with success message
                HttpSession session = request.getSession();
                session.setAttribute("successMessage", "Registration successful. Please log in.");
                response.sendRedirect(request.getContextPath() + "/login");
            } else {
                request.setAttribute("errorMessage", "Registration failed");
                request.getRequestDispatcher("/WEB-INF/views/users/register.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred during registration");
            request.getRequestDispatcher("/WEB-INF/views/users/register.jsp").forward(request, response);
        }
    }
}
