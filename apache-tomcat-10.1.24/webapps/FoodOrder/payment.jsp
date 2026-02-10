<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="com.tap.model.Cart, com.tap.model.Cartitem, com.tap.model.User, java.util.Map" %>
        <% Cart cart=(Cart) session.getAttribute("cart"); User user=(User) session.getAttribute("user"); if (cart==null
            || cart.getItems().isEmpty()) { response.sendRedirect("menu-cart.jsp"); return; } String displayAddress="" ;
            if (user !=null && user.getAddress() !=null) { displayAddress=user.getAddress(); } double subtotal=0; for
            (Cartitem item : cart.getItems().values()) { subtotal +=item.getPrice() * item.getQuantity(); } double
            deliveryFee=50.00; double tax=subtotal * 0.05; double totalAmount=subtotal + deliveryFee + tax; %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Payment - FoodExpress</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
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

                    .checkout-container {
                        max-width: 1000px;
                        margin: 40px auto;
                        padding: 0 20px;
                        display: grid;
                        grid-template-columns: 1fr 350px;
                        gap: 30px;
                    }

                    @media (max-width: 768px) {
                        .checkout-container {
                            grid-template-columns: 1fr;
                        }
                    }

                    .card {
                        border: none;
                        border-radius: 15px;
                        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
                        margin-bottom: 20px;
                    }

                    .card-header {
                        background: white;
                        border-bottom: 1px solid #eee;
                        padding: 20px;
                        border-radius: 15px 15px 0 0 !important;
                        font-weight: 700;
                        font-size: 18px;
                    }

                    .card-body {
                        padding: 25px;
                    }

                    .payment-option {
                        border: 2px solid #f0f0f0;
                        border-radius: 12px;
                        padding: 15px;
                        margin-bottom: 15px;
                        cursor: pointer;
                        transition: 0.3s;
                        display: flex;
                        align-items: center;
                        gap: 15px;
                    }

                    .payment-option:hover {
                        border-color: #FF6B00;
                        background: #fffcf5;
                    }

                    .payment-option.active {
                        border-color: #FF6B00;
                        background: #fffcf5;
                    }

                    .payment-option input {
                        display: none;
                    }

                    .payment-option i {
                        font-size: 24px;
                        width: 30px;
                        text-align: center;
                        color: #666;
                    }

                    .payment-option.active i {
                        color: #FF6B00;
                    }

                    .order-summary-row {
                        display: flex;
                        justify-content: space-between;
                        margin-bottom: 10px;
                        color: #666;
                    }

                    .order-total-row {
                        display: flex;
                        justify-content: space-between;
                        margin-top: 15px;
                        padding-top: 15px;
                        border-top: 2px dashed #eee;
                        font-weight: 800;
                        font-size: 20px;
                        color: #FF6B00;
                    }

                    .btn-pay {
                        width: 100%;
                        padding: 15px;
                        background: #FF6B00;
                        color: white;
                        border: none;
                        border-radius: 12px;
                        font-weight: 700;
                        font-size: 18px;
                        margin-top: 20px;
                        transition: 0.3s;
                    }

                    .btn-pay:hover {
                        background: #E65A00;
                        transform: translateY(-2px);
                        box-shadow: 0 5px 15px rgba(255, 107, 0, 0.3);
                    }

                    .form-label {
                        font-weight: 600;
                        color: #444;
                    }

                    .form-control {
                        border-radius: 10px;
                        padding: 12px;
                        border: 1px solid #ddd;
                    }

                    .form-control:focus {
                        border-color: #FF6B00;
                        box-shadow: 0 0 0 0.2rem rgba(255, 107, 0, 0.1);
                    }
                </style>
            </head>

            <body>
                <nav class="navbar navbar-expand-lg navbar-dark navbar-custom sticky-top">
                    <div class="container">
                        <a class="navbar-brand" href="home.jsp"><i class="fas fa-utensils me-2"></i>FoodExpress</a>
                        <div class="ms-auto">
                            <a href="home.jsp" class="nav-link d-inline-block me-3 text-white text-decoration-none"><i
                                    class="fas fa-home me-1"></i>Home</a>
                            <a href="orders" class="nav-link d-inline-block text-white text-decoration-none"><i
                                    class="fas fa-shopping-bag me-1"></i>My Orders</a>
                        </div>
                    </div>
                </nav>

                <div class="checkout-container">
                    <!-- Main Form -->
                    <div class="checkout-main">
                        <form action="PaymentServlet" method="POST" id="paymentForm">
                            <div class="card">
                                <div class="card-header">
                                    <i class="fas fa-map-marker-alt me-2 text-primary"></i>Delivery Address
                                </div>
                                <div class="card-body">
                                    <div class="mb-3">
                                        <label class="form-label">Complete Address</label>
                                        <textarea name="address" class="form-control" rows="3"
                                            placeholder="Enter your full delivery address..."
                                            required><%= displayAddress %></textarea>
                                    </div>
                                </div>
                            </div>

                            <div class="card">
                                <div class="card-header">
                                    <i class="fas fa-credit-card me-2 text-primary"></i>Payment Method
                                </div>
                                <div class="card-body">
                                    <label class="payment-option active">
                                        <input type="radio" name="paymentMethod" value="COD" checked>
                                        <i class="fas fa-money-bill-wave"></i>
                                        <div>
                                            <div class="fw-bold">Cash on Delivery</div>
                                            <div class="small text-muted">Pay when your food arrives</div>
                                        </div>
                                    </label>

                                    <label class="payment-option">
                                        <input type="radio" name="paymentMethod" value="CARD">
                                        <i class="fas fa-credit-card"></i>
                                        <div>
                                            <div class="fw-bold">Credit / Debit Card</div>
                                            <div class="small text-muted">Secure online payment</div>
                                        </div>
                                    </label>

                                    <label class="payment-option">
                                        <input type="radio" name="paymentMethod" value="UPI">
                                        <i class="fas fa-mobile-alt"></i>
                                        <div>
                                            <div class="fw-bold">UPI</div>
                                            <div class="small text-muted">Instant mobile payment</div>
                                        </div>
                                </div>
                            </div>
                    </div>
                    </form>
                </div>

                <!-- Sidebar Summary -->
                <div class="checkout-sidebar">
                    <div class="card">
                        <div class="card-header">Order Summary</div>
                        <div class="card-body">
                            <div class="order-summary-row">
                                <span>Items Total</span>
                                <span>&#8377; <%= String.format("%.2f", subtotal) %></span>
                            </div>
                            <div class="order-summary-row">
                                <span>Delivery Fee</span>
                                <span>&#8377; <%= String.format("%.2f", deliveryFee) %></span>
                            </div>
                            <div class="order-summary-row">
                                <span>Taxes (5%)</span>
                                <span>&#8377; <%= String.format("%.2f", tax) %></span>
                            </div>
                            <div class="order-total-row">
                                <span>Total</span>
                                <span>&#8377; <%= String.format("%.2f", totalAmount) %></span>
                            </div>

                            <button type="submit" form="paymentForm" class="btn-pay">Place Order</button>
                            <a href="menu-cart.jsp" class="btn btn-light w-100 mt-3 border rounded-pill">Back to
                                Cart</a>
                        </div>
                    </div>
                </div>
                </div>

                <script>
                    document.querySelectorAll('.payment-option').forEach(option => {
                        option.addEventListener('click', function () {
                            document.querySelectorAll('.payment-option').forEach(opt => opt.classList.remove('active'));
                            this.classList.add('active');
                            this.querySelector('input').checked = true;
                        });
                    });
                </script>
            </body>

            </html>