package com.schooltrip.controller;

import java.io.IOException;
import java.util.List;

import com.schooltrip.dao.UserDAO;

import com.schooltrip.model.User;
import com.schooltrip.model.Department;

import com.schooltrip.service.DepartmentService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.annotation.WebServlet;

@WebServlet("/register")
public class UserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private DepartmentService departmentService;

    @Override
    public void init() throws ServletException {
        super.init();
        this.departmentService = new DepartmentService();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get departments from database
        List<Department> departments = departmentService.getAllDepartments();
        request.setAttribute("departments", departments);

        request.getRequestDispatcher("/WEB-INF/views/users/register.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get form parameters
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String username = request.getParameter("username");
        if (username == null || username.isEmpty()) {
            username = email.split("@")[0];
        }
        String fullName = request.getParameter("fullName");
        String role = request.getParameter("role");
        int departmentId = Integer.parseInt(request.getParameter("departmentId"));

        // Create user object
        User user = new User();
        user.setUsername(username);
        user.setPassword(password);
        user.setEmail(email);
        user.setFullName(fullName);
        user.setRole(role);
        user.setDepartmentId(departmentId);

        // Register user
        UserDAO userDAO = new UserDAO();
        boolean registered = userDAO.registerUser(user);

        if (registered) {
            // Registration successful, redirect to login page
            response.sendRedirect(request.getContextPath() + "/login");
        } else {
            // Registration failed, set error message
            request.setAttribute("errorMessage", "Registration failed. Please try again.");
            request.getRequestDispatcher("/WEB-INF/views/users/register.jsp").forward(request, response);
        }
    }
}
