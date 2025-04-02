<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= request.getParameter("title") %></title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <style>
        :root {
            --primary-color: #3498db;
            --secondary-color: #2980b9;
            --dark-color: #2c3e50;
            --nav-color: #34495e;
            --light-gray: #f5f5f5;
            --dark-gray: #333;
            --border-radius: 4px;
            --box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            line-height: 1.6;
            color: var(--dark-gray);
            background-color: #f9f9f9;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }
        
        header {
            background-color: var(--dark-color);
            color: white;
            padding: 1rem 2rem;
            box-shadow: var(--box-shadow);
            position: sticky;
            top: 0;
            z-index: 1000;
        }
        
        .header-container {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        nav {
            background-color: var(--nav-color);
            padding: 0 2rem;
        }
        
        nav ul {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0;
            list-style: none;
            display: flex;
        }
        
        main {
            flex: 1;
            padding: 2rem 0;
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 2rem;
        }
        
        footer {
            background-color: var(--dark-color);
            color: white;
            padding: 2rem;
            margin-top: auto;
        }
        
        /* Responsive styles */
        @media (max-width: 768px) {
            header, nav {
                padding: 0.75rem 1rem;
            }
            
            nav ul {
                flex-wrap: wrap;
            }
            
            .container {
                padding: 0 1rem;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp" />
    <jsp:include page="/WEB-INF/views/common/navigation.jsp" />
    
    <main>
        <div class="container">
            <jsp:include page='<%= request.getParameter("content") %>' />
        </div>
    </main>
    
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    
    <script src="${pageContext.request.contextPath}/js/main.js"></script>
    <%= request.getParameter("scripts") != null ? request.getParameter("scripts") : "" %>
</body>
</html>