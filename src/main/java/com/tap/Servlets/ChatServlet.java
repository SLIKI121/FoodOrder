package com.tap.Servlets;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import com.tap.dapimplementation.OrderDaoImpl;
import com.tap.model.Order;
import com.tap.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/chat")
public class ChatServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private OrderDaoImpl orderDao = new OrderDaoImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String userMessage = request.getParameter("message");
        if (userMessage == null) userMessage = "";
        userMessage = userMessage.toLowerCase().trim();

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        String botResponse = "";

        if (userMessage.contains("order")) {
            if (user == null) {
                botResponse = "Please log in to check your order status.";
            } else {
                Order latestOrder = orderDao.getLatestOrderByUserId(user.getUserId());
                if (latestOrder != null) {
                    botResponse = "Your latest order #" + latestOrder.getOrderId() + 
                                  " is currently: **" + latestOrder.getStatus() + "**" +
                                  " (Placed on " + latestOrder.getOrderDate() + ")";
                } else {
                    botResponse = "You haven't placed any orders yet. Would you like to check out our menu?";
                }
            }
        } else if (userMessage.contains("payment")) {
            botResponse = "We accept Cash on Delivery, Credit/Debit Cards, and all major UPI apps.";
        } else if (userMessage.contains("delivery") || userMessage.contains("fee")) {
            botResponse = "Our standard delivery fee is ₹50. Delivery usually takes 30-45 minutes.";
        } else if (userMessage.contains("hello") || userMessage.contains("hi")) {
            botResponse = "Hello! I'm your FoodExpress assistant. How can I help you today?";
        } else if (userMessage.contains("contact") || userMessage.contains("help")) {
            botResponse = "You can reach our support team at support@foodexpress.com or call us at +91 12345 67890.";
        } else {
            botResponse = "I'm sorry, I didn't quite get that. You can ask about your 'order status', 'payment methods', or 'delivery fees'.";
        }

        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(botResponse);
    }
}
