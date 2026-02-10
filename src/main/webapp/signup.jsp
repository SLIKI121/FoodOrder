<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Sign Up - FoodExpress</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: linear-gradient(135deg, #0F0F0F 0%, #1A1A1A 100%);
                min-height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 40px 20px;
                position: relative;
                overflow-x: hidden;
            }

            /* Animated background elements */
            body::before {
                content: '';
                position: absolute;
                width: 600px;
                height: 600px;
                background: radial-gradient(circle, rgba(255, 107, 0, 0.08) 0%, transparent 70%);
                border-radius: 50%;
                top: -300px;
                left: -300px;
                animation: float 25s ease-in-out infinite;
            }

            @keyframes float {

                0%,
                100% {
                    transform: translate(0, 0) scale(1);
                }

                50% {
                    transform: translate(60px, 40px) scale(1.1);
                }
            }

            .signup-container {
                background: rgba(26, 26, 26, 0.95);
                backdrop-filter: blur(10px);
                border-radius: 24px;
                padding: 50px 40px;
                width: 100%;
                max-width: 600px;
                box-shadow: 0 20px 60px rgba(0, 0, 0, 0.5),
                    0 0 0 1px rgba(255, 107, 0, 0.1);
                position: relative;
                z-index: 1;
                animation: slideUp 0.6s ease-out;
            }

            @keyframes slideUp {
                from {
                    opacity: 0;
                    transform: translateY(30px);
                }

                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .logo-section {
                text-align: center;
                margin-bottom: 40px;
            }

            .logo-icon {
                width: 70px;
                height: 70px;
                background: linear-gradient(135deg, #FF6B00 0%, #FFB84D 100%);
                border-radius: 18px;
                display: inline-flex;
                align-items: center;
                justify-content: center;
                margin-bottom: 20px;
                box-shadow: 0 10px 30px rgba(255, 107, 0, 0.3);
            }

            .logo-icon i {
                font-size: 32px;
                color: #FFFFFF;
            }

            .logo-section h1 {
                color: #FFFFFF;
                font-size: 32px;
                font-weight: 700;
                margin-bottom: 8px;
                letter-spacing: -0.5px;
            }

            .logo-section p {
                color: #999;
                font-size: 15px;
            }

            .form-row {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 20px;
                margin-bottom: 20px;
            }

            .form-group {
                margin-bottom: 25px;
            }

            .form-group.full {
                grid-column: 1 / -1;
            }

            .form-group label {
                display: block;
                color: #FFFFFF;
                font-size: 14px;
                font-weight: 500;
                margin-bottom: 10px;
                letter-spacing: 0.3px;
            }

            .input-wrapper {
                position: relative;
            }

            .input-wrapper i {
                position: absolute;
                left: 18px;
                top: 50%;
                transform: translateY(-50%);
                color: #666;
                font-size: 16px;
                transition: color 0.3s;
            }

            .form-control {
                width: 100%;
                padding: 14px 18px 14px 50px;
                background: rgba(42, 42, 42, 0.8);
                border: 2px solid rgba(255, 107, 0, 0.15);
                border-radius: 12px;
                color: #FFFFFF;
                font-size: 15px;
                transition: all 0.3s;
                outline: none;
            }

            .form-control:focus {
                border-color: #FF6B00;
                background: rgba(42, 42, 42, 1);
                box-shadow: 0 0 0 4px rgba(255, 107, 0, 0.1);
            }

            .form-control:focus+i {
                color: #FF6B00;
            }

            .btn-signup {
                width: 100%;
                padding: 16px;
                background: linear-gradient(135deg, #FF6B00 0%, #FF8533 100%);
                border: none;
                border-radius: 12px;
                color: #FFFFFF;
                font-size: 16px;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s;
                box-shadow: 0 8px 20px rgba(255, 107, 0, 0.3);
                letter-spacing: 0.5px;
                margin-top: 10px;
            }

            .btn-signup:hover {
                transform: translateY(-2px);
                box-shadow: 0 12px 28px rgba(255, 107, 0, 0.4);
            }

            .login-link {
                text-align: center;
                margin-top: 30px;
                padding-top: 20px;
                border-top: 1px solid rgba(255, 255, 255, 0.05);
            }

            .login-link p {
                color: #999;
                font-size: 14px;
            }

            .login-link a {
                color: #FF6B00;
                text-decoration: none;
                font-weight: 600;
                transition: color 0.3s;
            }

            .login-link a:hover {
                color: #FFB84D;
            }

            .alert {
                background: rgba(220, 53, 69, 0.1);
                border: 1px solid rgba(220, 53, 69, 0.3);
                color: #ff6b6b;
                padding: 12px 16px;
                border-radius: 10px;
                margin-bottom: 25px;
                font-size: 14px;
                display: flex;
                align-items: center;
                gap: 10px;
            }

            @media (max-width: 600px) {
                .form-row {
                    grid-template-columns: 1fr;
                }

                .signup-container {
                    padding: 40px 25px;
                }
            }
        </style>
    </head>

    <body>
        <div class="signup-container">
            <div class="logo-section">
                <div class="logo-icon">
                    <i class="fas fa-user-plus"></i>
                </div>
                <h1>Create Account</h1>
                <p>Join FoodExpress for a delicious journey</p>
            </div>

            <% String error=request.getParameter("error"); if (error !=null && !error.isEmpty()) { %>
                <div class="alert">
                    <i class="fas fa-exclamation-circle"></i>
                    <span>
                        <% if ("email_exists".equals(error)) { %>Email already registered!
                            <% } else if ("password_mismatch".equals(error)) { %>Passwords do not match!
                                <% } else { %>Registration failed. Please try again.<% } %>
                    </span>
                </div>
                <% } %>

                    <form method="POST" action="SignupServlet">
                        <div class="form-row">
                            <div class="form-group">
                                <label for="name">Full Name</label>
                                <div class="input-wrapper">
                                    <input type="text" id="name" name="name" class="form-control" placeholder="John Doe"
                                        required>
                                    <i class="fas fa-user"></i>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="phone">Phone Number</label>
                                <div class="input-wrapper">
                                    <input type="tel" id="phone" name="phone" class="form-control"
                                        placeholder="10-digit number" required>
                                    <i class="fas fa-phone"></i>
                                </div>
                            </div>
                        </div>

                        <div class="form-group full">
                            <label for="email">Email Address</label>
                            <div class="input-wrapper">
                                <input type="email" id="email" name="email" class="form-control"
                                    placeholder="john@example.com" required>
                                <i class="fas fa-envelope"></i>
                            </div>
                        </div>

                        <div class="form-group full">
                            <label for="address">Delivery Address</label>
                            <div class="input-wrapper">
                                <input type="text" id="address" name="address" class="form-control"
                                    placeholder="Apt, Street, City" required>
                                <i class="fas fa-map-marker-alt"></i>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="password">Password</label>
                                <div class="input-wrapper">
                                    <input type="password" id="password" name="password" class="form-control"
                                        placeholder="••••••••" required>
                                    <i class="fas fa-lock"></i>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="confirmPassword">Confirm Password</label>
                                <div class="input-wrapper">
                                    <input type="password" id="confirmPassword" name="confirmPassword"
                                        class="form-control" placeholder="••••••••" required>
                                    <i class="fas fa-shield-alt"></i>
                                </div>
                            </div>
                        </div>

                        <button type="submit" class="btn-signup">
                            <i class="fas fa-check-circle"></i> Create Account
                        </button>
                    </form>

                    <div class="login-link">
                        <p>Already have an account? <a href="login.jsp">Sign In</a></p>
                    </div>
        </div>
    </body>

    </html>