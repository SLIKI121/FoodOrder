<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FoodDelivery - Order Confirmation</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        .confirmation-container {
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.2);
            max-width: 600px;
            width: 100%;
            padding: 50px 40px;
            text-align: center;
            animation: slideUp 0.6s ease;
        }
        
        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(40px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .success-icon {
            width: 100px;
            height: 100px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 30px;
            font-size: 50px;
            color: white;
            animation: bounce 0.6s ease;
        }
        
        @keyframes bounce {
            0%, 100% {
                transform: scale(0);
            }
            50% {
                transform: scale(1.1);
            }
            100% {
                transform: scale(1);
            }
        }
        
        .confirmation-title {
            font-size: 32px;
            font-weight: bold;
            color: #333;
            margin-bottom: 10px;
        }
        
        .confirmation-subtitle {
            font-size: 16px;
            color: #999;
            margin-bottom: 40px;
        }
        
        .order-info-box {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 30px;
            margin-bottom: 30px;
            border-left: 4px solid #667eea;
        }
        
        .order-number {
            font-size: 14px;
            color: #999;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 10px;
        }
        
        .order-id {
            font-size: 28px;
            font-weight: bold;
            color: #667eea;
            font-family: 'Courier New', monospace;
            word-break: break-all;
        }
        
        .info-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            margin-top: 30px;
            text-align: left;
        }
        
        .info-card {
            background: white;
            padding: 20px;
            border-radius: 10px;
            border: 1px solid #e0e0e0;
        }
        
        .info-card-label {
            font-size: 12px;
            color: #999;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 8px;
        }
        
        .info-card-value {
            font-size: 16px;
            font-weight: 600;
            color: #333;
        }
        
        .order-items-section {
            background: white;
            padding: 25px;
            border-radius: 10px;
            border: 1px solid #e0e0e0;
            text-align: left;
            margin-top: 30px;
        }
        
        .items-title {
            font-size: 16px;
            font-weight: bold;
            color: #333;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 2px solid #f0f0f0;
        }
        
        .order-item {
            display: flex;
            justify-content: space-between;
            padding: 12px 0;
            border-bottom: 1px solid #f0f0f0;
        }
        
        .order-item:last-child {
            border-bottom: none;
        }
        
        .item-details {
            display: flex;
            flex-direction: column;
        }
        
        .item-name {
            font-weight: 600;
            color: #333;
            margin-bottom: 3px;
        }
        
        .item-qty {
            font-size: 12px;
            color: #999;
        }
        
        .item-price {
            font-weight: bold;
            color: #667eea;
        }
        
        .price-summary {
            margin-top: 20px;
            padding-top: 20px;
            border-top: 2px solid #f0f0f0;
        }
        
        .price-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
            font-size: 14px;
            color: #666;
        }
        
        .price-row.total {
            font-weight: bold;
            font-size: 16px;
            color: #333;
        }
        
        .price-row.total span:last-child {
            color: #667eea;
            font-size: 18px;
        }
        
        .delivery-info {
            background: #e7f3ff;
            border-left: 4px solid #2196F3;
            padding: 15px;
            border-radius: 6px;
            margin-top: 25px;
            text-align: left;
        }
        
        .delivery-info-title {
            font-weight: 600;
            color: #333;
            margin-bottom: 8px;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .delivery-info-content {
            font-size: 14px;
            color: #666;
            line-height: 1.6;
        }
        
        .status-badge {
            display: inline-block;
            background: #e8f5e9;
            color: #2e7d32;
            padding: 8px 16px;
            border-radius: 20px;
            font-weight: 600;
            font-size: 12px;
            text-transform: uppercase;
            margin-bottom: 20px;
        }
        
        .button-group {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
            margin-top: 40px;
        }
        
        @media (max-width: 480px) {
            .button-group {
                grid-template-columns: 1fr;
            }
            
            .info-grid {
                grid-template-columns: 1fr;
            }
            
            .confirmation-container {
                padding: 30px 20px;
            }
        }
        
        .btn-primary-custom {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            padding: 12px 20px;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }
        
        .btn-primary-custom:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 20px rgba(102, 126, 234, 0.4);
            color: white;
        }
        
        .btn-secondary-custom {
            background: white;
            color: #667eea;
            border: 2px solid #667eea;
            padding: 12px 20px;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }
        
        .btn-secondary-custom:hover {
            background: #f8f9fa;
            color: #667eea;
            transform: translateY(-2px);
        }
        
        .timeline {
            display: flex;
            justify-content: space-between;
            margin-top: 25px;
            position: relative;
        }
        
        .timeline::before {
            content: '';
            position: absolute;
            top: 20px;
            left: 0;
            right: 0;
            height: 2px;
            background: #e0e0e0;
            z-index: 0;
        }
        
        .timeline-item {
            text-align: center;
            flex: 1;
            position: relative;
            z-index: 1;
        }
        
        .timeline-dot {
            width: 40px;
            height: 40px;
            background: white;
            border: 3px solid #ddd;
            border-radius: 50%;
            margin: 0 auto 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
            color: #ddd;
        }
        
        .timeline-item.active .timeline-dot {
            background: #667eea;
            border-color: #667eea;
            color: white;
        }
        
        .timeline-label {
            font-size: 12px;
            color: #999;
            font-weight: 600;
        }
    </style>
</head>
<body>
    <%
        // Check if user is logged in
        Object userObj = session.getAttribute("user");
        if (userObj == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        // Generate Order ID (in real app, this comes from database)
        String orderId = "ORD-" + System.currentTimeMillis() + "-" + (int)(Math.random() * 9000 + 1000);
        
        // Get parameters (would come from order processing)
        String totalAmount = request.getParameter("totalAmount");
        if (totalAmount == null) {
            totalAmount = "315.00";
        }
    %>
    
    <div class="confirmation-container">
        <!-- Success Icon -->
        <div class="success-icon">
            <i class="fas fa-check"></i>
        </div>
        
        <!-- Title -->
        <h1 class="confirmation-title">Order Placed Successfully!</h1>
        <p class="confirmation-subtitle">Your food will arrive soon. Thank you for ordering with us!</p>
        
        <!-- Status Badge -->
        <span class="status-badge"><i class="fas fa-check-circle"></i> Confirmed</span>
        
        <!-- Order Information Box -->
        <div class="order-info-box">
            <div class="order-number"><i class="fas fa-receipt"></i> Order ID</div>
            <div class="order-id"><%= orderId %></div>
        </div>
        
        <!-- Info Grid -->
        <div class="info-grid">
            <div class="info-card">
                <div class="info-card-label"><i class="fas fa-clock"></i> Order Time</div>
                <div class="info-card-value">
                    <%= java.time.LocalTime.now().format(java.time.format.DateTimeFormatter.ofPattern("HH:mm")) %>
                </div>
            </div>
            <div class="info-card">
                <div class="info-card-label"><i class="fas fa-hourglass-end"></i> Estimated Delivery</div>
                <div class="info-card-value">30-45 mins</div>
            </div>
        </div>
        
        <!-- Order Items -->
        <div class="order-items-section">
            <div class="items-title"><i class="fas fa-box"></i> Order Items</div>
            
            <div class="order-item">
                <div class="item-details">
                    <div class="item-name">Biryani</div>
                    <div class="item-qty">Quantity: 1</div>
                </div>
                <div class="item-price">₹250.00</div>
            </div>
            
            <div class="price-summary">
                <div class="price-row">
                    <span>Subtotal</span>
                    <span>₹250.00</span>
                </div>
                <div class="price-row">
                    <span>Delivery Fee</span>
                    <span>₹50.00</span>
                </div>
                <div class="price-row">
                    <span>Tax (5%)</span>
                    <span>₹15.00</span>
                </div>
                <div class="price-row total">
                    <span>Total Amount</span>
                    <span>₹<%= totalAmount %></span>
                </div>
            </div>
        </div>
        
        <!-- Delivery Information -->
        <div class="delivery-info">
            <div class="delivery-info-title">
                <i class="fas fa-map-marker-alt"></i> Delivery Details
            </div>
            <div class="delivery-info-content">
                <strong>Address:</strong> <%= session.getAttribute("userAddress") != null ? session.getAttribute("userAddress") : "Your delivery address" %><br>
                <strong>Phone:</strong> <%= session.getAttribute("userPhone") != null ? session.getAttribute("userPhone") : "Your phone number" %><br>
                <strong>Delivery Instructions:</strong> Please ring the bell twice and wait
            </div>
        </div>
        
        <!-- Order Timeline -->
        <div class="timeline">
            <div class="timeline-item active">
                <div class="timeline-dot"><i class="fas fa-check"></i></div>
                <div class="timeline-label">Confirmed</div>
            </div>
            <div class="timeline-item">
                <div class="timeline-dot"><i class="fas fa-utensils"></i></div>
                <div class="timeline-label">Preparing</div>
            </div>
            <div class="timeline-item">
                <div class="timeline-dot"><i class="fas fa-truck"></i></div>
                <div class="timeline-label">On the way</div>
            </div>
            <div class="timeline-item">
                <div class="timeline-dot"><i class="fas fa-home"></i></div>
                <div class="timeline-label">Delivered</div>
            </div>
        </div>
        
        <!-- Action Buttons -->
        <div class="button-group">
            <a href="menu-cart.jsp" class="btn-primary-custom">
                <i class="fas fa-shopping-bag"></i> Order More
            </a>
            <a href="LoginServlet?action=logout" class="btn-secondary-custom">
                <i class="fas fa-sign-out-alt"></i> Logout
            </a>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
