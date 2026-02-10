<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.tap.model.Cartitem" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Your Cart</title>
    <link rel="stylesheet" href="cart.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
</head>
<body>

<div class="cart-container">
    <h2>Your Cart</h2>
    <div class="cart-items">
        <%
            List<Cartitem> cartItems = (List<Cartitem>) request.getAttribute("cartItems");
            float total = 0;

            if (cartItems != null && !cartItems.isEmpty()) {
                for (Cartitem item : cartItems) {
                    total += item.getPrice() * item.getQuantity();
        %>
        <div class="cart-item">
            <div class="item-info">
                <h5 class="item-name"><%= item.getItemName()%></h5>
                <p class="item-price">₹<%= item.getPrice() %> each</p>
            </div>
            
            <div class="quantity-control">
                <form action="Cart" method="post">
                    <input type="hidden" name="ItemId" value="<%= item.getMenuId() %>">
                    <input type="hidden" name="action" value="update">
                    
                    <button type="button" class="qty-btn minus" onclick="updateQuantity(this, -1)">-</button>
                    <input type="number" name="quantity" value="<%= item.getQuantity() %>" min="1" class="quantity-input">
                    <button type="button" class="qty-btn plus" onclick="updateQuantity(this, 1)">+</button>
                    
                    <button type="submit" class="update-btn hidden">Update</button>
                </form>
            </div>

            <div class="item-total">
                ₹<%= item.getPrice() * item.getQuantity() %>
            </div>

            <form action="Cart" method="post" class="remove-form">
                <input type="hidden" name="ItemId" value="<%= item.getMenuId() %>">
                <input type="hidden" name="action" value="remove">
                <button type="submit" class="remove-btn" title="Remove from Cart">
                    <i class="fas fa-trash"></i>
                </button>
            </form>
        </div>
        <%
                }
            } else {
        %>
        <p>Your cart is empty.</p>
        <%
            }
        %>
    </div>

    <% if (cartItems != null && !cartItems.isEmpty()) { %>
    <div class="cart-summary">
        <div class="summary-row">
            <span>Subtotal:</span>
            <span>₹<%= total %></span>
        </div>
        <div class="summary-row">
            <span>Delivery Fee:</span>
            <span>₹50</span>
        </div>
        <div class="summary-row total">
            <span>Total:</span>
            <span>₹<%= total + 50 %></span>
        </div>
        <button class="checkout-btn">Proceed to Checkout</button>
    </div>
    <% } %>
</div>

<script>
function updateQuantity(button, change) {
    const form = button.closest('form');
    const input = form.querySelector('.quantity-input');
    let newValue = parseInt(input.value) + change;

    if (newValue < 1) newValue = 1;
    input.value = newValue;

    form.querySelector('.update-btn').click();
}
</script>

</body>
</html>
