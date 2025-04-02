package com.schooltrip.service;

import com.schooltrip.model.Trip;
import com.schooltrip.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TripService {
    /**
     * Create a new trip in the database
     * @param trip The trip object to be created
     * @return true if creation was successful, false otherwise
     */
    public boolean createTrip(Trip trip) {
        String sql = "INSERT INTO trips (name, destination, start_date, end_date, description) VALUES (?, ?, ?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            pstmt.setString(1, trip.getName());
            pstmt.setString(2, trip.getDestination());
            pstmt.setString(3, trip.getStartDate());
            pstmt.setString(4, trip.getEndDate());
            pstmt.setString(5, trip.getDescription());
            
            int affectedRows = pstmt.executeUpdate();
            
            if (affectedRows > 0) {
                try (ResultSet generatedKeys = pstmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        trip.setId(generatedKeys.getInt(1));
                    }
                }
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Retrieve all trips from the database
     * @return List of all trips
     */
    public List<Trip> getAllTrips() {
        List<Trip> trips = new ArrayList<>();
        String sql = "SELECT * FROM trips ORDER BY start_date DESC";
        
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Trip trip = new Trip();
                trip.setId(rs.getInt("id"));
                trip.setName(rs.getString("name"));
                trip.setDestination(rs.getString("destination"));
                trip.setStartDate(rs.getString("start_date"));
                trip.setEndDate(rs.getString("end_date"));
                trip.setDescription(rs.getString("description"));
                
                trips.add(trip);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return trips;
    }

    /**
     * Get a trip by its ID
     * @param id The trip ID
     * @return The Trip object or null if not found
     */
    public Trip getTripById(int id) {
        String sql = "SELECT * FROM trips WHERE id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    Trip trip = new Trip();
                    trip.setId(rs.getInt("id"));
                    trip.setName(rs.getString("name"));
                    trip.setDestination(rs.getString("destination"));
                    trip.setStartDate(rs.getString("start_date"));
                    trip.setEndDate(rs.getString("end_date"));
                    trip.setDescription(rs.getString("description"));
                    return trip;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Update an existing trip
     * @param trip The trip object with updated values
     * @return true if update was successful, false otherwise
     */
    public boolean updateTrip(Trip trip) {
        String sql = "UPDATE trips SET name = ?, destination = ?, start_date = ?, end_date = ?, description = ? WHERE id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, trip.getName());
            pstmt.setString(2, trip.getDestination());
            pstmt.setString(3, trip.getStartDate());
            pstmt.setString(4, trip.getEndDate());
            pstmt.setString(5, trip.getDescription());
            pstmt.setInt(6, trip.getId());
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Delete a trip by its ID
     * @param id The trip ID to delete
     * @return true if deletion was successful, false otherwise
     */
    public boolean deleteTrip(int id) {
        String sql = "DELETE FROM trips WHERE id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, id);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Get trips within a specific date range
     * @param startDate Start date in YYYY-MM-DD format
     * @param endDate End date in YYYY-MM-DD format
     * @return List of trips within the date range
     */
    public List<Trip> getTripsByDateRange(String startDate, String endDate) {
        List<Trip> trips = new ArrayList<>();
        String sql = "SELECT * FROM trips WHERE start_date >= ? AND end_date <= ? ORDER BY start_date";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, startDate);
            pstmt.setString(2, endDate);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Trip trip = new Trip();
                    trip.setId(rs.getInt("id"));
                    trip.setName(rs.getString("name"));
                    trip.setDestination(rs.getString("destination"));
                    trip.setStartDate(rs.getString("start_date"));
                    trip.setEndDate(rs.getString("end_date"));
                    trip.setDescription(rs.getString("description"));
                    
                    trips.add(trip);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return trips;
    }
}