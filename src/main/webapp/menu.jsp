<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="java.util.List" %>
        <%@ page import="java.util.Map" %>
            <%@ page import="com.tap.model.Menu" %>
                <%@ page import="com.tap.model.Cartitem" %>
                    <%@ page import="com.tap.model.Cart" %>
                        <%@ page import="com.tap.dapimplementation.MenuDaoImpl" %>
                            <% /* Authentication Check */ Object userObj=session.getAttribute("user"); if
                                (userObj==null) { response.sendRedirect("login.jsp"); return; } /* Cart for count only
                                */ Cart cart=(Cart) session.getAttribute("cart"); int cartCount=(cart !=null &&
                                cart.getItems() !=null) ? cart.getItems().size() : 0; /* Restaurant ID Handling */ int
                                restaurantId=1; String resIdParam=request.getParameter("restaurantId"); if (resIdParam
                                !=null && !resIdParam.isEmpty()) { try { restaurantId=Integer.parseInt(resIdParam);
                                session.setAttribute("restaurantId", Integer.valueOf(restaurantId)); } catch (Exception
                                nfe) { /* Keep default */ } } else { Object
                                sessionRestId=session.getAttribute("restaurantId"); if (sessionRestId !=null) {
                                restaurantId=((Integer) sessionRestId).intValue(); } } %>
                                <!DOCTYPE html>
                                <html lang="en">

                                <head>
                                    <meta charset="UTF-8">
                                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                                    <title>Menu - FoodExpress</title>
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
                                            position: relative;
                                        }

                                        .cart-badge {
                                            position: absolute;
                                            top: 0;
                                            right: 0;
                                            transform: translate(50%, -50%);
                                            font-size: 10px;
                                            padding: 3px 6px;
                                        }

                                        .main-container {
                                            padding: 30px;
                                            max-width: 1200px;
                                            margin: 0 auto;
                                        }

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
                                            transition: 0.3s;
                                            height: 100%;
                                            display: flex;
                                            flex-direction: column;
                                        }

                                        .menu-card:hover {
                                            transform: translateY(-5px);
                                            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
                                        }

                                        .menu-card-image {
                                            width: 100%;
                                            height: 180px;
                                            object-fit: cover;
                                        }

                                        .menu-card-content {
                                            padding: 20px;
                                            flex-grow: 1;
                                            display: flex;
                                            flex-direction: column;
                                        }

                                        .menu-card-title {
                                            font-weight: 700;
                                            font-size: 18px;
                                            margin-bottom: 8px;
                                        }

                                        .menu-card-description {
                                            font-size: 13px;
                                            color: #666;
                                            margin-bottom: 15px;
                                            flex-grow: 1;
                                        }

                                        .menu-card-footer {
                                            display: flex;
                                            justify-content: space-between;
                                            align-items: center;
                                        }

                                        .menu-price {
                                            font-weight: 800;
                                            font-size: 20px;
                                            color: #FF6B00;
                                        }

                                        .btn-add {
                                            background: #FF6B00;
                                            color: white;
                                            border: none;
                                            padding: 10px 15px;
                                            border-radius: 8px;
                                            font-weight: 600;
                                            cursor: pointer;
                                            transition: 0.3s;
                                        }

                                        .btn-add:hover {
                                            background: #E65A00;
                                        }

                                        .toast-container {
                                            position: fixed;
                                            bottom: 20px;
                                            right: 20px;
                                            z-index: 1050;
                                        }
                                    </style>
                                </head>

                                <body>
                                    <nav class="navbar navbar-expand-lg navbar-dark navbar-custom sticky-top">
                                        <div class="container">
                                            <a class="navbar-brand" href="home.jsp"><i
                                                    class="fas fa-utensils me-2"></i>FoodExpress</a>
                                            <div class="ms-auto d-flex align-items-center">
                                                <a href="home.jsp" class="nav-link me-3"><i
                                                        class="fas fa-home me-1"></i>Home</a>
                                                <a href="orders" class="nav-link me-3"><i
                                                        class="fas fa-shopping-bag me-1"></i>My Orders</a>
                                                <a href="cart.jsp" class="nav-link me-3">
                                                    <i class="fas fa-shopping-cart"></i>
                                                    <% if (cartCount> 0) { %>
                                                        <span class="badge bg-danger rounded-pill cart-badge">
                                                            <%= cartCount %>
                                                        </span>
                                                        <% } %>
                                                            Cart
                                                </a>
                                                <a href="LogoutServlet" class="nav-link"><i
                                                        class="fas fa-sign-out-alt me-1"></i>Logout</a>
                                            </div>
                                        </div>
                                    </nav>

                                    <div class="main-container">
                                        <div class="mb-4 d-flex justify-content-between align-items-center">
                                            <div>
                                                <h2 class="fw-bold">Menu</h2>
                                                <p class="text-muted">Discover delicious dishes from this restaurant</p>
                                            </div>
                                            <a href="cart.jsp" class="btn btn-outline-primary rounded-pill px-4">
                                                <i class="fas fa-shopping-basket me-2"></i>View Cart
                                            </a>
                                        </div>

                                        <div class="menu-section">
                                            <% try { MenuDaoImpl menuDao=new MenuDaoImpl(); List<Menu> menuItems =
                                                menuDao.getMenuByRestaurant(restaurantId);
                                                if (menuItems != null && !menuItems.isEmpty()) {
                                                for (Menu menu : menuItems) {
                                                String img = menu.getImageUrl();
                                                if (img == null || img.isEmpty()) { img = "images/menu/default.jpg"; }
                                                %>
                                                <div class="menu-card">
                                                    <img src="<%= img %>" class="menu-card-image"
                                                        alt="<%= menu.getItemName() %>">
                                                    <div class="menu-card-content">
                                                        <div class="menu-card-title">
                                                            <%= menu.getItemName() %>
                                                        </div>
                                                        <div class="menu-card-description">
                                                            <%= menu.getDescription() %>
                                                        </div>
                                                        <div class="menu-card-footer">
                                                            <div class="menu-price">&#8377; <%= menu.getPrice() %>
                                                            </div>
                                                            <form method="POST" action="CartServlet"
                                                                class="d-flex align-items-center gap-2">
                                                                <input type="hidden" name="menuId"
                                                                    value="<%= menu.getMenuId() %>">
                                                                <input type="hidden" name="action" value="add">
                                                                <input type="hidden" name="from" value="menu">
                                                                <input type="number" name="quantity" value="1" min="1"
                                                                    max="10" class="form-control form-control-sm"
                                                                    style="width: 50px;">
                                                                <button type="submit" class="btn-add"><i
                                                                        class="fas fa-plus"></i></button>
                                                            </form>
                                                        </div>
                                                    </div>
                                                </div>
                                                <% } } else { %>
                                                    <div class="text-center py-5 w-100" style="grid-column: 1/-1;">
                                                        <i class="fas fa-utensils fa-3x text-muted mb-3"></i>
                                                        <h4>No items available for this restaurant.</h4>
                                                        <a href="home.jsp"
                                                            class="btn btn-primary mt-3 px-4 rounded-pill">Back to
                                                            Restaurants</a>
                                                    </div>
                                                    <% } } catch (Exception ex) { %>
                                                        <div class="alert alert-danger w-100"
                                                            style="grid-column: 1/-1;">
                                                            Error loading menu. Please try again later.
                                                        </div>
                                                        <% } %>
                                        </div>
                                    </div>

                                    <% if (request.getParameter("added") !=null) { %>
                                        <div class="toast-container">
                                            <div class="toast show align-items-center text-white bg-success border-0"
                                                role="alert">
                                                <div class="d-flex">
                                                    <div class="toast-body">
                                                        Item added to cart successfully!
                                                    </div>
                                                    <button type="button" class="btn-close btn-close-white me-2 m-auto"
                                                        data-bs-dismiss="toast"></button>
                                                </div>
                                            </div>
                                        </div>
                                        <script>
                                            setTimeout(() => {
                                                document.querySelector('.toast').classList.remove('show');
                                            }, 3000);
                                        </script>
                                        <% } %>
                                </body>

                                </html>