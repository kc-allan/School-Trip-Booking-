<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<style>
    .trip-list-container {
        background: white;
        padding: 2rem;
        border-radius: var(--border-radius);
        box-shadow: var(--box-shadow);
    }
    
    .controls {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 1.5rem;
        flex-wrap: wrap;
        gap: 1rem;
    }
    
    .search-filter {
        display: flex;
        gap: 1rem;
        flex-wrap: wrap;
    }
    
    .search-filter input, .search-filter select {
        padding: 0.5rem 0.75rem;
        border: 1px solid #ddd;
        border-radius: var(--border-radius);
    }
    
    .btn {
        padding: 0.5rem 1rem;
        border-radius: var(--border-radius);
        cursor: pointer;
        text-decoration: none;
        font-weight: 500;
        transition: all 0.3s;
        border: none;
    }
    
    .btn-primary {
        background-color: var(--primary-color);
        color: white;
    }
    
    .btn-primary:hover {
        background-color: var(--secondary-color);
    }
    
    .trip-table {
        width: 100%;
        border-collapse: collapse;
        margin-bottom: 1.5rem;
    }
    
    .trip-table th, .trip-table td {
        padding: 1rem;
        text-align: left;
        border-bottom: 1px solid #eee;
    }
    
    .trip-table th {
        background-color: var(--light-gray);
        font-weight: 600;
        cursor: pointer;
        user-select: none;
    }
    
    .trip-table th:hover {
        background-color: #e0e0e0;
    }
    
    .trip-table tr:hover {
        background-color: #f5f5f5;
    }
    
    .status {
        padding: 0.25rem 0.5rem;
        border-radius: var(--border-radius);
        font-size: 0.8rem;
        font-weight: 500;
        text-transform: capitalize;
    }
    
    .status-approved {
        background-color: #d4edda;
        color: #155724;
    }
    
    .status-pending {
        background-color: #fff3cd;
        color: #856404;
    }
    
    .status-rejected {
        background-color: #f8d7da;
        color: #721c24;
    }
    
    .status-completed {
        background-color: #d1ecf1;
        color: #0c5460;
    }
    
    .action-btns {
        display: flex;
        gap: 0.5rem;
    }
    
    .btn-sm {
        padding: 0.25rem 0.5rem;
        font-size: 0.8rem;
    }
    
    .btn-success {
        background-color: var(--success-color);
        color: white;
    }
    
    .btn-warning {
        background-color: var(--warning-color);
        color: white;
    }
    
    .btn-danger {
        background-color: var(--danger-color);
        color: white;
    }
    
    .pagination {
        display: flex;
        justify-content: center;
        gap: 0.5rem;
        margin-top: 1.5rem;
    }
    
    .pagination a, .pagination span {
        padding: 0.5rem 0.75rem;
        border: 1px solid #ddd;
        border-radius: var(--border-radius);
        text-decoration: none;
        color: var(--primary-color);
    }
    
    .pagination a:hover {
        background-color: var(--light-gray);
    }
    
    .pagination .active {
        background-color: var(--primary-color);
        color: white;
        border-color: var(--primary-color);
    }
    
    .no-trips {
        text-align: center;
        padding: 2rem;
        color: #666;
    }
    
    @media (max-width: 768px) {
        .trip-list-container {
            margin: 1rem;
            padding: 1rem;
        }
        
        .trip-table {
            display: block;
            overflow-x: auto;
        }
        
        .controls {
            flex-direction: column;
            align-items: flex-start;
        }
        
        .search-filter {
            width: 100%;
        }
    }
</style>

<div class="trip-list-container">
    <h1><i class="fas fa-route"></i> Booked Trips</h1>
    
    <div class="controls">
        <div class="search-filter">
            <input type="text" id="searchInput" placeholder="Search trips...">
            <select id="statusFilter">
                <option value="">All Statuses</option>
                <option value="approved">Approved</option>
                <option value="pending">Pending</option>
                <option value="rejected">Rejected</option>
                <option value="completed">Completed</option>
            </select>
            <select id="dateFilter">
                <option value="">All Dates</option>
                <option value="upcoming">Upcoming</option>
                <option value="past">Past</option>
                <option value="today">Today</option>
                <option value="thisWeek">This Week</option>
            </select>
        </div>
        
        <c:if test="${sessionScope.user.role == 'admin' || sessionScope.user.role == 'cod'}">
            <a href="${pageContext.request.contextPath}/trip/request.jsp" class="btn btn-primary">
                <i class="fas fa-plus"></i> New Trip Request
            </a>
        </c:if>
    </div>
    
    <c:choose>
        <c:when test="${not empty trips}">
            <table class="trip-table">
                <thead>
                    <tr>
                        <th onclick="sortTable(0)">Trip ID <i class="fas fa-sort"></i></th>
                        <th onclick="sortTable(1)">Destination <i class="fas fa-sort"></i></th>
                        <th onclick="sortTable(2)">Department <i class="fas fa-sort"></i></th>
                        <th onclick="sortTable(3)">Start Date <i class="fas fa-sort"></i></th>
                        <th onclick="sortTable(4)">End Date <i class="fas fa-sort"></i></th>
                        <th onclick="sortTable(5)">Participants <i class="fas fa-sort"></i></th>
                        <th onclick="sortTable(6)">Status <i class="fas fa-sort"></i></th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="trip" items="${trips}">
                        <tr>
                            <td>${trip.id}</td>
                            <td>${trip.destination}</td>
                            <td>${trip.department.name}</td>
                            <td><fmt:formatDate value="${trip.startDate}" pattern="MMM dd, yyyy"/></td>
                            <td><fmt:formatDate value="${trip.endDate}" pattern="MMM dd, yyyy"/></td>
                            <td>${trip.participantCount}</td>
                            <td>
                                <span class="status status-${trip.status}">${trip.status}</span>
                            </td>
                            <td class="action-btns">
                                <a href="${pageContext.request.contextPath}/trip/view?id=${trip.id}" class="btn btn-sm btn-primary" title="View Details">
                                    <i class="fas fa-eye"></i>
                                </a>
                                <c:if test="${(sessionScope.user.role == 'admin' || sessionScope.user.id == trip.requestedBy.id) && trip.status == 'pending'}">
                                    <a href="${pageContext.request.contextPath}/trip/edit?id=${trip.id}" class="btn btn-sm btn-warning" title="Edit">
                                        <i class="fas fa-edit"></i>
                                    </a>
                                </c:if>
                                <c:if test="${sessionScope.user.role == 'admin' && trip.status != 'completed'}">
                                    <a href="${pageContext.request.contextPath}/trip/delete?id=${trip.id}" class="btn btn-sm btn-danger" title="Delete" onclick="return confirm('Are you sure you want to delete this trip?')">
                                        <i class="fas fa-trash"></i>
                                    </a>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            
            <div class="pagination">
                <c:if test="${currentPage > 1}">
                    <a href="${pageContext.request.contextPath}/trip/list?page=${currentPage - 1}"><i class="fas fa-chevron-left"></i> Prev</a>
                </c:if>
                
                <c:forEach begin="1" end="${totalPages}" var="i">
                    <c:choose>
                        <c:when test="${i == currentPage}">
                            <span class="active">${i}</span>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/trip/list?page=${i}">${i}</a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
                
                <c:if test="${currentPage < totalPages}">
                    <a href="${pageContext.request.contextPath}/trip/list?page=${currentPage + 1}">Next <i class="fas fa-chevron-right"></i></a>
                </c:if>
            </div>
        </c:when>
        <c:otherwise>
            <div class="no-trips">
                <i class="fas fa-info-circle" style="font-size: 2rem; color: #3498db; margin-bottom: 1rem;"></i>
                <h3>No Trips Found</h3>
                <p>There are currently no booked trips in the system.</p>
				<p>${sessionScope.user.role}</p>
                <c:if test="${sessionScope.user.role == 'admin' || sessionScope.user.role == 'cod'}">
                    <a href="${pageContext.request.contextPath}/trip/request.jsp" class="btn btn-primary" style="margin-top: 1rem;">
                        <i class="fas fa-plus"></i> Create New Trip
                    </a>
                </c:if>
            </div>
        </c:otherwise>
    </c:choose>
</div>