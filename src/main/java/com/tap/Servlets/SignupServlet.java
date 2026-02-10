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

@WebServlet("/SignupServlet")
public class SignupServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDao userDAO;
    
    @Override
    public void init() throws ServletException {
        userDAO = new UserDaoImpl();
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            String password = request.getParameter("password");
            String confirmPassword = request.getParameter("confirmPassword");
            
            // Validation
            if (name == null || name.trim().isEmpty() ||
                email == null || email.trim().isEmpty() ||
                password == null || password.trim().isEmpty()) {
                response.sendRedirect("signup.jsp?error=required");
                return;
            }
            
            // Check if passwords match
            if (!password.equals(confirmPassword)) {
                response.sendRedirect("signup.jsp?error=password_mismatch");
                return;
            }
            
            // Check if email already exists
            User existingUser = userDAO.getUser(email);
            if (existingUser != null) {
                response.sendRedirect("signup.jsp?error=email_exists");
                return;
            }
            
            // Create new user
            User newUser = new User();
            newUser.setName(name);
            newUser.setEmail(email);
            newUser.setPassword(password);
            newUser.setPhone(phone);
            newUser.setAddress(address);
            newUser.setRole("customer");
            
            // Add user to database
            int userId = userDAO.addUser(newUser);
            
            if (userId > 0) {
                // Redirect to login with success message
                response.sendRedirect("login.jsp?success=signup");
            } else {
                response.sendRedirect("signup.jsp?error=registration_failed");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("signup.jsp?error=exception");
        }
    }
}
