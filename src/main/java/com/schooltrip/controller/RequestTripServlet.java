package com.schooltrip.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.schooltrip.model.Trip;
import com.schooltrip.service.TripService;

@WebServlet("/addTrip")
public class RequestTripServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/trips/request-trip.jsp").forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get form parameters
        String name = request.getParameter("name");
        String destination = request.getParameter("destination");
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");
        String description = request.getParameter("description");
        
        // Create trip object
        Trip trip = new Trip();
        trip.setName(name);
        trip.setDestination(destination);
        trip.setStartDate(startDate);
        trip.setEndDate(endDate);
        trip.setDescription(description);
        
        // Save trip to database
        TripService tripService = new TripService();
        boolean created = tripService.createTrip(trip);
        
        if (created) {
            response.sendRedirect(request.getContextPath() + "/trip");
        } else {
            request.setAttribute("errorMessage", "Failed to create trip");
            request.getRequestDispatcher("/WEB-INF/views/trips/request-trip.jsp").forward(request, response);
        }
    }
}
