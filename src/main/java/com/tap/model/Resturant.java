package com.tap.model;

public class Resturant {
	private int restaurantId;
    private String restaurantName;
    private String cuisineType;
    private String address;
    private int rating;
    private int deliveryTime;
    private boolean isActive;
    private String imageUrl ;
    
    public Resturant() {
    	
    }
    public Resturant(int resturantId,String resturantName,String cuisineType,String address,int rating,int deliveryTime,boolean isActive,String imageUrl) {
    	super();
    	this.restaurantId=resturantId;
    	this.restaurantName=resturantName;
    	this.cuisineType=cuisineType;
    	this.address=address;
    	this.rating=rating;
    	this.deliveryTime=deliveryTime;
    	this.isActive=isActive;
    	this.imageUrl=imageUrl;
    }
	public int getRestaurantId() {
		return restaurantId;
	}
	public void setRestaurantId(int restaurantId) {
		this.restaurantId = restaurantId;
	}
	public String getRestaurantName() {
		return restaurantName;
	}
	public void setRestaurantName(String restaurantName) {
		this.restaurantName = restaurantName;
	}
	public String getCuisineType() {
		return cuisineType;
	}
	public void setCuisineType(String cuisineType) {
		this.cuisineType = cuisineType;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public int getRating() {
		return rating;
	}
	public void setRating(int rating) {
		this.rating = rating;
	}
	public int getDeliveryTime() {
		return deliveryTime;
	}
	public void setDeliveryTime(int deliveryTime) {
		this.deliveryTime = deliveryTime;
	}
	public boolean isActive() {
		return isActive;
	}
	public void setActive(boolean isActive) {
		this.isActive = isActive;
	}
	public String getImageUrl() {
		return imageUrl;
	}
	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}
	@Override
	public String toString() {
		return "Resturant [restaurantId=" + restaurantId + ", restaurantName=" + restaurantName + ", cuisineType="
				+ cuisineType + ", address=" + address + ", rating=" + rating + ", deliveryTime=" + deliveryTime
				+ ", isActive=" + isActive + ", imageUrl=" + imageUrl + "]";
	}
    
}
