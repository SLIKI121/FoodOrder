package com.tap.Servlets;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.Map;
import com.tap.dao.OrderDao;
import com.tap.dao.OrderitemDao;
import com.tap.dapimplementation.OrderDaoImpl;
import com.tap.dapimplementation.OrderitemDaoImpl;
import com.tap.model.Order;
import com.tap.model.Orderitem;
import com.tap.model.Cart;
import com.tap.model.Cartitem;
import com.tap.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/PaymentServlet")
public class PaymentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private OrderDao orderDAO;
    private OrderitemDao orderitemDAO;
    
    @Override
    public void init() throws ServletException {
        orderDAO = new OrderDaoImpl();
        orderitemDAO = new OrderitemDaoImpl();
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        
        if (session == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        try {
            // Get user information from session
            User user = (User) session.getAttribute("user");
            Cart cart = (Cart) session.getAttribute("cart");
            
            if (user == null || cart == null) {
                response.sendRedirect("menu-cart.jsp");
                return;
            }
            
            // Get payment details from form
            String address = request.getParameter("address");
            String paymentMethod = request.getParameter("paymentMethod");
            String cardName = request.getParameter("cardName");
            
            // Calculate total amount
            double subtotal = calculateCartTotal(cart);
            double deliveryFee = 50.00;
            double tax = subtotal * 0.05;
            double totalAmount = subtotal + deliveryFee + tax;
            
            // Get restaurantId from session
            int restaurantId = 1; // Default
            Object sessionRestId = session.getAttribute("restaurantId");
            if (sessionRestId != null) {
                restaurantId = (Integer) sessionRestId;
            }
            
            // Create Order
            Order order = new Order();
            order.setUserId(user.getUserId());
            order.setRestaurantId(restaurantId);
            order.setOrderDate(new Timestamp(System.currentTimeMillis()));
            order.setTotalAmount((float) totalAmount);
            order.setStatus("Confirmed");
            order.setPaymentMode(paymentMethod);
            
            // Insert order into database
            int orderId = orderDAO.addOrder(order);
            
            if (orderId > 0) {
                // Add order items
                Map<Integer, Cartitem> cartItems = cart.getItems();
                for (Cartitem item : cartItems.values()) {
                    Orderitem orderItem = new Orderitem();
                    orderItem.setOrderId(orderId);
                    orderItem.setMenuId(item.getMenuId());
                    orderItem.setQuantity(item.getQuantity());
                    orderItem.setSubTotal((float) (item.getPrice() * item.getQuantity()));
                    
                    orderitemDAO.addOrderItem(orderItem);
                }
                
                // Clear cart
                session.removeAttribute("cart");
                
                // Store order info for confirmation page
                session.setAttribute("orderId", orderId);
                session.setAttribute("orderAmount", totalAmount);
                
                // Redirect to confirmation page
                response.sendRedirect("confirmation.jsp?totalAmount=" + String.format("%.2f", totalAmount));
            } else {
                response.sendRedirect("payment.jsp?error=payment_failed");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("payment.jsp?error=exception");
        }
    }
    
    private double calculateCartTotal(Cart cart) {
        double total = 0.0;
        if (cart != null && cart.getItems() != null) {
            for (Cartitem item : cart.getItems().values()) {
                total += item.getPrice() * item.getQuantity();
            }
        }
        return total;
    }
}
