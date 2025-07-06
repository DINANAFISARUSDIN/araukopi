package ak.assignment;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MenuItemDAO {
    private Connection connection;

    public MenuItemDAO(Connection connection) {
        this.connection = connection;
    }

    public List<MenuItem> getAllMenuItems() throws SQLException {
        List<MenuItem> menuItems = new ArrayList<>();
        String sql = "SELECT * FROM MenuItem";
        Statement stmt = connection.createStatement();
        ResultSet rs = stmt.executeQuery(sql);
        while (rs.next()) {
            MenuItem item = new MenuItem(
                rs.getInt("MenuItemID"),
                rs.getString("Name"),
                rs.getBigDecimal("Price")
            );
            menuItems.add(item);
        }
        return menuItems;
    }

    public void addMenuItem(String name, double price) throws SQLException {
        String sql = "INSERT INTO MenuItem (Name, Price) VALUES (?, ?)";
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setString(1, name);
            pstmt.setDouble(2, price);
            pstmt.executeUpdate();
        }
    }

    public void updateMenuItem(int id, String name, double price) throws SQLException {
        String sql = "UPDATE MenuItem SET Name = ?, Price = ? WHERE MenuItemID = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setString(1, name);
            pstmt.setDouble(2, price);
            pstmt.setInt(3, id);
            pstmt.executeUpdate();
        }
    }

    public void deleteMenuItem(int id) throws SQLException {
        String sql = "DELETE FROM MenuItem WHERE MenuItemID = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, id);
            pstmt.executeUpdate();
        }
    }
}
