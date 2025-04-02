package com.schooltrip.model;

public class Booking {
	private int id;
	private String name;
	private String email;
	private String phone;
	private String tripDate;
	private String tripTime;
	private int departmentId;
	private String departmentName;
	private String status;
	private String createdOn;
	private String updatedOn;

	public Booking() {
	}

	public Booking(int id, String name, String email, String phone, String tripDate, String tripTime, int departmentId,
			String departmentName, String status, String createdOn, String updatedOn) {
		this.id = id;
		this.name = name;
		this.email = email;
		this.phone = phone;
		this.tripDate = tripDate;
		this.tripTime = tripTime;
		this.departmentId = departmentId;
		this.departmentName = departmentName;
		this.status = status;
		this.createdOn = createdOn;
		this.updatedOn = updatedOn;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getTripDate() {
		return tripDate;
	}

	public void setTripDate(String tripDate) {
		this.tripDate = tripDate;
	}

	public String getTripTime() {
		return tripTime;
	}

	public void setTripTime(String tripTime) {
		this.tripTime = tripTime;
	}

	public int getDepartmentId() {
		return departmentId;
	}

	public void setDepartmentId(int departmentId) {
		this.departmentId = departmentId;
	}

	public String getDepartmentName() {
		return departmentName;
	}

	public void setDepartmentName(String departmentName) {
		this.departmentName = departmentName;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getCreatedOn() {
		return createdOn;
	}

	public void setCreatedOn(String createdOn) {
		this.createdOn = createdOn;
	}

	public String getUpdatedOn() {
		return updatedOn;
	}

	public void setUpdatedOn(String updatedOn) {
		this.updatedOn = updatedOn;
	}
}
