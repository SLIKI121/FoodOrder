package com.tap.dao;

import java.util.List;

import com.tap.model.Orderitem;

public interface OrderitemDao {
void addOrderitem(Orderitem orderitem);
void addOrderItem(Orderitem orderitem);
Orderitem getOrderitem(int orderitemId);
void updateOrderitem(Orderitem orderitem);
void deleteOrderitem(int orderitemId);
List<Orderitem>getAllOrderitem();
}
