package com.tap.model;

public class Orderitem {
private int orderitemId;
private int orderId;
private int menuId;
private int quantity;
private float totalPrice;

public Orderitem() {
	
}
public Orderitem(int orderitemId,int orderId,int menuId,int quantity,float totalPrice) {
	super();
	this.orderitemId=orderitemId;
	this.orderId=orderId;
	this.menuId=menuId;
	this.quantity=quantity;
	this.totalPrice=totalPrice;
}
public int getOrderitemId() {
	return orderitemId;
}
public void setOrderitemId(int orderitemId) {
	this.orderitemId = orderitemId;
}
public int getOrderId() {
	return orderId;
}
public void setOrderId(int orderId) {
	this.orderId = orderId;
}
public int getMenuId() {
	return menuId;
}
public void setMenuId(int menuId) {
	this.menuId = menuId;
}
public int getQuantity() {
	return quantity;
}
public void setQuantity(int quantity) {
	this.quantity = quantity;
}
public float getTotalPrice() {
	return totalPrice;
}
public void setTotalPrice(float totalPrice) {
	this.totalPrice = totalPrice;
}
public void setSubTotal(float subTotal) {
	this.totalPrice = subTotal;
}
@Override
public String toString() {
	return "Orderitem [orderitemId=" + orderitemId + ", orderId=" + orderId + ", menuId=" + menuId + ", quantity="
			+ quantity + ", totalPrice=" + totalPrice + "]";
}

}
