package ak.assignment;
import java.sql.*;

public class FeedbackDAO {
    private Connection connection;

    public FeedbackDAO(Connection connection) {
        this.connection = connection;
    }

    public void createFeedback(int customerId, int orderId, String message, int rating) throws SQLException {
        String sql = "INSERT INTO Feedback (CustomerID, OrderID, Message, Rating) VALUES (?, ?, ?, ?)";
        PreparedStatement pstmt = connection.prepareStatement(sql);
        pstmt.setInt(1, customerId);
        pstmt.setInt(2, orderId);
        pstmt.setString(3, message);
        pstmt.setInt(4, rating);
        pstmt.executeUpdate();
    }
}
