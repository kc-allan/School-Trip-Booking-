<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:include page="/WEB-INF/views/common/layout.jsp">
    <jsp:param name="title" value="Booked Trips | School Trips Booking System" />
    <jsp:param name="content" value="/WEB-INF/views/trips/list-content.jsp" />
    <jsp:param name="scripts" value="
        <script>
            // Simple client-side filtering
            document.getElementById('searchInput').addEventListener('input', function() {
                const filter = this.value.toLowerCase();
                const rows = document.querySelectorAll('.trip-table tbody tr');
                
                rows.forEach(row => {
                    const text = row.textContent.toLowerCase();
                    row.style.display = text.includes(filter) ? '' : 'none';
                });
            });
            
            // Status filter
            document.getElementById('statusFilter').addEventListener('change', function() {
                const filter = this.value.toLowerCase();
                const rows = document.querySelectorAll('.trip-table tbody tr');
                
                rows.forEach(row => {
                    if (!filter) {
                        row.style.display = '';
                        return;
                    }
                    
                    const status = row.querySelector('.status').textContent.toLowerCase();
                    row.style.display = status.includes(filter) ? '' : 'none';
                });
            });
            
            // Simple table sorting
            function sortTable(columnIndex) {
                const table = document.querySelector('.trip-table');
                const tbody = table.querySelector('tbody');
                const rows = Array.from(tbody.querySelectorAll('tr'));
                const header = table.querySelectorAll('th')[columnIndex];
                const isAscending = !header.classList.contains('asc');
                
                // Clear all sort indicators
                table.querySelectorAll('th i').forEach(icon => {
                    icon.className = 'fas fa-sort';
                });
                
                // Set new sort indicator
                const icon = header.querySelector('i');
                icon.className = isAscending ? 'fas fa-sort-up' : 'fas fa-sort-down';
                header.classList.toggle('asc', isAscending);
                header.classList.toggle('desc', !isAscending);
                
                // Sort rows
                rows.sort((a, b) => {
                    const aValue = a.cells[columnIndex].textContent.trim();
                    const bValue = b.cells[columnIndex].textContent.trim();
                    
                    // Special handling for dates and numbers
                    if (columnIndex === 0) { // Trip ID (number)
                        return isAscending ? 
                            parseInt(aValue) - parseInt(bValue) : 
                            parseInt(bValue) - parseInt(aValue);
                    } else if (columnIndex === 3 || columnIndex === 4) { // Dates
                        return isAscending ? 
                            new Date(aValue) - new Date(bValue) : 
                            new Date(bValue) - new Date(aValue);
                    } else if (columnIndex === 5) { // Participants (number)
                        return isAscending ? 
                            parseInt(aValue) - parseInt(bValue) : 
                            parseInt(bValue) - parseInt(aValue);
                    } else {
                        return isAscending ? 
                            aValue.localeCompare(bValue) : 
                            bValue.localeCompare(aValue);
                    }
                });
                
                // Reattach sorted rows
                rows.forEach(row => tbody.appendChild(row));
            }
        </script>
    "/>
</jsp:include>