package com.tap.Servlets;

import java.io.IOException;
import com.tap.dao.UserDao;
import com.tap.dapimplementation.UserDaoImpl;
import com.tap.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDao userDAO;
    
    @Override
    public void init() throws ServletException {
        userDAO = new UserDaoImpl();
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        System.out.println("LoginServlet: Received login request for user: " + username);
        
        // Validation
        if (username == null || username.trim().isEmpty() || 
            password == null || password.trim().isEmpty()) {
            response.sendRedirect("login.jsp?error=required");
            return;
        }
        
        try {
            // Try to authenticate user - first as email
            User user = userDAO.getUser(username);
            
            // If not found by email, you can add username lookup here
            if (user == null) {
                response.sendRedirect("login.jsp?error=notfound");
                return;
            }
            
            // Verify password
            if (user.getPassword() != null && user.getPassword().equals(password)) {
                System.out.println("LoginServlet: Authentication successful for: " + username);
                // Create session
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                session.setAttribute("userId", user.getUserId());
                session.setAttribute("userName", user.getName());
                session.setAttribute("userEmail", user.getEmail());
                session.setAttribute("userPhone", user.getPhone());
                session.setAttribute("userAddress", user.getAddress());
                session.setMaxInactiveInterval(30 * 60); // 30 minutes
                
                // Redirect to Home page (Restaurants)
                System.out.println("LoginServlet: Redirecting to 'home'");
                response.sendRedirect("home");
            } else {
                System.out.println("LoginServlet: Authentication failed - invalid password for: " + username);
                // Invalid password
                response.sendRedirect("login.jsp?error=invalid");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=invalid");
        }
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Handle logout
        String action = request.getParameter("action");
        
        if ("logout".equals(action)) {
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.invalidate();
            }
            response.sendRedirect("login.jsp?success=logout");
        } else {
            response.sendRedirect("login.jsp");
        }
    }
}
