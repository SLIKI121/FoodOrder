<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login - FoodExpress</title>
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
                position: relative;
                overflow: hidden;
            }

            /* Animated background elements */
            body::before {
                content: '';
                position: absolute;
                width: 500px;
                height: 500px;
                background: radial-gradient(circle, rgba(255, 107, 0, 0.1) 0%, transparent 70%);
                border-radius: 50%;
                top: -250px;
                right: -250px;
                animation: float 20s ease-in-out infinite;
            }

            body::after {
                content: '';
                position: absolute;
                width: 400px;
                height: 400px;
                background: radial-gradient(circle, rgba(255, 107, 0, 0.08) 0%, transparent 70%);
                border-radius: 50%;
                bottom: -200px;
                left: -200px;
                animation: float 15s ease-in-out infinite reverse;
            }

            @keyframes float {

                0%,
                100% {
                    transform: translate(0, 0) scale(1);
                }

                50% {
                    transform: translate(50px, 50px) scale(1.1);
                }
            }

            .login-container {
                background: rgba(26, 26, 26, 0.95);
                backdrop-filter: blur(10px);
                border-radius: 24px;
                padding: 50px 40px;
                width: 100%;
                max-width: 450px;
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
                width: 80px;
                height: 80px;
                background: linear-gradient(135deg, #FF6B00 0%, #FFB84D 100%);
                border-radius: 20px;
                display: inline-flex;
                align-items: center;
                justify-content: center;
                margin-bottom: 20px;
                box-shadow: 0 10px 30px rgba(255, 107, 0, 0.3);
                animation: pulse 2s ease-in-out infinite;
            }

            @keyframes pulse {

                0%,
                100% {
                    transform: scale(1);
                }

                50% {
                    transform: scale(1.05);
                }
            }

            .logo-icon i {
                font-size: 40px;
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

            .form-group {
                margin-bottom: 25px;
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
                padding: 16px 18px 16px 50px;
                background: rgba(42, 42, 42, 0.8);
                border: 2px solid rgba(255, 107, 0, 0.2);
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

            .form-control::placeholder {
                color: #666;
            }

            .remember-forgot {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 30px;
            }

            .remember-me {
                display: flex;
                align-items: center;
                gap: 8px;
                color: #999;
                font-size: 14px;
                cursor: pointer;
            }

            .remember-me input[type="checkbox"] {
                width: 18px;
                height: 18px;
                cursor: pointer;
                accent-color: #FF6B00;
            }

            .forgot-password {
                color: #FF6B00;
                text-decoration: none;
                font-size: 14px;
                font-weight: 500;
                transition: color 0.3s;
            }

            .forgot-password:hover {
                color: #FFB84D;
            }

            .btn-login {
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
            }

            .btn-login:hover {
                transform: translateY(-2px);
                box-shadow: 0 12px 28px rgba(255, 107, 0, 0.4);
            }

            .btn-login:active {
                transform: translateY(0);
            }

            .divider {
                text-align: center;
                margin: 30px 0;
                position: relative;
            }

            .divider::before {
                content: '';
                position: absolute;
                left: 0;
                top: 50%;
                width: 100%;
                height: 1px;
                background: rgba(255, 255, 255, 0.1);
            }

            .divider span {
                background: rgba(26, 26, 26, 0.95);
                padding: 0 15px;
                color: #666;
                font-size: 14px;
                position: relative;
                z-index: 1;
            }

            .signup-link {
                text-align: center;
                margin-top: 25px;
            }

            .signup-link p {
                color: #999;
                font-size: 14px;
            }

            .signup-link a {
                color: #FF6B00;
                text-decoration: none;
                font-weight: 600;
                transition: color 0.3s;
            }

            .signup-link a:hover {
                color: #FFB84D;
            }

            .error-message {
                background: rgba(220, 53, 69, 0.1);
                border: 1px solid rgba(220, 53, 69, 0.3);
                color: #ff6b6b;
                padding: 12px 16px;
                border-radius: 10px;
                margin-bottom: 20px;
                font-size: 14px;
                display: flex;
                align-items: center;
                gap: 10px;
                animation: shake 0.5s;
            }

            @keyframes shake {

                0%,
                100% {
                    transform: translateX(0);
                }

                25% {
                    transform: translateX(-10px);
                }

                75% {
                    transform: translateX(10px);
                }
            }

            .error-message i {
                font-size: 18px;
            }

            /* Responsive */
            @media (max-width: 480px) {
                .login-container {
                    padding: 40px 30px;
                    margin: 20px;
                }

                .logo-section h1 {
                    font-size: 28px;
                }
            }
        </style>
    </head>

    <body>
        <div class="login-container">
            <div class="logo-section">
                <div class="logo-icon">
                    <i class="fas fa-utensils"></i>
                </div>
                <h1>FoodExpress</h1>
                <p>Welcome back! Please login to your account</p>
            </div>

            <% String error=request.getParameter("error"); if (error !=null) { String
                message="An error occurred. Please try again." ; if (error.equals("notfound"))
                message="User not found. Please sign up." ; else if (error.equals("invalid"))
                message="Invalid password. Please try again." ; else if (error.equals("required"))
                message="All fields are required." ; %>
                <div class="error-message">
                    <i class="fas fa-exclamation-circle"></i>
                    <span>
                        <%= message %>
                    </span>
                </div>
                <% } %>

                    <% String success=request.getParameter("success"); if (success !=null && success.equals("signup")) {
                        %>
                        <div class="error-message"
                            style="background: rgba(40, 167, 69, 0.1); border-color: rgba(40, 167, 69, 0.3); color: #28a745;">
                            <i class="fas fa-check-circle"></i>
                            <span>Registration successful! Please login.</span>
                        </div>
                        <% } %>

                            <form action="LoginServlet" method="POST">
                                <div class="form-group">
                                    <label for="email">Email Address</label>
                                    <div class="input-wrapper">
                                        <input type="email" id="email" name="username" class="form-control"
                                            placeholder="Enter your email" required autocomplete="email">
                                        <i class="fas fa-envelope"></i>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="password">Password</label>
                                    <div class="input-wrapper">
                                        <input type="password" id="password" name="password" class="form-control"
                                            placeholder="Enter your password" required autocomplete="current-password">
                                        <i class="fas fa-lock"></i>
                                    </div>
                                </div>

                                <div class="remember-forgot">
                                    <label class="remember-me">
                                        <input type="checkbox" name="remember">
                                        <span>Remember me</span>
                                    </label>
                                    <a href="#" class="forgot-password">Forgot Password?</a>
                                </div>

                                <button type="submit" class="btn-login">
                                    <i class="fas fa-sign-in-alt"></i> Sign In
                                </button>
                            </form>

                            <div class="divider">
                                <span>OR</span>
                            </div>

                            <div class="signup-link">
                                <p>Don't have an account? <a href="signup.jsp">Create Account</a></p>
                            </div>
        </div>
    </body>

    </html>