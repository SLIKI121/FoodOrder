<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FoodDelivery - Payment</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        .navbar-custom {
            background: rgba(255, 255, 255, 0.95);
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
        }
        
        .navbar-custom .navbar-brand {
            font-weight: bold;
            font-size: 24px;
            color: #667eea !important;
        }
        
        .payment-container {
            display: grid;
            grid-template-columns: 1fr 350px;
            gap: 20px;
            max-width: 1000px;
            margin: 0 auto;
        }
        
        @media (max-width: 768px) {
            .payment-container {
                grid-template-columns: 1fr;
            }
        }
        
        .payment-form {
            background: white;
            border-radius: 15px;
            padding: 40px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.1);
        }
        
        .form-section {
            margin-bottom: 40px;
        }
        
        .form-section-title {
            font-size: 18px;
            font-weight: bold;
            color: #333;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #667eea;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-group label {
            font-weight: 600;
            color: #333;
            margin-bottom: 8px;
            display: block;
        }
        
        .form-group input, .form-group textarea {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 14px;
            transition: all 0.3s;
            font-family: inherit;
        }
        
        .form-group input:focus, .form-group textarea:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
            outline: none;
        }
        
        .form-group input.is-invalid, .form-group textarea.is-invalid {
            border-color: #dc3545;
        }
        
        .error-message {
            color: #dc3545;
            font-size: 13px;
            margin-top: 5px;
            display: none;
        }
        
        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
        }
        
        .form-row.full {
            grid-template-columns: 1fr;
        }
        
        .payment-method {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 15px;
            margin-bottom: 20px;
        }
        
        .payment-option {
            position: relative;
        }
        
        .payment-option input[type="radio"] {
            display: none;
        }
        
        .payment-option label {
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 15px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s;
            font-weight: 600;
            font-size: 14px;
            margin-bottom: 0;
        }
        
        .payment-option input[type="radio"]:checked + label {
            border-color: #667eea;
            background: rgba(102, 126, 234, 0.1);
            color: #667eea;
        }
        
        .submit-btn {
            width: 100%;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 8px;
            padding: 14px;
            font-weight: 600;
            font-size: 16px;
            cursor: pointer;
            transition: all 0.3s;
            margin-top: 20px;
        }
        
        .submit-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(102, 126, 234, 0.4);
        }
        
        .submit-btn:active {
            transform: translateY(0);
        }
        
        /* Order Summary Sidebar */
        .order-summary {
            background: white;
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.1);
            height: fit-content;
            position: sticky;
            top: 20px;
        }
        
        .summary-title {
            font-size: 18px;
            font-weight: bold;
            color: #333;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .order-items {
            margin-bottom: 20px;
            padding-bottom: 20px;
            border-bottom: 2px solid #f0f0f0;
            max-height: 300px;
            overflow-y: auto;
        }
        
        .order-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 12px;
            font-size: 14px;
        }
        
        .order-item-name {
            color: #333;
            font-weight: 500;
        }
        
        .order-item-qty {
            color: #999;
            font-size: 12px;
        }
        
        .order-item-price {
            color: #667eea;
            font-weight: 600;
        }
        
        .summary-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 12px;
            font-size: 14px;
            color: #666;
        }
        
        .summary-row.total {
            font-weight: bold;
            font-size: 16px;
            color: #333;
            border-top: 2px solid #f0f0f0;
            padding-top: 12px;
            margin-top: 12px;
        }
        
        .summary-row.total span:last-child {
            color: #667eea;
        }
        
        .info-box {
            background: #f8f9fa;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 15px;
            font-size: 13px;
            color: #666;
        }
        
        .info-box i {
            color: #667eea;
            margin-right: 8px;
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
        
        // Get cart data from session
        String cartDataStr = request.getParameter("cartData");
        String subtotalStr = request.getParameter("subtotal");
        String totalStr = request.getParameter("total");
    %>
    
    <!-- Navigation Bar -->
    <nav class="navbar navbar-expand-lg navbar-custom">
        <div class="container-fluid">
            <a class="navbar-brand" href="menu-cart.jsp"><i class="fas fa-arrow-left"></i> Back to Cart</a>
            <span style="color: #667eea; font-weight: bold;">Payment</span>
        </div>
    </nav>
    
    <!-- Payment Container -->
    <div class="payment-container">
        <!-- Payment Form -->
        <form id="paymentForm" method="POST" action="PaymentServlet" class="payment-form">
            <!-- Delivery Address Section -->
            <div class="form-section">
                <div class="form-section-title">
                    <i class="fas fa-map-marker-alt"></i> Delivery Address
                </div>
                
                <div class="form-group">
                    <label for="address">Street Address</label>
                    <input type="text" id="address" name="address" placeholder="Enter your delivery address" 
                           value="<%= session.getAttribute("userAddress") != null ? session.getAttribute("userAddress") : "" %>" required>
                    <div class="error-message" id="addressError">Address is required</div>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="city">City</label>
                        <input type="text" id="city" name="city" placeholder="City" value="Bangalore" required>
                        <div class="error-message" id="cityError">City is required</div>
                    </div>
                    <div class="form-group">
                        <label for="zipcode">ZIP Code</label>
                        <input type="text" id="zipcode" name="zipcode" placeholder="e.g., 560001" required>
                        <div class="error-message" id="zipcodeError">Valid ZIP code required</div>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="instructions">Delivery Instructions (Optional)</label>
                    <textarea id="instructions" name="instructions" placeholder="e.g., Ring the bell twice" rows="3"></textarea>
                </div>
            </div>
            
            <!-- Payment Method Section -->
            <div class="form-section">
                <div class="form-section-title">
                    <i class="fas fa-credit-card"></i> Payment Method
                </div>
                
                <div class="payment-method">
                    <div class="payment-option">
                        <input type="radio" id="credit-card" name="paymentMethod" value="card" checked>
                        <label for="credit-card"><i class="fas fa-credit-card"></i> Credit Card</label>
                    </div>
                    <div class="payment-option">
                        <input type="radio" id="debit-card" name="paymentMethod" value="debit">
                        <label for="debit-card"><i class="fas fa-credit-card"></i> Debit Card</label>
                    </div>
                    <div class="payment-option">
                        <input type="radio" id="upi" name="paymentMethod" value="upi">
                        <label for="upi"><i class="fas fa-mobile-alt"></i> UPI</label>
                    </div>
                </div>
            </div>
            
            <!-- Card Details Section -->
            <div class="form-section" id="cardSection">
                <div class="form-section-title">
                    <i class="fas fa-lock"></i> Card Details
                </div>
                
                <div class="form-group">
                    <label for="cardName">Cardholder Name</label>
                    <input type="text" id="cardName" name="cardName" placeholder="John Doe" value="<%= session.getAttribute("userName") %>">
                    <div class="error-message" id="cardNameError">Cardholder name is required</div>
                </div>
                
                <div class="form-group">
                    <label for="cardNumber">Card Number</label>
                    <input type="text" id="cardNumber" name="cardNumber" placeholder="1234 5678 9012 3456" 
                           maxlength="19" inputmode="numeric">
                    <div class="error-message" id="cardNumberError">Valid card number required (16 digits)</div>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="expiry">Expiry Date</label>
                        <input type="text" id="expiry" name="expiry" placeholder="MM/YY" maxlength="5" inputmode="numeric">
                        <div class="error-message" id="expiryError">Valid expiry date required (MM/YY)</div>
                    </div>
                    <div class="form-group">
                        <label for="cvv">CVV</label>
                        <input type="text" id="cvv" name="cvv" placeholder="123" maxlength="4" inputmode="numeric">
                        <div class="error-message" id="cvvError">Valid CVV required (3-4 digits)</div>
                    </div>
                </div>
            </div>
            
            <!-- UPI Section -->
            <div class="form-section" id="upiSection" style="display: none;">
                <div class="form-section-title">
                    <i class="fas fa-mobile-alt"></i> UPI Payment
                </div>
                
                <div class="form-group">
                    <label for="upiId">UPI ID</label>
                    <input type="text" id="upiId" name="upiId" placeholder="yourname@upi">
                    <div class="error-message" id="upiIdError">Valid UPI ID required</div>
                </div>
                
                <div class="info-box">
                    <i class="fas fa-info-circle"></i>
                    Payment will be processed through your default UPI app
                </div>
            </div>
            
            <!-- Submit Button -->
            <button type="submit" class="submit-btn">
                <i class="fas fa-lock"></i> Complete Payment
            </button>
            
            <div class="info-box" style="margin-top: 20px;">
                <i class="fas fa-shield-alt"></i>
                Your payment is secured with 256-bit SSL encryption
            </div>
        </form>
        
        <!-- Order Summary Sidebar -->
        <div class="order-summary">
            <div class="summary-title">
                <i class="fas fa-receipt"></i> Order Summary
            </div>
            
            <!-- Sample order items - In real scenario, this would come from cart -->
            <div class="order-items" id="orderItemsList">
                <div class="order-item">
                    <div>
                        <div class="order-item-name">Biryani</div>
                        <div class="order-item-qty">Qty: 1</div>
                    </div>
                    <div class="order-item-price">₹250.00</div>
                </div>
            </div>
            
            <div class="summary-row">
                <span>Subtotal</span>
                <span>₹<span id="orderSubtotal">250.00</span></span>
            </div>
            <div class="summary-row">
                <span>Delivery Fee</span>
                <span>₹<span id="orderDelivery">50.00</span></span>
            </div>
            <div class="summary-row">
                <span>Tax (5%)</span>
                <span>₹<span id="orderTax">15.00</span></span>
            </div>
            <div class="summary-row total">
                <span>Total Amount</span>
                <span>₹<span id="orderTotal">315.00</span></span>
            </div>
            
            <div class="info-box" style="margin-top: 20px;">
                <i class="fas fa-truck"></i>
                <strong>Estimated Delivery:</strong> 30-45 minutes
            </div>
            
            <div class="info-box">
                <i class="fas fa-check-circle"></i>
                Your order will be confirmed once payment is successful
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Payment method toggle
        const paymentOptions = document.querySelectorAll('input[name="paymentMethod"]');
        const cardSection = document.getElementById('cardSection');
        const upiSection = document.getElementById('upiSection');
        
        paymentOptions.forEach(option => {
            option.addEventListener('change', function() {
                if (this.value === 'upi') {
                    cardSection.style.display = 'none';
                    upiSection.style.display = 'block';
                } else {
                    cardSection.style.display = 'block';
                    upiSection.style.display = 'none';
                }
            });
        });
        
        // Card number formatting
        document.getElementById('cardNumber').addEventListener('input', function(e) {
            let value = e.target.value.replace(/\s/g, '');
            let formattedValue = value.match(/.{1,4}/g)?.join(' ') || value;
            e.target.value = formattedValue;
        });
        
        // Expiry date formatting
        document.getElementById('expiry').addEventListener('input', function(e) {
            let value = e.target.value.replace(/\D/g, '');
            if (value.length >= 2) {
                value = value.slice(0, 2) + '/' + value.slice(2, 4);
            }
            e.target.value = value;
        });
        
        // CVV formatting
        document.getElementById('cvv').addEventListener('input', function(e) {
            e.target.value = e.target.value.replace(/\D/g, '');
        });
        
        // Form validation
        document.getElementById('paymentForm').addEventListener('submit', function(e) {
            e.preventDefault();
            
            let isValid = true;
            
            // Clear all errors
            document.querySelectorAll('.error-message').forEach(el => el.style.display = 'none');
            document.querySelectorAll('input, textarea').forEach(el => el.classList.remove('is-invalid'));
            
            // Validate address
            const address = document.getElementById('address').value.trim();
            if (!address) {
                document.getElementById('addressError').style.display = 'block';
                document.getElementById('address').classList.add('is-invalid');
                isValid = false;
            }
            
            // Validate city
            const city = document.getElementById('city').value.trim();
            if (!city) {
                document.getElementById('cityError').style.display = 'block';
                document.getElementById('city').classList.add('is-invalid');
                isValid = false;
            }
            
            // Validate ZIP code
            const zipcode = document.getElementById('zipcode').value.trim();
            if (!/^\d{6}$/.test(zipcode)) {
                document.getElementById('zipcodeError').style.display = 'block';
                document.getElementById('zipcode').classList.add('is-invalid');
                isValid = false;
            }
            
            const paymentMethod = document.querySelector('input[name="paymentMethod"]:checked').value;
            
            if (paymentMethod === 'upi') {
                // Validate UPI
                const upiId = document.getElementById('upiId').value.trim();
                if (!/^[a-zA-Z0-9._-]+@[a-zA-Z]{3,}$/.test(upiId)) {
                    document.getElementById('upiIdError').style.display = 'block';
                    document.getElementById('upiId').classList.add('is-invalid');
                    isValid = false;
                }
            } else {
                // Validate card details
                const cardName = document.getElementById('cardName').value.trim();
                if (!cardName) {
                    document.getElementById('cardNameError').style.display = 'block';
                    document.getElementById('cardName').classList.add('is-invalid');
                    isValid = false;
                }
                
                const cardNumber = document.getElementById('cardNumber').value.replace(/\s/g, '');
                if (!/^\d{16}$/.test(cardNumber)) {
                    document.getElementById('cardNumberError').style.display = 'block';
                    document.getElementById('cardNumber').classList.add('is-invalid');
                    isValid = false;
                }
                
                const expiry = document.getElementById('expiry').value;
                if (!/^(0[1-9]|1[0-2])\/\d{2}$/.test(expiry)) {
                    document.getElementById('expiryError').style.display = 'block';
                    document.getElementById('expiry').classList.add('is-invalid');
                    isValid = false;
                }
                
                const cvv = document.getElementById('cvv').value;
                if (!/^\d{3,4}$/.test(cvv)) {
                    document.getElementById('cvvError').style.display = 'block';
                    document.getElementById('cvv').classList.add('is-invalid');
                    isValid = false;
                }
            }
            
            if (isValid) {
                // Submit the form
                this.submit();
            }
        });
    </script>
</body>
</html>
