package ak.assignment;
import java.sql.*;

public class PaymentDAO {
    private Connection connection;

    public PaymentDAO(Connection connection) {
        this.connection = connection;
    }

    public void createPayment(int orderId, double amount) throws SQLException {
        String sql = "INSERT INTO Payment (OrderID, Amount, PaymentDate, PaymentStatus) VALUES (?, ?, NOW(), 'Completed')";
        PreparedStatement pstmt = connection.prepareStatement(sql);
        pstmt.setInt(1, orderId);
        pstmt.setDouble(2, amount);
        pstmt.executeUpdate();
    }
}
