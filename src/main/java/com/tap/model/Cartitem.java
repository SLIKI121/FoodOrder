package com.tap.model;


public class Cartitem {
    private int menuId;
    private int restaurantId;
    private String itemName;
    private float price;
    private int quantity;
    
    
    public Cartitem() {
    	
    }

    // ✅ Constructor to fix the error
    public Cartitem(int menuId, int restaurantId, String itemName, float price, int quantity) {
        this.menuId = menuId;
        this.restaurantId = restaurantId;
        this.itemName = itemName;
        this.price = price;
        this.quantity = quantity;
    }

	public int getMenuId() {
		return menuId;
	}

	public void setMenuId(int menuId) {
		this.menuId = menuId;
	}

	public int getRestaurantId() {
		return restaurantId;
	}

	public void setRestaurantId(int restaurantId) {
		this.restaurantId = restaurantId;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public float getPrice() {
		return price;
	}

	public void setPrice(float price) {
		this.price = price;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	@Override
	public String toString() {
		return "Cartitem [menuId=" + menuId + ", restaurantId=" + restaurantId + ", itemName=" + itemName + ", price="
				+ price + ", quantity=" + quantity + "]";
	}
}

    // Add getters/setters if needed...
