package com.schooltrip.model;

public class TripSchedule {
	private int id;
	private int tripId;
	private String tripDate;
	private String tripTime;
	private int availableSeats;
	private int bookedSeats;
	
	public TripSchedule() {}
	
	public TripSchedule(int id, int tripId, String tripDate, String tripTime, int availableSeats, int bookedSeats) {
		this.id = id;
		this.tripId = tripId;
		this.tripDate = tripDate;
		this.tripTime = tripTime;
		this.availableSeats = availableSeats;
		this.bookedSeats = bookedSeats;
	}
	
	public int getId() { return id; }
	public void setId(int id) { this.id = id; }
	public int getTripId() { return tripId; }
	public void setTripId(int tripId) { this.tripId = tripId; }
	public String getTripDate() { return tripDate; }
	public void setTripDate(String tripDate) { this.tripDate = tripDate; }
	public String getTripTime() { return tripTime; }
	public void setTripTime(String tripTime) { this.tripTime = tripTime; }
	public int getAvailableSeats() { return availableSeats; }
	public void setAvailableSeats(int availableSeats) { this.availableSeats = availableSeats; }
	public int getBookedSeats() { return bookedSeats; }
	public void setBookedSeats(int bookedSeats) { this.bookedSeats = bookedSeats; }
}
