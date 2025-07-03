import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;

public class PaymentServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            DatabaseConnection dbConnection = new DatabaseConnection();
            dbConnection.initJDBC();
            Connection connection = dbConnection.getConnection();

            PaymentDAO paymentDAO = new PaymentDAO(connection);
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            double amount = Double.parseDouble(request.getParameter("amount"));
            paymentDAO.createPayment(orderId, amount);

            response.sendRedirect("customer.jsp");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
