package com.tap.dapimplementation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.tap.dao.OrderDao;
import com.tap.model.Order;
import com.tap.utilty.DBConnection;

public class OrderDaoImpl implements OrderDao {
    private static final String INSERT_ORDER_QUERY = "INSERT into `order`(userId, restaurantId, orderDate, totalAmount, status, paymentMode) values(?,?,?,?,?,?)";
    private static final String GET_ORDER_QUERY = "SELECT * FROM `order` WHERE orderId=?";
    private static final String UPDATE_ORDER_QUERY = "UPDATE `order` SET totalAmount=?, paymentMode=? WHERE orderId=?";
    private static final String DELETE_ORDER_QUERY = "DELETE FROM `order` WHERE orderId=?";
    private static final String GET_ALL_ORDER_QUERY = "SELECT * FROM `order`";

    @Override
    public int addOrder(Order order) {
        int generatedId = 0;
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement pstmt = connection.prepareStatement(INSERT_ORDER_QUERY, Statement.RETURN_GENERATED_KEYS)) {
            
            pstmt.setInt(1, order.getUserId());
            pstmt.setInt(2, order.getRestaurantId());
            pstmt.setTimestamp(3, order.getOrderDate());
            pstmt.setFloat(4, order.getTotalAmount());
            pstmt.setString(5, order.getStatus());
            pstmt.setString(6, order.getPaymentMode());
            
            int affectedRows = pstmt.executeUpdate();
            
            if (affectedRows > 0) {
                try (ResultSet generatedKeys = pstmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        generatedId = generatedKeys.getInt(1);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return generatedId;
    }

    @Override
    public Order getOrder(int orderId) {
        Order order = null;
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement pstmt = connection.prepareStatement(GET_ORDER_QUERY)) {
            pstmt.setInt(1, orderId);
            try (ResultSet res = pstmt.executeQuery()) {
                if (res.next()) {
                    order = extracterOrder(res);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return order;
    }

    @Override
    public void updateOrder(Order order) {
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement pstmt = connection.prepareStatement(UPDATE_ORDER_QUERY)) {
            pstmt.setFloat(1, order.getTotalAmount());
            pstmt.setString(2, order.getPaymentMode());
            pstmt.setInt(3, order.getOrderId());
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void deleteOrder(int orderId) {
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement pstmt = connection.prepareStatement(DELETE_ORDER_QUERY)) {
            pstmt.setInt(1, orderId);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<Order> getAllOrder() {
        List<Order> orderList = new ArrayList<>();
        try (Connection connection = DBConnection.getConnection();
             Statement stmt = connection.createStatement();
             ResultSet res = stmt.executeQuery(GET_ALL_ORDER_QUERY)) {
            while (res.next()) {
                orderList.add(extracterOrder(res));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderList;
    }

    @Override
    public Order getLatestOrderByUserId(int userId) {
        Order order = null;
        String query = "SELECT * FROM `order` WHERE userId=? ORDER BY orderDate DESC LIMIT 1";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setInt(1, userId);
            try (ResultSet res = pstmt.executeQuery()) {
                if (res.next()) {
                    order = extracterOrder(res);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return order;
    }

    @Override
    public List<Order> getOrdersByUserId(int userId) {
        List<Order> orders = new ArrayList<>();
        String query = "SELECT * FROM `order` WHERE userId=? ORDER BY orderDate DESC";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setInt(1, userId);
            try (ResultSet res = pstmt.executeQuery()) {
                while (res.next()) {
                    orders.add(extracterOrder(res));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    private Order extracterOrder(ResultSet res) throws SQLException {
        int orderid = res.getInt("orderId");
        int userid = res.getInt("userId");
        int restaurantid = res.getInt("restaurantId");
        Timestamp orderdate = res.getTimestamp("orderDate");
        float totalamount = res.getFloat("totalAmount");
        String status = res.getString("status");
        String paymentMode = res.getString("paymentMode");
        return new Order(orderid, userid, restaurantid, orderdate, totalamount, status, paymentMode);
    }
}
