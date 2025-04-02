package com.schooltrip.model;

public class Trip {
	private int id;
	private String name;
	private String destination;
	private String startDate;
	private String endDate;
	private String description;
	
	// Constructors, getters, and setters
	public Trip() {}
	
	public Trip(int id, String name, String destination, String startDate, String endDate, String description) {
		this.id = id;
		this.name = name;
		this.destination = destination;
		this.startDate = startDate;
		this.endDate = endDate;
		this.description = description;
	}
	
	// Getters and setters
	public int getId() { return id; }
	public void setId(int id) { this.id = id; }
	public String getName() { return name; }
	public void setName(String name) { this.name = name; }
	public String getDestination() { return destination; }
	public void setDestination(String destination) { this.destination = destination; }
	public String getStartDate() { return startDate; }
	public void setStartDate(String startDate) { this.startDate = startDate; }
	public String getEndDate() { return endDate; }
	public void setEndDate(String endDate) { this.endDate = endDate; }
	public String getDescription() { return description; }
	public void setDescription(String description) { this.description = description; }
}
