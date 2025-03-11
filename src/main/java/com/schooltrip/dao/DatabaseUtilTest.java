package com.schooltrip.dao;

import static org.junit.jupiter.api.Assertions.assertNotNull;
import org.junit.jupiter.api.Test;
import java.sql.Connection;

class DatabaseUtilTest {

    @Test
    void testConnection() {
        try (Connection connection = DatabaseUtil.getConnection()) {
            assertNotNull(connection, "Database connection should not be null");
            System.out.println("Database connection successful!");
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Database connection failed!");
        }
    }
}
