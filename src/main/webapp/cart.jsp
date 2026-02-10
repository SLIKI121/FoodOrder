<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="java.util.Map" %>
        <%@ page import="com.tap.model.Cart" %>
            <%@ page import="com.tap.model.Cartitem" %>
                <% /* Authentication Check */ Object userObj=session.getAttribute("user"); if (userObj==null) {
                    response.sendRedirect("login.jsp"); return; } Cart cart=(Cart) session.getAttribute("cart"); %>
                    <!DOCTYPE html>
                    <html lang="en">

                    <head>
                        <meta charset="UTF-8">
                        <meta name="viewport" content="width=device-width, initial-scale=1.0">
                        <title>My Cart - FoodExpress</title>
                        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
                            rel="stylesheet">
                        <link rel="stylesheet"
                            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
                        <style>
                            body {
                                background: #f5f7fa;
                                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                            }

                            .navbar-custom {
                                background: linear-gradient(135deg, #FF6B00 0%, #FFB84D 100%);
                                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                            }

                            .navbar-custom .navbar-brand {
                                font-weight: bold;
                                font-size: 24px;
                                color: white !important;
                            }

                            .navbar-custom .nav-link {
                                color: white !important;
                            }

                            .cart-container {
                                max-width: 900px;
                                margin: 40px auto;
                                padding: 0 20px;
                            }

                            .card {
                                border: none;
                                border-radius: 15px;
                                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
                            }

                            .card-header {
                                background: white;
                                border-bottom: 2px solid #f0f0f0;
                                padding: 20px;
                                font-weight: 700;
                                font-size: 20px;
                                border-radius: 15px 15px 0 0 !important;
                            }

                            .cart-item {
                                display: grid;
                                grid-template-columns: 1fr auto auto;
                                align-items: center;
                                gap: 20px;
                                padding: 20px;
                                border-bottom: 1px solid #eee;
                            }

                            .cart-item:last-child {
                                border-bottom: none;
                            }

                            .item-info h5 {
                                margin: 0;
                                font-weight: 700;
                            }

                            .item-info p {
                                margin: 0;
                                color: #888;
                                font-size: 14px;
                            }

                            .qty-controls {
                                display: flex;
                                align-items: center;
                                gap: 10px;
                                background: #f8f9fa;
                                border-radius: 30px;
                                padding: 5px 15px;
                            }

                            .btn-qty {
                                border: none;
                                background: none;
                                font-size: 18px;
                                font-weight: 700;
                                color: #FF6B00;
                                cursor: pointer;
                                padding: 0 5px;
                            }

                            .qty-display {
                                font-weight: 700;
                                width: 25px;
                                text-align: center;
                            }

                            .item-price {
                                font-weight: 800;
                                font-size: 18px;
                                color: #333;
                                width: 100px;
                                text-align: right;
                            }

                            .cart-footer {
                                padding: 30px;
                                background: #fafafa;
                                border-radius: 0 0 15px 15px;
                            }

                            .total-section {
                                display: flex;
                                justify-content: flex-end;
                                align-items: center;
                                gap: 40px;
                                margin-bottom: 20px;
                            }

                            .total-label {
                                font-size: 18px;
                                color: #666;
                                font-weight: 600;
                            }

                            .total-amount {
                                font-size: 28px;
                                font-weight: 800;
                                color: #FF6B00;
                            }

                            .btn-checkout {
                                background: #FF6B00;
                                color: white;
                                border: none;
                                padding: 15px 40px;
                                border-radius: 12px;
                                font-weight: 700;
                                font-size: 18px;
                                transition: 0.3s;
                            }

                            .btn-checkout:hover {
                                background: #E65A00;
                                transform: translateY(-3px);
                                box-shadow: 0 5px 15px rgba(255, 107, 0, 0.3);
                            }

                            .btn-checkout:disabled {
                                background: #ccc;
                                cursor: not-allowed;
                                transform: none;
                                box-shadow: none;
                            }

                            .empty-cart {
                                text-align: center;
                                padding: 60px 20px;
                            }

                            .empty-cart i {
                                font-size: 80px;
                                color: #ddd;
                                margin-bottom: 20px;
                            }
                        </style>
                    </head>

                    <body>
                        <nav class="navbar navbar-expand-lg navbar-dark navbar-custom sticky-top">
                            <div class="container">
                                <a class="navbar-brand" href="home.jsp"><i
                                        class="fas fa-utensils me-2"></i>FoodExpress</a>
                                <div class="ms-auto">
                                    <a href="home.jsp" class="nav-link d-inline-block me-3"><i
                                            class="fas fa-home me-1"></i>Home</a>
                                    <a href="orders" class="nav-link d-inline-block me-3"><i
                                            class="fas fa-shopping-bag me-1"></i>My Orders</a>
                                    <a href="LogoutServlet" class="nav-link d-inline-block"><i
                                            class="fas fa-sign-out-alt me-1"></i>Logout</a>
                                </div>
                            </div>
                        </nav>

                        <div class="cart-container">
                            <div class="card">
                                <div class="card-header">
                                    <i class="fas fa-shopping-cart me-2 text-primary"></i>My Shopping Cart
                                </div>
                                <div class="card-body p-0">
                                    <% if (cart !=null && cart.getItems() !=null && !cart.getItems().isEmpty()) { %>
                                        <div class="cart-items">
                                            <% for (Map.Entry<Integer, Cartitem> entry : cart.getItems().entrySet()) {
                                                Cartitem item = entry.getValue();
                                                %>
                                                <div class="cart-item">
                                                    <div class="item-info">
                                                        <h5>
                                                            <%= item.getItemName() %>
                                                        </h5>
                                                        <p>&#8377; <%= item.getPrice() %> per unit</p>
                                                    </div>
                                                    <div class="qty-controls">
                                                        <form action="CartServlet" method="POST" class="m-0">
                                                            <input type="hidden" name="action" value="update">
                                                            <input type="hidden" name="menuId"
                                                                value="<%= item.getMenuId() %>">
                                                            <input type="hidden" name="quantity"
                                                                value="<%= item.getQuantity() - 1 %>">
                                                            <input type="hidden" name="from" value="cart">
                                                            <button type="submit" class="btn-qty" <%=item.getQuantity()
                                                                <=1 ? "disabled" : "" %>>-</button>
                                                        </form>
                                                        <div class="qty-display">
                                                            <%= item.getQuantity() %>
                                                        </div>
                                                        <form action="CartServlet" method="POST" class="m-0">
                                                            <input type="hidden" name="action" value="update">
                                                            <input type="hidden" name="menuId"
                                                                value="<%= item.getMenuId() %>">
                                                            <input type="hidden" name="quantity"
                                                                value="<%= item.getQuantity() + 1 %>">
                                                            <input type="hidden" name="from" value="cart">
                                                            <button type="submit" class="btn-qty">+</button>
                                                        </form>
                                                        <form action="CartServlet" method="POST" class="ms-3 m-0">
                                                            <input type="hidden" name="action" value="remove">
                                                            <input type="hidden" name="menuId"
                                                                value="<%= item.getMenuId() %>">
                                                            <input type="hidden" name="from" value="cart">
                                                            <button type="submit"
                                                                class="btn border-0 p-0 text-danger"><i
                                                                    class="fas fa-trash"></i></button>
                                                        </form>
                                                    </div>
                                                    <div class="item-price">
                                                        &#8377; <%= String.format("%.2f", item.getPrice() *
                                                            item.getQuantity()) %>
                                                    </div>
                                                </div>
                                                <% } %>
                                        </div>

                                        <div class="cart-footer">
                                            <div class="total-section">
                                                <span class="total-label">Subtotal</span>
                                                <span class="total-amount">&#8377; <%= String.format("%.2f",
                                                        cart.getTotalPrice()) %></span>
                                            </div>
                                            <div class="d-flex justify-content-between align-items-center">
                                                <a href="menu.jsp" class="btn btn-outline-secondary rounded-pill px-4">
                                                    <i class="fas fa-arrow-left me-2"></i>Add More Items
                                                </a>
                                                <form action="CheckoutServlet" method="POST">
                                                    <button type="submit" class="btn-checkout">Proceed to
                                                        Checkout</button>
                                                </form>
                                            </div>
                                        </div>
                                        <% } else { %>
                                            <div class="empty-cart">
                                                <i class="fas fa-shopping-basket"></i>
                                                <h3>Your cart is empty!</h3>
                                                <p class="text-muted">Looks like you haven't added anything to your cart
                                                    yet.</p>
                                                <a href="home.jsp"
                                                    class="btn btn-primary mt-4 px-5 py-3 rounded-pill fw-bold">Explore
                                                    Restaurants</a>
                                            </div>
                                            <% } %>
                                </div>
                            </div>
                        </div>
                    </body>

                    </html>