<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="com.tap.model.User, java.util.List" %>
        <% User user=(User) session.getAttribute("user"); if (user==null) { response.sendRedirect("login.jsp"); return;
            } %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>My Profile - FoodExpress</title>
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
                <style>
                    * {
                        margin: 0;
                        padding: 0;
                        box-sizing: border-box;
                    }

                    body {
                        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                        background: #0F0F0F;
                        color: #FFFFFF;
                        min-height: 100vh;
                    }

                    /* Navbar */
                    .navbar {
                        background: rgba(26, 26, 26, 0.95);
                        backdrop-filter: blur(10px);
                        padding: 20px 0;
                        position: sticky;
                        top: 0;
                        z-index: 1000;
                        border-bottom: 1px solid rgba(255, 107, 0, 0.1);
                    }

                    .navbar-container {
                        max-width: 1400px;
                        margin: 0 auto;
                        padding: 0 30px;
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                    }

                    .logo {
                        display: flex;
                        align-items: center;
                        gap: 12px;
                        text-decoration: none;
                    }

                    .logo-icon {
                        width: 45px;
                        height: 45px;
                        background: linear-gradient(135deg, #FF6B00 0%, #FFB84D 100%);
                        border-radius: 12px;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                    }

                    .logo-icon i {
                        color: #FFFFFF;
                        font-size: 22px;
                    }

                    .logo-text {
                        font-size: 26px;
                        font-weight: 700;
                        color: #FFFFFF;
                    }

                    .nav-links {
                        display: flex;
                        gap: 20px;
                        align-items: center;
                    }

                    .nav-link {
                        color: #999;
                        text-decoration: none;
                        padding: 8px 16px;
                        border-radius: 8px;
                        transition: all 0.3s;
                    }

                    .nav-link:hover {
                        color: #FF6B00;
                        background: rgba(255, 107, 0, 0.1);
                    }

                    /* Profile Layout */
                    .profile-container {
                        max-width: 1000px;
                        margin: 60px auto;
                        padding: 0 30px;
                        animation: fadeIn 0.8s ease;
                    }

                    @keyframes fadeIn {
                        from {
                            opacity: 0;
                            transform: translateY(20px);
                        }

                        to {
                            opacity: 1;
                            transform: translateY(0);
                        }
                    }

                    .profile-header {
                        background: linear-gradient(135deg, #1A1A1A 0%, #0F0F0F 100%);
                        border-radius: 24px;
                        padding: 40px;
                        display: flex;
                        align-items: center;
                        gap: 30px;
                        border: 1px solid rgba(255, 107, 0, 0.1);
                        margin-bottom: 30px;
                    }

                    .profile-avatar {
                        width: 120px;
                        height: 120px;
                        background: linear-gradient(135deg, #FF6B00 0%, #FFB84D 100%);
                        border-radius: 50%;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        font-size: 48px;
                        color: #FFFFFF;
                        box-shadow: 0 10px 30px rgba(255, 107, 0, 0.3);
                    }

                    .profile-info h1 {
                        font-size: 32px;
                        margin-bottom: 8px;
                    }

                    .profile-info p {
                        color: #999;
                        font-size: 16px;
                    }

                    .profile-grid {
                        display: grid;
                        grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
                        gap: 30px;
                    }

                    .info-card {
                        background: rgba(26, 26, 26, 0.8);
                        border-radius: 20px;
                        padding: 30px;
                        border: 1px solid rgba(255, 107, 0, 0.1);
                        transition: all 0.3s;
                    }

                    .info-card:hover {
                        border-color: rgba(255, 107, 0, 0.3);
                        transform: translateY(-5px);
                    }

                    .info-card h3 {
                        color: #FF6B00;
                        font-size: 18px;
                        margin-bottom: 20px;
                        display: flex;
                        align-items: center;
                        gap: 10px;
                    }

                    .info-item {
                        margin-bottom: 15px;
                    }

                    .info-label {
                        color: #666;
                        font-size: 14px;
                        margin-bottom: 5px;
                    }

                    .info-value {
                        font-size: 16px;
                        color: #FFFFFF;
                        font-weight: 500;
                    }

                    .btn-edit {
                        background: rgba(255, 107, 0, 0.1);
                        border: 1px solid #FF6B00;
                        color: #FF6B00;
                        padding: 12px 24px;
                        border-radius: 12px;
                        font-weight: 600;
                        cursor: pointer;
                        transition: all 0.3s;
                        margin-top: 20px;
                    }

                    .btn-edit:hover {
                        background: #FF6B00;
                        color: #FFFFFF;
                    }

                    @media (max-width: 768px) {
                        .profile-header {
                            flex-direction: column;
                            text-align: center;
                            padding: 30px;
                        }
                    }
                </style>
            </head>

            <body>
                <!-- Navbar -->
                <nav class="navbar">
                    <div class="navbar-container">
                        <a href="home" class="logo">
                            <div class="logo-icon">
                                <i class="fas fa-utensils"></i>
                            </div>
                            <span class="logo-text">FoodExpress</span>
                        </a>
                        <div class="nav-links">
                            <a href="home" class="nav-link"><i class="fas fa-home"></i> Home</a>
                            <a href="menu-cart.jsp" class="nav-link"><i class="fas fa-shopping-cart"></i> Cart</a>
                            <a href="LogoutServlet" class="nav-link"><i class="fas fa-sign-out-alt"></i> Logout</a>
                        </div>
                    </div>
                </nav>

                <div class="profile-container">
                    <div class="profile-header">
                        <div class="profile-avatar">
                            <%= user.getName().substring(0, 1).toUpperCase() %>
                        </div>
                        <div class="profile-info">
                            <h1>Welcome, <%= user.getName() %>!</h1>
                            <p>Member since October 2023</p>
                        </div>
                    </div>

                    <div class="profile-grid">
                        <div class="info-card">
                            <h3><i class="fas fa-user-circle"></i> Personal Details</h3>
                            <div class="info-item">
                                <div class="info-label">Full Name</div>
                                <div class="info-value">
                                    <%= user.getName() %>
                                </div>
                            </div>
                            <div class="info-item">
                                <div class="info-label">Email Address</div>
                                <div class="info-value">
                                    <%= user.getEmail() %>
                                </div>
                            </div>
                            <div class="info-item">
                                <div class="info-label">Phone Number</div>
                                <div class="info-value">
                                    <%= user.getPhone() %>
                                </div>
                            </div>
                        </div>

                        <div class="info-card">
                            <h3><i class="fas fa-map-marker-alt"></i> Delivery Address</h3>
                            <div class="info-item">
                                <div class="info-label">Current Address</div>
                                <div class="info-value">
                                    <%= user.getAddress() %>
                                </div>
                            </div>
                            <button class="btn-edit">Update Address</button>
                        </div>
                    </div>

                    <!-- My Orders Section -->
                    <div style="margin-top: 50px;">
                        <h2 style="margin-bottom: 30px; font-size: 28px;">My Recent Orders</h2>
                        <% List<com.tap.model.Order> orders = (List<com.tap.model.Order>)
                                request.getAttribute("orders");
                                if (orders == null || orders.isEmpty()) {
                                %>
                                <div class="info-card" style="text-align: center; padding: 50px;">
                                    <i class="fas fa-shopping-bag"
                                        style="font-size: 48px; color: #333; margin-bottom: 20px;"></i>
                                    <p style="color: #666;">You haven't placed any orders yet.</p>
                                    <a href="home" class="btn-edit"
                                        style="display: inline-block; text-decoration: none; margin-top: 20px;">Order
                                        Now</a>
                                </div>
                                <% } else { %>
                                    <div style="display: flex; flex-direction: column; gap: 20px;">
                                        <% for (com.tap.model.Order order : orders) { %>
                                            <div class="info-card"
                                                style="display: flex; justify-content: space-between; align-items: center;">
                                                <div>
                                                    <div
                                                        style="font-size: 14px; color: #FF6B00; font-weight: 600; margin-bottom: 5px;">
                                                        ORDER #<%= order.getOrderId() %>
                                                    </div>
                                                    <div style="font-size: 18px; font-weight: 700; margin-bottom: 5px;">
                                                        <%= order.getOrderDate() %>
                                                    </div>
                                                    <div style="color: #999; font-size: 14px;">
                                                        Payment: <%= order.getPaymentMode() %>
                                                    </div>
                                                </div>
                                                <div style="text-align: right;">
                                                    <div
                                                        style="font-size: 20px; font-weight: 800; color: #FFFFFF; margin-bottom: 8px;">
                                                        &#8377;<%= String.format("%.2f", order.getTotalAmount()) %>
                                                    </div>
                                                    <span
                                                        style="background: rgba(46, 204, 113, 0.1); color: #2ecc71; padding: 6px 15px; border-radius: 50px; font-size: 12px; font-weight: 600; text-transform: uppercase;">
                                                        <%= order.getStatus() %>
                                                    </span>
                                                </div>
                                            </div>
                                            <% } %>
                                    </div>
                                    <% } %>
                    </div>
                </div>
            </body>

            </html>