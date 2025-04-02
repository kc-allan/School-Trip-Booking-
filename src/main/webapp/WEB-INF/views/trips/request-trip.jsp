<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Request New Trip | School Trips Booking System</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <style>
        :root {
            --primary-color: #3498db;
            --secondary-color: #2980b9;
            --success-color: #2ecc71;
            --error-color: #e74c3c;
            --light-gray: #f5f5f5;
            --dark-gray: #333;
            --border-radius: 4px;
            --box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            line-height: 1.6;
            color: var(--dark-gray);
            background-color: #f9f9f9;
        }
        
        .container {
            max-width: 800px;
            margin: 2rem auto;
            padding: 2rem;
            background: white;
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
        }
        
        h1 {
            color: var(--primary-color);
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }
        
        .form-group {
            margin-bottom: 1.5rem;
        }
        
        label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 600;
        }
        
        input, select, textarea {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid #ddd;
            border-radius: var(--border-radius);
            font-size: 1rem;
            transition: border 0.3s;
        }
        
        input:focus, select:focus, textarea:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 2px rgba(52, 152, 219, 0.2);
        }
        
        .date-input-group {
            display: flex;
            gap: 1rem;
        }
        
        .date-input {
            flex: 1;
        }
        
        .btn {
            padding: 0.75rem 1.5rem;
            border-radius: var(--border-radius);
            cursor: pointer;
            font-size: 1rem;
            font-weight: 600;
            transition: background-color 0.3s;
            border: none;
        }
        
        .btn-primary {
            background-color: var(--primary-color);
            color: white;
        }
        
        .btn-primary:hover {
            background-color: var(--secondary-color);
        }
        
        .btn-block {
            display: block;
            width: 100%;
        }
        
        .error-message {
            color: var(--error-color);
            font-size: 0.9rem;
            margin-top: 0.25rem;
            display: none;
        }
        
        .input-icon {
            position: relative;
        }
        
        .input-icon i {
            position: absolute;
            left: 10px;
            top: 34%;
            color: #777;
        }
        
        .input-icon input, .input-icon select {
            padding-left: 35px;
        }
        
        .participants-list {
            margin-top: 1rem;
            border: 1px solid #eee;
            border-radius: var(--border-radius);
            padding: 1rem;
            max-height: 200px;
            overflow-y: auto;
        }
        
        .participant-item {
            display: flex;
            justify-content: space-between;
            padding: 0.5rem 0;
            border-bottom: 1px solid #eee;
        }
        
        .participant-item:last-child {
            border-bottom: none;
        }
        
        .remove-participant {
            color: var(--error-color);
            cursor: pointer;
        }
        
        .add-participant {
            display: flex;
            gap: 0.5rem;
            margin-top: 0.5rem;
        }
        
        .add-participant input {
            flex: 1;
        }
        
        .add-participant button {
            padding: 0 0.75rem;
            background-color: var(--success-color);
            color: white;
            border: none;
            border-radius: var(--border-radius);
            cursor: pointer;
        }
        
        @media (max-width: 768px) {
            .container {
                margin: 1rem;
                padding: 1.5rem;
            }
            
            .date-input-group {
                flex-direction: column;
                gap: 1rem;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp" />
    <jsp:include page="/WEB-INF/views/common/navigation.jsp" />
    
    <div class="container">
        <h1><i class="fas fa-plus-circle"></i> Request New Trip</h1>
        
        <c:if test="${not empty errorMessage}">
            <div class="error-message" style="display: block; background-color: #fdecea; padding: 1rem; border-radius: var(--border-radius); margin-bottom: 1.5rem; border-left: 4px solid var(--error-color);">
                <i class="fas fa-exclamation-circle"></i> ${errorMessage}
            </div>
        </c:if>
        
        <form id="tripForm" action="${pageContext.request.contextPath}/trip/request" method="post">
            <div class="form-group">
                <label for="destination">Destination</label>
                <div class="input-icon">
                    <i class="fas fa-map-marker-alt"></i>
                    <input type="text" id="destination" name="destination" required placeholder="Enter trip destination">
                </div>
                <span class="error-message" id="destinationError">Please enter a valid destination</span>
            </div>
            
            <div class="form-group">
                <label for="department">Department</label>
                <div class="input-icon">
                    <i class="fas fa-building"></i>
                    <select id="department" name="departmentId" required>
                        <option value="" disabled selected>Select your department</option>
                        <c:forEach var="department" items="${departments}">
                            <option value="${department.id}">${department.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <span class="error-message" id="departmentError">Please select a department</span>
            </div>
            
            <div class="form-group">
                <label>Trip Dates</label>
                <div class="date-input-group">
                    <div class="date-input">
                        <label for="departureDate">Departure Date</label>
                        <input type="date" id="departureDate" name="departureDate" required>
                        <span class="error-message" id="departureDateError">Please select a valid departure date</span>
                    </div>
                    <div class="date-input">
                        <label for="returnDate">Return Date</label>
                        <input type="date" id="returnDate" name="returnDate" required>
                        <span class="error-message" id="returnDateError">Please select a valid return date</span>
                    </div>
                </div>
            </div>
            
            <div class="form-group">
                <label for="purpose">Purpose of Trip</label>
                <textarea id="purpose" name="purpose" rows="4" required placeholder="Describe the purpose of this trip"></textarea>
                <span class="error-message" id="purposeError">Please describe the purpose of this trip</span>
            </div>
            
            <div class="form-group">
                <label for="participant">Participants</label>
                <input type="text" id="participant" placeholder="Enter participant name">
                <div class="add-participant">
                    <input type="email" id="participantEmail" placeholder="Enter participant email">
                    <button type="button" id="addParticipantBtn"><i class="fas fa-plus"></i></button>
                </div>
                <div class="participants-list" id="participantsList">
                    <!-- Participants will be added here dynamically -->
                </div>
                <input type="hidden" id="participants" name="participants">
                <span class="error-message" id="participantsError">Please add at least one participant</span>
            </div>
            
            <div class="form-group">
                <label for="transportation">Transportation Method</label>
                <select id="transportation" name="transportation" required>
                    <option value="" disabled selected>Select transportation method</option>
                    <option value="school_bus">School Bus</option>
                    <option value="public_transport">Public Transport</option>
                    <option value="rental_vehicle">Rental Vehicle</option>
                    <option value="other">Other</option>
                </select>
                <span class="error-message" id="transportationError">Please select a transportation method</span>
            </div>
            
            <div class="form-group">
                <label for="accommodation">Accommodation Needed?</label>
                <select id="accommodation" name="accommodation" required>
                    <option value="" disabled selected>Select accommodation option</option>
                    <option value="yes">Yes</option>
                    <option value="no">No</option>
                </select>
            </div>
            
            <div class="form-group" id="accommodationDetailsGroup" style="display: none;">
                <label for="accommodationDetails">Accommodation Details</label>
                <textarea id="accommodationDetails" name="accommodationDetails" rows="3" placeholder="Provide accommodation details if needed"></textarea>
            </div>
            
            <div class="form-group">
                <label for="budget">Estimated Budget (USD)</label>
                <div class="input-icon">
                    <i class="fas fa-dollar-sign"></i>
                    <input type="number" id="budget" name="budget" min="0" step="0.01" placeholder="Enter estimated budget">
                </div>
            </div>
            
            <div class="form-group">
                <label for="notes">Additional Notes</label>
                <textarea id="notes" name="notes" rows="3" placeholder="Any additional information"></textarea>
            </div>
            
            <div class="form-group">
                <button type="submit" class="btn btn-primary btn-block">
                    <i class="fas fa-paper-plane"></i> Submit Trip Request
                </button>
            </div>
        </form>
    </div>
    
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    
    <script>
        // Accommodation details toggle
        document.getElementById('accommodation').addEventListener('change', function() {
            const detailsGroup = document.getElementById('accommodationDetailsGroup');
            detailsGroup.style.display = this.value === 'yes' ? 'block' : 'none';
        });
        
        // Participants management
        const participants = [];
        
        document.getElementById('addParticipantBtn').addEventListener('click', function() {
            const nameInput = document.getElementById('participant');
            const emailInput = document.getElementById('participantEmail');
            const name = nameInput.value.trim();
            const email = emailInput.value.trim();
            
            if (name && email) {
                // Validate email format
                if (!validateEmail(email)) {
                    alert('Please enter a valid email address');
                    return;
                }
                
                participants.push({ name, email });
                updateParticipantsList();
                nameInput.value = '';
                emailInput.value = '';
                nameInput.focus();
            } else {
                alert('Please enter both name and email');
            }
        });
        
        function updateParticipantsList() {
            const list = document.getElementById('participantsList');
            const hiddenField = document.getElementById('participants');
            
            list.innerHTML = '';
            
            if (participants.length === 0) {
                list.innerHTML = '<p style="color: #666; text-align: center;">No participants added yet</p>';
                hiddenField.value = '';
                return;
            }
            
            participants.forEach((participant, index) => {
                const item = document.createElement('div');
                item.className = 'participant-item';
                item.innerHTML = `
                    <span>${participant.name} &lt;${participant.email}&gt;</span>
                    <span class="remove-participant" data-index="${index}">
                        <i class="fas fa-times"></i>
                    </span>
                `;
                list.appendChild(item);
            });
            
            hiddenField.value = JSON.stringify(participants);
            
            // Add event listeners to remove buttons
            document.querySelectorAll('.remove-participant').forEach(btn => {
                btn.addEventListener('click', function() {
                    const index = parseInt(this.getAttribute('data-index'));
                    participants.splice(index, 1);
                    updateParticipantsList();
                });
            });
        }
        
        function validateEmail(email) {
            const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            return re.test(email);
        }
        
        // Form validation
        document.getElementById('tripForm').addEventListener('submit', function(e) {
            let isValid = true;
            
            // Validate destination
            if (!document.getElementById('destination').value.trim()) {
                document.getElementById('destinationError').style.display = 'block';
                isValid = false;
            } else {
                document.getElementById('destinationError').style.display = 'none';
            }
            
            // Validate department
            if (!document.getElementById('department').value) {
                document.getElementById('departmentError').style.display = 'block';
                isValid = false;
            } else {
                document.getElementById('departmentError').style.display = 'none';
            }
            
            // Validate dates
            const departureDate = new Date(document.getElementById('departureDate').value);
            const returnDate = new Date(document.getElementById('returnDate').value);
            const today = new Date();
            today.setHours(0, 0, 0, 0);
            
            if (!document.getElementById('departureDate').value || departureDate < today) {
                document.getElementById('departureDateError').style.display = 'block';
                isValid = false;
            } else {
                document.getElementById('departureDateError').style.display = 'none';
            }
            
            if (!document.getElementById('returnDate').value || returnDate < departureDate) {
                document.getElementById('returnDateError').style.display = 'block';
                isValid = false;
            } else {
                document.getElementById('returnDateError').style.display = 'none';
            }
            
            // Validate purpose
            if (!document.getElementById('purpose').value.trim()) {
                document.getElementById('purposeError').style.display = 'block';
                isValid = false;
            } else {
                document.getElementById('purposeError').style.display = 'none';
            }
            
            // Validate participants
            if (participants.length === 0) {
                document.getElementById('participantsError').style.display = 'block';
                isValid = false;
            } else {
                document.getElementById('participantsError').style.display = 'none';
            }
            
            // Validate transportation
            if (!document.getElementById('transportation').value) {
                document.getElementById('transportationError').style.display = 'block';
                isValid = false;
            } else {
                document.getElementById('transportationError').style.display = 'none';
            }
            
            if (!isValid) {
                e.preventDefault();
                // Scroll to the first error
                document.querySelector('.error-message[style*="display: block"]').scrollIntoView({
                    behavior: 'smooth',
                    block: 'center'
                });
            }
        });
        
        // Initialize participants list
        updateParticipantsList();
    </script>
</body>
</html>