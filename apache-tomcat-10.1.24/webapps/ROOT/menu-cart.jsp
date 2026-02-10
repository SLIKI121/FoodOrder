<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, java.util.Map, com.tap.model.Menu, com.tap.model.Cartitem, com.tap.model.Cart, com.tap.dapimplementation.MenuDaoImpl" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FoodDelivery - Menu & Cart</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
    <link rel="stylesheet" href="styles.css">
    <style>
        body {
            background: #f5f7fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        /* Navbar */
        .navbar-custom {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        
        .navbar-custom .navbar-brand {
            font-weight: bold;
            font-size: 24px;
            color: white !important;
        }
        
        .navbar-custom .nav-link {
            color: rgba(255, 255, 255, 0.9) !important;
            transition: all 0.3s;
            margin: 0 10px;
        }
        
        .navbar-custom .nav-link:hover {
            color: white !important;
            transform: translateY(-2px);
        }
        
        .cart-badge {
            background: #ff6b6b;
            color: white;
            border-radius: 50%;
            width: 24px;
            height: 24px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 12px;
            font-weight: bold;
            position: absolute;
            top: -8px;
            right: -8px;
        }
        
        .cart-icon-wrapper {
            position: relative;
            display: inline-block;
        }
        
        /* Main Container */
        .main-container {
            display: grid;
            grid-template-columns: 1fr 350px;
            gap: 20px;
            padding: 20px;
            max-width: 1400px;
            margin: 0 auto;
        }
        
        @media (max-width: 1024px) {
            .main-container {
                grid-template-columns: 1fr;
            }
            
            .cart-sidebar {
                position: fixed;
                right: -400px;
                top: 70px;
                width: 350px;
                height: calc(100vh - 70px);
                transition: right 0.3s;
                z-index: 1000;
                background: white;
                box-shadow: -2px 0 10px rgba(0, 0, 0, 0.1);
            }
            
            .cart-sidebar.active {
                right: 0;
            }
        }
        
        /* Menu Section */
        .menu-section {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 20px;
        }
        
        .menu-card {
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            transition: all 0.3s;
            display: flex;
            flex-direction: column;
        }
        
        .menu-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
        }
        
        .menu-card-image {
            width: 100%;
            height: 180px;
            object-fit: cover;
            background: #e0e0e0;
        }
        
        .menu-card-content {
            padding: 15px;
            flex-grow: 1;
            display: flex;
            flex-direction: column;
        }
        
        .menu-card-title {
            font-weight: 600;
            font-size: 16px;
            color: #333;
            margin-bottom: 5px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        
        .menu-card-description {
            font-size: 12px;
            color: #999;
            margin-bottom: 10px;
            line-height: 1.4;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }
        
        .menu-card-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: auto;
            padding-top: 10px;
            border-top: 1px solid #f0f0f0;
        }
        
        .menu-price {
            font-weight: bold;
            font-size: 18px;
            color: #667eea;
        }
        
        .menu-rating {
            font-size: 12px;
            color: #ffc107;
        }
        
        .quantity-selector {
            display: flex;
            align-items: center;
            gap: 5px;
            margin-bottom: 10px;
        }
        
        .quantity-btn {
            width: 28px;
            height: 28px;
            border: 1px solid #ddd;
            background: white;
            cursor: pointer;
            border-radius: 4px;
            font-weight: bold;
            color: #667eea;
            transition: all 0.2s;
        }
        
        .quantity-btn:hover {
            background: #f0f0f0;
            border-color: #667eea;
        }
        
        .quantity-input {
            width: 40px;
            text-align: center;
            border: 1px solid #ddd;
            border-radius: 4px;
            padding: 5px;
            font-size: 14px;
        }
        
        .add-to-cart-btn {
            width: 100%;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 6px;
            padding: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
        }
        
        .add-to-cart-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(102, 126, 234, 0.4);
        }
        
        .add-to-cart-btn:active {
            transform: translateY(0);
        }
        
        /* Cart Sidebar */
        .cart-sidebar {
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            padding: 20px;
            height: fit-content;
            position: sticky;
            top: 80px;
        }
        
        .cart-header {
            font-size: 20px;
            font-weight: bold;
            color: #333;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .cart-items-container {
            max-height: 400px;
            overflow-y: auto;
            margin-bottom: 15px;
            padding-bottom: 10px;
            border-bottom: 2px solid #f0f0f0;
        }
        
        .cart-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 0;
            border-bottom: 1px solid #f0f0f0;
        }
        
        .cart-item-info {
            flex-grow: 1;
        }
        
        .cart-item-name {
            font-weight: 600;
            font-size: 14px;
            color: #333;
            margin-bottom: 3px;
        }
        
        .cart-item-qty {
            font-size: 12px;
            color: #999;
            margin-bottom: 5px;
        }
        
        .cart-item-price {
            font-weight: bold;
            color: #667eea;
            font-size: 14px;
            margin-bottom: 5px;
        }
        
        .cart-item-actions {
            display: flex;
            gap: 5px;
        }
        
        .cart-item-btn {
            background: none;
            border: none;
            cursor: pointer;
            color: #999;
            font-size: 12px;
            transition: color 0.2s;
            padding: 2px 5px;
        }
        
        .cart-item-btn:hover {
            color: #667eea;
        }
        
        .cart-item-btn.remove:hover {
            color: #dc3545;
        }
        
        .cart-summary {
            background: #f8f9fa;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 15px;
        }
        
        .summary-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 8px;
            font-size: 14px;
        }
        
        .summary-row.total {
            font-weight: bold;
            font-size: 16px;
            color: #667eea;
            border-top: 2px solid #ddd;
            padding-top: 10px;
            margin-top: 10px;
        }
        
        .empty-cart {
            text-align: center;
            padding: 40px 20px;
            color: #999;
        }
        
        .empty-cart i {
            font-size: 48px;
            margin-bottom: 10px;
            opacity: 0.5;
        }
        
        .checkout-btn {
            width: 100%;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 8px;
            padding: 12px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            font-size: 16px;
        }
        
        .checkout-btn:hover:not(:disabled) {
            transform: translateY(-2px);
            box-shadow: 0 5px 20px rgba(102, 126, 234, 0.4);
        }
        
        .checkout-btn:disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }
        
        .logout-btn {
            width: 100%;
            background: #dc3545;
            color: white;
            border: none;
            border-radius: 8px;
            padding: 10px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            margin-top: 10px;
            font-size: 14px;
        }
        
        .logout-btn:hover {
            background: #c82333;
            transform: translateY(-2px);
        }
        
        .user-info {
            background: #f8f9fa;
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 15px;
            font-size: 13px;
        }
        
        .user-info .label {
            color: #999;
            font-size: 11px;
            text-transform: uppercase;
        }
        
        .user-info .value {
            font-weight: 600;
            color: #333;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        
        .toggle-cart-btn {
            display: none;
            position: fixed;
            bottom: 30px;
            right: 30px;
            width: 60px;
            height: 60px;
            border-radius: 50%;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            cursor: pointer;
            font-size: 24px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
            z-index: 999;
            transition: all 0.3s;
        }
        
        .toggle-cart-btn:hover {
            transform: scale(1.1);
        }
        
        @media (max-width: 1024px) {
            .toggle-cart-btn {
                display: flex;
                align-items: center;
                justify-content: center;
            }
            
            .cart-close-btn {
                display: none;
                position: absolute;
                top: 15px;
                right: 15px;
                background: none;
                border: none;
                font-size: 24px;
                cursor: pointer;
                color: #999;
                z-index: 1001;
            }
            
            .cart-sidebar.active .cart-close-btn {
                display: block;
            }
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
        
        // Get cart from session
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }
    %>
    
    <!-- Navigation Bar -->
    <nav class="navbar navbar-expand-lg navbar-dark navbar-custom sticky-top">
        <div class="container-fluid">
            <a class="navbar-brand" href="#"><i class="fas fa-utensils"></i> FoodDelivery</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="menu-cart.jsp"><i class="fas fa-home"></i> Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="LoginServlet?action=logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
                    </li>
                    <li class="nav-item d-lg-none">
                        <button class="nav-link btn" onclick="toggleCart()">
                            <i class="fas fa-shopping-cart"></i> Cart <span class="cart-badge" id="cartCountMobile">0</span>
                        </button>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    
    <!-- Main Content -->
    <div class="main-container">
        <!-- Menu Items -->
        <div>
            <div style="margin-bottom: 30px;">
                <h3 style="color: #333; font-weight: bold;">Available Food Items</h3>
                <p style="color: #999;">Select items and add to cart</p>
            </div>
            
            <div class="menu-section" id="menuSection">
                <%
                    try {
                        MenuDaoImpl menuDao = new MenuDaoImpl();
                        List<Menu> menuItems = menuDao.getMenuByRestaurant(1); // Default restaurant ID
                        
                        if (menuItems != null && !menuItems.isEmpty()) {
                            for (Menu menu : menuItems) {
                %>
                <div class="menu-card">
                    <img src="<%= menu.getImageUrl() != null ? menu.getImageUrl() : "images/menu/default.jpg" %>" 
                         class="menu-card-image" alt="<%= menu.getItemName() %>">
                    <div class="menu-card-content">
                        <div class="menu-card-title"><%= menu.getItemName() %></div>
                        <div class="menu-card-description"><%= menu.getDescription() %></div>
                        
                        <div class="menu-card-footer">
                            <div>
                                <div class="menu-price">₹<%= String.format("%.2f", menu.getPrice()) %></div>
                                <div class="menu-rating"><i class="fas fa-star"></i> <%= menu.getRating() %></div>
                            </div>
                        </div>
                        
                        <form method="POST" action="CartServlet" style="display: flex; gap: 8px; margin-top: 10px;">
                            <input type="hidden" name="menuId" value="<%= menu.getMenuId() %>">
                            <input type="hidden" name="itemName" value="<%= menu.getItemName() %>">
                            <input type="hidden" name="price" value="<%= menu.getPrice() %>">
                            <input type="hidden" name="action" value="add">
                            
                            <div class="quantity-selector" style="flex: 1;">
                                <input type="number" name="quantity" class="quantity-input" value="1" min="1" max="10">
                            </div>
                            <button type="submit" class="add-to-cart-btn" style="flex: 0.5;">
                                <i class="fas fa-plus"></i>
                            </button>
                        </form>
                    </div>
                </div>
                <%
                            }
                        } else {
                %>
                <div style="grid-column: 1 / -1; text-align: center; padding: 50px 20px; color: #999;">
                    <p><i class="fas fa-inbox" style="font-size: 48px; opacity: 0.5;"></i></p>
                    <p>No items available</p>
                </div>
                <%
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                %>
                <div style="grid-column: 1 / -1; text-align: center; padding: 50px 20px; color: #dc3545;">
                    <p>Error loading menu items</p>
                </div>
                <%
                    }
                %>
            </div>
        </div>
        
        <!-- Shopping Cart Sidebar -->
        <div class="cart-sidebar" id="cartSidebar">
            <button class="cart-close-btn" onclick="toggleCart()"><i class="fas fa-times"></i></button>
            
            <div class="cart-header">
                <i class="fas fa-shopping-cart"></i>
                <span>Your Cart</span>
                <span class="cart-badge d-none d-lg-inline-block" id="cartCount">0</span>
            </div>
            
            <!-- User Info -->
            <div class="user-info">
                <div class="label">User</div>
                <div class="value"><%= session.getAttribute("userName") %></div>
            </div>
            
            <!-- Cart Items -->
            <div class="cart-items-container" id="cartItemsContainer">
                <div class="empty-cart">
                    <i class="fas fa-shopping-bag"></i>
                    <p>Your cart is empty</p>
                </div>
            </div>
            
            <!-- Cart Summary -->
            <div class="cart-summary" id="cartSummary" style="display: none;">
                <div class="summary-row">
                    <span>Subtotal</span>
                    <span>₹<span id="subtotal">0.00</span></span>
                </div>
                <div class="summary-row">
                    <span>Delivery Fee</span>
                    <span>₹<span id="deliveryFee">50.00</span></span>
                </div>
                <div class="summary-row total">
                    <span>Total</span>
                    <span>₹<span id="total">0.00</span></span>
                </div>
            </div>
            
            <!-- Checkout Button -->
            <form method="POST" action="PaymentServlet" id="checkoutForm">
                <button type="submit" class="checkout-btn" id="checkoutBtn" disabled>
                    Proceed to Payment
                </button>
            </form>
            
            <a href="LoginServlet?action=logout" style="text-decoration: none;">
                <button type="button" class="logout-btn">
                    <i class="fas fa-sign-out-alt"></i> Logout
                </button>
            </a>
        </div>
    </div>
    
    <!-- Toggle Cart Button for Mobile -->
    <button class="toggle-cart-btn" onclick="toggleCart()" id="toggleCartBtn">
        <i class="fas fa-shopping-cart"></i>
        <span class="cart-badge" id="cartCountFloat">0</span>
    </button>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        let cartItems = {};
        const DELIVERY_FEE = 50;
        
        function updateCart() {
            const cartContainer = document.getElementById('cartItemsContainer');
            const cartSummary = document.getElementById('cartSummary');
            const checkoutBtn = document.getElementById('checkoutBtn');
            const cartCount = document.getElementById('cartCount');
            const cartCountMobile = document.getElementById('cartCountMobile');
            const cartCountFloat = document.getElementById('cartCountFloat');
            
            const totalItems = Object.values(cartItems).reduce((sum, item) => sum + item.quantity, 0);
            const subtotal = Object.values(cartItems).reduce((sum, item) => sum + (item.price * item.quantity), 0);
            const total = subtotal + DELIVERY_FEE;
            
            // Update counts
            cartCount.textContent = totalItems;
            cartCountMobile.textContent = totalItems;
            cartCountFloat.textContent = totalItems;
            
            if (totalItems === 0) {
                cartContainer.innerHTML = `
                    <div class="empty-cart">
                        <i class="fas fa-shopping-bag"></i>
                        <p>Your cart is empty</p>
                    </div>
                `;
                cartSummary.style.display = 'none';
                checkoutBtn.disabled = true;
            } else {
                let itemsHTML = '';
                for (const [menuId, item] of Object.entries(cartItems)) {
                    itemsHTML += `
                        <div class="cart-item">
                            <div class="cart-item-info">
                                <div class="cart-item-name">${item.name}</div>
                                <div class="cart-item-qty">Qty: ${item.quantity}</div>
                                <div class="cart-item-price">₹${(item.price * item.quantity).toFixed(2)}</div>
                            </div>
                            <div class="cart-item-actions">
                                <button type="button" class="cart-item-btn" onclick="updateQuantity(${menuId}, ${item.quantity - 1})">-</button>
                                <button type="button" class="cart-item-btn remove" onclick="removeFromCart(${menuId})"><i class="fas fa-trash"></i></button>
                            </div>
                        </div>
                    `;
                }
                cartContainer.innerHTML = itemsHTML;
                
                document.getElementById('subtotal').textContent = subtotal.toFixed(2);
                document.getElementById('total').textContent = total.toFixed(2);
                
                cartSummary.style.display = 'block';
                checkoutBtn.disabled = false;
            }
        }
        
        function addToCart(menuId, name, price) {
            if (cartItems[menuId]) {
                cartItems[menuId].quantity++;
            } else {
                cartItems[menuId] = { name, price, quantity: 1 };
            }
            updateCart();
        }
        
        function removeFromCart(menuId) {
            delete cartItems[menuId];
            updateCart();
        }
        
        function updateQuantity(menuId, newQty) {
            if (newQty <= 0) {
                removeFromCart(menuId);
            } else {
                cartItems[menuId].quantity = newQty;
                updateCart();
            }
        }
        
        function toggleCart() {
            document.getElementById('cartSidebar').classList.toggle('active');
        }
        
        // Handle form submission
        document.getElementById('checkoutForm').addEventListener('submit', function(e) {
            if (Object.keys(cartItems).length === 0) {
                e.preventDefault();
                alert('Please add items to cart');
            }
        });
        
        // Intercept form submissions from menu cards
        document.addEventListener('submit', function(e) {
            if (e.target.closest('form[action="CartServlet"]')) {
                e.preventDefault();
                const form = e.target;
                const menuId = parseInt(form.querySelector('[name="menuId"]').value);
                const name = form.querySelector('[name="itemName"]').value;
                const price = parseFloat(form.querySelector('[name="price"]').value);
                const quantity = parseInt(form.querySelector('[name="quantity"]').value);
                
                // Add multiple quantities
                for (let i = 0; i < quantity; i++) {
                    addToCart(menuId, name, price);
                }
                
                // Reset quantity
                form.querySelector('[name="quantity"]').value = '1';
            }
        });
        
        // Initialize cart display
        updateCart();
    </script>
</body>
</html>
