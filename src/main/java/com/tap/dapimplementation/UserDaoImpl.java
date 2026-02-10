package com.tap.dapimplementation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.tap.dao.UserDao;
import com.tap.model.User;
import com.tap.utilty.DBConnection;

public class UserDaoImpl implements UserDao {
    
    private static final String INSERT_USER_QUERY = "INSERT INTO `user` (`name`, `email`, `password`, `phone`, `address`, `role`) VALUES (?, ?, ?, ?, ?, ?)";
    private static final String GET_USER_QUERY = "SELECT * FROM `user` WHERE `email` = ?";
    private static final String UPDATE_USER_QUERY = "UPDATE `user` SET `name` = ?, `password` = ?, `phone` = ?, `address` = ?, `role` = ? WHERE `id` = ?";
    private static final String DELETE_USER_QUERY = "DELETE FROM `user` WHERE `id` = ?";
    private static final String GET_ALL_USERS_QUERY = "SELECT * FROM `user`";

    public UserDaoImpl() {
        createTableIfNotExists();
    }

    private void createTableIfNotExists() {
        String createTableSQL = "CREATE TABLE IF NOT EXISTS `user` (" +
                "id INT AUTO_INCREMENT PRIMARY KEY," +
                "name VARCHAR(100) NOT NULL," +
                "email VARCHAR(100) NOT NULL UNIQUE," +
                "password VARCHAR(100) NOT NULL," +
                "phone VARCHAR(20)," +
                "address TEXT," +
                "role VARCHAR(20) DEFAULT 'customer'" +
                ")";
        try (Connection connection = DBConnection.getConnection();
             Statement stmt = connection.createStatement()) {
            stmt.execute(createTableSQL);
        } catch (SQLException e) {
            // Ignore if already exists with slightly different structure for now
        }
    }

    @Override
    public int addUser(User user) {
        int status = 0;
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement pstmt = connection.prepareStatement(INSERT_USER_QUERY, Statement.RETURN_GENERATED_KEYS)) {
            pstmt.setString(1, user.getName());
            pstmt.setString(2, user.getEmail());
            pstmt.setString(3, user.getPassword());
            pstmt.setString(4, user.getPhone());
            pstmt.setString(5, user.getAddress());
            pstmt.setString(6, user.getRole());
            
            pstmt.executeUpdate();
            ResultSet gk = pstmt.getGeneratedKeys();
            if (gk.next()) {
                status = gk.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return status;
    }

    @Override
    public User getUser(String email) {
        User user = null;
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement pstmt = connection.prepareStatement(GET_USER_QUERY)) {
            pstmt.setString(1, email);
            ResultSet res = pstmt.executeQuery();
            if (res.next()) {
                user = extractUser(res);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }

    @Override
    public void updateUser(User user) {
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement pstmt = connection.prepareStatement(UPDATE_USER_QUERY)) {
            pstmt.setString(1, user.getName());
            pstmt.setString(2, user.getPassword());
            pstmt.setString(3, user.getPhone());
            pstmt.setString(4, user.getAddress());
            pstmt.setString(5, user.getRole());
            pstmt.setInt(6, user.getUserId());
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void deleteUser(int userId) {
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement pstmt = connection.prepareStatement(DELETE_USER_QUERY)) {
            pstmt.setInt(1, userId);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<User> getallUsers() {
        List<User> userList = new ArrayList<>();
        try (Connection connection = DBConnection.getConnection();
             Statement stmt = connection.createStatement()) {
            ResultSet res = stmt.executeQuery(GET_ALL_USERS_QUERY);
            while (res.next()) {
                userList.add(extractUser(res));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return userList;
    }

    private User extractUser(ResultSet res) throws SQLException {
        User user = new User();
        user.setUserId(res.getInt("id"));
        user.setName(res.getString("name"));
        user.setEmail(res.getString("email"));
        user.setPassword(res.getString("password"));
        user.setPhone(res.getString("phone"));
        user.setAddress(res.getString("address"));
        user.setRole(res.getString("role"));
        return user;
    }
}
