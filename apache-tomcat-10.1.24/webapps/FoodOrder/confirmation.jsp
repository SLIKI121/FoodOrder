<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Order Confirmed - FoodExpress</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
        <style>
            body {
                background: #f5f7fa;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
                margin: 0;
            }

            .success-card {
                background: white;
                padding: 50px;
                border-radius: 20px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
                text-align: center;
                max-width: 500px;
                width: 90%;
            }

            .success-icon {
                width: 80px;
                height: 80px;
                background: #4CAF50;
                color: white;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 40px;
                margin: 0 auto 30px;
            }

            h1 {
                font-weight: 800;
                color: #333;
                margin-bottom: 20px;
            }

            p {
                color: #666;
                font-size: 18px;
                margin-bottom: 30px;
            }

            .order-info {
                background: #f8f9fa;
                border-radius: 12px;
                padding: 20px;
                margin-bottom: 30px;
            }

            .info-row {
                display: flex;
                justify-content: space-between;
                margin-bottom: 10px;
                font-weight: 600;
            }

            .btn-home {
                background: #FF6B00;
                color: white;
                border: none;
                padding: 15px 30px;
                border-radius: 30px;
                font-weight: 700;
                width: 100%;
                transition: 0.3s;
                text-decoration: none;
                display: block;
            }

            .btn-home:hover {
                background: #E65A00;
                transform: translateY(-3px);
                box-shadow: 0 5px 15px rgba(255, 107, 0, 0.3);
                color: white;
            }
        </style>
    </head>

    <body>
        <div class="success-card">
            <div class="success-icon">
                <i class="fas fa-check"></i>
            </div>
            <h1>Order Confirmed!</h1>
            <p>Your delicious food is being prepared and will be with you shortly.</p>

            <div class="order-info">
                <div class="info-row">
                    <span>Order ID</span>
                    <span class="text-primary">#<%= session.getAttribute("orderId") !=null ?
                            session.getAttribute("orderId") : "1024" %></span>
                </div>
                <div class="info-row">
                    <span>Total Amount</span>
                    <span class="text-success">&#8377; <%= request.getParameter("totalAmount") !=null ?
                            request.getParameter("totalAmount") : "0.00" %></span>
                </div>
            </div>

            <div class="d-grid gap-3">
                <a href="home" class="btn-home">Back to Home</a>
                <a href="orders" class="btn btn-outline-secondary rounded-pill py-3 fw-bold">View My Orders</a>
            </div>
        </div>
    </body>

    </html>