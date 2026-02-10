<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FoodDelivery - Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
    <link rel="stylesheet" href="styles.css">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        .login-container {
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.2);
            width: 100%;
            max-width: 450px;
            padding: 50px;
            animation: slideUp 0.5s ease;
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
            margin-bottom: 30px;
        }
        
        .logo-section h1 {
            color: #667eea;
            font-weight: bold;
            font-size: 32px;
            margin-bottom: 10px;
        }
        
        .logo-section p {
            color: #666;
            font-size: 14px;
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
        
        .form-group input {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 14px;
            transition: all 0.3s;
        }
        
        .form-group input:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
            outline: none;
        }
        
        .form-group input.is-invalid {
            border-color: #dc3545;
        }
        
        .error-message {
            color: #dc3545;
            font-size: 13px;
            margin-top: 5px;
            display: none;
        }
        
        .form-check {
            margin-bottom: 20px;
        }
        
        .form-check input {
            cursor: pointer;
        }
        
        .form-check label {
            cursor: pointer;
            margin-bottom: 0;
        }
        
        .login-btn {
            width: 100%;
            padding: 12px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            font-size: 16px;
            cursor: pointer;
            transition: all 0.3s;
            margin-top: 10px;
        }
        
        .login-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 20px rgba(102, 126, 234, 0.4);
        }
        
        .login-btn:active {
            transform: translateY(0);
        }
        
        .signup-link {
            text-align: center;
            margin-top: 20px;
            color: #666;
        }
        
        .signup-link a {
            color: #667eea;
            font-weight: 600;
            text-decoration: none;
        }
        
        .signup-link a:hover {
            text-decoration: underline;
        }
        
        .alert {
            border-radius: 8px;
            border: none;
            margin-bottom: 20px;
        }
        
        .alert-danger {
            background: #ffe5e5;
            color: #c82333;
        }
        
        .alert-success {
            background: #e5f5e5;
            color: #2d7d32;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="logo-section">
            <h1><i class="fas fa-utensils"></i> FoodDelivery</h1>
            <p>Order delicious food online</p>
        </div>
        
        <!-- Error Message -->
        <% String error = request.getParameter("error");
           if (error != null && !error.isEmpty()) { %>
            <div class="alert alert-danger">
                <% if ("invalid".equals(error)) { %>
                    Invalid username/email or password
                <% } else if ("required".equals(error)) { %>
                    Please fill all required fields
                <% } else if ("notfound".equals(error)) { %>
                    User not found. Please sign up first
                <% } %>
            </div>
        <% } %>
        
        <% String success = request.getParameter("success");
           if (success != null && !success.isEmpty()) { %>
            <div class="alert alert-success">
                Account created successfully! Please login.
            </div>
        <% } %>
        
        <form id="loginForm" method="POST" action="LoginServlet">
            <div class="form-group">
                <label for="username">Email or Username</label>
                <input type="text" id="username" name="username" placeholder="Enter your email or username" required>
                <div class="error-message" id="usernameError">Please enter a valid email or username</div>
            </div>
            
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" placeholder="Enter your password" required>
                <div class="error-message" id="passwordError">Password must be at least 6 characters</div>
            </div>
            
            <div class="form-check">
                <input type="checkbox" id="remember" name="remember" class="form-check-input">
                <label class="form-check-label" for="remember">Remember me</label>
            </div>
            
            <button type="submit" class="login-btn">Login</button>
        </form>
        
        <div class="signup-link">
            Don't have an account? <a href="signup.jsp">Sign up here</a>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.getElementById('loginForm').addEventListener('submit', function(e) {
            let isValid = true;
            const username = document.getElementById('username').value.trim();
            const password = document.getElementById('password').value;
            
            // Reset errors
            document.getElementById('usernameError').style.display = 'none';
            document.getElementById('passwordError').style.display = 'none';
            
            // Validate username
            if (!username) {
                document.getElementById('usernameError').style.display = 'block';
                document.getElementById('username').classList.add('is-invalid');
                isValid = false;
            } else {
                document.getElementById('username').classList.remove('is-invalid');
            }
            
            // Validate password
            if (!password || password.length < 6) {
                document.getElementById('passwordError').style.display = 'block';
                document.getElementById('password').classList.add('is-invalid');
                isValid = false;
            } else {
                document.getElementById('password').classList.remove('is-invalid');
            }
            
            if (!isValid) {
                e.preventDefault();
            }
        });
    </script>
</body>
</html>
