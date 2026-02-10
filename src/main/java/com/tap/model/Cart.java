package com.tap.model;

import java.util.HashMap;
import java.util.Map;

public class Cart {
    private Map<Integer, Cartitem> items;

    // Constructor
    public Cart() {
        this.items = new HashMap<>();
    }

    // Add an item to the cart
    public void addItemToCart(Cartitem item) {
    	
        if (items.containsKey(item.getMenuId())) {
            // If the item already exists, update quantity
            Cartitem existingItem = items.get(item.getMenuId());
            existingItem.setQuantity(existingItem.getQuantity() + item.getQuantity());
        } else {
            items.put(item.getMenuId(), item);
        }
    }

    // Update item quantity
    public void updateCartItem(int itemId, int quantity) {
        if (items.containsKey(itemId)) {
            if (quantity > 0) {
                items.get(itemId).setQuantity(quantity);
            } else {
                removeCartItem(itemId);
            }
        }
    }

    // Remove an item from the cart
    public void removeCartItem(int itemId) {
        items.remove(itemId);
    }

    // Display all items in the cart
    public void displayCart() {
        if (items.isEmpty()) {
            System.out.println("Cart is empty.");
        } else {
            System.out.println("Cart Items:");
            for (Cartitem item : items.values()) {
                System.out.println(item);
            }
        }
    }

    // Get total price of items in the cart
    public double getTotalPrice() {
        double total = 0;
        for (Cartitem item : items.values()) {
            total += item.getPrice() * item.getQuantity();
        }
        return total;
    }

    // Expose items map for servlet use
    public Map<Integer, Cartitem> getItems() {
        return items;
    }
}

