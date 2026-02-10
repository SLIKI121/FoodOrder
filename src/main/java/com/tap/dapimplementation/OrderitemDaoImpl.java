package com.tap.dapimplementation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.tap.dao.OrderitemDao;
import com.tap.model.Orderitem;
import com.tap.utilty.DBConnection;

public class OrderitemDaoImpl implements OrderitemDao {

    @Override
    public void addOrderitem(Orderitem orderitem) {
        String INSERT_ORDERITEM_QUERY = "INSERT into orderitem(orderId,menuId,quantity,totalPrice) values(?,?,?,?)";
        try {
            Connection connection = DBConnection.getConnection();
            PreparedStatement pstmt = connection.prepareStatement(INSERT_ORDERITEM_QUERY);
            pstmt.setInt(1, orderitem.getOrderId());
            pstmt.setInt(2, orderitem.getMenuId());
            pstmt.setInt(3, orderitem.getQuantity());
            pstmt.setFloat(4, orderitem.getTotalPrice());
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void addOrderItem(Orderitem orderitem) {
        addOrderitem(orderitem);
    }

    @Override
    public Orderitem getOrderitem(int orderitemId) {
        String GET_ORDERITEM_QUERY = "SELECT * FROM orderitem WHERE orderitemId=?";
        Orderitem orderitem = null;
        try {
            Connection connection = DBConnection.getConnection();
            PreparedStatement pstmt = connection.prepareStatement(GET_ORDERITEM_QUERY);
            pstmt.setInt(1, orderitemId);
            ResultSet res = pstmt.executeQuery();
            if (res.next()) {
                orderitem = extracterOrderitem(res);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderitem;
    }

    @Override
    public void updateOrderitem(Orderitem orderitem) {
        String UPDATE_ORDERITEM_QUERY = "UPDATE orderitem SET quantity=?, totalPrice=? WHERE orderitemId=?";
        try {
            Connection connection = DBConnection.getConnection();
            PreparedStatement pstmt = connection.prepareStatement(UPDATE_ORDERITEM_QUERY);
            pstmt.setInt(1, orderitem.getQuantity());
            pstmt.setFloat(2, orderitem.getTotalPrice());
            pstmt.setInt(3, orderitem.getOrderitemId());
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void deleteOrderitem(int orderitemId) {
        String DELETE_ORDERITEM_QUERY = "DELETE FROM orderitem WHERE orderitemId=?";
        try {
            Connection connection = DBConnection.getConnection();
            PreparedStatement pstmt = connection.prepareStatement(DELETE_ORDERITEM_QUERY);
            pstmt.setInt(1, orderitemId);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<Orderitem> getAllOrderitem() {
        ArrayList<Orderitem> OrderitemList = new ArrayList<Orderitem>();
        try {
            Connection connection = DBConnection.getConnection();
            Statement stmt = connection.createStatement();
            ResultSet res = stmt.executeQuery("SELECT * FROM orderitem");
            while (res.next()) {
                Orderitem orderitem = extracterOrderitem(res);
                OrderitemList.add(orderitem);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return OrderitemList;
    }

    Orderitem extracterOrderitem(ResultSet res) throws SQLException {
        int orderitemid = res.getInt("orderitemId");
        int orderid = res.getInt("orderId");
        int menuId = res.getInt("menuId");
        int quantity = res.getInt("quantity");
        float totalprice = res.getFloat("totalPrice");
        Orderitem orderitem = new Orderitem(orderitemid, orderid, menuId, quantity, totalprice);
        return orderitem;
    }
}