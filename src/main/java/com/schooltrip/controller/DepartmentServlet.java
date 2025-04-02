package com.schooltrip.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.schooltrip.model.Department;
import com.schooltrip.service.DepartmentService;

@WebServlet("/addDepartment")
public class DepartmentServlet extends HttpServlet {
    private DepartmentService departmentService = new DepartmentService();
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        
        String name = request.getParameter("name");
        if (name == null || name.trim().isEmpty()) {
            out.print("{\"success\": false, \"message\": \"Department name is required\"}");
            return;
        }
        
        try {
            boolean created = departmentService.createDepartment(name);
            if (created) {
                // Get the ID of the newly created department
                // (This would be more efficient with RETURN_GENERATED_KEYS in JDBC)
                List<Department> departments = departmentService.getAllDepartments();
                Department newDept = departments.stream()
                    .filter(d -> d.getName().equals(name))
                    .findFirst()
                    .orElse(null);
                
                if (newDept != null) {
                    out.print("{\"success\": true, \"id\": " + newDept.getId() + "}");
                } else {
                    out.print("{\"success\": false, \"message\": \"Department created but ID not found\"}");
                }
            } else {
                out.print("{\"success\": false, \"message\": \"Failed to create department\"}");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"success\": false, \"message\": \"Error: " + e.getMessage() + "\"}");
        }
    }
}