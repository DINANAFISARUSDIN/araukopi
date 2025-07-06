package ak.assignment;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;

public class FeedbackServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            DatabaseConnection dbConnection = new DatabaseConnection();
            dbConnection.initJDBC();
            Connection connection = dbConnection.getConnection();

            FeedbackDAO feedbackDAO = new FeedbackDAO(connection);
            int customerId = Integer.parseInt(request.getParameter("customerId"));
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            String message = request.getParameter("message");
            int rating = Integer.parseInt(request.getParameter("rating"));
            feedbackDAO.createFeedback(customerId, orderId, message, rating);

            response.sendRedirect("customer.jsp");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
