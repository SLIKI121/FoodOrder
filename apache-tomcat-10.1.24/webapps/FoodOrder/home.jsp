<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="java.util.List" %>
        <%@ page import="com.tap.model.Resturant" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>FoodExpress - Order Delicious Food Online</title>
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
                        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
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
                        box-shadow: 0 4px 15px rgba(255, 107, 0, 0.3);
                    }

                    .logo-icon i {
                        color: #FFFFFF;
                        font-size: 22px;
                    }

                    .logo-text {
                        font-size: 26px;
                        font-weight: 700;
                        color: #FFFFFF;
                        letter-spacing: -0.5px;
                    }

                    .nav-links {
                        display: flex;
                        gap: 30px;
                        align-items: center;
                    }

                    .nav-link {
                        color: #999;
                        text-decoration: none;
                        font-size: 15px;
                        font-weight: 500;
                        transition: color 0.3s;
                        padding: 8px 16px;
                        border-radius: 8px;
                    }

                    .nav-link:hover {
                        color: #FF6B00;
                        background: rgba(255, 107, 0, 0.1);
                    }

                    .btn-logout {
                        background: linear-gradient(135deg, #FF6B00 0%, #FF8533 100%);
                        color: #FFFFFF;
                        border: none;
                        padding: 10px 24px;
                        border-radius: 10px;
                        font-size: 14px;
                        font-weight: 600;
                        cursor: pointer;
                        transition: all 0.3s;
                        box-shadow: 0 4px 15px rgba(255, 107, 0, 0.3);
                    }

                    .btn-logout:hover {
                        transform: translateY(-2px);
                        box-shadow: 0 6px 20px rgba(255, 107, 0, 0.4);
                    }

                    /* Hero Section */
                    .hero {
                        background: linear-gradient(135deg, rgba(255, 107, 0, 0.1) 0%, rgba(26, 26, 26, 0.5) 100%);
                        padding: 80px 30px;
                        text-align: center;
                        border-bottom: 1px solid rgba(255, 107, 0, 0.1);
                    }

                    .hero h1 {
                        font-size: 56px;
                        font-weight: 800;
                        margin-bottom: 20px;
                        background: linear-gradient(135deg, #FFFFFF 0%, #FF6B00 100%);
                        -webkit-background-clip: text;
                        -webkit-text-fill-color: transparent;
                        background-clip: text;
                    }

                    .hero p {
                        font-size: 20px;
                        color: #999;
                        margin-bottom: 40px;
                    }

                    .search-bar {
                        max-width: 600px;
                        margin: 0 auto;
                        position: relative;
                    }

                    .search-bar input {
                        width: 100%;
                        padding: 18px 60px 18px 24px;
                        background: rgba(42, 42, 42, 0.8);
                        border: 2px solid rgba(255, 107, 0, 0.2);
                        border-radius: 50px;
                        color: #FFFFFF;
                        font-size: 16px;
                        outline: none;
                        transition: all 0.3s;
                    }

                    .search-bar input:focus {
                        border-color: #FF6B00;
                        box-shadow: 0 0 0 4px rgba(255, 107, 0, 0.1);
                    }

                    .search-bar button {
                        position: absolute;
                        right: 6px;
                        top: 50%;
                        transform: translateY(-50%);
                        background: linear-gradient(135deg, #FF6B00 0%, #FF8533 100%);
                        border: none;
                        width: 48px;
                        height: 48px;
                        border-radius: 50%;
                        color: #FFFFFF;
                        cursor: pointer;
                        transition: all 0.3s;
                    }

                    .search-bar button:hover {
                        transform: translateY(-50%) scale(1.05);
                    }

                    /* Main Content */
                    .container {
                        max-width: 1400px;
                        margin: 0 auto;
                        padding: 60px 30px;
                    }

                    .section-header {
                        margin-bottom: 40px;
                    }

                    .section-header h2 {
                        font-size: 36px;
                        font-weight: 700;
                        margin-bottom: 10px;
                        color: #FFFFFF;
                    }

                    .section-header p {
                        font-size: 16px;
                        color: #999;
                    }

                    /* Restaurant Grid */
                    .restaurant-grid {
                        display: grid;
                        grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
                        gap: 30px;
                    }

                    .restaurant-card {
                        background: rgba(26, 26, 26, 0.8);
                        border-radius: 20px;
                        overflow: hidden;
                        transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
                        border: 1px solid rgba(255, 107, 0, 0.1);
                        cursor: pointer;
                        position: relative;
                    }

                    .restaurant-card:hover {
                        transform: translateY(-10px);
                        box-shadow: 0 20px 40px rgba(255, 107, 0, 0.2);
                        border-color: rgba(255, 107, 0, 0.3);
                    }

                    .restaurant-image {
                        width: 100%;
                        height: 220px;
                        object-fit: cover;
                        transition: transform 0.4s;
                    }

                    .restaurant-card:hover .restaurant-image {
                        transform: scale(1.05);
                    }

                    .restaurant-info {
                        padding: 24px;
                    }

                    .restaurant-name {
                        font-size: 22px;
                        font-weight: 700;
                        color: #FFFFFF;
                        margin-bottom: 8px;
                    }

                    .restaurant-cuisine {
                        color: #FF6B00;
                        font-size: 14px;
                        font-weight: 600;
                        margin-bottom: 12px;
                        text-transform: uppercase;
                        letter-spacing: 0.5px;
                    }

                    .restaurant-meta {
                        display: flex;
                        gap: 20px;
                        margin-bottom: 16px;
                    }

                    .meta-item {
                        display: flex;
                        align-items: center;
                        gap: 6px;
                        color: #999;
                        font-size: 14px;
                    }

                    .meta-item i {
                        color: #FF6B00;
                    }

                    .rating {
                        display: flex;
                        align-items: center;
                        gap: 6px;
                        color: #FFB84D;
                        font-weight: 600;
                    }

                    .btn-view-menu {
                        width: 100%;
                        padding: 14px;
                        background: linear-gradient(135deg, #FF6B00 0%, #FF8533 100%);
                        border: none;
                        border-radius: 12px;
                        color: #FFFFFF;
                        font-size: 15px;
                        font-weight: 600;
                        cursor: pointer;
                        transition: all 0.3s;
                        margin-top: 12px;
                    }

                    .btn-view-menu:hover {
                        transform: translateY(-2px);
                        box-shadow: 0 8px 20px rgba(255, 107, 0, 0.4);
                    }

                    .no-restaurants {
                        text-align: center;
                        padding: 80px 20px;
                        color: #666;
                    }

                    .no-restaurants i {
                        font-size: 64px;
                        margin-bottom: 20px;
                        color: #333;
                    }

                    /* Responsive */
                    @media (max-width: 768px) {
                        .hero h1 {
                            font-size: 36px;
                        }

                        .restaurant-grid {
                            grid-template-columns: 1fr;
                        }

                        .nav-links {
                            gap: 15px;
                        }

                        .navbar-container {
                            flex-direction: column;
                            gap: 20px;
                        }
                    }

                    /* Chatbot Styles */
                    .chat-widget {
                        position: fixed;
                        bottom: 30px;
                        right: 30px;
                        z-index: 2000;
                        font-family: inherit;
                    }

                    .chat-button {
                        width: 60px;
                        height: 60px;
                        background: linear-gradient(135deg, #FF6B00 0%, #FF8533 100%);
                        border-radius: 50%;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        color: white;
                        font-size: 24px;
                        cursor: pointer;
                        box-shadow: 0 10px 25px rgba(255, 107, 0, 0.4);
                        transition: all 0.3s cubic-bezier(0.175, 0.885, 0.32, 1.275);
                    }

                    .chat-button:hover {
                        transform: scale(1.1) rotate(5deg);
                    }

                    .chat-window {
                        position: absolute;
                        bottom: 80px;
                        right: 0;
                        width: 350px;
                        height: 500px;
                        background: rgba(26, 26, 26, 0.98);
                        backdrop-filter: blur(15px);
                        border-radius: 20px;
                        border: 1px solid rgba(255, 107, 0, 0.2);
                        display: none;
                        flex-direction: column;
                        overflow: hidden;
                        box-shadow: 0 15px 50px rgba(0, 0, 0, 0.5);
                        animation: slideIn 0.3s ease-out;
                    }

                    @keyframes slideIn {
                        from {
                            opacity: 0;
                            transform: translateY(20px);
                        }

                        to {
                            opacity: 1;
                            transform: translateY(0);
                        }
                    }

                    .chat-header {
                        background: linear-gradient(135deg, #FF6B00 0%, #FF8533 100%);
                        padding: 20px;
                        color: white;
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                    }

                    .chat-header h4 {
                        margin: 0;
                        font-weight: 600;
                    }

                    .chat-messages {
                        flex: 1;
                        padding: 20px;
                        overflow-y: auto;
                        display: flex;
                        flex-direction: column;
                        gap: 15px;
                    }

                    .message {
                        max-width: 80%;
                        padding: 12px 16px;
                        border-radius: 15px;
                        font-size: 14px;
                        line-height: 1.5;
                    }

                    .bot-message {
                        align-self: flex-start;
                        background: rgba(42, 42, 42, 0.8);
                        color: #EEE;
                        border-bottom-left-radius: 2px;
                    }

                    .user-message {
                        align-self: flex-end;
                        background: #FF6B00;
                        color: white;
                        border-bottom-right-radius: 2px;
                    }

                    .chat-input-area {
                        padding: 15px;
                        background: rgba(42, 42, 42, 0.4);
                        border-top: 1px solid rgba(255, 255, 255, 0.05);
                        display: flex;
                        gap: 10px;
                    }

                    .chat-input-area input {
                        flex: 1;
                        background: rgba(20, 20, 20, 0.8);
                        border: 1px solid rgba(255, 107, 0, 0.2);
                        border-radius: 10px;
                        padding: 10px 15px;
                        color: white;
                        outline: none;
                    }

                    .chat-input-area button {
                        background: #FF6B00;
                        border: none;
                        width: 40px;
                        height: 40px;
                        border-radius: 10px;
                        color: white;
                        cursor: pointer;
                        transition: 0.3s;
                    }

                    .chat-input-area button:hover {
                        background: #FF8533;
                    }
                </style>
            </head>

            <body>
                <!-- Navbar -->
                <nav class="navbar">
                    <div class="navbar-container">
                        <a href="home.jsp" class="logo">
                            <div class="logo-icon">
                                <i class="fas fa-utensils"></i>
                            </div>
                            <span class="logo-text">FoodExpress</span>
                        </a>
                        <div class="nav-links">
                            <a href="home.jsp" class="nav-link">Home</a>
                            <a href="orders" class="nav-link">My Orders</a>
                            <a href="cart.jsp" class="nav-link">
                                <i class="fas fa-shopping-cart"></i> Cart
                            </a>
                            <form action="LogoutServlet" method="POST" style="margin: 0;">
                                <button type="submit" class="btn-logout">
                                    <i class="fas fa-sign-out-alt"></i> Logout
                                </button>
                            </form>
                        </div>
                    </div>
                </nav>

                <!-- Hero Section -->
                <section class="hero">
                    <h1>Order Your Favorite Food</h1>
                    <p>Delicious meals delivered to your doorstep in minutes</p>
                    <div class="search-bar">
                        <input type="text" placeholder="Search for restaurants or cuisines..." id="searchInput">
                        <button><i class="fas fa-search"></i></button>
                    </div>
                </section>

                <!-- Main Content -->
                <div class="container">
                    <div class="section-header">
                        <h2>Popular Restaurants</h2>
                        <p>Discover the best restaurants near you</p>
                    </div>

                    <div class="restaurant-grid">
                        <% List<Resturant> restaurants = (List<Resturant>) request.getAttribute("resturants");
                                if (restaurants != null && !restaurants.isEmpty()) {
                                for (Resturant restaurant : restaurants) {
                                %>
                                <div class="restaurant-card"
                                    onclick="window.location.href='menu.jsp?restaurantId=<%= restaurant.getRestaurantId() %>'">
                                    <% String imageUrl=restaurant.getImageUrl(); if (imageUrl==null ||
                                        imageUrl.isEmpty()) { imageUrl="images/restaurant-default.jpg" ; } %>
                                        <img src="<%= imageUrl %>" alt="<%= restaurant.getRestaurantName() %>"
                                            class="restaurant-image">
                                        <div class="restaurant-info">
                                            <h3 class="restaurant-name">
                                                <%= restaurant.getRestaurantName() %>
                                            </h3>
                                            <div class="restaurant-cuisine">
                                                <%= restaurant.getCuisineType() %>
                                            </div>
                                            <div class="restaurant-meta">
                                                <div class="meta-item rating">
                                                    <i class="fas fa-star"></i>
                                                    <span>
                                                        <%= restaurant.getRating() %>
                                                    </span>
                                                </div>
                                                <div class="meta-item">
                                                    <i class="fas fa-clock"></i>
                                                    <span>
                                                        <%= restaurant.getDeliveryTime() %> mins
                                                    </span>
                                                </div>
                                            </div>
                                            <button class="btn-view-menu">
                                                <i class="fas fa-utensils"></i> View Menu
                                            </button>
                                        </div>
                                </div>
                                <% } } else { %>
                                    <div class="no-restaurants">
                                        <i class="fas fa-store-slash"></i>
                                        <h3>No restaurants available</h3>
                                        <p>Please check back later</p>
                                    </div>
                                    <% } %>
                    </div>
                </div>

                <!-- Chatbot Widget -->
                <div class="chat-widget">
                    <div class="chat-button" onclick="toggleChat()">
                        <i class="fas fa-comment-dots"></i>
                    </div>
                    <div class="chat-window" id="chatWindow">
                        <div class="chat-header">
                            <h4><i class="fas fa-robot"></i> FoodExpress Support</h4>
                            <i class="fas fa-times" style="cursor: pointer;" onclick="toggleChat()"></i>
                        </div>
                        <div class="chat-messages" id="chatMessages">
                            <div class="message bot-message">
                                Hi! 👋 I'm your food delivery assistant. How can I help you today?
                            </div>
                        </div>
                        <div class="chat-input-area">
                            <input type="text" id="chatInput" placeholder="Type your message..."
                                onkeypress="if(event.key === 'Enter') sendMessage()">
                            <button onclick="sendMessage()"><i class="fas fa-paper-plane"></i></button>
                        </div>
                    </div>
                </div>

                <script>
                    function toggleChat() {
                        const win = document.getElementById('chatWindow');
                        win.style.display = win.style.display === 'flex' ? 'none' : 'flex';
                    }

                    async function sendMessage() {
                        const input = document.getElementById('chatInput');
                        const msg = input.value.trim();
                        if (!msg) return;

                        addMessage(msg, 'user');
                        input.value = '';

                        try {
                            const response = await fetch('chat', {
                                method: 'POST',
                                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                                body: 'message=' + encodeURIComponent(msg)
                            });
                            const botMsg = await response.text();
                            addMessage(botMsg, 'bot');
                        } catch (err) {
                            addMessage('Sorry, I am having trouble connecting right now.', 'bot');
                        }
                    }

                    function addMessage(text, sender) {
                        const container = document.getElementById('chatMessages');
                        const div = document.createElement('div');
                        div.className = 'message ' + (sender === 'user' ? 'user-message' : 'bot-message');
                        div.innerHTML = text.replace(/\*\*(.*?)\*\*/g, '<strong>$1</strong>'); // Simple bold support
                        container.appendChild(div);
                        container.scrollTop = container.scrollHeight;
                    }

                    // Search functionality
                    document.getElementById('searchInput').addEventListener('input', function (e) {
                        const searchTerm = e.target.value.toLowerCase();
                        const cards = document.querySelectorAll('.restaurant-card');

                        cards.forEach(card => {
                            const name = card.querySelector('.restaurant-name').textContent.toLowerCase();
                            const cuisine = card.querySelector('.restaurant-cuisine').textContent.toLowerCase();

                            if (name.includes(searchTerm) || cuisine.includes(searchTerm)) {
                                card.style.display = 'block';
                            } else {
                                card.style.display = 'none';
                            }
                        });
                    });
                </script>
            </body>

            </html>