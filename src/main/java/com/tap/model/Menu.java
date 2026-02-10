package com.tap.model;

public class Menu {
private int menuId;
private int restaurantId;
private String itemName;
private String description;
private float price;
private int rating;
private boolean isAvailable;
private String imageUrl;

public Menu() {
	
}

public Menu(int menuId,int restaurantId,String itemName,String description,float price,int rating,boolean isAvailable,String imageUrl) {
	super();
	this.menuId=menuId;
	this.restaurantId=restaurantId;
	this.itemName=itemName;
	this.description=description;
	this.price=price;
	this.rating=rating;
	this.isAvailable=isAvailable;
	this.imageUrl=imageUrl;
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

public String getDescription() {
	return description;
}

public void setDescription(String description) {
	this.description = description;
}

public float getPrice() {
	return price;
}

public void setPrice(float price) {
	this.price = price;
}

public int getRating() {
	return rating;
}

public void setRating( int rating) {
	this.rating = rating;
}

public boolean isAvailable() {
	return isAvailable;
}

public void setAvailable(boolean isAvailable) {
	this.isAvailable = isAvailable;
}

public String getImageUrl() {
	return imageUrl;
}

public void setImageUrl(String imageUrl) {
	this.imageUrl = imageUrl;
}

@Override
public String toString() {
	return "Menu [menuId=" + menuId + ", restaurantId=" + restaurantId + ", itemName=" + itemName + ", description="
			+ description + ", price=" + price + ", rating=" + rating + ", isAvailable=" + isAvailable + ", imageUrl="
			+ imageUrl + "]";
}

public void setRating(String string) {
	// TODO Auto-generated method stub
	
}




}


