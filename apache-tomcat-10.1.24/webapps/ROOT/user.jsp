<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login | User Management</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }
        
        .container {
            display: flex;
            max-width: 1000px;
            width: 100%;
            background: white;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
        }
        
        .left-section {
            flex: 1;
            background: linear-gradient(135deg, #6a11cb 0%, #2575fc 100%);
            color: white;
            padding: 60px 40px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }
        
        .right-section {
            flex: 1;
            padding: 60px 40px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }
        
        .welcome-text {
            margin-bottom: 40px;
        }
        
        .welcome-text h1 {
            font-size: 32px;
            margin-bottom: 10px;
            font-weight: 700;
        }
        
        .welcome-text p {
            font-size: 16px;
            opacity: 0.9;
        }
        
        .features {
            margin-top: 30px;
        }
        
        .feature {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }
        
        .feature-icon {
            width: 40px;
            height: 40px;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
        }
        
        .feature-text h4 {
            font-size: 16px;
            margin-bottom: 5px;
        }
        
        .feature-text p {
            font-size: 14px;
            opacity: 0.8;
        }
        
        .logo {
            text-align: center;
            margin-bottom: 40px;
        }
        
        .logo h2 {
            font-size: 28px;
            color: #333;
            font-weight: 700;
        }
        
        .logo p {
            color: #666;
            margin-top: 5px;
        }
        
        .login-form {
            width: 100%;
        }
        
        .form-group {
            margin-bottom: 25px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-weight: 500;
        }
        
        .input-with-icon {
            position: relative;
        }
        
        .input-icon {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #666;
        }
        
        .form-control {
            width: 100%;
            padding: 15px 15px 15px 45px;
            border: 2px solid #e1e5ee;
            border-radius: 10px;
            font-size: 16px;
            transition: all 0.3s;
        }
        
        .form-control:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }
        
        .password-toggle {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            background: none;
            border: none;
            color: #666;
            cursor: pointer;
        }
        
        .remember-forgot {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }
        
        .remember-me {
            display: flex;
            align-items: center;
        }
        
        .remember-me input {
            margin-right: 8px;
        }
        
        .forgot-password {
            color: #667eea;
            text-decoration: none;
            font-weight: 500;
        }
        
        .forgot-password:hover {
            text-decoration: underline;
        }
        
        .login-btn {
            width: 100%;
            padding: 15px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: transform 0.3s, box-shadow 0.3s;
            margin-bottom: 25px;
        }
        
        .login-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 7px 15px rgba(102, 126, 234, 0.4);
        }
        
        .login-btn:active {
            transform: translateY(0);
        }
        
        .divider {
            text-align: center;
            position: relative;
            margin: 25px 0;
            color: #666;
        }
        
        .divider::before {
            content: '';
            position: absolute;
            left: 0;
            top: 50%;
            width: 45%;
            height: 1px;
            background: #e1e5ee;
        }
        
        .divider::after {
            content: '';
            position: absolute;
            right: 0;
            top: 50%;
            width: 45%;
            height: 1px;
            background: #e1e5ee;
        }
        
        .social-login {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-bottom: 25px;
        }
        
        .social-btn {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            border: 2px solid #e1e5ee;
            background: white;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.3s;
        }
        
        .social-btn:hover {
            border-color: #667eea;
            transform: translateY(-2px);
        }
        
        .social-btn i {
            font-size: 20px;
        }
        
        .signup-link {
            text-align: center;
            color: #666;
        }
        
        .signup-link a {
            color: #667eea;
            text-decoration: none;
            font-weight: 600;
            margin-left: 5px;
        }
        
        .signup-link a:hover {
            text-decoration: underline;
        }
        
        .error-message {
            background: #fee;
            color: #c33;
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 20px;
            border-left: 4px solid #c33;
            display: none;
        }
        
        .error-message.show {
            display: block;
        }
        
        .success-message {
            background: #efe;
            color: #393;
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 20px;
            border-left: 4px solid #393;
            display: none;
        }
        
        .success-message.show {
            display: block;
        }
        
        @media (max-width: 768px) {
            .container {
                flex-direction: column;
            }
            
            .left-section {
                padding: 40px 20px;
            }
            
            .right-section {
                padding: 40px 20px;
            }
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <div class="container">
        <!-- Left Section with Welcome Message -->
        <div class="left-section">
            <div class="welcome-text">
                <h1>Welcome Back</h1>
                <p>Login to continue to your account and access all features</p>
            </div>
            
            <div class="features">
                <div class="feature">
                    <div class="feature-icon">
                        <i class="fas fa-shield-alt"></i>
                    </div>
                    <div class="feature-text">
                        <h4>Secure Login</h4>
                        <p>Your data is protected with 256-bit encryption</p>
                    </div>
                </div>
                
                <div class="feature">
                    <div class="feature-icon">
                        <i class="fas fa-bolt"></i>
                    </div>
                    <div class="feature-text">
                        <h4>Fast Access</h4>
                        <p>Quick access to all your tools and data</p>
                    </div>
                </div>
                
                <div class="feature">
                    <div class="feature-icon">
                        <i class="fas fa-users"></i>
                    </div>
                    <div class="feature-text">
                        <h4>Multi-User</h4>
                        <p>Manage multiple accounts with ease</p>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Right Section with Login Form -->
        <div class="right-section">
            <div class="logo">
                <h2>User Management</h2>
                <p>Professional User Management System</p>
            </div>
            
            <!-- Error/Success Messages -->
            <div class="error-message" id="errorMessage">
                <i class="fas fa-exclamation-circle"></i> 
                <span id="errorText"></span>
            </div>
            
            <div class="success-message" id="successMessage">
                <i class="fas fa-check-circle"></i> 
                <span id="successText"></span>
            </div>
            
            <form class="login-form" action="LoginController" method="POST" id="loginForm">
                <div class="form-group">
                    <label for="username">Enter Username</label>
                    <div class="input-with-icon">
                        <i class="fas fa-user input-icon"></i>
                        <input type="text" 
                               id="username" 
                               name="username" 
                               class="form-control" 
                               placeholder="Enter your username or email" 
                               required>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="password">Enter Password</label>
                    <div class="input-with-icon">
                        <i class="fas fa-lock input-icon"></i>
                        <input type="password" 
                               id="password" 
                               name="password" 
                               class="form-control" 
                               placeholder="Enter your password" 
                               required>
                        <button type="button" class="password-toggle" id="togglePassword">
                            <i class="fas fa-eye"></i>
                        </button>
                    </div>
                </div>
                
                <div class="remember-forgot">
                    <div class="remember-me">
                        <input type="checkbox" id="remember" name="remember">
                        <label for="remember">Remember me</label>
                    </div>
                    <a href="ForgotPassword.jsp" class="forgot-password">Forgot Password?</a>
                </div>
                
                <button type="submit" class="login-btn">
                    <i class="fas fa-sign-in-alt"></i> Login
                </button>
                
                <div class="divider">
                    <span>Or continue with</span>
                </div>
                
                <div class="social-login">
                    <div class="social-btn" title="Login with Google">
                        <i class="fab fa-google" style="color: #DB4437;"></i>
                    </div>
                    <div class="social-btn" title="Login with Facebook">
                        <i class="fab fa-facebook-f" style="color: #4267B2;"></i>
                    </div>
                    <div class="social-btn" title="Login with GitHub">
                        <i class="fab fa-github" style="color: #333;"></i>
                    </div>
                </div>
                
                <div class="signup-link">
                    New user? 
                    <a href="Register.jsp">Create Account</a>
                </div>
            </form>
        </div>
    </div>
    
    <script>
        // Toggle password visibility
        document.getElementById('togglePassword').addEventListener('click', function() {
            const passwordInput = document.getElementById('password');
            const icon = this.querySelector('i');
            
            if (passwordInput.type === 'password') {
                passwordInput.type = 'text';
                icon.classList.remove('fa-eye');
                icon.classList.add('fa-eye-slash');
            } else {
                passwordInput.type = 'password';
                icon.classList.remove('fa-eye-slash');
                icon.classList.add('fa-eye');
            }
        });
        
        // Form validation
        document.getElementById('loginForm').addEventListener('submit', function(e) {
            const username = document.getElementById('username').value.trim();
            const password = document.getElementById('password').value.trim();
            const errorMessage = document.getElementById('errorMessage');
            const errorText = document.getElementById('errorText');
            
            // Hide previous errors
            errorMessage.classList.remove('show');
            
            // Validate inputs
            if (!username) {
                errorText.textContent = 'Please enter your username or email';
                errorMessage.classList.add('show');
                e.preventDefault();
                return false;
            }
            
            if (!password) {
                errorText.textContent = 'Please enter your password';
                errorMessage.classList.add('show');
                e.preventDefault();
                return false;
            }
            
            // Check for session messages
            const urlParams = new URLSearchParams(window.location.search);
            const error = urlParams.get('error');
            const success = urlParams.get('success');
            const message = urlParams.get('message');
            
            if (error === 'invalid') {
                errorText.textContent = 'Invalid username or password. Please try again.';
                errorMessage.classList.add('show');
            } else if (error === 'session_expired') {
                errorText.textContent = 'Your session has expired. Please login again.';
                errorMessage.classList.add('show');
            } else if (success === 'registered') {
                document.getElementById('successText').textContent = message || 'Registration successful! Please login.';
                document.getElementById('successMessage').classList.add('show');
            } else if (success === 'logout') {
                document.getElementById('successText').textContent = 'You have been logged out successfully.';
                document.getElementById('successMessage').classList.add('show');
            }
            
            return true;
        });
        
        // Auto-focus username field
        window.onload = function() {
            document.getElementById('username').focus();
            
            // Check for remember me cookie
            const rememberedUsername = getCookie('remembered_username');
            if (rememberedUsername) {
                document.getElementById('username').value = rememberedUsername;
                document.getElementById('remember').checked = true;
            }
        };
        
        // Simple cookie helper function
        function getCookie(name) {
            const cookies = document.cookie.split(';');
            for (let cookie of cookies) {
                const [key, value] = cookie.trim().split('=');
                if (key === name) return decodeURIComponent(value);
            }
            return null;
        }
        
        // Social login buttons
        document.querySelectorAll('.social-btn').forEach(btn => {
            btn.addEventListener('click', function() {
                const platform = this.querySelector('i').classList[1];
                let platformName = '';
                
                if (platform.includes('google')) platformName = 'Google';
                else if (platform.includes('facebook')) platformName = 'Facebook';
                else if (platform.includes('github')) platformName = 'GitHub';
                
                alert(`This would normally redirect to ${platformName} login. Integration pending.`);
            });
        });
    </script>
    
    <!-- Check for error/success parameters on page load -->
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const urlParams = new URLSearchParams(window.location.search);
            const error = urlParams.get('error');
            const success = urlParams.get('success');
            const message = urlParams.get('message');
            
            if (error === 'invalid') {
                document.getElementById('errorText').textContent = 'Invalid username or password. Please try again.';
                document.getElementById('errorMessage').classList.add('show');
            } else if (error === 'session_expired') {
                document.getElementById('errorText').textContent = 'Your session has expired. Please login again.';
                document.getElementById('errorMessage').classList.add('show');
            } else if (success === 'registered') {
                document.getElementById('successText').textContent = message || 'Registration successful! Please login.';
                document.getElementById('successMessage').classList.add('show');
            } else if (success === 'logout') {
                document.getElementById('successText').textContent = 'You have been logged out successfully.';
                document.getElementById('successMessage').classList.add('show');
            }
        });
    </script>
</body>
</html>