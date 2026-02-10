package com.tap.dao;

import java.util.List;

import com.tap.model.Menu;

public interface MenuDao {
void  addMenu(Menu menu);
Menu getMenu(int  itemId);

void updateMenu(Menu menu);
void deleteMenu(int MenuId);
List<Menu> getMenuByRestaurant(int restaurantId);
List<Menu> getAllMenu();

}
