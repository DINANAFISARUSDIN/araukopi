import java.sql.*;

public class OrderDAO {
    private Connection connection;

    public OrderDAO(Connection connection) {
        this.connection = connection;
    }

    public void createOrder(int customerId, String status) throws SQLException {
        String sql = "INSERT INTO `Order` (CustomerID, OrderDate, Status) VALUES (?, NOW(), ?)";
        PreparedStatement pstmt = connection.prepareStatement(sql);
        pstmt.setInt(1, customerId);
        pstmt.setString(2, status);
        pstmt.executeUpdate();
    }
}
