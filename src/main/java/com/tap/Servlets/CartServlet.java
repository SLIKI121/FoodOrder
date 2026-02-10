package com.tap.Servlets;

import java.io.IOException;
import com.tap.dapimplementation.MenuDaoImpl;
import com.tap.dao.*;
import com.tap.model.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet({"/Cart", "/CartServlet"})
public class CartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        
        System.out.println("=== CartServlet doPost called ===");
        System.out.println("Action: " + req.getParameter("action"));
        System.out.println("MenuId: " + req.getParameter("menuId"));
        System.out.println("Quantity: " + req.getParameter("quantity"));
        System.out.println("RestaurantId param: " + req.getParameter("restaurantId"));
        
        Integer oldRestIdObj = (Integer) session.getAttribute("restaurantId");
        int oldRestId = (oldRestIdObj != null) ? oldRestIdObj : -1;
        
        try {
            // Get restaurantId from parameter, default to 1 if not provided
            String restIdParam = req.getParameter("restaurantId");
            int newrestaurantId = (restIdParam != null && !restIdParam.isEmpty()) ? 
                Integer.parseInt(restIdParam) : 1;
            
            System.out.println("Old RestId: " + oldRestId + ", New RestId: " + newrestaurantId);
            
            if (cart == null) {
                System.out.println("Creating new cart (cart was null)");
                cart = new Cart();
                session.setAttribute("cart", cart);
                session.setAttribute("restaurantId", newrestaurantId);
            }
            
            String action = req.getParameter("action");
            if (action != null) {
                if (action.equals("add")) {
                    addItemtoCart(req, cart);
                } else if (action.equals("update")) {
                    updateCartitem(req, cart);
                } else if (action.equals("remove")) {
                    removeItemcart(req, cart);
                }
            }
            
            session.setAttribute("cart", cart);
            
            String from = req.getParameter("from");
            if ("cart".equals(from)) {
                resp.sendRedirect("cart.jsp");
            } else {
                resp.sendRedirect("menu.jsp?added=true&restaurantId=" + newrestaurantId);
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("menu.jsp");
        }
    }
    
    private void removeItemcart(HttpServletRequest req, Cart cart) {
        try {
            int itemId = Integer.parseInt(req.getParameter("menuId"));
            cart.removeCartItem(itemId);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    private void updateCartitem(HttpServletRequest req, Cart cart) {
        try {
            int itemId = Integer.parseInt(req.getParameter("menuId"));
            int quantity = Integer.parseInt(req.getParameter("quantity"));
            cart.updateCartItem(itemId, quantity);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    private void addItemtoCart(HttpServletRequest req, Cart cart) {
        try {
            int itemId = Integer.parseInt(req.getParameter("menuId"));
            int quantity = Integer.parseInt(req.getParameter("quantity"));
            
            MenuDaoImpl menuDao = new MenuDaoImpl();
            Menu menuById = menuDao.getMenu(itemId);
            
            if (menuById != null) {
                HttpSession session = req.getSession();
                session.setAttribute("restaurantId", menuById.getRestaurantId());
                
                Cartitem item = new Cartitem(
                    menuById.getMenuId(),
                    menuById.getRestaurantId(),
                    menuById.getItemName(),
                    menuById.getPrice(),
                    quantity
                );
                cart.addItemToCart(item);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}


