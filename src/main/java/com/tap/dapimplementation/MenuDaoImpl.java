package com.tap.dapimplementation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.tap.dao.MenuDao;
import com.tap.model.Menu;
import com.tap.utilty.DBConnection;

public class MenuDaoImpl implements MenuDao {
    
    private static final String ADD_MENU_QUERY = "INSERT INTO menu (restaurantId, itemName, description, price, rating, imageUrl, isAvailable) VALUES (?, ?, ?, ?, ?, ?, ?)";
    private static final String GET_MENU_QUERY = "SELECT * FROM menu WHERE menuId = ?";
    private static final String UPDATE_MENU_QUERY = "UPDATE menu SET itemName = ?, description = ?, price = ?, rating = ?, imageUrl = ?, isAvailable = ? WHERE menuId = ?";
    private static final String DELETE_MENU_QUERY = "DELETE FROM menu WHERE menuId = ?";
    private static final String GET_ALL_MENU_QUERY = "SELECT * FROM menu";
    private static final String GET_MENU_BY_RESTAURANT_QUERY = "SELECT * FROM menu WHERE restaurantId = ?";

    @Override
    public void addMenu(Menu menu) {
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement pstmt = connection.prepareStatement(ADD_MENU_QUERY)) {
            pstmt.setInt(1, menu.getRestaurantId());
            pstmt.setString(2, menu.getItemName());
            pstmt.setString(3, menu.getDescription());
            pstmt.setFloat(4, menu.getPrice());
            pstmt.setInt(5, menu.getRating());
            pstmt.setString(6, menu.getImageUrl());
            pstmt.setBoolean(7, menu.isAvailable());
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public Menu getMenu(int menuId) {
        Menu menu = null;
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement pstmt = connection.prepareStatement(GET_MENU_QUERY)) {
            pstmt.setInt(1, menuId);
            ResultSet res = pstmt.executeQuery();
            if (res.next()) {
                menu = extractMenu(res);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return menu;
    }

    @Override
    public void updateMenu(Menu menu) {
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement pstmt = connection.prepareStatement(UPDATE_MENU_QUERY)) {
            pstmt.setString(1, menu.getItemName());
            pstmt.setString(2, menu.getDescription());
            pstmt.setFloat(3, menu.getPrice());
            pstmt.setInt(4, menu.getRating());
            pstmt.setString(5, menu.getImageUrl());
            pstmt.setBoolean(6, menu.isAvailable());
            pstmt.setInt(7, menu.getMenuId());
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void deleteMenu(int menuId) {
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement pstmt = connection.prepareStatement(DELETE_MENU_QUERY)) {
            pstmt.setInt(1, menuId);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<Menu> getAllMenu() {
        List<Menu> menuList = new ArrayList<>();
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement pstmt = connection.prepareStatement(GET_ALL_MENU_QUERY)) {
            ResultSet res = pstmt.executeQuery();
            while (res.next()) {
                menuList.add(extractMenu(res));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return menuList;
    }

    @Override
    public List<Menu> getMenuByRestaurant(int restaurantId) {
        List<Menu> menuList = new ArrayList<>();
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement pstmt = connection.prepareStatement(GET_MENU_BY_RESTAURANT_QUERY)) {
            pstmt.setInt(1, restaurantId);
            ResultSet res = pstmt.executeQuery();
            while (res.next()) {
                menuList.add(extractMenu(res));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return menuList;
    }

    private Menu extractMenu(ResultSet res) throws SQLException {
        Menu menu = new Menu();
        menu.setMenuId(res.getInt("menuId"));
        menu.setRestaurantId(res.getInt("restaurantId"));
        menu.setItemName(res.getString("itemName"));
        menu.setDescription(res.getString("description"));
        menu.setPrice(res.getFloat("price"));
        menu.setRating(res.getInt("rating"));
        menu.setImageUrl(res.getString("imageUrl"));
        menu.setAvailable(res.getBoolean("isAvailable"));
        return menu;
    }
}


