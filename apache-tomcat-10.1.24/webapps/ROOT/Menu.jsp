<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.util.List,com.tap.model.Menu" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Menu</title>
    <link rel="stylesheet" type="text/css" href="Menu.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
</head>
<body>
<div class="menu-container">
    <h2>Menu</h2>
    <div class="menu-list">
        <%
            List<Menu> menuList = (List<Menu>) request.getAttribute("allmenuList");    
            for (Menu m : menuList) {
        %>
            <div class="menu-item">
                <img src="<%= m.getImageUrl() %>" alt="<%= m.getItemName() %>" class="menu-image">
                <div class="menu-details">
                    <h5 class="menu-name"><%= m.getItemName() %></h5>
                    <p class="menu-description"><%= m.getDescription() %></p>
                    <p class="menu-price">Price: ₹<%= m.getPrice() %></p>
                    <p class="menu-rating"><i class="fas fa-star"></i> <%= m.getRating() %>/5</p>
                    <p class="menu-availability" data-available="<%= m.isAvailable() %>">
                        <i class="fas fa-<%= m.isAvailable() ? "check-circle" : "times-circle" %>"></i>
                        <%= m.isAvailable() ? "Available" : "Not Available" %>
                    </p>
                    
                    <form action="Cart" method="post" class="cart-form">
                        <input type="hidden" name="ItemId" value="<%= m.getMenuId() %>">
                        <input type="hidden" name="restaurantId" value="<%= request.getParameter("restaurantId") %>">
                       <input type="hidden" name="quantity" value="1">
                        <button type="submit" class="add-to-cart-btn">
                        <input type="hidden" name="action" value="add">
                            <i class="fas fa-cart-plus"></i> Add to Cart 
                        </button>
                    </form>
                </div>
            </div>
        <%
            }
        %>
    </div>
</div>
</body>
</html>