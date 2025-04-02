package com.schooltrip.service;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.schooltrip.util.DBConnection;

import com.schooltrip.model.Department;

public class DepartmentService {

	// Fetch all departments from database
	public List<Department> getAllDepartments() {
		List<Department> departments = new ArrayList<>();
		String sql = "SELECT id, name FROM departments ORDER BY name";

		try (Connection conn = DBConnection.getConnection();
				Statement stmt = conn.createStatement();
				ResultSet rs = stmt.executeQuery(sql)) {

			while (rs.next()) {
				Department dept = new Department();
				dept.setId(rs.getInt("id"));
				dept.setName(rs.getString("name"));
				departments.add(dept);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			throw new RuntimeException("Error fetching departments", e);
		}
		return departments;
	}

	// Create a new department
	public boolean createDepartment(String departmentName) {
		String sql = "INSERT INTO departments (name) VALUES (?)";

		try (Connection conn = DBConnection.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql)) {

			pstmt.setString(1, departmentName);
			int affectedRows = pstmt.executeUpdate();
			return affectedRows > 0;
		} catch (SQLException e) {
			e.printStackTrace();
			throw new RuntimeException("Error creating department", e);
		}
	}
}