package com.schooltrip.dao;

import static org.junit.jupiter.api.Assertions.assertNotNull;
import java.sql.Connection;
import org.junit.jupiter.api.Test;

import com.schooltrip.util.DBConnection;

class DatabaseUtilTest {

    @Test
    void testConnection() {
        try (Connection connection = DBConnection.getConnection()) {
            assertNotNull(connection, "Database connection should not be null");
            System.out.println("Database connection successful!");
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Database connection failed!");
        }
    }
}
