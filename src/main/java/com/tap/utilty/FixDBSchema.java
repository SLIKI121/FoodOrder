package com.tap.utilty;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class FixDBSchema {
    public static void main(String[] args) {
        try (Connection conn = DBConnection.getConnection()) {
            if (conn == null) {
                System.out.println("Failed to connect to database!");
                return;
            }
            Statement stmt = conn.createStatement();
            DatabaseMetaData metaData = conn.getMetaData();

            // 1. Fix 'user' table - Drop and Recreate to be sure
            System.out.println("Recreating 'user' table...");
            stmt.executeUpdate("DROP TABLE IF EXISTS `user` ");
            String createUser = "CREATE TABLE `user` (" +
                    "id INT AUTO_INCREMENT PRIMARY KEY," +
                    "name VARCHAR(100) NOT NULL," +
                    "email VARCHAR(100) NOT NULL UNIQUE," +
                    "password VARCHAR(100) NOT NULL," +
                    "phone VARCHAR(20)," +
                    "address TEXT," +
                    "role VARCHAR(20) DEFAULT 'customer'" +
                    ")";
            stmt.executeUpdate(createUser);
            System.out.println("'user' table recreated.");

            // 2. Ensure 'resturants' table exists (misspelled as per DAO)
            System.out.println("Checking 'resturants' table...");
            String createResturants = "CREATE TABLE IF NOT EXISTS `resturants` (" +
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
            stmt.executeUpdate(createResturants);
            System.out.println("'resturants' table verified.");

            // 3. Ensure 'menu' table exists
            System.out.println("Checking 'menu' table...");
            String createMenu = "CREATE TABLE IF NOT EXISTS `menu` (" +
                    "`menuId` int NOT NULL AUTO_INCREMENT," +
                    "`restaurantId` int DEFAULT NULL," +
                    "`itemName` varchar(100) DEFAULT NULL," +
                    "`description` varchar(255) DEFAULT NULL," +
                    "`price` float DEFAULT NULL," +
                    "`rating` int DEFAULT NULL," +
                    "`isAvailable` tinyint(1) DEFAULT '1'," +
                    "`imageUrl` varchar(255) DEFAULT NULL," +
                    "PRIMARY KEY (`menuId`)," +
                    "KEY `restaurantId` (`restaurantId`)" +
                    ")";
            stmt.executeUpdate(createMenu);
            System.out.println("'menu' table verified.");

             // 4. Ensure 'order' table exists
            System.out.println("Recreating 'order' table...");
            stmt.executeUpdate("DROP TABLE IF EXISTS `order` ");
            String createOrder = "CREATE TABLE `order` (" +
                    "`orderId` int NOT NULL AUTO_INCREMENT," +
                    "`userId` int DEFAULT NULL," +
                    "`restaurantId` int DEFAULT NULL," +
                    "`orderDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP," +
                    "`totalAmount` float DEFAULT NULL," +
                    "`status` varchar(20) DEFAULT 'Pending'," +
                    "`paymentMode` varchar(20) DEFAULT NULL," +
                    "PRIMARY KEY (`orderId`)" +
                    ")";
            stmt.executeUpdate(createOrder);
            System.out.println("'order' table recreated.");

            // 5. Ensure 'orderitem' table exists
            System.out.println("Recreating 'orderitem' table...");
            stmt.executeUpdate("DROP TABLE IF EXISTS `orderitem` ");
            String createOrderItem = "CREATE TABLE `orderitem` (" +
                    "`orderitemId` int NOT NULL AUTO_INCREMENT," +
                    "`orderId` int DEFAULT NULL," +
                    "`menuId` int DEFAULT NULL," +
                    "`quantity` int DEFAULT NULL," +
                    "`totalPrice` float DEFAULT NULL," +
                    "PRIMARY KEY (`orderitemId`)" +
                    ")";
            stmt.executeUpdate(createOrderItem);
            System.out.println("'orderitem' table recreated.");

            System.out.println("Schema fix completed successfully!");

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
