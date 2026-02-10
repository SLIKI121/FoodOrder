<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.util.List,com.tap.model.Resturant" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Food Delivery</title>
    <link rel="stylesheet" href="restoStyle.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
</head>
<body>

    <!-- Navigation Bar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand fw-bold" href="#">FoodDelivery</a>
            <div class="collapse navbar-collapse">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link" href="#">🔍 Search</a></li>
                    <li class="nav-item"><a class="nav-link" href="#">📦 Orders</a></li>
                    <li class="nav-item"><a class="nav-link" href="#">🛒 Cart</a></li>
                    <li class="nav-item"><a class="nav-link" href="#">🚪 Login</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Search Bar -->
    <div class="container mt-4">
        <input type="text" class="form-control search-bar" placeholder="Search for restaurants and food">
    </div>

    <!-- Restaurants Section -->
    <div class="container mt-4">
        <h4>Restaurants near you</h4>
        <div class="row">
            <!-- Restaurant Cards -->
            <%
            List<Resturant> resturants = (List<Resturant>) request.getAttribute("resturants");
            for (Resturant r : resturants) {
            %>
            <div class="col-md-4 col-sm-6 mb-4">
                <div class="restaurant-card">
                    <a href="Menu?restaurantId=<%=r.getRestaurantId() %>" style="text-decoration: none; color: inherit;">
                        <img src="<%= r.getImageUrl() %>" alt="Restaurant" class="img-fluid">
                        <div class="resturant-info">
                            <h5 class="restaurant-name"><%= r.getRestaurantName() %></h5>
                            <p class="restaurant-cuisine"><%= r.getCuisineType() %></p>
                            <div class="resturant-metadata">
                                <span class="rating"><i class="fas fa-star text-warning"></i> <%= r.getRating() %></span>
                                <span><i class="fas fa-clock"></i> <%= r.getDeliveryTime() %> mins</span>
                                <span><i class="fas fa-rupee-sign"></i> <%= r.getRestaurantId() %></span>
                            </div>
                        </div>
                    </a>
                </div>
            </div>
            <%
            }
            %>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>