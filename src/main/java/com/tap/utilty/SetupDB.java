package com.tap.utilty;

import java.sql.Connection;
import java.sql.Statement;

public class SetupDB {
    public static void main(String[] args) {
        try {
            Connection con = DBConnection.getConnection();
            if (con == null) {
                System.out.println("Failed to connect to DB");
                return;
            }
            Statement stmt = con.createStatement();
            
            // Create table
            String createTable = "CREATE TABLE IF NOT EXISTS `resturants` (" +
                    "`restaurantId` int NOT NULL AUTO_INCREMENT," +
                    "`restaurantName` varchar(100) DEFAULT NULL," +
                    "`cuisineType` varchar(100) DEFAULT NULL," +
                    "`address` varchar(255) DEFAULT NULL," +
                    "`rating` int DEFAULT NULL," +
                    "`deliveryTime` int DEFAULT NULL," +
                    "`isActive` tinyint(1) DEFAULT '1'," +
                    "`imageUrl` varchar(255) DEFAULT NULL," +
                    "PRIMARY KEY (`restaurantId`)" +
                    ")";
            stmt.executeUpdate(createTable);
            System.out.println("Table 'resturants' created or already exists.");

             // Check if empty
            if (!stmt.executeQuery("SELECT * FROM resturants").next()) {
                // Insert sample data
                String insertData = "INSERT INTO `resturants` " +
                        "(`restaurantName`, `cuisineType`, `address`, `rating`, `deliveryTime`, `isActive`, `imageUrl`) VALUES " +
                        "('Spicy Bites', 'Indian, Chinese', '123 Main St', 4, 30, 1, 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=500')," +
                        "('Burger King', 'Fast Food', '456 High St', 5, 20, 1, 'https://images.unsplash.com/photo-1571091718767-18b5b1457add?w=500')," +
                        "('Pizza Hut', 'Italian', '789 Oak Ave', 4, 45, 1, 'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=500')";
                stmt.executeUpdate(insertData);
                System.out.println("Sample restaurants inserted.");
                
                // Also update menus to link to these restaurants if needed (assuming restaurantId 1, 2, 3)
                // Existing menu in QUICK_START linked to ID 1.
            } else {
                System.out.println("Table already has data.");
            }
            
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
