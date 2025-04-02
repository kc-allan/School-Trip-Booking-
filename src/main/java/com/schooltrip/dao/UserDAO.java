package com.schooltrip.dao;

import java.sql.*;
import java.util.Optional;

import com.schooltrip.model.User;
import com.schooltrip.util.PasswordHashUtil;

public class UserDAO {
    public boolean registerUser(User user, String password) throws Exception {
        String sql = "INSERT INTO users (full_name, email, username, password, role, department_id) VALUES (?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            pstmt.setString(1, user.getFullName());
            pstmt.setString(2, user.getEmail());
            pstmt.setString(3, user.getUsername());
            pstmt.setString(4, PasswordHashUtil.hashPassword(password));
            pstmt.setString(5, user.getRole());
            pstmt.setInt(6, user.getDepartmentId());

            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;
        }
    }

    public Optional<User> authenticateUser(String email, String password) throws Exception {
        String sql = "SELECT * FROM users WHERE email = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, email);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    String storedPassword = rs.getString("password");
                    
                    if (PasswordHashUtil.verifyPassword(password, storedPassword)) {
                        User user = new User();
                        user.setUserId(rs.getInt("user_id"));
                        user.setFullName(rs.getString("full_name"));
                        user.setEmail(rs.getString("email"));
                        user.setRole(rs.getString("role"));
                        user.setDepartmentId(rs.getInt("department_id"));
                        
                        return Optional.of(user);
                    }
                }
            }
        }
        return Optional.empty();
    }

    public boolean emailExists(String email) throws Exception {
        String sql = "SELECT COUNT(*) FROM users WHERE email = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, email);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        }
        return false;
    }
}