package com.schooltrip.controller;

import java.io.IOException;
import java.util.List;

import com.schooltrip.dao.UserDAO;
import com.schooltrip.model.Department;
import com.schooltrip.model.User;
import com.schooltrip.service.DepartmentService;
import com.schooltrip.util.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private UserDAO userDAO;

    public void init() {
        userDAO = new UserDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
                // Get list of departments for the dropdown
        try {
            DepartmentService departmentService = new DepartmentService();
            List<Department> departments = departmentService.getAllDepartments();
            request.setAttribute("departments", departments);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred while fetching departments");
        }
        request.getRequestDispatcher("/WEB-INF/views/users/register.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String username = email.split(email.split("@")[0])[0];
        String password = request.getParameter("password");
        String role = request.getParameter("role");
        int departmentId = Integer.parseInt(request.getParameter("departmentId"));

        User user = new User(fullName, email, username, role, departmentId);

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
