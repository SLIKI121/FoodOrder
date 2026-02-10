package com.tap.Servlets;
//File: src/com/yourcompany/userapp/controller/LoginController.java


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

@WebServlet("/LoginController")
public class UserServlet extends HttpServlet {
 private UserDao userDAO;
 
 @Override
 public void init() throws ServletException {
     userDAO = new UserDaoImpl();
 }
 
 protected void doPost(HttpServletRequest request, HttpServletResponse response) 
         throws ServletException, IOException {
     
     String username = request.getParameter("username");
     String password = request.getParameter("password");
     String remember = request.getParameter("remember");
     
     // Validate user credentials
     User user = userDAO.getUser(username); // Try email first
     if (user == null) {
         // Try username if email not found
         // You'd need a method to get user by username
     }
     
     if (user != null && user.getPassword().equals(password)) {
         // Create session
         HttpSession session = request.getSession();
         session.setAttribute("user", user);
         session.setAttribute("userId", user.getUserId());
         session.setAttribute("userName", user.getName());
         session.setMaxInactiveInterval(30 * 60); // 30 minutes
         
         // Set remember me cookie if requested
         if ("on".equals(remember)) {
             // Set cookie logic here
         }
         
         // Redirect to dashboard
         response.sendRedirect("Dashboard.jsp");
     } else {
         // Invalid credentials
         response.sendRedirect("Login.jsp?error=invalid");
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
         response.sendRedirect("Login.jsp?success=logout");
     } else {
         response.sendRedirect("Login.jsp");
     }
 }
}

