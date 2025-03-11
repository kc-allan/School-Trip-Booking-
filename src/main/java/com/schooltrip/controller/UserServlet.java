package com.schooltrip.controller;

import java.io.IOException;

import com.schooltrip.dao.UserDAO;
import com.schooltrip.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


public class UserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO(); 

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getPathInfo();
        if (action == null || action.equals("/login")) {
            request.getRequestDispatcher("/WEB-INF/jsp/user/login.jsp").forward(request, response);
        } else if (action.equals("/register")) {
            request.getRequestDispatcher("/WEB-INF/jsp/user/register.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getPathInfo();
        if (action.equals("/register")) {
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            User user = new User();
            userDAO.saveUser(user);  // Save to database
            response.sendRedirect(request.getContextPath() + "/users/login");
        } else if (action.equals("/login")) {
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            User user = userDAO.authenticate(email, password);
            if (user != null) {
                request.getSession().setAttribute("user", user);
                response.sendRedirect(request.getContextPath() + "/dashboard");
            } else {
                request.setAttribute("errorMessage", "Invalid Credentials!");
                request.getRequestDispatcher("/WEB-INF/jsp/user/login.jsp").forward(request, response);
            }
        }
    }
}
