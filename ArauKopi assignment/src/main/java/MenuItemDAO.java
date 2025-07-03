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
            MenuItem item = new MenuItem(rs.getInt("MenuItemID"), rs.getString("Name"), rs.getBigDecimal("Price"));
            menuItems.add(item);
        }
        return menuItems;
    }
}
