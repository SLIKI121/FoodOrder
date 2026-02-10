package com.tap.dapimplementation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.tap.dao.ResturantDao;
import com.tap.model.Resturant;
import com.tap.utilty.DBConnection;

public class ResturantDaoImpl implements ResturantDao{
	

    // Fixed: Added all fields and WHERE clause to UPDATE query
    public static final String INSERT_RESTURANT_QUERY="INSERT into `resturants`(`restaurantname`,`cuisineType`,`address`,`rating`,`deliveryTime`,`isActive`,`imageUrl`)values(?,?,?,?,?,?,?)";
    public static final String GET_RESTURANT_QUERY="SELECT * FROM `resturants` WHERE `restaurantId`=?";
    public static final String UPDATE_RESTURANT_QUERY="UPDATE `resturants` SET `restaurantName`=?, `cuisineType`=?, `address`=?, `rating`=?, `deliveryTime`=?, `isActive`=?, `imageUrl`=? WHERE `restaurantId`=?";
    public static final String DELETE_RESTURANT_QUERY="DELETE FROM `resturants` WHERE `restaurantId`=?";
    public static final String GET_ALL_RESTURANTS_QUERY="SELECT * FROM `resturants`";
    
    @Override
    public void addResturant(Resturant resturant) {
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement pstmt = connection.prepareStatement(INSERT_RESTURANT_QUERY)) {
            
            pstmt.setString(1, resturant.getRestaurantName());
            pstmt.setString(2, resturant.getCuisineType());
            pstmt.setString(3, resturant.getAddress());
            pstmt.setInt(4, resturant.getRating());
            pstmt.setInt(5, resturant.getDeliveryTime());
            pstmt.setBoolean(6, resturant.isActive());
            pstmt.setString(7, resturant.getImageUrl());
            
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public Resturant getResturant(int restaurantId) {
        Resturant resturant = null;
        Connection connection = null;
        PreparedStatement pstmt = null;
        ResultSet res = null;
        
        try {
            connection = DBConnection.getConnection();
            pstmt = connection.prepareStatement(GET_RESTURANT_QUERY);
            pstmt.setInt(1, restaurantId);
            res = pstmt.executeQuery();
            
            if (res.next()) {
                resturant = extractResturant(res);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(res, pstmt, connection);
        }
        return resturant;
    }

    @Override
    public void updateResturant(Resturant resturant) {
        Connection connection = null;
        PreparedStatement pstmt = null;
        
        try {
            connection = DBConnection.getConnection();
            pstmt = connection.prepareStatement(UPDATE_RESTURANT_QUERY);
            
            // Set parameters in the correct order matching the query
            pstmt.setString(1, resturant.getRestaurantName());
            pstmt.setString(2, resturant.getCuisineType());
            pstmt.setString(3, resturant.getAddress());
            pstmt.setInt(4, resturant.getRating());
            pstmt.setInt(5, resturant.getDeliveryTime());
            pstmt.setBoolean(6, resturant.isActive());
            pstmt.setString(7, resturant.getImageUrl());
            pstmt.setInt(8, resturant.getRestaurantId()); // WHERE clause parameter
            
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(null, pstmt, connection);
        }
    }

    @Override
    public void deleteResturant(int restaurantId) {
        Connection connection = null;
        PreparedStatement pstmt = null;
        
        try {
            connection = DBConnection.getConnection();
            pstmt = connection.prepareStatement(DELETE_RESTURANT_QUERY);
            pstmt.setInt(1, restaurantId);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(null, pstmt, connection);
        }
    }

    @Override
    public List<Resturant> getallResturant() {
        System.out.println("ResturantDaoImpl: getallResturant called");
        ArrayList<Resturant> resturantsList = new ArrayList<Resturant>();
        Connection connection = null;
        Statement stmt = null;
        ResultSet res = null;
        
        try {
            connection = DBConnection.getConnection();
            stmt = connection.createStatement();
            System.out.println("ResturantDaoImpl: Executing query: " + GET_ALL_RESTURANTS_QUERY);
            res = stmt.executeQuery(GET_ALL_RESTURANTS_QUERY);
            
            while (res.next()) {
                Resturant resturant = extractResturant(res);
                resturantsList.add(resturant);
            }
            System.out.println("ResturantDaoImpl: Modified List size: " + resturantsList.size());
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("ResturantDaoImpl: Exception: " + e.getMessage());
        } finally {
            closeResources(res, stmt, connection);
        }
        return resturantsList;
    }
    
    private Resturant extractResturant(ResultSet res) throws SQLException {
        int restaurantId = res.getInt("restaurantId");
        String restaurantName = res.getString("restaurantName");
        String cuisineType = res.getString("cuisineType");
        String address = res.getString("address");
        int rating = res.getInt("rating");
        int deliveryTime = res.getInt("deliveryTime");
        boolean isActive = res.getBoolean("isActive");
        String imageUrl = res.getString("imageUrl");
        
        return new Resturant(restaurantId, restaurantName, cuisineType, address, rating, deliveryTime, isActive, imageUrl);
    }
    
    // Helper method to close resources
    private void closeResources(ResultSet rs, Statement stmt, Connection conn) {
        try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}